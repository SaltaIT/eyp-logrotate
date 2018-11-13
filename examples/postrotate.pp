class { 'logrotate': }

logrotate::logs { 'single line postrotate':
  log        => '/demo.log',
  postrotate => '/demo.sh'
}

logrotate::logs { 'multi postrotate':
  log        => '/demo_multi.log',
  postrotate => [ '/demo1.sh', '/demo2.sh' ],
}
