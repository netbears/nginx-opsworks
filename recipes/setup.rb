file "/etc/apt/sources.list.d/nginx.list" do
  content "deb http://nginx.org/packages/ubuntu/ xenial nginx\ndeb-src http://nginx.org/packages/ubuntu/ xenial nginx"
end
execute 'wget http://nginx.org/keys/nginx_signing.key'
execute 'apt-key add nginx_signing.key'
execute 'rm nginx_signing.key'

execute 'apt-get update'

node['base_packages'].each do |pkg|
  package pkg
end

# Install php-fpm
include_recipe 'php-fpm::default'

# Add awscli
bash "install-awscli" do
  user "root"
  code <<-SCRIPT
    export LC_ALL="en_US.UTF-8" && \
    export LC_CTYPE="en_US.UTF-8" && \
    pip install --upgrade pip && \
    pip install awscli --upgrade
  SCRIPT
end

# Install npm and npm packges
execute 'curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y nodejs'
execute "npm install --global #{node['npm_packages'].join(' ')}"

include_recipe 'netbears_nginx::php_custom'
include_recipe 'netbears_nginx::logrotate'
include_recipe 'netbears_nginx::node_exporter'
include_recipe 'netbears_nginx::configure_nginx'
