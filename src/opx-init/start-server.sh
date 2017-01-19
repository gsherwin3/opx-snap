#!/usr/bin/env bash

# Setup OPX environment variables
source $SNAP/usr/bin/opx-env
echo "STARTING: WebServer (RestAPI) using GO.."

#
$BINDIR/go run main.go
echo "ENDING: WebServer"

