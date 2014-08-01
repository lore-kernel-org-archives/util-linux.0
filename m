Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:53690 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750876AbaHAMTV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 1 Aug 2014 08:19:21 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] docs: improve the wording and formatting of the zramctl man page
Date: Fri,  1 Aug 2014 14:19:08 +0200
Message-Id: <1406895548-2925-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1406895548-2925-1-git-send-email-bensberg@justemail.net>
References: <1406895548-2925-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Especially fix the mistaken short option -h for --noheadings.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/zramctl.8 |   61 ++++++++++++++++++++++++++++++---------------------
 1 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/sys-utils/zramctl.8 b/sys-utils/zramctl.8
index 34bb71f..74240a1 100644
--- a/sys-utils/zramctl.8
+++ b/sys-utils/zramctl.8
@@ -22,20 +22,19 @@ Print name of first unused zram device:
 .B "zramctl \-f"
 .sp
 .in -5
-Setup zram device:
+Set up a zram device:
 .sp
 .in +5
 .B zramctl
 .RB [ \-f " | "\fIzramdev\fP ]
 .RB [ \-s
 .IR size ]
-.RB \ [ \-t
+.RB [ \-t
 .IR number ]
-.in +8
 .RB [ \-a
 .IR algorithm ]
 .sp
-.in -13
+.in -5
 .ad b
 .SH DESCRIPTION
 .B zramctl
@@ -44,35 +43,47 @@ query the status of used zram devices.  If no option is given, all zram devices
 are shown.
 
 .SH OPTIONS
-.IP "\fB\-a, \-\-algorithm \fI{lzo|lz4}\fP"
-Set compression algorithm used for compress data in zram device.
-.IP "\fB\-f, \-\-find\fP"
-Find the first unused zram device. If a \fB--size\fR argument is present, then
+.TP
+.BR \-a , " \-\-algorithm lzo" | lz4
+Set the compression algorithm to be used for compressing data in the zram device.
+.TP
+.BR \-f , " \-\-find"
+Find the first unused zram device.  If a \fB--size\fR argument is present, then
 initialize the device.
-.IP "\fB\-h, \-\-help\fP"
-print help
-.IP "\fB\-h, \-\-noheadings\fP"
+.TP
+.BR \-n , " \-\-noheadings"
 Do not print a header line in status output.
-.IP "\fB\-o, \-\-output \fIlist\fP"
-Define the status output columns to use.  If no output arrangement is specified,
-then a default set is used.
+.TP
+.BR \-o , " \-\-output " \fIlist
+Define the status output columns to be used.  If no output arrangement is
+specified, then a default set is used.
 Use \fB\-\-help\fP to get a list of all supported columns.
-.IP "\fB\-r, \-\-reset\fP
-Reset options specified zram device(s). Zram device setting can be changed only
-after reset.
-.IP "\fB\-\-raw\fP"
+.TP
+.B \-\-raw
 Use the raw format for status output.
-.IP "\fB\-s, \-\-size\fP \fIsize\fP
-Force zram driver to reread size of the file associated with the specified zram device
+.TP
+.BR \-r , " \-\-reset"
+Reset the options of the specified zram device(s).  Zram device settings
+can be changed only after a reset.
+.TP
+.BR \-s , " \-\-size " \fIsize
+Force the zram driver to reread the size of the file associated with
+the specified zram device
 
 The \fIsize\fR argument may be followed by the multiplicative suffixes KiB (=1024),
 MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB"
 is optional, e.g., "K" has the same meaning as "KiB") or the suffixes
 KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
-.IP "\fB\-t, \-\-streams \fInumber\fP"
-Set number of maximum compress streams what used for device. The default is one stream.
-.IP "\fB\-V, \-\-version\fP"
+.TP
+.BR \-t , " \-\-streams " \fInumber
+Set the maximum number of compression streams that can be used for the device.
+The default is one stream.
+.TP
+.BR \-V , " \-\-version"
 Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 
 .SH RETURN VALUE
 .B zramctl
@@ -84,8 +95,8 @@ returns 0 on success, nonzero on failure.
 zram block devices
 
 .SH EXAMPLE
-The following commands can be used for setup the zram device with gigabyte size
- and using as swap device.
+The following commands set up a zram device with a size of one gigabyte
+and use it as swap device.
 .nf
 .IP
 # zramctl --find --size 1024M
-- 
1.7.0.4

