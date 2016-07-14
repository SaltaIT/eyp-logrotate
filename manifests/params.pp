class logrotate::params {

  $package_logrotate='logrotate'
  $puppet_managed_dir='/etc/logrotate.d/puppet-managed'

  case $::osfamily
  {
    'redhat':
        {
      case $::operatingsystemrelease
      {
        /^[6-7].*$/:
        {
          $su_default=undef
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }

    }
    'Debian':
    {
      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^14.*$/:
            {
              $su_default='root syslog'
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
