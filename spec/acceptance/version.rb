
_osfamily               = fact('osfamily')
_operatingsystem        = fact('operatingsystem')
_operatingsystemrelease = fact('operatingsystemrelease').to_f

case _osfamily
when 'RedHat'
  $packagename     = 'logrotate'
  $baseconf        = '/etc/logrotate.conf'

when 'Debian'
  $packagename     = 'logrotate'
  $baseconf        = '/etc/logrotate.conf'

else
  $packagename     = '-_-'
  $baseconf        = '-_-'
end
