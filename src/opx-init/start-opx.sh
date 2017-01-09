#!/usr/bin/env bash

# Setup /var/run, /run and /var/log
/usr/bin/test -d $SNAP_DATA/run || mkdir -p $SNAP_DATA/run
/usr/bin/test -d $SNAP_DATA/var || mkdir -p $SNAP_DATA/var
/usr/bin/test -d $SNAP_DATA/var/log || mkdir -p $SNAP_DATA/var/log
/usr/bin/test -d $SNAP_DATA/var/log/redis || mkdir -p $SNAP_DATA/var/log/redis
/usr/bin/test -L $SNAP_DATA/var/run || ln -s $SNAP_DATA/run $SNAP_DATA/var/run

#
# Appliance / Simulation
#
source $SNAP/usr/bin/opx-sim-env

# Setup OpenSwitch environment variables
source $SNAP/usr/bin/opx-env
echo HACK STARTING: OPX 
$BINDIR/redis-server $SNAP/etc/redis/redis.conf &
$BNNDIR/opx_cps_service &
$BINDIR/python  $SNAP/usr/lib/opx/cps_db_stunnel_manager.py
$BINDIR/opx_nas_daemon &
$BINDIR/base_nas_front_panel_ports.sh &
$BINDIR/base-nas-shell.sh &
$BINDIR/base_nas_create_interface.sh &
$BINDIR/base_nas_fanout_init.sh && $SNAP/usr/bin/network_restart.sh
$BINDIR/base_acl_copp_svc.sh &
$BINDIR/base_nas_default_init.sh &
echo HACK ENDING: OPX

