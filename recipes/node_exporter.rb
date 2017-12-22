remote_file "/tmp/node_exporter.tar.gz" do
  source "https://github.com/prometheus/node_exporter/releases/download/v0.15.2/node_exporter-0.15.2.linux-amd64.tar.gz"
  owner "root"
  group "root"
  mode "0755"
  backup false
  action :create_if_missing
  notifies :run, "execute[extract_node_exporter]", :immediately
end

execute "extract_node_exporter" do
  command <<-COMMAND
    tar xf /tmp/node_exporter.tar.gz
    mv node_exporter-0.15.2.linux-amd64/node_exporter /usr/local/bin/node_exporter
    chmod +x /usr/local/bin/node_exporter
  COMMAND
  action :nothing
end

poise_service 'node_exporter' do
  user node['user']
  command '/usr/local/bin/node_exporter'
  action %i[enable start]
end
