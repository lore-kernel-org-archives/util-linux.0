Return-Path: <SRS0=K2/4=7Y=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7C5C433E1
	for <util-linux@archiver.kernel.org>; Thu, 11 Jun 2020 00:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E04BC206A4
	for <util-linux@archiver.kernel.org>; Thu, 11 Jun 2020 00:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgFKAuh (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgFKAug (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 10 Jun 2020 20:50:36 -0400
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0038BC08C5C1
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2020 17:50:35 -0700 (PDT)
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 05B0oXHc018955
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Thu, 11 Jun 2020 00:50:34 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is 05B0oXHc018955
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 05B0oXiP026889
        for <util-linux@vger.kernel.org>; Thu, 11 Jun 2020 00:50:33 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 05B0oXNV026888
        for util-linux@vger.kernel.org; Thu, 11 Jun 2020 00:50:33 GMT
Date:   Thu, 11 Jun 2020 00:50:33 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] doc: sys-utils/*: fix some warnings from "mandoc -T lint"
Message-ID: <20200611005033.GA26867@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

mandoc: ./sys-utils/adjtime_config.5:26:1: WARNING: skipping paragraph macro: sp after PP

mandoc: ./sys-utils/chcpu.8:98:2: WARNING: skipping paragraph macro: br at the end of SH

mandoc: ./sys-utils/choom.1:26:22: STYLE: unterminated quoted argument

mandoc: ./sys-utils/dmesg.1:90:5: STYLE: unterminated quoted argument
mandoc: ./sys-utils/dmesg.1:147:5: STYLE: unterminated quoted argument
mandoc: ./sys-utils/dmesg.1:33:2: WARNING: skipping paragraph macro: PP empty
mandoc: ./sys-utils/dmesg.1:255:2: WARNING: skipping paragraph macro: br after sp

mandoc: ./sys-utils/flock.1:183:2: WARNING: line scope broken: TQ breaks TP
mandoc: ./sys-utils/flock.1:43:2: WARNING: skipping paragraph macro: PP after SH

mandoc: ./sys-utils/fsfreeze.8:79:2: WARNING: skipping paragraph macro: PP after SH
mandoc: ./sys-utils/fsfreeze.8:83:2: WARNING: skipping paragraph macro: PP after SH

mandoc: ./sys-utils/ipcmk.1:43:2: WARNING: skipping paragraph macro: PP empty

mandoc: ./sys-utils/lsirq.1:16:11: STYLE: unterminated quoted argument
mandoc: ./sys-utils/lsirq.1:31:11: STYLE: unterminated quoted argument
mandoc: ./sys-utils/lsirq.1:34:11: STYLE: unterminated quoted argument

mandoc: ./sys-utils/mount.8:901:4: STYLE: unterminated quoted argument
mandoc: ./sys-utils/mount.8:2239:38: STYLE: unterminated quoted argument
mandoc: ./sys-utils/mount.8:88:2: WARNING: skipping paragraph macro: br after sp
mandoc: ./sys-utils/mount.8:90:2: WARNING: skipping paragraph macro: br before sp

mandoc: ./sys-utils/mountpoint.1:50:2: WARNING: skipping paragraph macro: PP after SH
mandoc: ./sys-utils/mountpoint.1:57:2: WARNING: skipping paragraph macro: PP after SH

mandoc: ./sys-utils/readprofile.8:10:2: WARNING: skipping paragraph macro: PP after SH
mandoc: ./sys-utils/readprofile.8:100:2: WARNING: skipping paragraph macro: PP after SH

mandoc: ./sys-utils/renice.1:65:11: STYLE: unterminated quoted argument
mandoc: ./sys-utils/renice.1:68:11: STYLE: unterminated quoted argument
mandoc: ./sys-utils/renice.1:72:11: STYLE: unterminated quoted argument
mandoc: ./sys-utils/renice.1:55:2: WARNING: skipping paragraph macro: PP empty

mandoc: ./sys-utils/swapon.8:227:2: WARNING: skipping paragraph macro: br after SH

mandoc: ./sys-utils/unshare.1:350:32: STYLE: unterminated quoted argument
mandoc: ./sys-utils/unshare.1:253:2: WARNING: skipping paragraph macro: PP after SH

####

  The ouput from "nroff" and "groff" is unchanged.

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 sys-utils/adjtime_config.5 | 2 +-
 sys-utils/chcpu.8          | 1 -
 sys-utils/choom.1          | 2 +-
 sys-utils/dmesg.1          | 6 ++----
 sys-utils/flock.1          | 2 --
 sys-utils/fsfreeze.8       | 2 --
 sys-utils/ipcmk.1          | 1 -
 sys-utils/lsirq.1          | 6 +++---
 sys-utils/mount.8          | 6 ++----
 sys-utils/mountpoint.1     | 2 --
 sys-utils/readprofile.8    | 2 --
 sys-utils/renice.1         | 7 +++----
 sys-utils/swapon.8         | 1 -
 sys-utils/unshare.1        | 3 +--
 14 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/sys-utils/adjtime_config.5 b/sys-utils/adjtime_config.5
index 9482e25f9..0166461c4 100644
--- a/sys-utils/adjtime_config.5
+++ b/sys-utils/adjtime_config.5
@@ -23,7 +23,7 @@ For more details see "\fBThe Adjust Function\fR" and  "\fBThe Adjtime File\fR" s
 .BR hwclock (8)
 man page.
 .PP
-
+.
 The format of the adjtime file is, in ASCII.
 .sp
 .SS First line
diff --git a/sys-utils/chcpu.8 b/sys-utils/chcpu.8
index 10273f6e2..41b2d0951 100644
--- a/sys-utils/chcpu.8
+++ b/sys-utils/chcpu.8
@@ -95,7 +95,6 @@ Heiko Carstens
 .ME
 .SH COPYRIGHT
 Copyright IBM Corp. 2011
-.br
 .SH SEE ALSO
 .BR lscpu (1)
 .SH AVAILABILITY
diff --git a/sys-utils/choom.1 b/sys-utils/choom.1
index def31d5f0..ce2b8b539 100644
--- a/sys-utils/choom.1
+++ b/sys-utils/choom.1
@@ -23,7 +23,7 @@ The \fBchoom\fP command displays and adjusts Out-Of-Memory killer score setting.
 
 .SH OPTIONS
 .TP
-.BR \-p ", " \-\-pid " \fIpid\fP
+.BR \-p ", " \-\-pid " \fIpid\fP"
 Specifies process ID.
 .TP
 .BR \-n , " \-\-adjust " \fIvalue\fP
diff --git a/sys-utils/dmesg.1 b/sys-utils/dmesg.1
index 6c5773a6b..4bec7892b 100644
--- a/sys-utils/dmesg.1
+++ b/sys-utils/dmesg.1
@@ -30,7 +30,6 @@ The
 and
 .B \-\-console\-level
 options are mutually exclusive.
-.PP
 .IP "\fB\-C\fR, \fB\-\-clear\fR"
 Clear the ring buffer.
 .IP "\fB\-c\fR, \fB\-\-read\-clear\fR"
@@ -87,7 +86,7 @@ of levels.  For example:
 will print error and warning messages only.  For all supported levels see the
 .B \-\-help
 output.
-.IP "\fB\-n\fR, \fB\-\-console\-level \fIlevel\fR
+.IP "\fB\-n\fR, \fB\-\-console\-level \fIlevel\fR"
 Set the
 .I level
 at which printing of messages is done to the console.  The
@@ -144,7 +143,7 @@ kernel interface to read kernel messages.  The default is to use /dev/kmsg rathe
 than
 .BR syslog (2)
 since kernel 3.5.0.
-.IP "\fB\-s\fR, \fB\-\-buffer\-size \fIsize\fR
+.IP "\fB\-s\fR, \fB\-\-buffer\-size \fIsize\fR"
 Use a buffer of
 .I size
 to query the kernel ring buffer.  This is 16392 by default.  (The default
@@ -252,7 +251,6 @@ for more details.
 Karel Zak
 .ME
 
-.br
 .B dmesg
 was originally written by
 .MT tytso@athena.mit.edu
diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index def273dbd..20975f82c 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -40,7 +40,6 @@ flock \- manage locks from shell scripts
 .B flock
 .RI [options] " number"
 .SH DESCRIPTION
-.PP
 This utility manages
 .BR flock (2)
 locks from within shell scripts or from the command line.
@@ -181,7 +180,6 @@ then execute flock and grab an exclusive non-blocking lock (using the script
 itself as the lock file) before re-execing itself with the right arguments.  It
 also sets the FLOCKER env var to the right value so it doesn't run again.
 .TP
-.TQ
 shell> exec 4<>/var/lock/mylockfile
 .TQ
 shell> flock -n 4
diff --git a/sys-utils/fsfreeze.8 b/sys-utils/fsfreeze.8
index eb3214769..cbde489ad 100644
--- a/sys-utils/fsfreeze.8
+++ b/sys-utils/fsfreeze.8
@@ -76,11 +76,9 @@ Previous list may be incomplete, as more filesystems get support.  If in
 doubt easiest way to know if a filesystem has support is create a small
 loopback mount and test freezing it.
 .SH NOTES
-.PP
 This man page is based on
 .BR xfs_freeze (8).
 .SH AUTHORS
-.PP
 Written by Hajime Taira.
 .SH SEE ALSO
 .BR mount (8)
diff --git a/sys-utils/ipcmk.1 b/sys-utils/ipcmk.1
index c40222014..a194af41e 100644
--- a/sys-utils/ipcmk.1
+++ b/sys-utils/ipcmk.1
@@ -40,7 +40,6 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.PP
 .SH AUTHORS
 .MT hayden.james@gmail.com
 Hayden A. James
diff --git a/sys-utils/lsirq.1 b/sys-utils/lsirq.1
index 767077123..d58605bff 100644
--- a/sys-utils/lsirq.1
+++ b/sys-utils/lsirq.1
@@ -13,7 +13,7 @@ expected columns by using
 .BR \-\-output .
 .SH OPTIONS
 .TP
-.BR \-n , " \-\-noheadings
+.BR \-n ", " \-\-noheadings
 Don't print headings.
 .TP
 .BR \-o , " \-\-output " \fIlist\fP
@@ -28,10 +28,10 @@ Specify sort criteria by column name.  See
 .B \-\-help
 output to get column names.
 .TP
-.BR \-J , " \-\-json
+.BR \-J ", " \-\-json
 Use JSON output format.
 .TP
-.BR \-P , " \-\-pairs
+.BR \-P ", " \-\-pairs
 Produce output in the form of key="value" pairs.  All potentially unsafe characters
 are hex-escaped (\\x<code>).
 .TP
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 48817bd36..e7215226c 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -85,9 +85,7 @@ The standard form of the
 command is:
 .RS
 
-.br
 .BI "mount \-t" " type device dir"
-.br
 
 .RE
 This tells the kernel to attach the filesystem found on
@@ -898,7 +896,7 @@ but mount operations is done on another place, for example:
 .RS
 .RS
 .sp
-.B "mount \-\-all \-\-target\-prefix /chroot \-o X\-mount.mkdir
+.B "mount \-\-all \-\-target\-prefix /chroot \-o X\-mount.mkdir"
 .sp
 .RE
 mounts all from system
@@ -2236,7 +2234,7 @@ Enable POSIX Access Control Lists.  See the
 .BR acl (5)
 manual page.
 .TP
-.BR barrier=none " / " barrier=flush "
+.BR barrier=none " / " barrier=flush
 This disables / enables the use of write barriers in the journaling code.
 barrier=none disables, barrier=flush enables (default).  This also requires an
 IO stack which can support barriers, and if reiserfs gets an error on a barrier
diff --git a/sys-utils/mountpoint.1 b/sys-utils/mountpoint.1
index cadb026da..a10072143 100644
--- a/sys-utils/mountpoint.1
+++ b/sys-utils/mountpoint.1
@@ -47,14 +47,12 @@ Zero if the directory or file is a mountpoint, non-zero if not.
 .IP LIBMOUNT_DEBUG=all
 enables libmount debug output.
 .SH NOTES
-.PP
 The util-linux
 .B mountpoint
 implementation was written from scratch for libmount.  The original version
 for sysvinit suite was written by Miquel van Smoorenburg.
 
 .SH AUTHORS
-.PP
 Karel Zak <kzak@redhat.com>
 .SH SEE ALSO
 .BR mount (8)
diff --git a/sys-utils/readprofile.8 b/sys-utils/readprofile.8
index c335644d7..b987abb7f 100644
--- a/sys-utils/readprofile.8
+++ b/sys-utils/readprofile.8
@@ -7,7 +7,6 @@ readprofile \- read kernel profiling information
 .SH VERSION
 This manpage documents version 2.0 of the program.
 .SH DESCRIPTION
-.LP
 The
 .B readprofile
 command uses the
@@ -97,7 +96,6 @@ Display help text and exit.
 /usr/src/linux/*           The program being profiled :-)
 .fi
 .SH BUGS
-.LP
 .B readprofile
 only works with a 1.3.x or newer kernel, because
 .I /proc/profile
diff --git a/sys-utils/renice.1 b/sys-utils/renice.1
index cb9863143..c39aa1f39 100644
--- a/sys-utils/renice.1
+++ b/sys-utils/renice.1
@@ -52,7 +52,6 @@ scheduling priority altered.
 .BR renice 'ing
 a user causes all processes owned by the user to have their scheduling
 priority altered.
-.PP
 .SH OPTIONS
 .TP
 .BR \-n , " \-\-priority " \fIpriority\fR
@@ -62,14 +61,14 @@ to be used for the process, process group, or user.  Use of the option
 .BR \-n " or " \-\-priority
 is optional, but when used it must be the first argument.
 .TP
-.BR \-g , " \-\-pgrp
+.BR \-g ", " \-\-pgrp
 Interpret the succeeding arguments as process group IDs.
 .TP
-.BR \-p , " \-\-pid
+.BR \-p ", " \-\-pid
 Interpret the succeeding arguments as process IDs
 (the default).
 .TP
-.BR \-u , " \-\-user
+.BR \-u ", " \-\-user
 Interpret the succeeding arguments as usernames or UIDs.
 .TP
 .BR \-V , " \-\-version"
diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index b10076c90..486e02840 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -224,7 +224,6 @@ enables libmount debug output.
 enables libblkid debug output.
 
 .SH FILES
-.br
 .I /dev/sd??
 standard paging devices
 .br
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 2096f45ab..bd5f416b4 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -250,7 +250,6 @@ restricted so that a less privileged user can not get more access to sensitive
 files that a more privileged user made unavailable. In short the rule for proc
 and sysfs is as close to a bind mount as possible.
 .SH EXAMPLES
-.PP
 The following command creates a PID namespace, using
 .B \-\-fork
 to ensure that the executed command is performed in a child process
@@ -347,7 +346,7 @@ is killed, all of the processes within the PID namespace are killed.
 
 .BR "# ps h \-o 'comm' $!     " "# Show that background job is unshare(1)"
 unshare
-.BR "# kill $!               " "# Kill unshare(1)
+.BR "# kill $!               " "# Kill unshare(1)"
 .B # pidof sleep
 .EE
 .in
-- 
2.26.2
