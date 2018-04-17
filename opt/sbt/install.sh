#!/usr/bin/env bash

SBT_VERSION="0.13.13"
SBT_HOME="sbt-$SBT_VERSION"
INSTALL_DIRECTORY="/opt/sbt"
TMP_DIRECTORY="/tmp/sbt_install"

function get_sbt {
  local TMP_DIR=$1
  if [ ! -d "$TMP_DIR" ]; then
    mkdir -p $TMP_DIR
  fi
  SBT_ARCHIVE=$TMP_DIR/sbt-$SBT_VERSION.tar.gz
  echo "Download sbt binary"
  wget --no-check-certificate --no-cookies \
    --output-document=$SBT_ARCHIVE \
    https://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz

}

function extract_sbt {
  local DEST_DIR=$1
  local ARCHIVE=$2
  if [ ! -d "$DEST_DIR" ]; then
    mkdir -p $DEST_DIR
  fi
  echo "Extracting sbt"
  tar -xzf $ARCHIVE -C $DEST_DIR
  mv $DEST_DIR/sbt-launcher-packaging-$SBT_VERSION $DEST_DIR/$SBT_HOME
}

function create_bin_links {
  echo "Create links for commands"
  commands=( "sbt" )
  for command in "${commands[@]}"; do
    ln -sf $INSTALL_DIRECTORY/$SBT_HOME/bin/$command /usr/bin/$command
  done
}

if [ -d "$INSTALL_DIRECTORY/$SBT_HOME" ]; then
  echo "Sbt $SBT_VERSION already installed"
  exit 0;
fi

get_sbt $TMP_DIRECTORY
extract_sbt $INSTALL_DIRECTORY $SBT_ARCHIVE

echo "Give write permission for group"
chown -R root:development $INSTALL_DIRECTORY
chmod -R g+w $INSTALL_DIRECTORY

echo "Clean tmp directory"
rm -Rf $TMP_DIR

echo "Installation completed"
