
_osfamily               = fact('osfamily')
_operatingsystem        = fact('operatingsystem')
_operatingsystemrelease = fact('operatingsystemrelease').to_f

case _osfamily
when 'RedHat'
  $packagename     = 'logrotate'

when 'Debian'
  $packagename     = 'logrotate'

else
  $packagename     = '-_-'
end
