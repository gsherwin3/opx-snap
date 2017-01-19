#!/bin/bash

#
# OPX Environment Settings
#
source $SNAP/usr/bin/opx-common-env

# Required directories
BINDIR=$SNAP/usr/bin
BNDIR=$SNAP/bin
SBINDIR=$SNAP/usr/sbin
LCLDBDIR=$SNAP_DATA/var/local/opx
LOGDIR=$SNAP_DATA/var/log
PIDDIR=$DBDIR
CTLDIR=$PIDDIR
SCHEMADIR=$SNAP/usr/share/opx

# Override the default dir locations in opx
export OVS_SYSCONFDIR=$SNAP/etc
export OVS_PKGDATADIR=$SCHEMADIR
export OVS_RUNDIR=$DBDIR
export OVS_LOGDIR=$LOGDIR
export OVS_DBDIR=$DBDIR

# Required for GO
export GOROOT=$SNAP/usr/lib/go-1.6
export GOPATH=$SNAP
