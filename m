Return-Path: <SRS0=+NO+=7D=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5593DC433DF
	for <util-linux@archiver.kernel.org>; Thu, 21 May 2020 07:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E3A20738
	for <util-linux@archiver.kernel.org>; Thu, 21 May 2020 07:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMimPPe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgEUH2h (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 21 May 2020 03:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbgEUH2g (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 21 May 2020 03:28:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E14AC061A0E
        for <util-linux@vger.kernel.org>; Thu, 21 May 2020 00:28:36 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id s3so7630364eji.6
        for <util-linux@vger.kernel.org>; Thu, 21 May 2020 00:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=MzW9ehm6I79IeQoKpZPkRsrZQ/DQY2aRlovT67fGg0Y=;
        b=aMimPPe/rt+Bcsegh44CnGrc5N16hPhA2jXPcra6F2xmfP0SU/plCO7/6MR/Wh5gbl
         g7dUPXFwobJVDaR1YrJfFz+OWEVU/fbqgtWWsAhQPtscm5/lKhb4Zg9RrX6DPEDcR/50
         1TW3y3o7KR4/VDxjzQuD0GjdsJn52y21FnAufJA2dlaqBrlidkd1DVyngZ3Ycx/O3ZRb
         d4VUqfpdcB0Q/JMkYtW7T/iwozrnIYrRRNkqMyFmTSPAOVv9OE2wU269g4YItwLIyMzj
         E8VB4i/Kw6eNFH4ygy+yH0Y+nat9WOAyVbaRg3VEpl4MipxLEIZ05ycR1x2cYSuQ1JtR
         Gm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=MzW9ehm6I79IeQoKpZPkRsrZQ/DQY2aRlovT67fGg0Y=;
        b=APVgENv3lFnoqdh31vrjfWHhwponms+Z3yFO9r52nCK450r0VfMoFsLRgrasgANijO
         Pu9Y4RlztHKwWc2eSefT/e9PmsNpQaQwZW3bsuOwRuqt0Xyz8CUAWdFK2s9oHW8FFdYO
         yg6rdSIalyyT7DJo8NK1LwTiENcfB7pGSioGE3gA9RZU8UKd8w/5nk7dR2B+4R7eth89
         mkjpMZEWp8UA5GMUnZlU/nIwHo7ht1/aR800cK4hCCyNdIvLSBqLS0GnTr9dALA3qzKU
         DhEeTCro8gSthwjxYDxW3SQnAqsn2zNCBGGIUuU7C9o1v7z7MLt8vVQ5+CmpgJ/d4i76
         yCiQ==
X-Gm-Message-State: AOAM533MxS5eH/x+iqdgz4zT7gbr9RkPnU2hf7S8vOTr11CkgWfab2zu
        s2wysQ8B6IS2E/5cS/bZZuR6HFqpJLs=
X-Google-Smtp-Source: ABdhPJzcS3ozEJiBIi91mwWzwMDXUpS8awf55coLCtxKiKmeECFzKsC5ZdrwP3kN972QYtikkI1ZPw==
X-Received: by 2002:a17:906:e01:: with SMTP id l1mr2224528eji.425.1590046113052;
        Thu, 21 May 2020 00:28:33 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id y17sm3985765edo.23.2020.05.21.00.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 00:28:32 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, util-linux@vger.kernel.org
To:     Karel Zak <kzak@redhat.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [PATCH 2/4] Manual pages: order NOTES / HISTORY / BUGS / EXAMPLE
 consistently
Message-ID: <6e066e96-acb7-edf5-6337-0e4a264e593b@gmail.com>
Date:   Thu, 21 May 2020 09:28:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

There is value in ensuring that manual page sections use consistently
named sections, as far as possible, and also that sections have a
consistent order within manual pages. This is one of a series of patches
to place manual page sections in a consistent order.

In this patch, we ensure that the NOTES, HISTORY, BUGS, and EXAMPLE
sections are always placed near the end of the page, just above
AUTHORS, COPYRIGHT, SEE ALSO, and AVAILABILITY.

One page is not fixed by this patch: term-utils/agetty.8. This page
is a mess of unusual section names, and probably requires an individual
edit.

Testing that no gross editing mistake (causing accidental loss or addition
of text) was performed as follows:

    $ cat $(grep '\.SH' -l $(find . -name '*.[1-9]') |sort) | sort > a
    [Apply patch]
    $ cat $(grep '\.SH' -l $(find . -name '*.[1-9]') |sort) | sort > b
    $ diff a b
    $ echo $?
    0

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 disk-utils/mkswap.8     |  8 +++---
 disk-utils/raw.8        |  8 +++---
 disk-utils/sfdisk.8     | 18 ++++++------
 lib/terminal-colors.d.5 | 48 +++++++++++++++----------------
 login-utils/last.1      |  8 +++---
 login-utils/lslogins.1  |  6 ++--
 misc-utils/cal.1        |  4 +--
 misc-utils/findmnt.8    | 22 +++++++-------
 misc-utils/kill.1       | 34 +++++++++++-----------
 misc-utils/logger.1     |  8 +++---
 misc-utils/look.1       | 14 ++++-----
 misc-utils/lsblk.8      | 26 ++++++++---------
 misc-utils/mcookie.1    |  4 +--
 misc-utils/rename.1     | 64 ++++++++++++++++++++---------------------
 misc-utils/whereis.1    | 24 ++++++++--------
 schedutils/ionice.1     |  6 ++--
 sys-utils/flock.1       | 26 ++++++++---------
 sys-utils/fstab.5       |  8 +++---
 sys-utils/ipcs.1        | 38 ++++++++++++------------
 sys-utils/losetup.8     |  6 ++--
 sys-utils/mount.8       |  8 +++---
 sys-utils/prlimit.1     |  8 +++---
 sys-utils/readprofile.8 | 50 ++++++++++++++++----------------
 sys-utils/renice.1      | 16 +++++------
 sys-utils/swapon.8      | 26 ++++++++---------
 sys-utils/tunelp.8      |  8 +++---
 term-utils/script.1     | 38 ++++++++++++------------
 text-utils/col.1        | 12 ++++----
 text-utils/colcrt.1     | 20 ++++++-------
 text-utils/column.1     | 48 +++++++++++++++----------------
 text-utils/hexdump.1    |  8 +++---
 text-utils/ul.1         |  8 +++---
 32 files changed, 315 insertions(+), 315 deletions(-)

diff --git a/disk-utils/mkswap.8 b/disk-utils/mkswap.8
index d464341ef..81ad133b4 100644
--- a/disk-utils/mkswap.8
+++ b/disk-utils/mkswap.8
@@ -99,6 +99,10 @@ Display help text and exit.
 .BR \-V , " \-\-version"
 Display version information and exit.
 
+.SH ENVIRONMENT
+.IP LIBBLKID_DEBUG=all
+enables libblkid debug output.
+
 .SH NOTES
 The maximum useful size of a swap area depends on the architecture and
 the kernel version.
@@ -136,10 +140,6 @@ about
 .B the swap file use restrictions
 (holes, preallocation and copy-on-write issues).
 
-.SH ENVIRONMENT
-.IP LIBBLKID_DEBUG=all
-enables libblkid debug output.
-
 .SH SEE ALSO
 .BR fdisk (8),
 .BR swapon (8)
diff --git a/disk-utils/raw.8 b/disk-utils/raw.8
index fcf996c5b..ba9fd256a 100644
--- a/disk-utils/raw.8
+++ b/disk-utils/raw.8
@@ -75,6 +75,10 @@ Display help text and exit.
 \fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
 
+.SH NOTES
+Rather than using raw devices applications should prefer
+.BR open (2)
+devices, such as /dev/sda1, with the O_DIRECT flag.
 .SH BUGS
 The Linux
 .BR dd (1)
@@ -88,10 +92,6 @@ device buffer cache.  If you use raw I/O to overwrite data already in
 the buffer cache, the buffer cache will no longer correspond to the
 contents of the actual storage device underneath.  This is deliberate,
 but is regarded either a bug or a feature depending on who you ask!
-.SH NOTES
-Rather than using raw devices applications should prefer
-.BR open (2)
-devices, such as /dev/sda1, with the O_DIRECT flag.
 .SH AUTHORS
 Stephen Tweedie (sct@redhat.com)
 .SH AVAILABILITY
diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 4859fc9c2..5cccfa70c 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -601,15 +601,6 @@ The warning messages.
 .B welcome
 The welcome message.
 
-.SH NOTES
-Since version 2.26 \fBsfdisk\fR no longer provides the \fB\-R\fR or
-\fB\-\-re\-read\fR option to force the kernel to reread the partition table.
-Use \fBblockdev \-\-rereadpt\fR instead.
-.PP
-Since version 2.26 \fBsfdisk\fR does not provide the \fB\-\-DOS\fR, \fB\-\-IBM\fR, \fB\-\-DOS\-extended\fR,
-\fB\-\-unhide\fR, \fB\-\-show\-extended\fR, \fB\-\-cylinders\fR, \fB\-\-heads\fR, \fB\-\-sectors\fR,
-\fB\-\-inside\-outer\fR, \fB\-\-not\-inside\-outer\fR options.
-
 .SH ENVIRONMENT
 .IP SFDISK_DEBUG=all
 enables sfdisk debug output.
@@ -620,6 +611,15 @@ enables libblkid debug output.
 .IP LIBSMARTCOLS_DEBUG=all
 enables libsmartcols debug output.
 
+.SH NOTES
+Since version 2.26 \fBsfdisk\fR no longer provides the \fB\-R\fR or
+\fB\-\-re\-read\fR option to force the kernel to reread the partition table.
+Use \fBblockdev \-\-rereadpt\fR instead.
+.PP
+Since version 2.26 \fBsfdisk\fR does not provide the \fB\-\-DOS\fR, \fB\-\-IBM\fR, \fB\-\-DOS\-extended\fR,
+\fB\-\-unhide\fR, \fB\-\-show\-extended\fR, \fB\-\-cylinders\fR, \fB\-\-heads\fR, \fB\-\-sectors\fR,
+\fB\-\-inside\-outer\fR, \fB\-\-not\-inside\-outer\fR options.
+
 .SH AUTHORS
 Karel Zak <kzak@redhat.com>
 .PP
diff --git a/lib/terminal-colors.d.5 b/lib/terminal-colors.d.5
index 73dff6a47..4714bf505 100644
--- a/lib/terminal-colors.d.5
+++ b/lib/terminal-colors.d.5
@@ -50,30 +50,6 @@ or
 .I $HOME/.config/terminal-colors.d
 overrides the global setting.
 
-.SH EXAMPLE
-Disable colors for all compatible utilities:
-.RS
-.br
-.B "touch /etc/terminal-colors.d/disable"
-.br
-.RE
-
-Disable colors for all compatible utils on a vt100 terminal:
-.RS
-.br
-.B "touch /etc/terminal-colors.d/@vt100.disable"
-.br
-.RE
-
-Disable colors for all compatible utils except dmesg(1):
-.RS
-.br
-.B "touch /etc/terminal-colors.d/disable"
-.sp
-.B "touch /etc/terminal-colors.d/dmesg.enable"
-.br
-.RE
-
 .SH DEFAULT SCHEME FILES FORMAT
 The following statement is recognized:
 
@@ -180,6 +156,30 @@ a comment.
 .IP TERMINAL_COLORS_DEBUG=all
 enables debug output.
 
+.SH EXAMPLE
+Disable colors for all compatible utilities:
+.RS
+.br
+.B "touch /etc/terminal-colors.d/disable"
+.br
+.RE
+
+Disable colors for all compatible utils on a vt100 terminal:
+.RS
+.br
+.B "touch /etc/terminal-colors.d/@vt100.disable"
+.br
+.RE
+
+Disable colors for all compatible utils except dmesg(1):
+.RS
+.br
+.B "touch /etc/terminal-colors.d/disable"
+.sp
+.B "touch /etc/terminal-colors.d/dmesg.enable"
+.br
+.RE
+
 .SH COMPATIBILITY
 The terminal-colors.d functionality is currently supported by all util-linux
 utilities which provides colorized output.  For more details always see the
diff --git a/login-utils/last.1 b/login-utils/last.1
index bd632a7bb..4ce2774b2 100644
--- a/login-utils/last.1
+++ b/login-utils/last.1
@@ -167,6 +167,10 @@ tomorrow	(time is set to 00:00:00)
 +5min
 -5days
 .TE
+.SH FILES
+/var/log/wtmp
+.br
+/var/log/btmp
 .SH NOTES
 The files
 .I wtmp
@@ -178,10 +182,6 @@ files to be used, they can be created with a simple
 .BR touch (1)
 command (for example,
 .IR "touch /var/log/wtmp" ).
-.SH FILES
-/var/log/wtmp
-.br
-/var/log/btmp
 .SH AUTHORS
 .MT miquels@cistron.nl
 Miquel van Smoorenburg
diff --git a/login-utils/lslogins.1 b/login-utils/lslogins.1
index 3ca9162eb..123f61ccf 100644
--- a/login-utils/lslogins.1
+++ b/login-utils/lslogins.1
@@ -122,9 +122,6 @@ Display the users' security context.
 \fB\-z\fR, \fB\-\-print0\fR
 Delimit user entries with a nul character, instead of a newline.
 
-.SH NOTES
-The default UID thresholds are read from /etc/login.defs.
-
 .SH EXIT STATUS
 .TP
 0
@@ -135,6 +132,9 @@ if incorrect arguments specified,
 .TP
 2
 if a serious error occurs (e.g., a corrupt log).
+.SH NOTES
+The default UID thresholds are read from /etc/login.defs.
+
 .SH HISTORY
 The \fBlslogins\fP utility is inspired by the \fBlogins\fP utility, which first appeared in FreeBSD 4.10.
 .SH AUTHORS
diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index f1b97193f..ac606b355 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -219,6 +219,8 @@ Implicit coloring can be disabled as follows:
 See
 .BR terminal-colors.d (5)
 for more details about colorization configuration.
+.SH HISTORY
+A cal command appeared in Version 6 AT&T UNIX.
 .SH BUGS
 .PP
 The default
@@ -229,8 +231,6 @@ October 1582, are not implemented.
 .PP
 Alternative calendars, such as the Umm al-Qura, the Solar Hijri, the Ge'ez,
 or the lunisolar Hindu, are not supported.
-.SH HISTORY
-A cal command appeared in Version 6 AT&T UNIX.
 .SH AVAILABILITY
 The cal command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/misc-utils/findmnt.8 b/misc-utils/findmnt.8
index 3e49c5be1..128793451 100644
--- a/misc-utils/findmnt.8
+++ b/misc-utils/findmnt.8
@@ -260,6 +260,17 @@ It's possible to specify source (device) or target (mountpoint) to filter mount
 .TP
 .B \-\-verbose
 Force findmnt to print more information (\fB\-\-verify\fP only for now).
+.SH ENVIRONMENT
+.IP LIBMOUNT_FSTAB=<path>
+overrides the default location of the fstab file
+.IP LIBMOUNT_MTAB=<path>
+overrides the default location of the mtab file
+.IP LIBMOUNT_DEBUG=all
+enables libmount debug output
+.IP LIBSMARTCOLS_DEBUG=all
+enables libsmartcols debug output
+.IP LIBSMARTCOLS_DEBUG_PADDING=on
+use visible padding characters. Requires enabled LIBSMARTCOLS_DEBUG.
 .SH EXAMPLE
 .IP "\fBfindmnt \-\-fstab \-t nfs\fP"
 Prints all NFS filesystems defined in
@@ -285,17 +296,6 @@ Monitors mount, unmount, remount and move on /mnt/foo.
 Waits for /mnt/foo unmount.
 .IP "\fBfindmnt \-\-poll=remount \-t ext3 \-O ro\fP"
 Monitors remounts to read-only mode on all ext3 filesystems.
-.SH ENVIRONMENT
-.IP LIBMOUNT_FSTAB=<path>
-overrides the default location of the fstab file
-.IP LIBMOUNT_MTAB=<path>
-overrides the default location of the mtab file
-.IP LIBMOUNT_DEBUG=all
-enables libmount debug output
-.IP LIBSMARTCOLS_DEBUG=all
-enables libsmartcols debug output
-.IP LIBSMARTCOLS_DEBUG_PADDING=on
-use visible padding characters. Requires enabled LIBSMARTCOLS_DEBUG.
 .SH AUTHORS
 .nf
 Karel Zak <kzak@redhat.com>
diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
index 7f542ce0a..6fd50036d 100644
--- a/misc-utils/kill.1
+++ b/misc-utils/kill.1
@@ -147,6 +147,23 @@ Example.  Send signals QUIT, TERM and KILL in sequence and wait for 1000
 milliseconds between the signals
 .br
 kill \-\-verbose \-\-timeout 1000 TERM \-\-timeout 1000 KILL \-\-signal QUIT 12345
+.SH EXIT STATUS
+.B kill
+has the following exit status values:
+.PP
+.RS
+.PD 0
+.TP
+.B 0
+success
+.TP
+.B 1
+failure
+.TP
+.B 64
+partial success (when more than one process specified)
+.PD
+.RE
 .SH NOTES
 Although it is possible to specify the TID (thread ID, see
 .BR gettid (2))
@@ -171,23 +188,6 @@ preferred in relation to the
 executable described by this manual.  Easiest way to ensure one is executing
 the executable is to use full path when calling the command, for example:
 .B "/bin/kill \-\-version"
-.SH EXIT STATUS
-.B kill
-has the following exit status values:
-.PP
-.RS
-.PD 0
-.TP
-.B 0
-success
-.TP
-.B 1
-failure
-.TP
-.B 64
-partial success (when more than one process specified)
-.PD
-.RE
 .SH AUTHORS
 .MT svalente@mit.edu
 Salvatore Valente
diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 6c3d94d62..6dd53705d 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -345,16 +345,16 @@ l l.
 .PP
 For the priority order and intended purposes of these facilities and levels, see
 .BR syslog (3).
+.SH CONFORMING TO
+The
+.B logger
+command is expected to be IEEE Std 1003.2 ("POSIX.2") compatible.
 .SH EXAMPLE
 .B logger System rebooted
 .br
 .B logger \-p local0.notice \-t HOSTIDM \-f /dev/idmc
 .br
 .B logger \-n loghost.example.com System rebooted
-.SH CONFORMING TO
-The
-.B logger
-command is expected to be IEEE Std 1003.2 ("POSIX.2") compatible.
 .SH AUTHORS
 The
 .B logger
diff --git a/misc-utils/look.1 b/misc-utils/look.1
index 539e9f6a1..d33139e98 100644
--- a/misc-utils/look.1
+++ b/misc-utils/look.1
@@ -94,13 +94,6 @@ The
 .B look
 utility exits 0 if one or more lines were found and displayed, 1 if
 no lines were found, and >1 if an error occurred.
-.SH EXAMPLE
-.RS
-.nf
-sort \-d /etc/passwd \-o /tmp/look.dict
-look \-t: root:foobar /tmp/look.dict
-.nf
-.RE
 .SH ENVIRONMENT
 .TP
 .B WORDLIST
@@ -115,6 +108,13 @@ the alternative dictionary
 The
 .B look
 utility appeared in Version 7 AT&T Unix.
+.SH EXAMPLE
+.RS
+.nf
+sort \-d /etc/passwd \-o /tmp/look.dict
+look \-t: root:foobar /tmp/look.dict
+.nf
+.RE
 .SH SEE ALSO
 .BR grep (1),
 .BR sort (1)
diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index 76c64b625..3da4e2e19 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -167,19 +167,6 @@ command is issued.  The specified directory is the system root of the Linux
 instance to be inspected.  The real device nodes in the target directory can
 be replaced by text files with udev attributes.
 
-.SH NOTES
-For partitions, some information (e.g., queue attributes) is inherited from the
-parent device.
-.PP
-The
-.B lsblk
-command needs to be able to look up each block device by major:minor numbers,
-which is done by using
-.IR /sys/dev/block .
-This sysfs block directory appeared in kernel 2.6.27 (October 2008).
-In case of problems with a new enough kernel, check that CONFIG_SYSFS
-was enabled at the time of the kernel build.
-
 .SH EXIT STATUS
 .IP 0
 success
@@ -201,6 +188,19 @@ enables libmount debug output.
 enables libsmartcols debug output.
 .IP LIBSMARTCOLS_DEBUG_PADDING=on
 use visible padding characters. Requires enabled LIBSMARTCOLS_DEBUG.
+.SH NOTES
+For partitions, some information (e.g., queue attributes) is inherited from the
+parent device.
+.PP
+The
+.B lsblk
+command needs to be able to look up each block device by major:minor numbers,
+which is done by using
+.IR /sys/dev/block .
+This sysfs block directory appeared in kernel 2.6.27 (October 2008).
+In case of problems with a new enough kernel, check that CONFIG_SYSFS
+was enabled at the time of the kernel build.
+
 .SH AUTHORS
 .nf
 Milan Broz <mbroz@redhat.com>
diff --git a/misc-utils/mcookie.1 b/misc-utils/mcookie.1
index d907a79aa..fcb37edc5 100644
--- a/misc-utils/mcookie.1
+++ b/misc-utils/mcookie.1
@@ -51,12 +51,12 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH BUGS
-It is assumed that none of the randomness sources will block.
 .SH FILES
 .I /dev/urandom
 .br
 .I /dev/random
+.SH BUGS
+It is assumed that none of the randomness sources will block.
 .SH SEE ALSO
 .BR md5sum (1),
 .BR X (7),
diff --git a/misc-utils/rename.1 b/misc-utils/rename.1
index 8067017f2..64c70f7e4 100644
--- a/misc-utils/rename.1
+++ b/misc-utils/rename.1
@@ -40,38 +40,6 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH EXAMPLE
-Given the files
-.IR foo1 ", ..., " foo9 ", " foo10 ", ..., " foo278 ,
-the commands
-.RS
-.PP
-.nf
-rename foo foo00 foo?
-rename foo foo0 foo??
-.fi
-.PP
-.RE
-will turn them into
-.IR foo001 ", ..., " foo009 ", " foo010 ", ..., " foo278 .
-And
-.RS
-.PP
-.nf
-rename .htm .html *.htm
-.fi
-.PP
-.RE
-will fix the extension of your html files.
-Provide an empty string for shortening:
-.RS
-.PP
-.nf
-rename '_with_long_name' '' file_with_long_name.*
-.fi
-.PP
-.RE
-will remove the substring in the filenames.
 .SH WARNING
 The renaming has no safeguards by default or without any one of the options
 .B \-\-no-overwrite\fR,
@@ -116,6 +84,38 @@ nothing was renamed
 unanticipated error occurred
 .PD
 .RE
+.SH EXAMPLE
+Given the files
+.IR foo1 ", ..., " foo9 ", " foo10 ", ..., " foo278 ,
+the commands
+.RS
+.PP
+.nf
+rename foo foo00 foo?
+rename foo foo0 foo??
+.fi
+.PP
+.RE
+will turn them into
+.IR foo001 ", ..., " foo009 ", " foo010 ", ..., " foo278 .
+And
+.RS
+.PP
+.nf
+rename .htm .html *.htm
+.fi
+.PP
+.RE
+will fix the extension of your html files.
+Provide an empty string for shortening:
+.RS
+.PP
+.nf
+rename '_with_long_name' '' file_with_long_name.*
+.fi
+.PP
+.RE
+will remove the substring in the filenames.
 .SH SEE ALSO
 .BR mv (1)
 .SH AVAILABILITY
diff --git a/misc-utils/whereis.1 b/misc-utils/whereis.1
index dee143f99..8da51d8e9 100644
--- a/misc-utils/whereis.1
+++ b/misc-utils/whereis.1
@@ -131,18 +131,6 @@ Display help text and exit.
 .TP
 \fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
-.SH EXAMPLE
-To find all files in
-.I /usr/\:bin
-which are not documented
-in
-.I /usr/\:man/\:man1
-or have no source in
-.IR /usr/\:src :
-.IP
-.B cd /usr/bin
-.br
-.B whereis \-u \-ms \-M /usr/man/man1 \-S /usr/src \-f *
 .SH FILE SEARCH PATHS
 By default
 .B whereis
@@ -165,6 +153,18 @@ are displayed with
 .SH ENVIRONMENT
 .IP WHEREIS_DEBUG=all
 enables debug output.
+.SH EXAMPLE
+To find all files in
+.I /usr/\:bin
+which are not documented
+in
+.I /usr/\:man/\:man1
+or have no source in
+.IR /usr/\:src :
+.IP
+.B cd /usr/bin
+.br
+.B whereis \-u \-ms \-M /usr/man/man1 \-S /usr/src \-f *
 .SH AVAILABILITY
 The whereis command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/schedutils/ionice.1 b/schedutils/ionice.1
index 0b2daba6c..415def55a 100644
--- a/schedutils/ionice.1
+++ b/schedutils/ionice.1
@@ -113,6 +113,9 @@ scheduling parameters.
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
+.SH NOTES
+Linux supports I/O scheduling priorities and classes since 2.6.13 with the CFQ
+I/O scheduler.
 .SH EXAMPLE
 .LP
 .TP 7
@@ -127,9 +130,6 @@ Runs 'bash' as a best-effort program with highest priority.
 # \fBionice\fP \-p 89 91
 .TP 7
 Prints the class and priority of the processes with PID 89 and 91.
-.SH NOTES
-Linux supports I/O scheduling priorities and classes since 2.6.13 with the CFQ
-I/O scheduler.
 .SH AUTHORS
 .nf
 Jens Axboe <jens@axboe.dk>
diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index 0da5ea946..bea70c6be 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -124,6 +124,19 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
+.SH EXIT STATUS
+The command uses
+.B sysexits.h
+exit status values for everything, except when using either of the options
+.B \-n
+or
+.B \-w
+which report a failure to acquire the lock with a exit status given by the
+.B \-E
+option, or 1 by default.
+.PP
+When using the \fIcommand\fR variant, and executing the child worked, then
+the exit status is that of the child command.
 .SH EXAMPLE
 Note that "shell> " in examples is a command line prompt.
 .TP
@@ -175,19 +188,6 @@ shell> flock -n 4
 This form is convenient for locking a file without spawning a subprocess.
 The shell opens the lock file for reading and writing as file descriptor 4,
 then flock is used to lock the descriptor.
-.SH EXIT STATUS
-The command uses
-.B sysexits.h
-exit status values for everything, except when using either of the options
-.B \-n
-or
-.B \-w
-which report a failure to acquire the lock with a exit status given by the
-.B \-E
-option, or 1 by default.
-.PP
-When using the \fIcommand\fR variant, and executing the child worked, then
-the exit status is that of the child command.
 .SH AUTHORS
 .UR hpa@zytor.com
 H. Peter Anvin
diff --git a/sys-utils/fstab.5 b/sys-utils/fstab.5
index 9e73d4349..118df0d3d 100644
--- a/sys-utils/fstab.5
+++ b/sys-utils/fstab.5
@@ -216,6 +216,10 @@ parallelism available in the hardware.
 Defaults to zero (don't fsck) if not present.
 .RE
 
+.SH FILES
+.IR /etc/fstab ,
+.I <fstab.h>
+
 .SH NOTES
 The proper way to read records from
 .B fstab
@@ -228,10 +232,6 @@ The keyword
 .B ignore
 as a filesystem type (3rd field) is no longer supported by the pure
 libmount based mount utility (since util-linux v2.22).
-
-.SH FILES
-.IR /etc/fstab ,
-.I <fstab.h>
 .SH HISTORY
 The ancestor of this
 .B fstab
diff --git a/sys-utils/ipcs.1 b/sys-utils/ipcs.1
index a7fcb540e..8fd1a33ef 100644
--- a/sys-utils/ipcs.1
+++ b/sys-utils/ipcs.1
@@ -75,25 +75,6 @@ Print sizes in bytes.
 .TP
 .B \-\-human
 Print sizes in human-readable format.
-.SH NOTES
-The current implementation of
-.B ipcs
-obtains information about available IPC resources by parsing the files in
-.IR /proc/sysvipc .
-Before util-linux version v2.23, an alternate mechanism was used: the
-.BR IPC_STAT
-command of
-.BR msgctl (2),
-.BR semctl (2),
-and
-.BR shmctl (2).
-This mechanism is also used in later util-linux versions in the case where
-.I /proc
-is unavailable.
-A limitation of the
-.B IPC_STAT
-mechanism is that it can only be used to retrieve information about
-IPC resources for which the user has read permission.
 .SH CONFORMING TO
 The Linux ipcs utility is not fully compatible to the POSIX ipcs utility.
 The Linux version does not support the POSIX
@@ -113,6 +94,25 @@ options not defined by POSIX.  A portable application shall not use the
 and
 .B \-u
 options.
+.SH NOTES
+The current implementation of
+.B ipcs
+obtains information about available IPC resources by parsing the files in
+.IR /proc/sysvipc .
+Before util-linux version v2.23, an alternate mechanism was used: the
+.BR IPC_STAT
+command of
+.BR msgctl (2),
+.BR semctl (2),
+and
+.BR shmctl (2).
+This mechanism is also used in later util-linux versions in the case where
+.I /proc
+is unavailable.
+A limitation of the
+.B IPC_STAT
+mechanism is that it can only be used to retrieve information about
+IPC resources for which the user has read permission.
 .SH AUTHORS
 .UR balasub@cis.ohio-state.edu
 Krishna Balasubramanian
diff --git a/sys-utils/losetup.8 b/sys-utils/losetup.8
index 6c4f603da..0db710449 100644
--- a/sys-utils/losetup.8
+++ b/sys-utils/losetup.8
@@ -186,6 +186,9 @@ loop block devices
 .I /dev/loop-control
 loop control device
 
+.SH ENVIRONMENT
+.IP LOOPDEV_DEBUG=all
+enables debug output.
 .SH EXAMPLE
 The following commands can be used as an example of using the loop device.
 .nf
@@ -199,9 +202,6 @@ The following commands can be used as an example of using the loop device.
 # umount /dev/loop0
 # losetup \-\-detach /dev/loop0
 .fi
-.SH ENVIRONMENT
-.IP LOOPDEV_DEBUG=all
-enables debug output.
 .SH AUTHORS
 Karel Zak <kzak@redhat.com>, based on the original version from
 Theodore Ts'o <tytso@athena.mit.edu>
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 2ffbfe812..9a43672c6 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -2605,6 +2605,10 @@ enables libmount debug output
 enables libblkid debug output
 .IP LOOPDEV_DEBUG=all
 enables loop device setup debug output
+.SH HISTORY
+A
+.B mount
+command existed in Version 5 AT&T UNIX.
 .SH BUGS
 It is possible for a corrupted filesystem to cause a crash.
 .PP
@@ -2664,10 +2668,6 @@ the
 command manually before calling
 .B mount
 with the configured loop device.
-.SH HISTORY
-A
-.B mount
-command existed in Version 5 AT&T UNIX.
 .SH AUTHORS
 .nf
 Karel Zak <kzak@redhat.com>
diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
index 0f2b49f37..89933d90a 100644
--- a/sys-utils/prlimit.1
+++ b/sys-utils/prlimit.1
@@ -89,6 +89,10 @@ Maximum number of file locks held.
 .IP "\fB\-y, \-\-rttime\fP[=\fIlimits\fR]"
 Timeout for real-time tasks.
 
+.SH NOTES
+The prlimit system call is supported since Linux 2.6.36, older kernels will
+break this program.
+
 .SH EXAMPLE
 .IP "\fBprlimit \-\-pid 13134\fP"
 Display limit values for all current resources.
@@ -103,10 +107,6 @@ processes to unlimited.
 .IP "\fBprlimit \-\-cpu=10 sort \-u hugefile\fP"
 Set both the soft and hard CPU time limit to ten seconds and run 'sort'.
 
-.SH NOTES
-The prlimit system call is supported since Linux 2.6.36, older kernels will
-break this program.
-
 .SH AUTHORS
 .nf
 Davidlohr Bueso <dave@gnu.org> - In memory of Dennis M. Ritchie.
diff --git a/sys-utils/readprofile.8 b/sys-utils/readprofile.8
index 7b7b2ab41..c335644d7 100644
--- a/sys-utils/readprofile.8
+++ b/sys-utils/readprofile.8
@@ -90,6 +90,31 @@ Display version information and exit.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
+.SH FILES
+.nf
+/proc/profile              A binary snapshot of the profiling buffer.
+/usr/src/linux/System.map  The symbol table for the kernel.
+/usr/src/linux/*           The program being profiled :-)
+.fi
+.SH BUGS
+.LP
+.B readprofile
+only works with a 1.3.x or newer kernel, because
+.I /proc/profile
+changed in the step from 1.2 to 1.3
+.LP
+This program only works with ELF kernels.  The change for a.out
+kernels is trivial, and left as an exercise to the a.out user.
+.LP
+To enable profiling, the kernel must be rebooted, because no
+profiling module is available, and it wouldn't be easy to build.  To
+enable profiling, you can specify "profile=2" (or another number) on
+the kernel commandline.  The number you specify is the two-exponent
+used as profiling step.
+.LP
+Profiling is disabled when interrupts are inhibited.  This means that
+many profiling ticks happen when interrupts are re-enabled.  Watch
+out for misleading information.
 .SH EXAMPLE
 Browse the profiling buffer ordering by clock ticks:
 .nf
@@ -120,31 +145,6 @@ Request profiling at 2kHz per CPU, and reset the profiling buffer:
 .nf
    sudo readprofile \-M 20
 .fi
-.SH BUGS
-.LP
-.B readprofile
-only works with a 1.3.x or newer kernel, because
-.I /proc/profile
-changed in the step from 1.2 to 1.3
-.LP
-This program only works with ELF kernels.  The change for a.out
-kernels is trivial, and left as an exercise to the a.out user.
-.LP
-To enable profiling, the kernel must be rebooted, because no
-profiling module is available, and it wouldn't be easy to build.  To
-enable profiling, you can specify "profile=2" (or another number) on
-the kernel commandline.  The number you specify is the two-exponent
-used as profiling step.
-.LP
-Profiling is disabled when interrupts are inhibited.  This means that
-many profiling ticks happen when interrupts are re-enabled.  Watch
-out for misleading information.
-.SH FILES
-.nf
-/proc/profile              A binary snapshot of the profiling buffer.
-/usr/src/linux/System.map  The symbol table for the kernel.
-/usr/src/linux/*           The program being profiled :-)
-.fi
 .SH AVAILABILITY
 The readprofile command is part of the util-linux package and is
 available from
diff --git a/sys-utils/renice.1 b/sys-utils/renice.1
index cfba47ff8..99cc61f21 100644
--- a/sys-utils/renice.1
+++ b/sys-utils/renice.1
@@ -77,11 +77,10 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH EXAMPLE
-The following command would change the priority of the processes with
-PIDs 987 and 32, plus all processes owned by the users daemon and root:
+.SH FILES
 .TP
-.B "       renice" +1 987 \-u daemon root \-p 32
+.I /etc/passwd
+to map user names to user IDs
 .SH NOTES
 Users other than the superuser may only alter the priority of processes they
 own.  Furthermore, an unprivileged user can only
@@ -98,14 +97,15 @@ value in the range \-20 to 19.
 Useful priorities are: 19 (the affected processes will run only when nothing
 else in the system wants to), 0 (the ``base'' scheduling priority), anything
 negative (to make things go very fast).
-.SH FILES
-.TP
-.I /etc/passwd
-to map user names to user IDs
 .SH HISTORY
 The
 .B renice
 command appeared in 4.0BSD.
+.SH EXAMPLE
+The following command would change the priority of the processes with
+PIDs 987 and 32, plus all processes owned by the users daemon and root:
+.TP
+.B "       renice" +1 987 \-u daemon root \-p 32
 .SH SEE ALSO
 .BR nice (1),
 .BR chrt (1),
diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index 157bbcd95..276e36e00 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -187,6 +187,19 @@ Be verbose.
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
+.SH ENVIRONMENT
+.IP LIBMOUNT_DEBUG=all
+enables libmount debug output.
+.IP LIBBLKID_DEBUG=all
+enables libblkid debug output.
+
+.SH FILES
+.br
+.I /dev/sd??
+standard paging devices
+.br
+.I /etc/fstab
+ascii filesystem description table
 .SH NOTES
 .SS Files with holes
 The swap file implementation in the kernel expects to be able to write to the
@@ -220,19 +233,6 @@ automatically detects and rewrites a swap space signature with old software
 suspend data (e.g., S1SUSPEND, S2SUSPEND, ...). The problem is that if we don't
 do it, then we get data corruption the next time an attempt at unsuspending is
 made.
-.SH ENVIRONMENT
-.IP LIBMOUNT_DEBUG=all
-enables libmount debug output.
-.IP LIBBLKID_DEBUG=all
-enables libblkid debug output.
-
-.SH FILES
-.br
-.I /dev/sd??
-standard paging devices
-.br
-.I /etc/fstab
-ascii filesystem description table
 .SH HISTORY
 The
 .B swapon
diff --git a/sys-utils/tunelp.8 b/sys-utils/tunelp.8
index 7716ba7e1..35287bc8b 100644
--- a/sys-utils/tunelp.8
+++ b/sys-utils/tunelp.8
@@ -102,6 +102,10 @@ later.
 .TP
 \fB\-q\fR, \fB\-\-print\-irq\fR \fI<on|off>\fR
 This option sets printing the display of the current IRQ setting.
+.SH FILES
+.I /dev/lp?
+.br
+.I /proc/parport/*/*
 .SH NOTES
 .BR \-o ,
 .BR \-C ,
@@ -111,10 +115,6 @@ all require a Linux kernel version of 1.1.76 or later.
 .PP
 .B \-C
 requires a Linux version prior to 2.1.131.
-.SH FILES
-.I /dev/lp?
-.br
-.I /proc/parport/*/*
 .SH AVAILABILITY
 The tunelp  command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/term-utils/script.1 b/term-utils/script.1
index 73ec27c2e..ce6b124a4 100644
--- a/term-utils/script.1
+++ b/term-utils/script.1
@@ -190,6 +190,25 @@ Display version information and exit.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
+.SH SIGNALS
+Upon receiving
+.BR SIGUSR1 ,
+.B script
+immediately flushes the output files.
+.PP
+.SH ENVIRONMENT
+The following environment variable is utilized by
+.BR script :
+.TP
+.B SHELL
+If the variable
+.B SHELL
+exists, the shell forked by
+.B script
+will be that shell.  If
+.B SHELL
+is not set, the Bourne shell is assumed.  (Most shells set this variable
+automatically).
 .SH NOTES
 The script ends when the forked shell exits (a
 .I control-D
@@ -240,25 +259,6 @@ You should also avoid use of script in command pipes, as
 .B script
 can read more input than you would expect.
 .PP
-.SH SIGNALS
-Upon receiving
-.BR SIGUSR1 ,
-.B script
-immediately flushes the output files.
-.PP
-.SH ENVIRONMENT
-The following environment variable is utilized by
-.BR script :
-.TP
-.B SHELL
-If the variable
-.B SHELL
-exists, the shell forked by
-.B script
-will be that shell.  If
-.B SHELL
-is not set, the Bourne shell is assumed.  (Most shells set this variable
-automatically).
 .SH HISTORY
 The
 .B script
diff --git a/text-utils/col.1 b/text-utils/col.1
index 322f0afe5..cdd5c02d1 100644
--- a/text-utils/col.1
+++ b/text-utils/col.1
@@ -85,6 +85,12 @@ Display version information and exit.
 .TP
 \fB\-H\fR, \fB\-\-help\fR
 Display help text and exit.
+.SH CONFORMING TO
+The
+.B col
+utility conforms to the Single UNIX Specification, Version 2.  The
+.B \-l
+option is an extension to the standard.
 .SH NOTES
 The control sequences for carriage motion that
 .B col
@@ -137,12 +143,6 @@ character set is correct when they are output.
 If the input attempts to back up to the last flushed line,
 .B col
 will display a warning message.
-.SH CONFORMING TO
-The
-.B col
-utility conforms to the Single UNIX Specification, Version 2.  The
-.B \-l
-option is an extension to the standard.
 .SH HISTORY
 A
 .B col
diff --git a/text-utils/colcrt.1 b/text-utils/colcrt.1
index 5f8bf445b..90ded9577 100644
--- a/text-utils/colcrt.1
+++ b/text-utils/colcrt.1
@@ -66,14 +66,10 @@ Display version information and exit.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
-.SH EXAMPLE
-A typical use of
+.SH HISTORY
+The
 .B colcrt
-would be:
-.PP
-.RS
-.B tbl exum2.n \&| nroff \-ms \&| colcrt \- \&| more
-.RE
+command appeared in 3.0BSD.
 .SH BUGS
 Should fold underlines onto blanks even with the
 .B '\-'
@@ -88,10 +84,14 @@ Lines are trimmed to 132 characters.
 .PP
 Some provision should be made for processing superscripts and subscripts in
 documents which are already double-spaced.
-.SH HISTORY
-The
+.SH EXAMPLE
+A typical use of
 .B colcrt
-command appeared in 3.0BSD.
+would be:
+.PP
+.RS
+.B tbl exum2.n \&| nroff \-ms \&| colcrt \- \&| more
+.RE
 .SH SEE ALSO
 .BR col (1),
 .BR more (1),
diff --git a/text-utils/column.1 b/text-utils/column.1
index 23f582b37..e43d6fee4 100644
--- a/text-utils/column.1
+++ b/text-utils/column.1
@@ -126,28 +126,8 @@ Display help text and exit.
 .SH ENVIRONMENT
 The environment variable \fBCOLUMNS\fR is used to determine the size of
 the screen if no other information is available.
-.SH EXAMPLE
-Print fstab with header line and align number to the right:
-.EX
-\fBsed 's/#.*//' /etc/fstab | column \-\-table \-\-table-columns SOURCE,TARGET,TYPE,OPTIONS,PASS,FREQ \-\-table-right PASS,FREQ\fR
-.EE
-.PP
-Print fstab and hide unnamed columns:
-.EX
-\fBsed 's/#.*//' /etc/fstab | column \-\-table \-\-table-columns SOURCE,TARGET,TYPE \-\-table-hide \-\fR
-.EE
-.PP
-
-.PP
-Print a tree:
-.EX
-\fBecho \-e '1 0 A\\n2 1 AA\\n3 1 AB\\n4 2 AAA\\n5 2 AAB' | column \-\-tree-id 1 \-\-tree-parent 2 \-\-tree 3\fR
-1  0  A
-2  1  |-AA
-4  2  | |-AAA
-5  2  | `-AAB
-3  1  `-AB
-.EE
+.SH HISTORY
+The column command appeared in 4.3BSD-Reno.
 .SH BUGS
 Version 2.23 changed the
 .B \-s
@@ -177,8 +157,28 @@ has since been corrected (see above). Other implementations of
 .B column
 may continue to use the older documentation, but the behavior should be
 identical in any case.
-.SH HISTORY
-The column command appeared in 4.3BSD-Reno.
+.SH EXAMPLE
+Print fstab with header line and align number to the right:
+.EX
+\fBsed 's/#.*//' /etc/fstab | column \-\-table \-\-table-columns SOURCE,TARGET,TYPE,OPTIONS,PASS,FREQ \-\-table-right PASS,FREQ\fR
+.EE
+.PP
+Print fstab and hide unnamed columns:
+.EX
+\fBsed 's/#.*//' /etc/fstab | column \-\-table \-\-table-columns SOURCE,TARGET,TYPE \-\-table-hide \-\fR
+.EE
+.PP
+
+.PP
+Print a tree:
+.EX
+\fBecho \-e '1 0 A\\n2 1 AA\\n3 1 AB\\n4 2 AAA\\n5 2 AAB' | column \-\-tree-id 1 \-\-tree-parent 2 \-\-tree 3\fR
+1  0  A
+2  1  |-AA
+4  2  | |-AAA
+5  2  | `-AAB
+3  1  `-AB
+.EE
 .SH SEE ALSO
 .BR colrm (1),
 .BR ls (1),
diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
index 4af4ffe0e..f5728f939 100644
--- a/text-utils/hexdump.1
+++ b/text-utils/hexdump.1
@@ -343,6 +343,10 @@ used between format units than in the default output).
 .SH EXIT STATUS
 .B hexdump
 exits 0 on success and >0 if an error occurred.
+.SH CONFORMING TO
+The
+.B hexdump
+utility is expected to be IEEE Std 1003.2 ("POSIX.2") compatible.
 .SH EXAMPLE
 Display the input in perusal format:
 .nf
@@ -369,10 +373,6 @@ Implicit coloring can be disabled by an empty file \fI/etc/terminal-colors.d/hex
 See
 .BR terminal-colors.d (5)
 for more details about colorization configuration.
-.SH CONFORMING TO
-The
-.B hexdump
-utility is expected to be IEEE Std 1003.2 ("POSIX.2") compatible.
 .SH AVAILABILITY
 The hexdump command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/text-utils/ul.1 b/text-utils/ul.1
index 7dc9ddd7b..860087593 100644
--- a/text-utils/ul.1
+++ b/text-utils/ul.1
@@ -90,15 +90,15 @@ or as set during the login process by the user in their
 .B login
 file (see
 .BR setenv (3)).
+.SH HISTORY
+The
+.B ul
+command appeared in 3.0BSD.
 .SH BUGS
 .B nroff
 usually outputs a series of backspaces and underlines intermixed with the
 text to indicate underlining.  No attempt is made to optimize the backward
 motion.
-.SH HISTORY
-The
-.B ul
-command appeared in 3.0BSD.
 .SH SEE ALSO
 .BR colcrt (1),
 .BR login (1),
-- 
2.26.2

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
