#!/bin/env sh

build_i386 () {
	cd arch/i386 && make && cd ../..
	cd kern && make && cd ..
	make
}

set -e

[ "$1" = "i386" ] && build_i386

