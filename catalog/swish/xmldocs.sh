#! /bin/sh
if [ -d "$1" ]; then
	cd "$1"
fi
swish-e -S prog -c xmldocs.conf 
