#!/bin/sh
# Script to dump a database backup, keeping one previous backup so that we 
# aren't overwriting our good copy if it fails.

vars="$HOME/scripts/envvars.sh"
source $vars

##### required configuration parameters #################

MYSQL_BACKUP_PASSWORD="$BACKUP_PASSWORD"

###### end configuration -- see below for requirements ##

MYSQL_BACKUP_USER=readonly
MYSQL_BACKUP_DIR="$HOME/mysql_backup"
MYSQL_BINDIR="/usr/local/mysql/bin"

# MYSQL_BACKUP_DIR
	# directory name to store the backup file; readable and writable only
	# by the user that will invoke this script.
# MYSQL_BACKUP_USER
	# name of a mysql database account which has SELECT and LOCK TABLES privileges 
	# on all databases
# MYSQL_BACKUP_PASSWORD
	# put the password to your backup user in MySQL here.
# MYSQL_BACKUP_PASSWORD_FILE (old version)
	# filename containing the password for MYSQL_BACKUP_USER, as 
	# first line in the file; readable only by the user that will
	# invoke this script.
# MYSQL_BINDIR
	# location of the mysqldump binary

###### end requirements

if [ -z "$MYSQL_BACKUP_DIR" ] ; then
	echo "MYSQL_BACKUP_DIR must be defined."
	exit
fi
if ! [ -d "$MYSQL_BACKUP_DIR" ] ; then
	(mkdir -p "$MYSQL_BACKUP_DIR") || exit
fi

if [ -z "$MYSQL_BACKUP_USER" ] ; then
	echo "MYSQL_BACKUP_USER must be defined."
	exit
fi

if [ "$MYSQL_BACKUP_PASSWORD" == "BACKUP_PASSWORD" ] ; then
	echo "MYSQL_BACKUP_PASSWORD must be defined.";
fi

BACKUP_FILE="${MYSQL_BACKUP_DIR}/backup.sql"

# keep one previous backup
[ -f "${BACKUP_FILE}"  ] && mv "${BACKUP_FILE}" "${BACKUP_FILE}.0"

${MYSQL_BINDIR}/mysqldump -u $MYSQL_BACKUP_USER --password=$MYSQL_BACKUP_PASSWORD --opt --all-databases > $BACKUP_FILE 2>&1 | grep -v "mysqldump: [Warning] Using a password on the command line interface can be insecure."
