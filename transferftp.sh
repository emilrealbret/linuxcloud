#!/bin/bash

### MySQL Server Login Info ###
MUSER="root"
MPASS="Kode1234!!!!"
# mysql server
MHOST="localhost"
 
### FTP SERVER Login info ###
FTPU="LampstackBackup"
FTPP="Kode1234!!!!"
FTPS="20.56.65.145"
 
 
MYSQL="$(wordpress)"
MYSQLDUMP="$(which mysqldump)"
BAK="/backup/mysql"
GZIP="$(which gzip)"
NOW=$(date +"%d-%m-%Y")
 
[ ! -d $BAK ] && mkdir -p $BAK || /bin/rm -f $BAK/*
 
DBS="$($MYSQL -u $MUSER -h $MHOST -p$MPASS -Bse 'show databases')"
for db in $DBS
do
 FILE=$BAK/$db.$NOW-$(date +"%T").gz
 $MYSQLDUMP -u $MUSER -h $MHOST -p$MPASS $db | $GZIP -9 > $FILE
done
 
lftp -u $FTPU,$FTPP -e "mkdir /mysql/$NOW;cd /mysql/$NOW; mput /backup/mysql/*; quit" $FTPS