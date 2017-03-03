#!/usr/bin/env bash

MVN_VERSION="3.3.9"
M2_HOME="apache-maven-$MVN_VERSION"
INSTALL_DIRECTORY="/opt/maven"
TMP_DIRECTORY="/tmp/maven_install"

function get_maven {
  local TMP_DIR=$1
  if [ ! -d "$TMP_DIR" ]; then
    mkdir -p $TMP_DIR
  fi
  MAVEN_ARCHIVE=$TMP_DIR/maven.tar.gz
  echo "Download maven binary"
  wget --no-check-certificate --no-cookies \
    --output-document=$MAVEN_ARCHIVE \
    http://apache.trisect.eu/maven/maven-3/$MVN_VERSION/binaries/apache-maven-$MVN_VERSION-bin.tar.gz

}

function extract_maven {
  local DEST_DIR=$1
  local ARCHIVE=$2
  if [ ! -d "$DEST_DIR" ]; then
    mkdir -p $DEST_DIR
  fi
  echo "Extracting maven"
  tar -xzf $ARCHIVE -C $DEST_DIR
}

function create_bin_links {
  echo "Create links for commands"
  commands=( "mvn" )
  for command in "${commands[@]}"; do
    ln -sf $INSTALL_DIRECTORY/$M2_HOME/bin/$command /usr/bin/$command
  done
}

if [ -d "$INSTALL_DIRECTORY/$M2_HOME" ]; then
  echo "Maven $MVN_VERSION already installed"
  exit 0;
fi

get_maven $TMP_DIRECTORY
extract_maven $INSTALL_DIRECTORY $MAVEN_ARCHIVE

echo "Clean tmp directory"
rm -Rf $TMP_DIR

echo "Installation completed"
