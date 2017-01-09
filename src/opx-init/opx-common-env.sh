#!/bin/bash

#
# OPX Common Environment Settings
#

# Syslog settings
LOGSYSLOG="SYSLOG"
LOGCONSOLE="CONSOLE"
LOGLVLDBG="DBG"
LOGLVLINFO="INFO"
LOGLVLERR="ERR"
SYSLOGDBG="-v${LOGSYSLOG}:${LOGLVLDBG}"
SYSLOGINFO="-v${LOGSYSLOG}:${LOGLVLINFO}"
SYSLOGERR="-v${LOGSYSLOG}:${LOGLVLERR}"
CONSDBG="-v${LOGCONSOLE}:${LOGLVLDBG}"
CONSINFO="-v${LOGCONSOLE}:${LOGLVLINFO}"
CONSERR="-v${LOGCONSOLE}:${LOGLVLERR}"
LOGDEFAULT=${SYSLOGINFO}

# Required directories
PASSWDDIR=$SNAP_DATA/var/run/ops-passwd-srv
CFGDIR=$SNAP_DATA/etc/opx

# Override the default install_path and data_path in OPX
export OPX_INSTALL_PATH=$SNAP
export OPX_DATA_PATH=$SNAP_DATA
export PATH=/snap/opx-vm/x1/bin:/snap/opx-vm/x1/usr/bin:$PATH
export LD_LIBRARY_PATH=$SNAP/lib:$SNAP/usr/lib/x86_64-linux-gnu
export PYTHONPATH=$SNAP/usr/lib/opx:$SNAP/usr/lib/x86_64-linux-gnu/opx
