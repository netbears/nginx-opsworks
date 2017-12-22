# Create nginx directories
directory "#{node['nginx']['dir']}/sites-enabled" do
  owner 'root'
  group 'root'
  action :create
  recursive true
end

directory "#{node['nginx']['dir']}/sites-available" do
  owner 'root'
  group 'root'
  action :create
  recursive true
end

# Copy fastcgi.conf
template "#{node['nginx']['dir']}/fastcgi.conf" do
  source 'fastcgi.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'  
end

# Disable default site
file "/etc/nginx/sites-enabled/default" do
    action :delete
end

# The rest of the sites use the same vhost template file
template "#{node['nginx']['dir']}/sites-available/#{node['application']['website']}" do
  source "nginx_vhost.erb"
  owner 'root'
  group 'root'
  mode '0644'  
  variables({
    docroot: "#{node['deploy_to']}/current#{node['application']['web_root']}",
    server_name:  node['application']['website'],
    server_aliases: node['application']['dns'],
    basic_auth: false
  })  
end

# Set NGINX config
template "#{node['nginx']['dir']}/nginx.conf" do
  source 'nginx.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
    variables({
    user: node['user']
  })  
end

# Enable the virtual host
link "#{node['nginx']['dir']}/sites-enabled/#{node['application']['website']}" do
  to "#{node['nginx']['dir']}/sites-available/#{node['application']['website']}"
end

service "nginx" do
  action :restart
end
