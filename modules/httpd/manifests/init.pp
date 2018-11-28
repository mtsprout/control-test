class httpd {

  package { 'httpd':
    ensure => present,
  }

  file { '/var/www/html':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Package['httpd'],
  }

  file { '/var/www/html/index.html':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    content => epp('httpd/index.html.epp'),
    mode    => '0644',
    require => File['/var/www/html'],
  }

  service { 'httpd':
    ensure => running,
  }
}
