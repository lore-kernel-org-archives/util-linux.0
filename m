Return-Path: util-linux-owner@vger.kernel.org
Received: from inpost.hi.is ([130.208.165.62]:34698 "EHLO inpost.hi.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbeHFAL6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 5 Aug 2018 20:11:58 -0400
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id w75M5mdp008773
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Sun, 5 Aug 2018 22:05:48 GMT
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id w75M5mNf032220
        for <util-linux@vger.kernel.org>; Sun, 5 Aug 2018 22:05:48 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id w75M5mDV032219
        for util-linux@vger.kernel.org; Sun, 5 Aug 2018 22:05:48 GMT
Date: Sun, 5 Aug 2018 22:05:48 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] man pages: Fix misuse of two-fonts-macros (BR, IR)
Message-ID: <20180805220548.GA32181@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Change a two-fonts-macro to the single font one, when there is only
one genuine argument.

  Split a punctuation mark from the only argument to a two-fonts-marco.

  Remove an isolated two-fonts-macro.

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---

Warning from "test-groff -b -e -mandoc -T utf8 -rF0 -t -w w -z"

  [ "test-groff" is a developmental version of "groff" ]

Input file is ././sys-utils/hwclock.8.in

<./sys-utils/hwclock.8.in>:196 (macro BR): only 1 argument, but more are expected
<./sys-utils/hwclock.8.in>:827 (macro RB): only 1 argument, but more are expected

####

Input file is ././sys-utils/lscpu.1

<./sys-utils/lscpu.1>:128 (macro BR): only 0 argument, but more are expected

####

Input file is ././sys-utils/mount.8

<./sys-utils/mount.8>:242 (macro IR): only 1 argument, but more are expected
<./sys-utils/mount.8>:658 (macro BR): only 1 argument, but more are expected
<./sys-utils/mount.8>:661 (macro BR): only 1 argument, but more are expected

####

Input file is ././sys-utils/rtcwake.8.in

<./sys-utils/rtcwake.8.in>:52 (macro BR): only 1 argument, but more are expected

####

Input file is ././sys-utils/umount.8

<./sys-utils/umount.8>:138 (macro BR): only 1 argument, but more are expected
<./sys-utils/umount.8>:141 (macro BR): only 1 argument, but more are expected
<./sys-utils/umount.8>:179 (macro BR): only 0 argument, but more are expected
####

 sys-utils/hwclock.8.in | 4 ++--
 sys-utils/lscpu.1      | 1 -
 sys-utils/mount.8      | 6 +++---
 sys-utils/rtcwake.8.in | 2 +-
 sys-utils/umount.8     | 5 ++---
 5 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index bef7a3170..dacdd272f 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -193,7 +193,7 @@ the Hardware Clock while its Linux instance is not running.
 .TP
 .B \-\-set
 Set the Hardware Clock to the time given by the
-.BR \-\-date
+.B \-\-date
 option, and update the timestamps in
 .IR @ADJTIME_PATH@ .
 With the
@@ -824,7 +824,7 @@ cold drift should yield better results.
 .PP
 .B Steps to calculate cold drift:
 .IP 1 2
-.RB "Ensure that NTP daemon will not be launched at startup."
+.B "Ensure that NTP daemon will not be launched at startup."
 .IP 2 2
 .RI The " System Clock " "time must be correct at shutdown!"
 .IP 3 2
diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index fa7a475ba..23dee9b42 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -125,7 +125,6 @@ Display help text and exit.
 .TP
 .BR \-J , " \-\-json"
 Use JSON output format for the default summary or extended output (see \fB\-\-extended\fP).
-.BR
 .TP
 .BR \-p , " \-\-parse" [=\fIlist\fP]
 Optimize the command output for easy parsing.
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index a04a11a67..c503987e8 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -239,7 +239,7 @@ and
 traditionally maintained a list of currently mounted filesystems in the file
 .IR /etc/mtab .
 The support for regular classic
-.IR /etc/mtab
+.I /etc/mtab
 is completely disabled in compile time by default, because on current Linux
 systems it is better to make it a symlink to
 .I /proc/mounts
@@ -655,10 +655,10 @@ or special file representing that namespace.
 .sp
 .BR mount (8)
 switches to the namespace when it reads /etc/fstab, writes /etc/mtab (or writes to /run/mount) and calls
-.BR mount(2)
+.BR mount (2)
 system call, otherwise it runs in the original namespace. It means that the target namespace does not have
 to contain any libraries or another requirements necessary to execute
-.BR mount(2)
+.BR mount (2)
 command.
 .sp
 See \fBnamespaces\fR(7) for more information.
diff --git a/sys-utils/rtcwake.8.in b/sys-utils/rtcwake.8.in
index 9aaca6d79..167f7f9d1 100644
--- a/sys-utils/rtcwake.8.in
+++ b/sys-utils/rtcwake.8.in
@@ -49,7 +49,7 @@ an alarm up to 24 hours in the future.
 The suspend setup maybe be interrupted by active hardware; for example wireless USB
 input devices that continue to send events for some fraction of a second after the
 return key is pressed.
-.BR rtcwake
+.B rtcwake
 tries to avoid this problem and it waits to terminal to settle down before
 entering a system sleep.
 
diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index 136f6179c..eb2e65dd7 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -135,10 +135,10 @@ or special file representing that namespace.
 .sp
 .BR umount (8)
 switches to the namespace when it reads /etc/fstab, writes /etc/mtab (or writes to /run/mount) and calls
-.BR umount(2)
+.BR umount (2)
 system call, otherwise it runs in the original namespace. It means that the target namespace does not have
 to contain any libraries or another requirements necessary to execute
-.BR umount(2)
+.BR umount (2)
 command.
 .sp
 See \fBnamespaces\fR(7) for more information.
@@ -176,7 +176,6 @@ More than one type may be specified in a comma-separated list.  The list
 of filesystem types can be prefixed with
 .B no
 to indicate that no action should be taken for all of the mentioned types.
-.BR
 Note that
 .B umount
 reads information about mounted filesystems from kernel (/proc/mounts) and
-- 
2.18.0

-- 
Bjarni I. Gislason
