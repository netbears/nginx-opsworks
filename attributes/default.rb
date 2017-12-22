default['user'] = default['group'] = 'www-data'
default['deploy_to'] = '/srv/www'

default['base_packages'] = %w(
  composer
  default-jre
  libgtop2-dev
  libpcre3
  libpcre3-dev
  libphp-phpmailer
  memcached
  php-memcached
  php-oauth
  php-pear
  php-redis
  php-curl
  php-dev
  php-gd
  php-intl
  php-mbstring
  php-mcrypt
  php-xml
  php-mysql
  php-xmlrpc
  php-imagick
  php-apcu
  php-zip
  php-soap
  zip
  unzip
  apt-transport-https
  python-pip
  language-pack-en
  nginx
)

default['npm_packages'] = %w(
  uglify-js
  uglifycss
  npm-cache
  grunt
  grunt-cli
  grunt-contrib-concat
  bower

)

default['php_extensions'] = []

default['build-essential']['compile_time'] = true

# php custom configuration
default['php_custom']['upload_max_filesize'] = '32M'
default['php_custom']['post_max_size'] = '32M'
default['php_custom']['apc.shm_size'] = '2048M'
default['php_custom']['memory_limit'] = '2048M'


default['deploy_install'] = []
