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

	printf ">>> bird6 configuration >>>>>>>>>>>>>>>>>\n"
	[ -f /run/bird/bird6.con ] && cp /run/bird/bird6.conf /etc/bird/bird6.conf
	cat /etc/bird/bird6.conf
	printf "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n\n"

        echo "executing bird daemon..."
        /usr/sbin/bird -c /etc/bird/bird.conf
        sleep 1;
        echo "executing bird6 daemon..."
        /usr/sbin/bird6 -c /etc/bird/bird6.conf
        sleep 1;

	while true; do
                if ! pidof bird > /dev/null; then
                        echo "Bird died. Terminating."
                        exit 1
                fi

                if ! pidof bird6 > /dev/null; then
                        echo "Bird6 died. Terminating."
                        exit 1
                fi
                sleep 5
	done
}

[ -n "$ENVFILE" ] && . "$ENVFILE"

run_bird
exit 0
