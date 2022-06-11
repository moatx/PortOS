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
	exit 1
}

makeobjdir() {
	check_dir="$(ls -A "${oarg}" 2>/dev/null)"
	[ -z "${oarg}" ] && usage
	[ -n "${check_dir}" ] && rm -r "${oarg}"
	[ ! -d "${oarg}" ] && mkdir "${oarg}"
	OBJDIR=$(readlink -f "${oarg}")
	echo "${OBJDIR}"
	echo
}

build_i386() {
	make clean
	#if [ "${garg}" -eq 1 ]; then
	#	make -C arch/i386 grub OBJDIR="${OBJDIR}" ARCH=i386
	#else
	#fi
	make -C arch/i386 OBJDIR="${OBJDIR}" ARCH=i386
	make -C kern OBJDIR="${OBJDIR}" ARCH=i386
	make OBJDIR="${OBJDIR}"
}

main() {
	[ -z "$1" ] && usage

	while getopts go: args; do
		case ${args} in
		o)
			oarg="${OPTARG}"
			echo "oarg = ${oarg} (${OPTARG})"
			;;
		g) garg=1 ;;
		*) usage ;;
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
		usage
		;;
	esac

	# clean up
	rm -r "${oarg}"

	echo "#############################################################################"

	echo "dont forget to make clean"
}

main "$@"
