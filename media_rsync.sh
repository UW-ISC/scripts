#!/usr/bin/env bash

here=`find . -name scripts`
vars="$here/envvars.sh"
source $vars

src_path="$REMOTE_USERNAME@$REMOTE_ADDRESS:$REMOTE_WORDPRESS_PATH/wp-content/uploads/"
dest_path="$WORDPRESS_PATH/wp-content/uploads/"

rsync_cmd="rsync -azO -e ssh $src_path $dest_path"
$rsync_cmd
