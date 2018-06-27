#!/bin/sh

set -e

term() {
	echo "Terminating..."
	exit 0
}

die() {
	echo "$@"
	exit 1
}

set_defaults() {
	true
}

validate_input() {
	true
}

run_bird() {
	echo "Applying defaults..."
	set_defaults
	echo "Validating input..."
	validate_input
	printf ">>> bird configuration >>>>>>>>>>>>>>>>>\n"
	[ -f /run/bird/bird.con ] && cp /run/bird/bird.conf /etc/bird/bird.conf
	cat /etc/bird/bird.conf
	printf "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n\n"

	trap term TERM
	while true; do
		echo "executing bird daemon..."
		/usr/sbin/bird -c /etc/bird/bird.conf -f
		sleep 3;
		echo "reload..."
	done
}

[ -n "$ENVFILE" ] && . "$ENVFILE"

run_bird
exit 0
