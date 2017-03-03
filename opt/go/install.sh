#!/usr/bin/env bash

GO_VERSION="1.7.5"
GO_HOME="go-$GO_VERSION"
INSTALL_DIRECTORY="/opt/go"
TMP_DIRECTORY="/tmp/go_install"

function get_go {
  local TMP_DIR=$1
  if [ ! -d "$TMP_DIR" ]; then
    mkdir -p $TMP_DIR
  fi
  GO_ARCHIVE=$TMP_DIR/go-$GO_VERSION.tar.gz
  echo "Download go binary"
  wget --no-check-certificate --no-cookies \
    --output-document=$GO_ARCHIVE \
    https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz

}

function extract_go {
  local DEST_DIR=$1
  local ARCHIVE=$2
  if [ ! -d "$DEST_DIR" ]; then
    mkdir -p $DEST_DIR
  fi
  echo "Extracting go"
  tar -xzf $ARCHIVE -C $DEST_DIR
  mv $DEST_DIR/go $DEST_DIR/$GO_HOME
}

function create_bin_links {
  echo "Create links for commands"
  commands=( "go" "gofmt" "godoc" )
  for command in "${commands[@]}"; do
    ln -sf $INSTALL_DIRECTORY/$GO_HOME/bin/$command /usr/bin/$command
  done
}

if [ -d "$INSTALL_DIRECTORY/$GO_HOME" ]; then
  echo "Go $GO_VERSION already installed"
  exit 0;
fi

get_go $TMP_DIRECTORY
extract_go $INSTALL_DIRECTORY $GO_ARCHIVE
create_bin_links

echo "Clean tmp directory"
rm -Rf $TMP_DIR

echo "Installation completed"
