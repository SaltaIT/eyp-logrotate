class { 'logrotate': }

logrotate::logs { '/demo.log':
  postrotate => '/demo.sh'
}

logrotate::logs { '/demo_multi.log':
  postrotate => [ '/demo1.sh', '/demo2.sh' ],
}
