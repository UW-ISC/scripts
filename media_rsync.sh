#!/usr/bin/env bash

here=`find . -name scripts`
vars="$here/envvars.sh"
source $vars

src_path="$REMOTE_USERNAME@$REMOTE_ADDRESS:$REMOTE_WORDPRESS_PATH/wp-content/uploads/"
dest_path="$WORDPRESS_PATH/wp-content/uploads/"

rsync_cmd="rsync -azv -e ssh $dest_path $src_path"
echo "Currently this is just set to give the command to copy TO this host."
echo $rsync_cmd
