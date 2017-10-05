FILESEXTRAPATHS_append := "${THISDIR}/files:"

SRC_URI_append = " file://0001-Add-support-for-V4L2VDA-on-Linux.patch \
		   file://0002-Add-mmap-via-libv4l-to-generic_v4l2_device.patch \
		   file://0003-third_party-openh264-Remove-conflicting-build-flag.patch \
		 "

EXTRA_OEGN_append = " use_v4l2_codec=true use_v4lplugin=true use_linux_v4l2_only=true"
