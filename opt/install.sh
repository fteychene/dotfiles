#!/usr/bin/env bash

BASE_DIR="$( cd "$( dirname "$0" )" && pwd )"

$BASE_DIR/java/install.sh
$BASE_DIR/maven/install.sh
$BASE_DIR/scala/install.sh
$BASE_DIR/sbt/install.sh
$BASE_DIR/go/install.sh
$BASE_DIR/p4merge/install.sh
