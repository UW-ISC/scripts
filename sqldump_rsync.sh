#!/usr/bin/env bash

vars="$HOME/scripts/envvars.sh"
source $vars

src_path="$REMOTE_USERNAME@$REMOTE_DB_ADDRESS:$REMOTE_HOME/$MYSQL_BACKUP_DIR/"
dest_path="$HOME/$MYSQL_BACKUP_DIR/"

rsync_cmd="rsync -azO -e ssh $src_path $dest_path"
$rsync_cmd
