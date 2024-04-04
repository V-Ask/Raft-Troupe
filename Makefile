MKID=node $(TROUPE)/rt/built/p2p/mkid.js
MKALIASES=node $(TROUPE)/rt/built/p2p/mkaliases.js
START=$(TROUPE)/network.sh
LOCAL=$(TROUPE)/local.sh



run: build/node_dest.trp
	$(LOCAL) ./build/node_dest.trp

build/node_dest.trp: node.trp libs/log.trp libs/leader-info.trp libs/key-val.trp libs/tests.trp
	python build.py node.trp

zero.listener1:
	$(START) zero.trp --id=ids/node1.json --aliases=aliases.json --stdiolev={} # --debug --debugp2p
zero.listener2:
	$(START) zero.trp --id=ids/node2.json --aliases=aliases.json --stdiolev={} # --debug --debugp2p
zero.listener3:
	$(START) zero.trp --id=ids/node3.json --aliases=aliases.json --stdiolev={} # --debug --debugp2p

raft.dialer: build/node_dest.trp
	$(START) ./build/node_dest.trp --id=ids/raft-dialer.json --aliases=aliases.json # --debug --debugp2p


create-network-identifiers:
	mkdir -p ids 
	$(MKID) --outfile=ids/raft-dialer.json
	$(MKID) --outfile=ids/node1.json
	$(MKID) --outfile=ids/node2.json
	$(MKID) --outfile=ids/node3.json
	$(MKID) --outfile=ids/node4.json
	$(MKID) --outfile=ids/node5.json
	$(MKALIASES) --include ids/raft-dialer.json --include ids/node1.json --include ids/node2.json --include ids/node2.json --include ids/node3.json --include ids/node4.json --include ids/node5.json --outfile aliases.json
