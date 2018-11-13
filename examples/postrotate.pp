class { 'logrotate': }

logrotate::logs { 'single_line_postrotate':
  log        => '/demo.log',
  postrotate => '/demo.sh'
}

logrotate::logs { 'multi_postrotate':
  log        => '/demo_multi.log',
  postrotate => [ '/demo1.sh', '/demo2.sh' ],
}
