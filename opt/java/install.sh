#!/usr/bin/env bash

JAVA_VERSION="1.8.0_152"
JDK_NAME="jdk$JAVA_VERSION"
INSTALL_DIRECTORY="/opt/java"
TMP_DIRECTORY="/tmp/jdk_install"

function get_jdk {
  local TMP_DIR=$1
  if [ ! -d "$TMP_DIR" ]; then
    mkdir -p $TMP_DIR
  fi
  JDK_ARCHIVE=$TMP_DIR/jdk.tar.gz
  echo "Download jdk"
  wget --no-check-certificate --no-cookies \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    --output-document=$JDK_ARCHIVE \
    http://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-x64.tar.gz

}

function extract_jdk {
  local DEST_DIR=$1
  local ARCHIVE=$2
  if [ ! -d "$DEST_DIR" ]; then
    mkdir -p $DEST_DIR
  fi
  echo "Extracting jdk"
  tar -xzf $ARCHIVE -C $DEST_DIR
}

function create_bin_links {
  echo "Create links for commands"
  commands=( "jar" "java" "javac" "javadoc" "javah" "javap" "javaws" "jcmd" "jconsole" "jarsigner" "jhat" "jinfo" "jmap" "jmc" "jps" "jstack" "jstat" "jstatd" "jvisualvm" "keytool" "policytool" "wsgen" "wsimport" )
  for command in "${commands[@]}"; do
    ln -sf $INSTALL_DIRECTORY/$JDK_NAME/bin/$command /usr/bin/$command
  done
}

function create_install_link {
  local INSTALL_DIRECTORY=$1
  echo "Create link $INSTALL_DIRECTORY/jdk to newly installed jdk"
  echo "ln -sdf $INSTALL_DIRECTORY/$JDK_NAME $INSTALL_DIRECTORY/jdk"
  ln -sTf $INSTALL_DIRECTORY/$JDK_NAME $INSTALL_DIRECTORY/jdk
}

if [ -d "$INSTALL_DIRECTORY/$JDK_NAME" ]; then
  echo "Java $JAVA_VERSION already installed"
  exit 0;
fi

get_jdk $TMP_DIRECTORY
extract_jdk $INSTALL_DIRECTORY $JDK_ARCHIVE
create_install_link $INSTALL_DIRECTORY

echo "Clean tmp directory"
rm -Rf $TMP_DIR

echo "Installation completed"
