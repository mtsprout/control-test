class nginx {

  package { 'nginx':
    ensure  => present,
    require => Package['httpd']
  }

  file { '/usr/share/nginx/html':
    ensure  => directory,
    owner   => 'root',
    group   => 'webdevs',
    mode    => '2775',
    require => Package['nginx'],
  }

  file { '/usr/share/nginx/html/index.html':
    ensure  => file,
    owner   => 'root',
    group   => 'webdevs',
    content => epp('httpd/index.html.epp'),
    mode    => '0664',
    require => File['/usr/share/nginx/html'],
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
}
