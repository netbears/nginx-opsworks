name             'netbears_nginx'
maintainer       'NETBEARS'
license          'All rights reserved'
description      'Installs/Configures netbears_nginx'
long_description 'Installs/Configures netbears_nginx'
version          '1.5.7'

depends 'build-essential'
depends 'git'
depends 'php-fpm', '~> 0.7.9'
depends 'chef_nginx', '~> 6.1.1'
depends 'systemd'
depends 'poise-service'
depends 'logrotate'
depends 'sudo'

supports 'ubuntu', '= 16.04'