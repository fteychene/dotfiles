#!/usr/bin/env bash

function decrypt_tool {
  local SOURCE_DIR=$1
  local TMP_DIR=$2
  if [ ! -d "$TMP_DIR" ]; then
    mkdir -p $TMP_DIR
  fi
  echo "Decypt p4merge tools"
  openssl aes-256-cbc -d -in $BASE_DIR/tool.tgz -out $TMP_DIR/tool.tgz
}

function extract_tool {
  local DEST_DIR=$1
  local ARCHIVE=$2
  if [ ! -d "$DEST_DIR" ]; then
    mkdir -p $DEST_DIR
  fi
  echo "Extracting p4merge tool"
  tar -xzf $ARCHIVE -C $DEST_DIR

}

BASE_DIR="$( cd "$( dirname "$0" )" && pwd )"
INSTALLATION_DIR="/opt/p4merge"
TMP_DIR="/tmp/p4merge_install"

decrypt_tool $BASE_DIR $TMP_DIR
extract_tool $TMP_DIR $TMP_DIR/tool.tgz
mv $TMP_DIR/p4v-2015.2.1458499 $INSTALLATION_DIR

rm -Rf $TMP_DIR
