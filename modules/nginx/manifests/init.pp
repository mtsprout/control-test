class nginx {

  package { 'nginx':
    ensure  => 'present',
    require => Yumrepo['nginx'],
  }

  yumrepo { 'nginx':
    ensure    => 'present',
    assumeyes => 'true',
    enabled   => 'true',
    baseurl   => 'http://nginx.org/packages/centos/$releasever/$basearch/',
    gpgcheck  => 'false',
    target    => '/etc/yum.repos.d/nginx.repo'
  }

  file { '/usr/share/nginx/html':
    ensure  => 'directory',
    owner   => 'root',
    group   => 'webusers',
    mode    => '2775',
    require => Package['nginx'],
  }

  file { '/usr/share/nginx/html/index.html':
    ensure   => 'present',
    owner    => 'root',
    group    => 'webusers',
    content  => epp('nginx/index.html.epp'),
    mode     => '0664',
    require  => File['/usr/share/nginx/html'],
  }

  service { 'nginx':
    ensure => running,
  }

  user { 'csprout':
    ensure     => 'present',
    uid        => '1001',
    gid        => '1001',
    groups     => 'webusers',
    home       => '/home/csprout',
    shell      => '/bin/bash',
    managehome => 'true',
  }

  group { 'webusers' :
    ensure => 'present',
    gid    => '5000',
    before => User['csprout']
    }

  group { 'csprout' :
    ensure => 'present',
    gid    => '1001',
    before => User['csprout']
  }
}
