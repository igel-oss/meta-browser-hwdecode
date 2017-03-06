Overview
========

This meta-rcar extension contains the recipes necessary to build the
[v4l-gst libv4l plugin](https://github.com/igel-oss/v4l-gst)
and the integration module to access it from Chromium.

The plugin can be used to connect the Chromium hardware video decode
acceleration framework to GStreamer through the V4L2 API.

This recipe supports optional integration with Chromium, which requires the
meta-browser layer to be included in your yocto configuration.

Building
========

Add the following packages to your IMAGE_INSTALL_append variable in your local.conf
* v4l-gst
* libv4l
* libv4l-dev

Add the following define to your local.conf

```
PACKAGECONFIG_append_pn-chromium = " proprietary-codecs"

```

`bitbake` as usual.


Configuration
=============

Create the settings file ```/etc/xdg/libv4l-gst.conf``` if it doesn't exist. Example settings for an R-Car board are show below, but they may be updated to use more generic settings.

```
[libv4l-gst]
pipeline=h264parse ! omxh264dec ! queue max-size-bytes=0 max-size-time=0 max-size-buffers=0 ! vspfilter
min-buffers=2
```

Running
=======

Create a dummy V4L2 device file under /dev

```
# touch /dev/video-gst
# chsmack -a \* /dev/video-gst
```
Accessing the /dev/video-gst file will allow an application to use the v4l-gst plugin
using the same API as a regular V4L2 device file.

Running with Chromium
---------------------

Link to the video decoder device file that Chromium uses

```
# ln -s /dev/video-gst /dev/video-dec
# chsmack -a \* /dev/video-dec
```

Hardware video decoding is blacklisted by default on Chromium. Add the ```--ignore-gpu-blacklist``` (and if necessary ```--in-process-gpu``` ) flag(s)
to the Chromium command line to enable video decoding via the V4L2 interface.
