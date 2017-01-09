#!/bin/bash

#
# OPX VM Environment Settings
#
source $SNAP/usr/bin/opx-common-env

# Required directories
BINDIR=$SNAP/usr/bin
BNDIR=$SNAP/bin
SBINDIR=$SNAP/sbin
LOGDIR=$SNAP_DATA/var/log
SCHEMADIR=$SNAP/opt/opx/share/opx
PIDDIR=$DBDIR
CTLDIR=$PIDDIR

# Override the default dir locations in opx
export OVS_SYSCONFDIR=$SNAP/etc
export OVS_PKGDATADIR=$SCHEMADIR
export OVS_RUNDIR=$DBDIR
export OVS_LOGDIR=$LOGDIR
export OVS_DBDIR=$DBDIR
