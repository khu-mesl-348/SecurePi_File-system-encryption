#!bin/bash

ecryptfsd
uuid=$(su -c 'cat /etc/keys/keyuuid')

(echo 2; echo $uuid; echo 1; echo 1; echo n; echo n) | su -c 'mount -t ecryptfs secret secret'
