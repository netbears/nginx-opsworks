default['application']['website']               = "yourdomain.com"
default['application']['web_root']              = "/public"
default['application']['environment']           = "PROD"
default['application']['log_directory']         = "/var/log/app"
default['application']['dns']                   = %w(
  alternate1.yourdomain.com
  alternate2.yourdomain.com
  www.yourdomain.com
)

