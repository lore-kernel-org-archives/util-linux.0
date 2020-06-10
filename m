Return-Path: <SRS0=qkB4=7X=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93197C433DF
	for <util-linux@archiver.kernel.org>; Wed, 10 Jun 2020 02:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A0420691
	for <util-linux@archiver.kernel.org>; Wed, 10 Jun 2020 02:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgFJCR6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 9 Jun 2020 22:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFJCR5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 9 Jun 2020 22:17:57 -0400
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6CFC05BD1E
        for <util-linux@vger.kernel.org>; Tue,  9 Jun 2020 19:17:56 -0700 (PDT)
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 05A2HoWK018521
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2020 02:17:50 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is 05A2HoWK018521
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 05A2HoeN024554
        for <util-linux@vger.kernel.org>; Wed, 10 Jun 2020 02:17:50 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 05A2HovW024553
        for util-linux@vger.kernel.org; Wed, 10 Jun 2020 02:17:50 GMT
Date:   Wed, 10 Jun 2020 02:17:50 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] doc: Fix some warnings from "test-groff" for manuals
Message-ID: <20200610021750.GA24504@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Source is current git content.

Output is from: test-groff -b -e -mandoc -T utf8 -rF0 -t -w w -z

  [ "test-groff" is a developmental version of "groff" ]

Input file is ././disk-utils/sfdisk.8

troff: backtrace: file '<./disk-utils/sfdisk.8>':67
troff: <./disk-utils/sfdisk.8>:67: warning: trailing space
####

Input file is ././misc-utils/kill.1

troff: backtrace: '/home/bg/git/groff/build/s-tmac/an-ext.tmac':133: macro 'EE'
troff: backtrace: file '<./misc-utils/kill.1>':167
troff: <./misc-utils/kill.1>:167: warning: macro 'mF' not defined
troff: backtrace: '/home/bg/git/groff/build/s-tmac/an-ext.tmac':134: macro 'EE'
troff: backtrace: file '<./misc-utils/kill.1>':167
troff: <./misc-utils/kill.1>:167: warning: number register 'mE' not defined
troff: backtrace: '/home/bg/git/groff/build/s-tmac/an-ext.tmac':134: macro 'EE'
troff: backtrace: file '<./misc-utils/kill.1>':167
troff: <./misc-utils/kill.1>:167: warning: bad font number
troff: backtrace: '/home/bg/git/groff/build/s-tmac/an-ext.tmac':135: macro 'EE'
troff: backtrace: file '<./misc-utils/kill.1>':167
troff: <./misc-utils/kill.1>:167: warning: number register 'sP' not defined
troff: backtrace: '/home/bg/git/groff/build/s-tmac/an-ext.tmac':134: macro 'EE'
troff: backtrace: file '<./misc-utils/kill.1>':170
troff: <./misc-utils/kill.1>:170: warning: bad font number
####

Input file is ././sys-utils/ipcs.1

<./sys-utils/ipcs.1>:103 (macro BR): only 1 argument, but more are expected
####

Input file is ././sys-utils/mount.8

<./sys-utils/mount.8>:68 (macro RB): only 1 argument, but more are expected
troff: backtrace: '/home/bg/git/groff/build/s-tmac/an-old.tmac':467: macro 'RB'
troff: backtrace: file '<./sys-utils/mount.8>':68
troff: <./sys-utils/mount.8>:68: warning [p 1, 3.5i]: can't break line
an-old.tmac: <./sys-utils/mount.8>:201 (.RE): warning: extra .RE or .RS is missing before it; "an-RS-open" is 0.
<./sys-utils/mount.8>:453 (macro BR): only 1 argument, but more are expected
<./sys-utils/mount.8>:500 (macro BR): only 1 argument, but more are expected
<./sys-utils/mount.8>:1050 (macro BR): only 1 argument, but more are expected
####

Input file is ././sys-utils/setpriv.1

<./sys-utils/setpriv.1>:17 (macro BR): only 1 argument, but more are expected
<./sys-utils/setpriv.1>:154 (macro BR): only 1 argument, but more are expected
<./sys-utils/setpriv.1>:166 (macro BR): only 1 argument, but more are expected
####

Input file is ././sys-utils/umount.8

<./sys-utils/umount.8>:145 (macro IR): only 1 argument, but more are expected
####

Input file is ././sys-utils/unshare.1

<./sys-utils/unshare.1>:266 (macro BR): only 1 argument, but more are expected

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
####
---
 disk-utils/sfdisk.8 |  2 +-
 misc-utils/kill.1   |  2 +-
 sys-utils/ipcs.1    |  2 +-
 sys-utils/mount.8   | 12 ++++++------
 sys-utils/setpriv.1 |  6 +++---
 sys-utils/umount.8  |  2 +-
 sys-utils/unshare.1 |  2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 2f8afe88c..e3b479cbf 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -64,7 +64,7 @@ uses BLKRRPART (reread partition table) ioctl to make sure that the device is
 not used by system or other tools (see also \-\-no-reread).  It's possible that
 this feature or another sfdisk activity races with \fBudevd\fR.  The recommended way
 how to avoid possible collisions is to use \fB\-\-lock\fR option.
