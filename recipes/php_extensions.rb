directory node['php']['ext_conf_dir'] do
  mode '0755'
end

node['php_extensions'].each do |ext|
  if ext.respond_to?(:keys)
    php_pear ext[:name] do
      preferred_state ext[:preferred_state] unless ext[:preferred_state].nil?
      version ext[:version] unless ext[:version].nil?
      action :install
    end
    name = "#{ext[:name]}.ini"
  else
    php_pear ext do
      action :install
    end
    name = "#{ext}.ini"
  end

  link File.join(node['php']['ext_conf_dir'], '../fpm/conf.d', name).to_s do
    to File.join(node['php']['ext_conf_dir'], name).to_s
  end
end