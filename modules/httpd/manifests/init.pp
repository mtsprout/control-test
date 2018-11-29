class httpd {

  package { 'httpd':
    ensure => absent,
  }
}
