#!/usr/bin/env bash

# Setup OPX environment variables
source $SNAP/usr/bin/opx-env

DBSVR="ovsdb-server.pid"

for i in $PIDDIR/*.pid ; do
    pid=`cat $i`
    if [ -z "${i##*$DBSVR}" ] ; then
        dbsvrpid=$pid
    else
        kill -9 $pid
    fi
done

if [ ! -z "$dbsvrpid" ] ; then
    sleep 1
    kill -9 $dbsvrpid
fi

rm -f  $PIDDIR/*.pid
rm -f  $CTLDIR/*.ctl

# Delete the Appliance/Simulator
source $SNAP/usr/bin/opx-sim-env
for i in $PIDDIR/*.pid ; do
    pid=`cat $i`
    kill -9 $pid
done
rm -f  $PIDDIR/*.pid
rm -f  $CTLDIR/*.ctl

# The management interface daemon, ops_mgmtintfcfg, messes with
# /etc/resolv.conf and causes the system to lose access to DNS. Therefore
# when stopping the SNAP run resolvconf again on the management port to enable
# the eth0 management port to be fully used again after the SNAP has
# exited.
/bin/resolvconf -u > /dev/null 2>&1
