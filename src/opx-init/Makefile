BIN:=$(DESTDIR)/usr/bin

all:

install:
	install -d $(BIN)
	install -m 755 opx-common-env.sh $(BIN)/opx-common-env
	install -m 755 opx-env.sh $(BIN)/opx-env
	install -m 755 opx-sim-env.sh $(BIN)/opx-sim-env
	install -m 755 start-opx.sh $(BIN)/start-opx
	install -m 755 stop-opx.sh $(BIN)/stop-opx
	install -m 755 start-server.sh $(BIN)/start-server
	install -m 755 80-dn-virt-intf.rules $(BIN)/80-dn-virt-intf.rules 
