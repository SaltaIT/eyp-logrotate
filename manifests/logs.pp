define logrotate::logs(
                        $log,
                        $namelog       = $name,
                        $ensure        = 'present',
                        $su            = undef,
                        $rotate        = undef,
                        $maxage        = undef,
                        $compress      = undef,
                        $delaycompress = undef,
                        $notifempty    = undef,
                        $frequency     = undef,
                        $missingok     = undef,
                        $postrotate    = undef,
                        $dateext       = false,
                        $copytruncate  = false,
                        $size          = undef,
                      ) {

  #
  file { "${logrotate::params::puppet_managed_dir}/${namelog}":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => [ Package[$logrotate::params::package_logrotate], File[$logrotate::params::puppet_managed_dir] ],
    content => template("${module_name}/logfile_template.erb")
  }

}
