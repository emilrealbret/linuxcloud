#!/bin/sh
USERNAME="skoftp"
PASSWORD="Kode1234!!!!"
SERVER="20.56.65.145"
 
# local directory to pickup .tar.gz file
FILE="/tmp/backup"
 
# remote server directory to upload backup
BACKUPDIR="/pro/backup/sql"
 
# login to remote server
ftp -n -i $SERVER <<EOF
user $USERNAME $PASSWORD
cd $BACKUPDIR
mput $FILE/.tar.gz
quit
EOF