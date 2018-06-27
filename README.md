# bird routing daemon

This container image provides bird 1.5.0 (bird.network.cz)
on ubuntu 16.04.4.

FIB manipulation currently requires some capability:
	NET_ADMIN, SYS_ADMIN, SETPCAP, NET_RAW

### Configuration

Configuration is done by supplying a bird.conf file
in /run/bird/bird.conf. If no config file is supplied
on startup, a default one is used.

