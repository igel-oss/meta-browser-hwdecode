SRC_URI += " \
	file://0001-libv4l2-Refactor-v4l2_mmap.patch \
	file://0002-libv4l2-Support-mmap-to-libv4l-plugin.patch \
"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

