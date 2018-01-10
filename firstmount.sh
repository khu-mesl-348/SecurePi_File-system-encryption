#!bin/bash

if [ ! -d /etc/keys ]
then
su -c 'mkdir /etc/keys'
fi

ecryptfsd
ecryptfs-generate-tpm-key -p 0 -p 2 -p 3 | sudo tee /etc/keys/keyuuid

su -c 'sed -i 1,4d /etc/keys/keyuuid'
su -c "sed -i 's/And registered in persistent storage with UUID (tspi_uuid parameter): //' /etc/keys/keyuuid"

if [ ! -d ./secret ]
then
su -c 'mkdir ./secret'
fi

uuid=$(su -c 'cat /etc/keys/keyuuid')

(echo 2; echo $uuid; echo 1; echo 1; echo n; echo n; echo yes; echo yes) | su -c 'mount -t ecryptfs secret secret'
