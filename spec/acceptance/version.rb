
_osfamily               = fact('osfamily')
_operatingsystem        = fact('operatingsystem')
_operatingsystemrelease = fact('operatingsystemrelease').to_f

case _osfamily
when 'RedHat'
  $packagename     = 'logrotate'
  $baseconf        = '/etc/logrotate.conf'
  $example_nginx   = '/etc/logrotate.d/puppet-managed/rotatnginx'
  $example_bitban  = '/etc/logrotate.d/puppet-managed/bitban1'
  $example_demo    = '/etc/logrotate.d/puppet-managed/example'


when 'Debian'
  $packagename     = 'logrotate'
  $baseconf        = '/etc/logrotate.conf'
  $example_nginx   = '/etc/logrotate.d/puppet-managed/rotatnginx'
  $example_bitban  = '/etc/logrotate.d/puppet-managed/bitban1'
  $example_demo    = '/etc/logrotate.d/puppet-managed/example'


else
  $packagename     = '-_-'
  $baseconf        = '-_-'
  $example_nginx   = '-_-'
  $example_bitban  = '-_-'
  $example_demo    = '-_-'

end
