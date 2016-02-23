class logrotate (
      $compress = true,
      $dateext = true,
      $ensure = 'installed',
      $overwrite_default_logrotate_conf=true,
    ) inherits logrotate::params {

  package { $logrotate::params::package_logrotate:
    ensure => $ensure,
  }

  if($ensure == 'installed')
  {

    if($overwrite_default_logrotate_conf)
    {
      file { '/etc/logrotate.conf':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('logrotate/logrotateconf.erb'),
        require => Package[$logrotate::params::package_logrotate],
      }
    }

    file { $logrotate::params::puppet_managed_dir:
      ensure  => 'directory',
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      recurse => true,
      purge   => true,
      require => Package[$logrotate::params::package_logrotate],
    }
  }

}
