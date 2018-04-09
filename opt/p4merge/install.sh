#!/usr/bin/env bash

set -ue

function get_p4v {
  local TMP_DIR=$1
  if [ ! -d "$TMP_DIR" ]; then
    mkdir -p $TMP_DIR
  fi
  local P4V_ARCHIVE=$TMP_DIR/$2
  echo "Download p4merge binary"
  wget --no-check-certificate --no-cookies \
    --output-document=$P4V_ARCHIVE \
    http://www.perforce.com/downloads/perforce/r18.1/bin.linux26x86_64/p4v.tgz
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

if [ -d "$INSTALLATION_DIR" ]; then
  echo "p4merge already installed"
  exit 0;
fi

get_p4v $TMP_DIR p4v.tar.gz
extract_tool $TMP_DIR $TMP_DIR/p4v.tar.gz
mv $TMP_DIR/p4v-2018.1.1637591 $INSTALLATION_DIR

rm -Rf $TMP_DIR
