#!/bin/env bash

BASE_DIR="$( cd "$( dirname "$0" )" && pwd )"
HOSTNAME=`hostname`
SCRIPT=`basename "$0"`


if [ -d "$BASE_DIR/$HOSTNAME" ]
then
    . "$BASE_DIR/$HOSTNAME/$SCRIPT"
else 
    . "$BASE_DIR/basic/$SCRIPT"
fi