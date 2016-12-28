# logrotate ![status ready](https://img.shields.io/badge/status-ready-brightgreen.svg) ![doc completed](https://img.shields.io/badge/doc-completed-brightgreen.svg)


#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What logrotate affects](#what-logrotate-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with logrotate](#beginning-with-logrotate)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)

## Overview

logrotate configuration

## Module Description

manages logrotate configuration files

## Setup

### What logrotate affects

Manages:
* logrotate package
* files and directories:
  * /etc/logrotate.conf
  * /etc/logrotate.d/puppet-managed

### Setup Requirements

This module requires pluginsync enabled

### Beginning with logrotate

```yaml
logrotates:
  nginxlogs:
    log: /LOGS/web/*.log
    rotate: 2
    frequency: daily
    notifempty: true
    compress: true
    missingok: true
    dateext: true
    postrotate: /etc/init.d/nginx reload
  opt_openresty_nginx_logs:
    log:
      - /opt/openresty/nginx/logs/access.log
      - /opt/openresty/nginx/logs/error.log
    rotate: 2
    frequency: daily
    notifempty: true
    compress: true
    missingok: true
    dateext: true
    postrotate: /etc/init.d/nginx reload
```

## Usage

example usage:

```puppet
class { 'logrotate': }

logrotate::logs { 'example':
  create_mode => '0777',
  rotate      => '3',
  log         => [ '/var/example/log1', '/var/example/log2' ],
}

logrotate::logs { 'bitban1':
  log           => '/deploy/VAR/local/elespanol/www.elespanol.com/BB3Logs/*log*',
  su            => [ 'bbt-deploy', 'bbt-deploy' ],
  rotate        => '2',
  frequency     => 'daily',
  notifempty    => true,
  compress      => true,
  delaycompress => true,
  missingok     => true,
}

logrotate::logs { 'rotatnginx':
  log        => '/LOGS/web/*.log',
  rotate     => '2',
  frequency  => 'daily',
  notifempty => true,
  compress   => true,
  missingok  => true,
  postrotate => '/etc/init.d/nginx reload',
}
```

### puppet managed configuration files

This is going to generate the following logrotate configuration files:

#### /etc/logrotate.d/puppet-managed/rotatnginx
```
/LOGS/web/*.log {
  rotate 2
  daily
  notifempty
  compress
  missingok
  postrotate
    /etc/init.d/nginx reload
  endscript
}
```
#### /etc/logrotate.d/puppet-managed/bitban1
```
/deploy/VAR/local/elespanol/www.elespanol.com/BB3Logs/*log* {
  su bbt-deploy bbt-deploy
  rotate 2
  daily
  notifempty
  compress
  delaycompress
  missingok
}
```

#### /etc/logrotate.d/puppet-managed/example

```
/var/example/log1 /var/example/log2 {
  create 0777 root root
  rotate 3
}
```



## Reference

### classes

#### logrotate

* **ensure**: package status (default: installed)
* **overwrite_default_logrotate_conf**: (default: true)
* default behaviour:
  * **compress**: compress log files (default: true)
  * **dateext**: use date as a suffix of the rotated file (default: true)
  * **create**: create new (empty) log files after rotating old ones (default: true)
  * **rotate**: keep rotations worth of backlogs (default: 4)
  * **frequency**: log rotation frequency (default: weekly)

### defines

#### logrotate::logs

* **log**: log files to rotate (it can be an array or string)
* **namelog**: (default: resource's name)       
* **ensure**: log rotation config file presence (default: present)
* **su**: array, change ownership (default: undef)
* **rotate**: keep rotations worth of backlogs (default: undef)
* **maxage**: Remove  rotated  logs older than **maxage** days (default: undef)
* **compress**: compress log files (default: undef)
* **delaycompress**: Postpone compression of the previous log file to the next rotation cycle (default: undef)
* **notifempty**: Do not rotate if file is empty (default: undef)
* **frequency**: log rotation frequency (default: undef)
* **missingok**: If the log file is missing, go on to the next one without issuing an error message (default: undef)
* **postrotate**: post rotation action (default: undef)
* **dateext**: use date as a suffix of the rotated file (default: false)
* **copytruncate**: Truncate the original log file to zero size in place after creating a copy (default: false)
* **size**: Log files are rotated only if they grow bigger then **size** bytes (default: undef)
* **create_mode**: file creation mode, if create_owner and/or create_group are defined, defaults to 0640 (default: undef)
* **create_owner**: file creation owner, if create_mode and/or create_group are defined, defaults to root (default: undef)
* **create_group**: file creation group, if create_mode and/or create_group are defined, defaults to root (default: undef)
* **custom_file**: create log file rotation on a custom file path (default: undef)

## Limitations

Tested on:
* Ubuntu 14.04
* CentOS 5
* CentOS 6
* CentOS 7

## Development

We are pushing to have acceptance testing in place, so any new feature must
have tests to check both presence and absence of any feature

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
