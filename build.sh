#! /usr/bin/env sh

# defaults
oarg="build"
garg=
OBJDIR=

usage() {
	cat <<_usage_
Usage: ${0##*/} [-og] target
targets:
	i386	build i386
Options:
	-o directory	Output object files to a directory
	-g grub		Use the grub boot-loader (only for the i386 port)
_usage_
}

makeobjdir() {
	#check_dir="$(ls -A "${oarg}" 2>/dev/null)"
	[ -z "${oarg}" ] && usage && exit 1
	#[ -n "${check_dir}" ] && rm -r "${oarg}"
	[ ! -d "${oarg}" ] && mkdir "${oarg}"
	OBJDIR=$(readlink -f "${oarg}")
	echo "OBJDIR = ${OBJDIR}"
}

build_i386() {
	make clean
	make -C arch/i386 OBJDIR="${OBJDIR}" ARCH=i386 1>/dev/null
	if [ -n "${garg}" ]; then
		make -C kern grub OBJDIR="${OBJDIR}" ARCH=i386 1>/dev/null
	else
		make -C sboot OBJDIR="${OBJDIR}" ARCH=i386 1>/dev/null
		make -C kern OBJDIR="${OBJDIR}" ARCH=i386 1>/dev/null
		make OBJDIR="${OBJDIR}" 1>/dev/null
	fi
}

makeisogrub() {
	mkdir -p isodir/boot/grub 
	cp "${OBJDIR}"/kernel.bin isodir/boot
	# support i386 for now
	cp arch/i386/grub.cfg isodir/boot/grub
	grub-mkrescue -o PortOS.iso isodir 2>/dev/null
	rm -r isodir
}

main() {
	set -e
	[ -z "$1" ] && usage && exit

	while getopts gho: args; do
		case ${args} in
		o)
			oarg="${OPTARG}"
			echo "oarg = ${oarg} (${OPTARG})"
			;;
		g) garg=1 ;;
		h) usage && exit ;;
		*) usage && exit 1 ;;
		esac
	done
	shift $((OPTIND - 1))

	for d in ./*; do
		# this is so it doesnt complain that there is a dir with the same name
		[ "$(basename "${oarg}")" = "${oarg}" ] && continue

		echo "checking: $(basename "${d}") = ${oarg}"
		[ "$(basename "${oarg}")" = "$(basename "${d}")" ] && exit

	done

	makeobjdir

	case "$1" in
	"i386")
		build_i386
		;;
	*)
		usage && exit 1
		;;
	esac

	[ -n "${garg}" ] && makeisogrub

	# clean up
	rm -r "${oarg}"

	echo
	echo "#############################################################################"
	echo
	echo "dont forget to make clean"
	echo
}

main "$@"
