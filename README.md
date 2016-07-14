# logrotate

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

TODO

## Reference

### classes

#### logrotate

* ensure                           = 'installed',
* compress                         = true,
* dateext                          = true,
* overwrite_default_logrotate_conf = true,
* create                           = true,
* rotate                           = '4',
* frequency                        = 'weekly',

### defines

#### logrotate::logs

* log,
* namelog       = $name,
* ensure        = 'present',
* su            = undef,
* rotate        = undef,
* maxage        = undef,
* compress      = undef,
* delaycompress = undef,
* notifempty    = undef,
* frequency     = undef,
* missingok     = undef,
* postrotate    = undef,
* dateext       = false,
* copytruncate  = false,
* size          = undef,
* create_mode   = undef,
* create_owner  = undef,
* create_group  = undef,
* custom_file   = undef,

## Limitations

Tested on Ubuntu 14.04, should also work on CentOS

## Development

We are pushing to have acceptance testing in place, so any new feature must
have tests to check both presence and absence of any feature

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