-The exclusive lock will cause udevd to skip the event handling on the device. 
+The exclusive lock will cause udevd to skip the event handling on the device.
 .PP
 The sfdisk prompt is only a hint for users and a displayed partition number does
 not mean that the same partition table entry will be created (if -N not
diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
index 6ca318a6a..5e0ebaf37 100644
--- a/misc-utils/kill.1
+++ b/misc-utils/kill.1
@@ -164,7 +164,7 @@ the signals QUIT, TERM and KILL in sequence and waits for 1000
 milliseconds between sending the signals:
 .IP
 .in +4n
-.EE
+.EX
 kill \-\-verbose \-\-timeout 1000 TERM \-\-timeout 1000 KILL \e
         \-\-signal QUIT 12345
 .EE
diff --git a/sys-utils/ipcs.1 b/sys-utils/ipcs.1
index d259a7df6..4d1388485 100644
--- a/sys-utils/ipcs.1
+++ b/sys-utils/ipcs.1
@@ -100,7 +100,7 @@ The current implementation of
 obtains information about available IPC resources by parsing the files in
 .IR /proc/sysvipc .
 Before util-linux version v2.23, an alternate mechanism was used: the
-.BR IPC_STAT
+.B IPC_STAT
 command of
 .BR msgctl (2),
 .BR semctl (2),
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index e4ded7e5d..7aefe76b9 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -61,11 +61,12 @@ mount \- mount a filesystem
 .I device mountpoint
 .LP
 .B mount
-.RB \-\-bind | \-\-rbind | \-\-move
+.BR \-\-bind | \-\-rbind | \-\-move
 .I olddir newdir
 .LP
 .B mount
-.RB \-\-make\-{shared|slave|private|unbindable|rshared|rslave|rprivate|runbindable}
+.BR \-\-make\- { shared | slave | private | unbindable | rshared | \
+rslave | rprivate | runbindable }
 .I mountpoint
 .SH DESCRIPTION
 All files accessible in a Unix system are arranged in one big
@@ -198,7 +199,6 @@ manufacturer.  See \fBls /dev/disk/by-id\fR for more details, this directory
 and running udevd is required.  This identifier is not recommended for generic
 use as the identifier is not strictly defined and it depends on udev, udev rules
 and hardware.
-.RE
 .sp
 The command \fBlsblk \-\-fs\fR provides an overview of filesystems, LABELs and UUIDs
 on available block devices.  The command \fBblkid \-p <device>\fR provides details about
@@ -450,7 +450,7 @@ a second place by using:
 Note that the filesystem mount options maintained by the kernel will remain the same as those
 on the original mount point.  The userspace mount options (e.g., _netdev) will not be copied
 by
-.BR mount
+.B mount
 and it's necessary to explicitly specify the options on the
 .B mount
 command line.
@@ -497,7 +497,7 @@ filesystem-specific flags) are silently ignored.  It's impossible to change moun
 options recursively (for example with \fB\-o rbind,ro\fR).
 
 Since util-linux 2.31,
-.BR mount
+.B mount
 ignores the \fBbind\fR flag from
 .I /etc/fstab
 on a
@@ -1047,7 +1047,7 @@ Verbose mode.
 .TP
 .BR \-w , " \-\-rw" , " \-\-read\-write"
 Mount the filesystem read/write.  Read-write is the kernel default and the
-.BR mount
+.B mount
 default is to try read-only if the previous mount syscall with read-write flags
 on write-protected devices of filesystems failed.
 .sp
diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index dbf5772ed..939b69a3a 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -14,7 +14,7 @@ In comparison to
 .BR su (1)
 and
 .BR runuser (1),
-.BR setpriv
+.B setpriv
 neither uses PAM, nor does it prompt for a password.
 It is a simple, non-set-user-ID wrapper around
 .BR execve (2),
@@ -151,7 +151,7 @@ credentials to remedy that situation.
 .BI \-\-selinux\-label " label"
 Request a particular SELinux transition (using a transition on exec, not
 dyntrans).  This will fail and cause
-.BR setpriv
+.B setpriv
 to abort if SELinux is not in use, and the transition may be ignored or cause
 .BR execve (2)
 to fail at SELinux's whim.  (In particular, this is unlikely to work in
@@ -163,7 +163,7 @@ This is similar to
 .BI \-\-apparmor\-profile " profile"
 Request a particular AppArmor profile (using a transition on exec).  This will
 fail and cause
-.BR setpriv
+.B setpriv
 to abort if AppArmor is not in use, and the transition may be ignored or cause
 .BR execve (2)
 to fail at AppArmor's whim.
diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index ff26d413e..6f402fd67 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -142,7 +142,7 @@ or special file representing that namespace.
 switches to the namespace when it reads
 .IR /etc/fstab ,
 writes
-.IR /etc/mtab
+.I /etc/mtab
 (or writes to
 .IR /run/mount )
 and calls
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 5292880af..2096f45ab 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -263,7 +263,7 @@ and that a new
 filesystem is mounted that contains information corresponding to the new
 PID namespace.
 When the
-.BR readlink
+.B readlink
 command terminates, the new namespaces are automatically torn down.
 .PP
 .in +4n
-- 
2.26.2
