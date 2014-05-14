# GStreamer Debug Emacs Module

## Abstract

gst-debug.el is an emacs mini module to navigate GStreamer debug logs.

When hitting **Enter** or **M-.** in a log file it will open the source code
to the line that generated that debug message. If you have multiple emacs
windows open, it will open the GStreamer source code file in the second to
last active so you can continue reading the log in the active window. If you
only have one window open it will open the source code file in the current one.

## Requirements

You need a recent Emacs to use latest helm, at least Emacs-24.3.

## Getting Started

### Install

  1. Get gst-debug.el into your emac's load path

    ```
    $ git clone https://github.com/luisbg/emacs-gstreamer.git
    $ cp emacs-gstreamer/gst-debug.el ~/.emacs_load_path/
    ```
  2. Add it to your emacs init file (usually ~/.emacs)

    ```
    (require 'gst-debug)
    ```

  Alternative.

    ```
    (add-to-list 'load-path "/path/to/emacs-gstreamer/directory")
    (require 'gst-debug)
    ```

### Usage

First you need to generate and load your tags table since gst-debug depends on
it.

    $ cd /path/to/gst/modules
    $ etags `find . -name "*.c" -o -name "*.h"`
    M-x visit-tag-table TAGS


Open in emacs the Gstreamer debug log file generated without colors and switch
to gst-debug mode.

**Enter** or **M-.** will jump to the source code line where the
log line comes from.

For example:


    $ gst-app --gst-debug=*:5 --gst-debug-color-mode=off &> gst_log
    M-x find-file gst_log
    M-x gst-debug
    M-x goto-line 100
    <Enter>

More information about generating GStreamer debug lgos:
http://gstreamer.freedesktop.org/data/doc/gstreamer/head/gstreamer/html/gst-running.html

## Bugs, Improvements, and Getting Help

Contact me at luis@debethencourt.com if you find any bugs, have ideas for
improvements or need help.