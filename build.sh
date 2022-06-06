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
	[ -n "$(ls -A "$oarg")" ] && rm -r "$oarg"
	[ ! -d "$oarg" ] && mkdir "$oarg"
	OBJDIR=$(readlink -f "$oarg")
	echo "$OBJDIR"
	echo
}

build_i386 () {
	make clean
	make -C arch/i386 OBJDIR="$OBJDIR" ARCH=i386
	make -C kern OBJDIR="$OBJDIR" ARCH=i386
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


	for d in ./*; do
                echo "checking: $(basename "$d") = $oarg"
                [ "$(basename "$oarg")" = "$(basename "$d")" ] && exit
        done



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


