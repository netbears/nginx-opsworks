
directory "#{node['deploy_to']}/shared" do
  owner node['user']
  group node['group']
  action :create
  recursive true
end

directory "#{node['application']['log_directory']}" do
  owner node['user']
  group node['group']
  action :create
  recursive true
end

directory "#{node['deploy_to']}/shared" do
  owner node['user']
  group node['group']
  action :create
  recursive true
end

app = search('aws_opsworks_app').first

execute "chown -R #{node['user']}:#{node['group']} #{node['deploy_to']}"

deploy app['name'] do
  repo app['app_source']['url']
  revision app['app_source']['revision']
  migrate false
  symlink_before_migrate({})
  symlinks ({})
  deploy_to node['deploy_to']
  user node['user']
  group node['group']
  rollback_on_error true
  enable_submodules false
end

current = "#{node['deploy_to']}/current"
shared = "#{node['deploy_to']}/shared"

node['deploy_install'].each do |run_cmd|
  execute run_cmd do
    user node['user']
    environment 'HOME' => shared
    cwd current
  end
end

service "nginx" do
  action :reload
end

service "php7.0-fpm" do
  action :reload
end
