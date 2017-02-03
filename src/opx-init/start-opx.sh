#!/usr/bin/env bash

# Setup /var/run, /run and /var/log
/usr/bin/test -d $SNAP_DATA/run || mkdir -p $SNAP_DATA/run
/usr/bin/test -d $SNAP_DATA/var || mkdir -p $SNAP_DATA/var
/usr/bin/test -d $SNAP_DATA/var/log || mkdir -p $SNAP_DATA/var/log
/usr/bin/test -L $SNAP_DATA/var/run || ln -s $SNAP_DATA/run $SNAP_DATA/var/run
/usr/bin/test -d $SNAP_DATA/etc || mkdir -p $SNAP_DATA/etc

if [ ! -d  $SNAP_DATA/etc/opx ]
then
     mkdir -p $SNAP_DATA/etc/opx
     /bin/cp $SNAP/etc/opx/sai_vm_db.cfg $SNAP_DATA/etc/opx/sai_vm_db.cfg
     sed -i -e"s|\/opt\/dell\/os10\/sai-db|$SNAP_DATA\/etc\/opx|g" $SNAP_DATA/etc/opx/sai_vm_db.cfg
     /bin/cp $SNAP/etc/opx/*.sql $SNAP_DATA/etc/opx
fi

if [ ! -d  $SNAP_DATA/etc/opx/sdi ]
then
     mkdir -p $SNAP_DATA/etc/opx/sdi
    /bin/cp $SNAP/etc/opx/sdi/*.sql $SNAP_DATA/etc/opx/sdi
fi

if [ ! -d $SNAP_DATA/var/run/redis.conf ]
then
    mkdir -p $SNAP_DATA/var/log/redis
    mkdir -p $SNAP_DATA/var/lib
    mkdir -p $SNAP_DATA/var/lib/redis
    sed "s|logfile \/var\/log\/redis\/redis-server.log|logfile ${SNAP_DATA}\/var\/log\/redis\/redis-server.log|g" $SNAP/etc/redis/redis.conf > $SNAP_DATA/var/run/redis.conf
    sed -i -e"s|\/var\/lib\/redis|$SNAP_DATA\/var\/lib\/redis|g" $SNAP_DATA/var/run/redis.conf
fi

#
# Appliance / Simulation
#
source $SNAP/usr/bin/opx-sim-env

# Setup OPX environment variables
source $SNAP/usr/bin/opx-env

# Setup _opx_cps user
if ! getent group _opx_cps > /dev/null; then
    addgroup --quiet --system --force-badname _opx_cps
fi
if ! getent passwd  _opx_cps> /dev/null; then
    adduser --quiet --system  --force-badname --no-create-home --ingroup _opx_cps _opx_cps
fi

echo STARTING: OPX 
cd $SNAP_DATA/run
/bin/run-parts --verbose $SNAP/etc/redis/redis-server.pre-up.d
$BINDIR/redis-server $SNAP_DATA/var/run/redis.conf &
/bin/run-parts --verbose $SNAP/etc/redis/redis-server.post-up.d
$BINDIR/opx_cps_service &
$BINDIR/python  $SNAP/usr/lib/opx/cps_db_stunnel_manager.py &
$BINDIR/base_nas_monitor_phy_media.sh &
$BINDIR/base_nas_phy_media_config.sh &
#$BINDIR/opx_platform_init.sh
$BINDIR/opx_nas_daemon &
$BINDIR/opx_pas_service &
$BINDIR/base_nas_front_panel_ports.sh &
$BINDIR/base-nas-shell.sh &
$BINDIR/base_nas_create_interface.sh &
$BINDIR/base_nas_fanout_init.sh && $BINDIR/network_restart.sh &
$BINDIR/base_ip &
$BINDIR/base_acl_copp_svc.sh &
$BINDIR/base_nas_default_init.sh &
$BINDIR/base_qos_init.sh &
echo ENDING: OPX

