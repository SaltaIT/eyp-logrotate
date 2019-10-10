class logrotate::params {

  $package_logrotate='logrotate'
  $puppet_managed_dir_default='/etc/logrotate.d/puppet-managed'

  case $::osfamily
  {
    'redhat':
    {
      $enforce_wtmp_and_btmp_default = true
      case $::operatingsystemrelease
      {
        /^[5-8].*$/:
        {
          $su_default=undef
          $compresscmd_default=undef
          $uncompresscmd_default=undef
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }

    }
    'Debian':
    {
      $enforce_wtmp_and_btmp_default = true
      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^1[468].*$/:
            {
              $su_default='root syslog'
              $compresscmd_default=undef
              $uncompresscmd_default=undef
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    'Suse':
    {
      $enforce_wtmp_and_btmp_default = false
      case $::operatingsystem
      {
        'SLES':
        {
          case $::operatingsystemrelease
          {
            /^11.3$/:
            {
              $su_default=undef
              $compresscmd_default=undef
              $uncompresscmd_default=undef
            }
            /^12.[34]$/:
            {
              $su_default=undef
              $compresscmd_default='/usr/bin/xz'
              $uncompresscmd_default='/usr/bin/xzdec'
            }
            default: { fail("Unsupported operating system ${::operatingsystem} ${::operatingsystemrelease}") }
          }
        }
        default: { fail("Unsupported operating system ${::operatingsystem}") }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
