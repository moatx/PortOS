#! /usr/bin/env sh

# defaults
oarg="build"
OBJDIR=

usage() {
cat <<_usage_
Usage: ${0##*/} [-o] target
targets:
	i386	build i386
Options:
	-o directory	output object files to a directory
_usage_
	exit 1
}


makeobjdir () {
	[ -z "$oarg" ] && usage
	[ "$oarg" == "$(ls -A .)" ] && echo "output directory already exists and is needed for the kernel" && exit 1
	[ ! -z "$(ls -A "$oarg")" ] && rm -r "$oarg"
	[ ! -d "$oarg" ] && mkdir "$oarg"
	OBJDIR=$(readlink -f "$oarg")
	echo "$OBJDIR"
	echo
}

build_i386 () {
	make clean
	cd arch/i386 && make OBJDIR="$OBJDIR" CPU=i386 && cd ../..
	cd kern && make OBJDIR="$OBJDIR" CPU=i386 && cd ..
	make OBJDIR="$OBJDIR"
}

main () {
	[ -z "$1" ] && usage
	
	while getopts o: args
	do
        	case $args in
                        o)      oarg="$OPTARG";;
			*)	usage	;;
		esac
	done
                  
	shift $((OPTIND - 1))

	makeobjdir

	case "$1" in
		"i386")
			build_i386
			;;
		*)  
			usage
			;;
	esac
	
	#clean up
	rm -r "$oarg"

	echo "#############################################################################"	

	echo "dont forget to make clean"
}



main "$@"


