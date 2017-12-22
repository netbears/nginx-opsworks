file '/etc/php/7.0/fpm/conf.d/custom.ini' do
  content node['php_custom'].map { |k, v| "#{k} = #{v}" }.join("\n")
end
