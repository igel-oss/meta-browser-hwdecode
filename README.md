Overview
========

This layer enables hardware assisted video decoding in Chromium via
the Chromium V4L2VDA, using the [v4l-gst libv4l plugin](https://github.com/igel-oss/v4l-gst) to connect it to the Renesas H/W video decoder available through
GStreamer.

Currently, only the H264 video codec is supported.

Building
========

1. Add this layer to your bblayers.conf file

2. Add the following packages to your IMAGE_INSTALL_append variable in your local.conf
   * v4l-gst
   * libv4l
   * libv4l-dev

3. Add the following define to your local.conf

```
PACKAGECONFIG_append_pn-chromium = " proprietary-codecs"
```

`bitbake` as usual.


Configuration
=============

The settings file for the v4l-gst bridge is located at ```/etc/xdg/libv4l-gst.conf```.
This file allows for specifying the GStreamer pipeline that the plugin will
attempt to use to decode the video frames that it receives from the V4L2
interface.

Example settings for an R-Car board are show below, but they may be updated to
use more generic settings.

```
[libv4l-gst]
pipeline=h264parse ! omxh264dec no-reorder=true ! queue max-size-bytes=0 max-size-time=0 max-size-buffers=0 ! vspfilter output-io-mode=0
```

Running
=======

Create a dummy V4L2 device file under /dev

```
# touch /dev/video-gst
# chsmack -a \* /dev/video-gst
```
Accessing the /dev/video-gst file will allow an application to use the v4l-gst
plugin using the same API as a regular V4L2 device file.

Running with Chromium
---------------------

Link to the video decoder device file that Chromium uses

```
# ln -s /dev/video-gst /dev/video-dec
# chsmack -a \* /dev/video-dec
```

Hardware video decoding is blacklisted by default on Chromium. Add the ```--ignore-gpu-blacklist``` to the Chromium command line to enable video decoding
via the V4L2 interface.
