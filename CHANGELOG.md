# CHANGELOG

## 0.1.39

* SLES11SP4 support

## 0.1.38

* allow **logrotate::logs::postrotate** to be an array

## 0.1.37

* added SLES 12.3 support
* added **compresscmd** and **uncompresscmd**
* added variable to disable basic config for wtmp and btmp (**enforce_wtmp_and_btmp**)

## 0.1.36

* added Ubuntu 18.04 support

## 0.1.35

* added sharedscripts option to **logrotate::logs**

## 0.1.34

* rewrite puppet_managed_dir for **logrotate::logs**

## 0.1.33

* bugfix template logrotate.conf

## 0.1.32

* bugfix puppet managed dir

## 0.1.31

* added **puppet_managed_dir** as a varible to be able to customize it

## 0.1.30

* ubuntu16 support

## 0.1.29

* added dependency **logrotate** dependency for **logrotate::logs**

## 0.1.27

* autoinclude **::logrotate** in **logrotate::logs**

## 0.1.26

* SLES11SP3 support

## 0.1.25

* bugfix default su option on CentOS
