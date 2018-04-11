#!/usr/bin/env bash

SCALA_VERSION="2.12.1"
SCALA_HOME="scala-$SCALA_VERSION"
INSTALL_DIRECTORY="/opt/scala"
TMP_DIRECTORY="/tmp/scala_install"

function get_scala {
  local TMP_DIR=$1
  if [ ! -d "$TMP_DIR" ]; then
    mkdir -p $TMP_DIR
  fi
  SCALA_ARCHIVE=$TMP_DIR/scala-$SCALA_VERSION.tar.gz
  echo "Download scala binary"
  wget --no-check-certificate --no-cookies \
    --output-document=$SCALA_ARCHIVE \
    http://downloads.lightbend.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz

}

function extract_scala {
  local DEST_DIR=$1
  local ARCHIVE=$2
  if [ ! -d "$DEST_DIR" ]; then
    mkdir -p $DEST_DIR
  fi
  echo "Extracting scala"
  tar -xzf $ARCHIVE -C $DEST_DIR
}

function create_bin_links {
  echo "Create links for commands"
  commands=( "scala" "scalac" "scaladoc" "scalap" )
  for command in "${commands[@]}"; do
    ln -sf $INSTALL_DIRECTORY/$SCALA_HOME/bin/$command /usr/bin/$command
  done
}

if [ -d "$INSTALL_DIRECTORY/$SCALA_HOME" ]; then
  echo "Scala $SCALA_VERSION already installed"
  exit 0;
fi

get_scala $TMP_DIRECTORY
extract_scala $INSTALL_DIRECTORY $SCALA_ARCHIVE

echo "Give write permission for group"
chmod -R g+w $INSTALL_DIRECTORY

echo "Clean tmp directory"
rm -Rf $TMP_DIR

echo "Installation completed"
