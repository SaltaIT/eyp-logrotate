define logrotate::logs(
                        $log           = undef,
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
                        $create_mode   = undef,
                        $create_owner  = undef,
                        $create_group  = undef,
                        $custom_file   = undef,
                      ) {

  #
  if($custom_file!=undef)
  {
    validate_absolute_path($custom_file)
    $logrotate_filename=$custom_file
  }
  else
  {
    $logrotate_filename="${logrotate::params::puppet_managed_dir}/${namelog}"
  }

  if($ensure=='present' and $log==undef)
  {
    fail('Must pass log to Logrotate::Logs while ensuring it is present')
  }

  file { $logrotate_filename:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => [ Package[$logrotate::params::package_logrotate], File[$logrotate::params::puppet_managed_dir] ],
    content => template("${module_name}/logfile_template.erb")
  }

}
