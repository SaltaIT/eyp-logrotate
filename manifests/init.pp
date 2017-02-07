class logrotate (
                  $compress                         = true,
                  $dateext                          = true,
                  $ensure                           = 'installed',
                  $overwrite_default_logrotate_conf = true,
                  $create                           = true,
                  $rotate                           = '4',
                  $frequency                        = 'weekly',
                  $su                               = $logrotate::params::su_default,
                  $puppet_managed_dir               = $logrotate::params::puppet_managed_dir_default,
                ) inherits logrotate::params {

  package { $logrotate::params::package_logrotate:
    ensure => $ensure,
  }

  if($ensure == 'installed')
  {

    if($overwrite_default_logrotate_conf)
    {
      file { '/etc/logrotate.conf':
        ensure  => 'present',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("${module_name}/logrotateconf.erb"),
        require => Package[$logrotate::params::package_logrotate],
      }
    }

    file { $puppet_managed_dir:
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
