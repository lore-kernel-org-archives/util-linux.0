Return-Path: <SRS0=/i5r=7L=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4DCC433E1
	for <util-linux@archiver.kernel.org>; Fri, 29 May 2020 12:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9508C20723
	for <util-linux@archiver.kernel.org>; Fri, 29 May 2020 12:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/ta+v1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgE2MU4 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 29 May 2020 08:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgE2MUz (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 29 May 2020 08:20:55 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03DDC03E969
        for <util-linux@vger.kernel.org>; Fri, 29 May 2020 05:20:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t18so3321707wru.6
        for <util-linux@vger.kernel.org>; Fri, 29 May 2020 05:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CMHsQdfTj3zr+mnkKs/PAxORZwEdzZp6ym9wmv18Rpk=;
        b=p/ta+v1BwAFbZMmoIZEOh14xf/+5fOeWDa8idyuRLHoaFpAvf9NvYWurRLrb3I2TYh
         R+lIkHY27ENsSGi96/jq75shHC5H2xnSKzVFTUpSt6M1g/DY8WSQzuPeYpMDshq3WCTH
         6zPFjW1ZlphebYyM9Vpphe1P7qxo9blNHOhs42b2msx3GJz13I8bpOxYkcvvVXlU8EgW
         8bofTzbk+YJW0mNAYgjbXOKnQsPv5MSeDyMRsVVktxj4g2MAW4GqsgDsB5TRnLM/G9tE
         xx2A9eEkj9AAwNjoBA2RALg0+8nEbWBcJ9wf5jy2A6Xmy1i0P65muada+tOpwTqTqHM/
         /JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CMHsQdfTj3zr+mnkKs/PAxORZwEdzZp6ym9wmv18Rpk=;
        b=YAaXOk7xMZBFBt9II4zNQ1ut8ykgtgimL9x9TByR66MXtiStGr7pCWrIeOEd5+2r9S
         u8JRTGwb0CviIvrOj31NWHBvgYaeZtUQ5e0EyXmTcG+BNl4S+yp+zzPMcLvrKVYLRyUU
         0xy4cr9T8N+0okwf++ZUL3vrDqyAxDrO3l0wKZkrovIAXlHM2Y5EApnUK8PwJMFNq3a9
         16OnV2nIr4V/39YFxLdm/hI1GqdmQ0T2KO2iQBoqqhFqwwS65DOi1F18ftlZpUE7hsb4
         p9Fv9aaQut/vrhQiK5lCDw77nF6bRnrHhL+GZPLl8EjUTvJuAm8WH+8xbfATzIW4gjVb
         VaWg==
X-Gm-Message-State: AOAM5323RWeRPL0H1AsdK/+U0NDLHgKkZPSxbP0U6owC+bgoDgqORDAk
        bF5BHF6wL2ThhwQc+fUBBiy/sJQiDPI=
X-Google-Smtp-Source: ABdhPJy77dYCjFxleZrfDAgY8XP/0RRlzxfaliehWRL50hlUllO5nmF5Nw+3LiFYT/n4rB8wPtwPPw==
X-Received: by 2002:adf:82f8:: with SMTP id 111mr5734937wrc.257.1590754852598;
        Fri, 29 May 2020 05:20:52 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2516:6501:a84b:ccd6:785a:2f0f])
        by smtp.gmail.com with ESMTPSA id u7sm9911386wrm.23.2020.05.29.05.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 05:20:52 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 2/2] Manual pages: mount.8: Miscellaneous wording, grammar, and formatting fixes
Date:   Fri, 29 May 2020 14:20:48 +0200
Message-Id: <20200529122048.1052198-2-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529122048.1052198-1-mtk.manpages@gmail.com>
References: <20200529122048.1052198-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Most of these are "obviously correct":
- formatting fixes
- improved English wordings
- add missing articles ("a", "the")
- a few spelling fixes
- a few "obvious" corrections to the text

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 sys-utils/mount.8 | 318 +++++++++++++++++++++++++++-------------------
 1 file changed, 188 insertions(+), 130 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index ca1544c9e..5b8b0d5f2 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -106,7 +106,8 @@ file.  It's possible to use the
 .B \-\-target
 or
 .B \-\-source
-options to avoid ambivalent interpretation of the given argument.  For example:
+options to avoid ambiguous interpretation of the given argument.
+For example:
 .RS
 .sp
 .B mount \-\-target /mountpoint
@@ -115,7 +116,9 @@ options to avoid ambivalent interpretation of the given argument.  For example:
 
 The same filesystem may be mounted more than once, and in some cases (e.g.,
 network filesystems) the same filesystem may be mounted on the same
-mountpoint more times. The mount command does not implement any policy to
+mountpoint multiple times. The
+.B mount
+command does not implement any policy to
 control this behavior. All behavior is controlled by the kernel and it is usually
 specific to the filesystem driver. The exception is \fB\-\-all\fR, in this case
 already mounted filesystems are ignored (see \fB\-\-all\fR below for more details).
@@ -150,7 +153,8 @@ or UUID.  Partition identifiers are supported for example for GUID Partition
 Tables (GPT).
 
 The device names of disk partitions are unstable; hardware reconfiguration,
-adding or removing a device can cause changes in names. This is the reason why it's
+and adding or removing a device can cause changes in names.
+This is the reason why it's
 strongly recommended to use filesystem or partition identifiers like UUID or
 LABEL.
 
@@ -187,9 +191,9 @@ of the UUID should be based on lower case characters.
 The
 .I proc
 filesystem is not associated with a special device, and when
-mounting it, an arbitrary keyword, such as
-.I proc
-can be used instead of a device specification.
+mounting it, an arbitrary keyword\(emfor example,
+.IR proc \(emcan
+be used instead of a device specification.
 (The customary choice
 .I none
 is less fortunate: the error message `none already mounted' from
@@ -226,7 +230,7 @@ to be mounted as indicated, except for those whose line contains the
 keyword.  Adding the
 .B \-F
 option will make \fBmount\fR fork, so that the
-filesystems are mounted simultaneously.
+filesystems are mounted in parallel.
 .LP
 When mounting a filesystem mentioned in
 .I fstab
@@ -242,12 +246,18 @@ traditionally maintained a list of currently mounted filesystems in the file
 .IR /etc/mtab .
 The support for regular classic
 .I /etc/mtab
-is completely disabled in compile time by default, because on current Linux
-systems it is better to make it a symlink to
+is completely disabled at compile time by default, because on current Linux
+systems it is better to make
+.I /etc/mtab
+a symlink to
 .I /proc/mounts
-instead. The regular mtab file maintained in userspace cannot reliably
+instead. The regular
+.I mtab
+file maintained in userspace cannot reliably
 work with namespaces, containers and other advanced Linux features.
-If the regular mtab support is enabled than it's possible to
+If the regular
+.I mtab
+support is enabled, then it's possible to
 use the file as well as the symlink.
 .sp
 If no arguments are given to
@@ -255,7 +265,7 @@ If no arguments are given to
 the list of mounted filesystems is printed.
 .sp
 If you want to override mount options from
-.I /etc/fstab
+.IR /etc/fstab ,
 you have to use the \fB\-o\fR option:
 .RS
 .sp
@@ -265,8 +275,9 @@ you have to use the \fB\-o\fR option:
 and then the mount options from the command line will be appended to
 the list of options from
 .IR /etc/fstab .
-This default behaviour is possible to change by command line
-option \fB\-\-options\-mode\fR.
+This default behaviour can be changed using the
+\fB\-\-options\-mode\fR
+command-line option.
 The usual behavior is that the last option wins if there are conflicting
 ones.
 .sp
@@ -285,12 +296,13 @@ are specified.  For example, to mount device
 .B "mount /dev/foo /dir"
 .sp
 .RE
-This default behaviour is possible to change by command line option
-\fB\-\-options\-source\-force\fR to always read configuration from
+This default behaviour can be changed by using the
+\fB\-\-options\-source\-force\fR command-line option
+to always read configuration from
 .IR fstab .
 For non-root users
 .B mount
-always read
+always reads the
 .I fstab
 configuration.
 
@@ -310,6 +322,7 @@ Thus, given a line
 .RE
 any user can mount the iso9660 filesystem found on an inserted CDROM
 using the command:
+.PP
 .RS
 .B "mount /cd"
 .sp
@@ -319,12 +332,13 @@ specified on command line are verified before
 .I fstab
 is parsed or a helper
 program is executed. It's strongly recommended to use a valid mountpoint to
-specify filesystem, otherwise \fBmount\fR may fail. For example it's bad idea
+specify filesystem, otherwise \fBmount\fR may fail. For example it's a bad idea
 to use NFS or CIFS source on command line.
 .PP
-Since version 2.35 \fBmount\fR command does not exit when user permissions are
-inadequate by internal libmount security rules.  It drops suid permissions
-and continue as regular non-root user. It allows to support use-cases where
+Since util-linux 2.35, \fBmount\fR does not exit when user permissions are
+inadequate according to libmount's internal security rules.
+Instead, it drops suid permissions
+and continues as regular non-root user. This behavior supports use-cases where
 root permissions are not necessary (e.g., fuse filesystems, user namespaces,
 etc).
 .PP
@@ -348,7 +362,7 @@ of the special file.  This may be useful e.g.\& for
 if a login script makes the console user owner of this device.
 The
 .B group
-option is similar, with the restriction that the user must be
+option is similar, with the restriction that the user must be a
 member of the group of the special file.
 
 .SS Bind mount operation
@@ -373,14 +387,14 @@ entry:
 
 After this call the same contents are accessible in two places.
 
-It is important to understand that "bind" does not to create any second-class
+It is important to understand that "bind" does not create any second-class
 or special node in the kernel VFS. The "bind" is just another operation to
 attach a filesystem. There is nowhere stored information that the filesystem
-has been attached by "bind" operation. The \fIolddir\fR and \fInewdir\fR are
-independent and the \fIolddir\fR may be umounted.
+has been attached by a "bind" operation. The \fIolddir\fR and \fInewdir\fR are
+independent and the \fIolddir\fR may be unmounted.
 
 One can also remount a single file (on a single file).  It's also
-possible to use the bind mount to create a mountpoint from a regular
+possible to use a bind mount to create a mountpoint from a regular
 directory, for example:
 
 .RS
@@ -389,7 +403,7 @@ directory, for example:
 .RE
 
 The bind mount call attaches only (part of) a single filesystem, not possible
-submounts.  The entire file hierarchy including submounts is attached
+submounts.  The entire file hierarchy including submounts can be attached
 a second place by using:
 
 .RS
@@ -398,14 +412,17 @@ a second place by using:
 .I olddir newdir
 .RE
 
-Note that the filesystem mount options maintained by kernel will remain the same as those
+Note that the filesystem mount options maintained by the kernel will remain the same as those
 on the original mount point.  The userspace mount options (e.g., _netdev) will not be copied
 by
-.BR mount (8)
-and it's necessary explicitly specify the options on mount command line.
+.BR mount
+and it's necessary to explicitly specify the options on the
+.B mount
+command line.
 
+Since util-linux 2.27
 .BR mount (8)
-since v2.27 allows to change the mount options by passing the
+permits changing the mount options by passing the
 relevant options along with
 .BR \-\-bind .
 For example:
@@ -439,18 +456,21 @@ will be writable, but the
 will be read-only.
 
 It's also possible to change nosuid, nodev, noexec, noatime, nodiratime and
-relatime VFS entry flags by "remount,bind" operation.
-The other (for example
-filesystem specific flags) are silently ignored.  It's impossible to change mount
+relatime VFS entry flags via a "remount,bind" operation.
+The other flags (for example
+filesystem-specific flags) are silently ignored.  It's impossible to change mount
 options recursively (for example with \fB\-o rbind,ro\fR).
 
-.BR mount (8)
-since v2.31 ignores the \fBbind\fR flag from
+Since util-linux 2.31,
+.BR mount
+ignores the \fBbind\fR flag from
 .I /etc/fstab
-on
-.B remount operation
-(if "\-o remount" specified on command line). This is necessary to fully control
-mount options on remount by command line. In the previous versions the bind
+on a
+.B remount
+operation
+(if "\-o remount" is specified on command line).
+This is necessary to fully control
+mount options on remount by command line. In previous versions the bind
 flag has been always applied and it was impossible to re-define mount options
 without interaction with the bind semantic. This
 .BR mount (8)
@@ -492,7 +512,8 @@ not vice versa.  A private mount carries no propagation abilities.  An
 unbindable mount is a private mount which cannot be cloned through a bind
 operation.  The detailed semantics are documented in
 .I Documentation/filesystems/sharedsubtree.txt
-file in the kernel source tree.
+file in the kernel source tree; see also
+.BR mount_namespaces (7).
 
 Supported operations are:
 
@@ -523,7 +544,7 @@ mounts under a given mountpoint.
 when a \fB\-\-make-\fR* operation is requested.  All necessary information has to be
 specified on the command line.
 
-Note that the Linux kernel does not allow to change multiple propagation flags
+Note that the Linux kernel does not allow changing multiple propagation flags
 with a single
 .BR mount (2)
 system call, and the flags cannot be mixed with other mount options and operations.
@@ -575,7 +596,7 @@ argument, and finally applying a
 .BR \-r " or " \-w
 option, when present.
 
-The command \fBmount\fR does not pass all command-line options to the
+The \fBmount\fR command does not pass all command-line options to the
 \fB/sbin/mount.\fIsuffix\fR mount helpers.  The interface between \fBmount\fR
 and the mount helpers is described below in the section \fBEXTERNAL HELPERS\fR.
 .sp
@@ -590,9 +611,11 @@ Mount all filesystems (of the given types) mentioned in
 .B noauto
 keyword).  The filesystems are mounted following their order in
 .IR fstab .
-The mount command compares filesystem source, target (and fs root for bind
+The
+.B mount
+command compares filesystem source, target (and fs root for bind
 mount or btrfs) to detect already mounted filesystems. The kernel table with
-already mounted filesystems is cached during \fBmount \-\-all\fR. It means
+already mounted filesystems is cached during \fBmount \-\-all\fR. This means
 that all duplicated
 .I fstab
 entries will be mounted.
@@ -615,8 +638,10 @@ Remount a subtree somewhere else (so that its contents are available
 in both places).  See above, under \fBBind mounts\fR.
 .TP
 .BR \-c , " \-\-no\-canonicalize"
-Don't canonicalize paths.  The mount command canonicalizes all paths
-(from command line or
+Don't canonicalize paths.  The
+.B mount
+command canonicalizes all paths
+(from the command line or
 .IR fstab )
 by default.  This option can be used
 together with the
@@ -634,8 +659,9 @@ Note that \fBmount\fR(8) does not pass this option to the
 Fork off a new incarnation of \fBmount\fR for each device.
 This will do the mounts on different devices or different NFS servers
 in parallel.
-This has the advantage that it is faster; also NFS timeouts go in
-parallel.  A disadvantage is that the mounts are done in undefined order.
+This has the advantage that it is faster; also NFS timeouts proceed in
+parallel.
+A disadvantage is that the order of the mount operations is undefined.
 Thus, you cannot use this option if you want to mount both
 .I /usr
 and
@@ -682,7 +708,7 @@ This is necessary for example when
 is on a read-only filesystem.
 .TP
 .BR \-N , " \-\-namespace " \fIns
-Perform mount in the mount namespace specified by \fIns\fR.
+Perform the mount operation in the mount namespace specified by \fIns\fR.
 \fIns\fR is either PID of process running in that namespace
 or special file representing that namespace.
 .sp
@@ -693,13 +719,13 @@ writes
 .I /etc/mtab
 (or writes to
 .IR /run/mount )
-and calls
+and calls the
 .BR mount (2)
 system call, otherwise it runs in the original mount namespace.
-It means that the target namespace does not have
-to contain any libraries or other requirements necessary to execute
+This means that the target namespace does not have
+to contain any libraries or other requirements necessary to execute the
 .BR mount (2)
-command.
+call.
 .sp
 See \fBmount_namespaces\fR(7) for more information.
 .TP
@@ -766,13 +792,13 @@ sections.
 .BR "\-\-options\-mode " \fImode
 Controls how to combine options from
 .IR fstab / mtab
-with options from command line.
+with options from the command line.
 \fImode\fR can be one of
 .BR ignore ", " append ", " prepend " or " replace .
-For example \fBappend\fR means that options from
+For example, \fBappend\fR means that options from
 .I fstab
-are appended to options from command line.
-Default value is \fBprepend\fR -- it means command line options are evaluated after
+are appended to options from the command line.
+The default value is \fBprepend\fR -- it means command line options are evaluated after
 .I fstab
 options.
 Note that the last option wins if there are conflicting ones.
@@ -780,12 +806,12 @@ Note that the last option wins if there are conflicting ones.
 .TP
 .BR "\-\-options\-source " \fIsource
 Source of default options.
-\fIsource\fR is comma separated list of
+\fIsource\fR is a comma-separated list of
 .BR fstab ", " mtab " and " disable .
 \fBdisable\fR disables
 .BR fstab " and " mtab
 and disables \fB\-\-options\-source\-force\fR.
-Default value is \fBfstab,mtab\fR.
+The default value is \fBfstab,mtab\fR.
 
 .TP
 .B \-\-options\-source\-force
@@ -817,17 +843,20 @@ options not supported by a filesystem type.  Not all filesystems support this
 option.  Currently it's supported by the \fBmount.nfs\fR mount helper only.
 .TP
 .BI \-\-source " device"
-If only one argument for the mount command is given then the argument might be
-interpreted as target (mountpoint) or source (device).  This option allows to
+If only one argument for the mount command is given, then the argument might be
+interpreted as the target (mountpoint) or source (device).
+This option allows you to
 explicitly define that the argument is the mount source.
 .TP
 .BI \-\-target " directory"
-If only one argument for the mount command is given then the argument might be
-interpreted as target (mountpoint) or source (device).  This option allows to
+If only one argument for the mount command is given, then the argument might be
+interpreted as the target (mountpoint) or source (device).
+This option allows you to
 explicitly define that the argument is the mount target.
 .TP
 .BI \-\-target\-prefix " directory"
-Prepend specified directory to all mount targets.  This option allows to follow
+Prepend the specified directory to all mount targets.
+This option allows to follow
 .IR fstab ,
 but mount operations is done on another place, for example:
 .RS
@@ -840,7 +869,7 @@ mounts all from system
 .I fstab
 to
 .IR /chroot ,
-all missing muontpoint are created
+all missing mountpoint are created
 (due to X-mount.mkdir).  See also \fB\-\-fstab\fP to use an alternative
 .IR fstab .
 .RE
@@ -848,7 +877,8 @@ all missing muontpoint are created
 .BR \-T , " \-\-fstab " \fIpath
 Specifies an alternative
 .I fstab
-file.  If \fIpath\fP is a directory then the files
+file.
+If \fIpath\fP is a directory, then the files
 in the directory are sorted by
 .BR strverscmp (3);
 files that start with "."\& or without an
@@ -891,10 +921,13 @@ If no
 .B \-t
 option is given, or if the
 .B auto
-type is specified, mount will try to guess the desired type.
+type is specified,
+.B mount
+will try to guess the desired type.
 Mount uses the blkid library for guessing the filesystem
 type; if that does not turn up anything that looks familiar,
-mount will try to read the file
+.B mount
+will try to read the file
 .IR /etc/filesystems ,
 or, if that does not exist,
 .IR /proc/filesystems .
@@ -920,13 +953,13 @@ can be useful to change the probe order (e.g., to try vfat before msdos
 or ext3 before ext2) or if you use a kernel module autoloader.
 .sp
 More than one type may be specified in a comma-separated
-list, for option
+list, for the
 .B \-t
-as well as in an
+option as well as in an
 .I /etc/fstab
-entry.  The list of filesystem types for option
+entry.  The list of filesystem types for the
 .B \-t
-can be prefixed with
+option can be prefixed with
 .B no
 to specify the filesystem types on which no action should be taken.
 The prefix
@@ -978,15 +1011,15 @@ Mount the partition that has the specified
 Verbose mode.
 .TP
 .BR \-w , " \-\-rw" , " \-\-read\-write"
-Mount the filesystem read/write.  The read-write is kernel default and
-.BR mount (8)
+Mount the filesystem read/write.  Read-write is the kernel default and the
+.BR mount
 default is to try read-only if the previous mount syscall with read-write flags
 on write-protected devices of filesystems failed.
 .sp
 A synonym is
 .BR "\-o rw" .
 
-Note that specify \fB\-w\fR on command line forces \fBmount\fR command to never
+Note that specifying \fB\-w\fR on the command line forces \fBmount\fR to never
 try read-only mount on write-protected devices or already mounted read-only
 filesystems.
 .TP
@@ -1063,7 +1096,9 @@ Two other options are
 .B fscontext=
 and
 .BR defcontext= ,
-both of which are mutually exclusive of the context option.  This means you
+both of which are mutually exclusive of the
+.B context=
+option.  This means you
 can use fscontext and defcontext with each other, but neither can be used with
 context.
 
@@ -1088,7 +1123,7 @@ The
 .B rootcontext=
 option allows you to explicitly label the root inode of a FS being mounted
 before that FS or inode becomes visible to userspace.  This was found to be
-useful for things like stateless linux.
+useful for things like stateless Linux.
 
 Note that the kernel rejects any remount request that includes the context
 option, \fBeven\fP when unchanged from the current context.
@@ -1118,15 +1153,14 @@ For more details, see
 Use the default options:
 .BR rw ", " suid ", " dev ", " exec ", " auto ", " nouser ", and " async .
 
-Note that the real set of all default mount options depends on kernel
+Note that the real set of all default mount options depends on the kernel
 and filesystem type.  See the beginning of this section for more details.
 .TP
 .B dev
 Interpret character or block special devices on the filesystem.
 .TP
 .B nodev
-Do not interpret character or block special devices on the file
-system.
+Do not interpret character or block special devices on the filesystem.
 .TP
 .B diratime
 Update directory inode access times on this filesystem.  This is the default.
@@ -1219,19 +1253,19 @@ This mount option significantly reduces writes to the inode table for
 workloads that perform frequent random writes to preallocated files.
 
 The on-disk timestamps are updated only when:
-.sp
 .RS
-- the inode needs to be updated for some change unrelated to file timestamps
-.sp
-- the application employs
+.IP - 2
+the inode needs to be updated for some change unrelated to file timestamps
+.IP -
+the application employs
 .BR fsync (2),
 .BR syncfs (2),
 or
 .BR sync (2)
-.sp
-- an undeleted inode is evicted from memory
-.sp
-- more than 24 hours have passed since the i-node was written to disk.
+.IP -
+an undeleted inode is evicted from memory
+.IP -
+more than 24 hours have passed since the i-node was written to disk.
 .RE
 .sp
 .TP
@@ -1267,9 +1301,11 @@ readonly filesystem writable.  It does not change device or mount point.
 
 The remount operation together with the
 .B bind
-flag has special semantic. See above, the subsection \fBBind mounts\fR.
+flag has special semantics. See above, the subsection \fBBind mounts\fR.
 
-The remount functionality follows the standard way the mount command works
+The remount functionality follows the standard way the
+.B mount
+command works
 with options from
 .IR fstab .
 This means that \fBmount\fR does not read
@@ -1306,16 +1342,19 @@ If no mountpoint is found in
 then a remount with unspecified source is
 allowed.
 .sp
-mount(8) allows to use \fB\-\-all\fR to remount all already mounted filesystems
+.B mount
+allows the use of \fB\-\-all\fR to remount all already mounted filesystems
 which match a specified filter (\fB\-O\fR and \fB\-t\fR).  For example:
 .sp
 .in +4
 .B "mount \-\-all \-o remount,ro \-t vfat"
 .in
 .sp
-remounts all already mounted vfat filesystems in read-only mode. The each of the
-filesystems is remounted by "mount \-o remount,ro /dir" semantic. It means the
-mount command reads
+remounts all already mounted vfat filesystems in read-only mode. Each of the
+filesystems is remounted by "mount \-o remount,ro /dir" semantic.
+This means the
+.B mount
+command reads
 .I fstab
 or
 .I mtab
@@ -1364,7 +1403,7 @@ This option implies the options
 .B X-*
 All options prefixed with "X-" are interpreted as comments or as userspace
 application-specific options.
-These options are not stored in the user space (e.g.,
+These options are not stored in user space (e.g.,
 .I mtab
 file),
 nor sent to the mount.\fItype\fR helpers nor to the
@@ -1372,16 +1411,19 @@ nor sent to the mount.\fItype\fR helpers nor to the
 system call.  The suggested format is \fBX-\fIappname\fR.\fIoption\fR.
 .TP
 .B x-*
-The same as \fBX-*\fR options, but stored permanently in the user space. It
-means the options are also available for umount or other operations.  Note
-that maintain mount options in user space is tricky, because it's necessary use
-libmount based tools and there is no guarantee that the options will be always
+The same as \fBX-*\fR options, but stored permanently in user space.
+This means the options are also available for
+.B umount
+or other operations.  Note
+that maintaining  mount options in user space is tricky,
+because it's necessary use
+libmount-based tools and there is no guarantee that the options will be always
 available (for example after a move mount operation or in unshared namespace).
 
 Note that before util-linux v2.30 the x-* options have not been maintained by
-libmount and stored in user space (functionality was the same as have X-* now),
-but due to growing number of use-cases (in initrd, systemd etc.) the
-functionality have been extended to keep existing
+libmount and stored in user space (functionality was the same as for X-* now),
+but due to the growing number of use-cases (in initrd, systemd etc.) the
+functionality has been extended to keep existing
 .I fstab
 configurations usable
 without a change.
@@ -1513,36 +1555,36 @@ and the pseudo terminal slave can be accessed as
 .IR /dev/pts/ <number>.
 .TP
 \fBuid=\fP\,\fIvalue\fP and \fBgid=\fP\,\fIvalue\fP
-This sets the owner or the group of newly created PTYs to
+This sets the owner or the group of newly created pseudo terminals to
 the specified values.  When nothing is specified, they will
 be set to the UID and GID of the creating process.
 For example, if there is a tty group with GID 5, then
 .B gid=5
-will cause newly created PTYs to belong to the tty group.
+will cause newly created pseudo terminals to belong to the tty group.
 .TP
 .BI mode= value
-Set the mode of newly created PTYs to the specified value.
+Set the mode of newly created pseudo terminals to the specified value.
 The default is 0600.
 A value of
 .B mode=620
 and
 .B gid=5
-makes "mesg y" the default on newly created PTYs.
+makes "mesg y" the default on newly created pseudo terminals.
 .TP
 \fBnewinstance
-Create a private instance of devpts filesystem, such that
-indices of ptys allocated in this new instance are
+Create a private instance of the devpts filesystem, such that
+indices of pseudo terminals allocated in this new instance are
 independent of indices created in other instances of devpts.
 
 All mounts of devpts without this
 .B newinstance
-option share the same set of pty indices (i.e., legacy mode).
+option share the same set of pseudo terminal indices (i.e., legacy mode).
 Each mount of devpts with the
 .B newinstance
-option has a private set of pty indices.
+option has a private set of pseudo terminal indices.
 
 This option is mainly used to support containers in the
-linux kernel.  It is implemented in linux kernel versions
+Linux kernel.  It is implemented in Linux kernel versions
 starting with 2.6.29.  Further, this mount option is valid
 only if CONFIG_DEVPTS_MULTIPLE_INSTANCES is enabled in the
 kernel configuration.
@@ -1550,10 +1592,10 @@ kernel configuration.
 To use this option effectively,
 .I /dev/ptmx
 must be a symbolic link to
-.I pts/ptmx.
+.IR pts/ptmx .
 See
 .I Documentation/filesystems/devpts.txt
-in the linux kernel source tree for details.
+in the Linux kernel source tree for details.
 .TP
 .BI ptmxmode= value
 
@@ -1579,7 +1621,7 @@ node and is highly recommended when the
 .B newinstance
 option is specified.
 
-This option is only implemented in linux kernel versions
+This option is only implemented in Linux kernel versions
 starting with 2.6.29.  Further, this option is valid only if
 CONFIG_DEVPTS_MULTIPLE_INSTANCES is enabled in the kernel
 configuration.
@@ -1633,8 +1675,9 @@ is also allowed.  I.e.\& \s+3~\s0dmask & 022)
 
 Normally
 .BR utime (2)
-checks current process is owner of the file, or it has
-CAP_FOWNER capability.  But FAT filesystem doesn't have UID/GID on disk, so
+checks that the current process is owner of the file, or that it has the
+.B CAP_FOWNER
+capability.  But FAT filesystems don't have UID/GID on disk, so the
 normal check is too inflexible.  With this option you can relax it.
 .RE
 .TP
@@ -1665,7 +1708,7 @@ Sets the codepage for converting to shortname characters on FAT
 and VFAT filesystems.  By default, codepage 437 is used.
 .TP
 .BI conv= mode
-This option is obsolete and may fail or being ignored.
+This option is obsolete and may fail or be ignored.
 .TP
 .BI cvf_format= module
 Forces the driver to use the CVF (Compressed Volume File) module
@@ -2171,6 +2214,7 @@ UBIFS is a flash filesystem which works on top of UBI volumes.  Note that
 \fBatime\fR is not supported and is always turned off.
 .TP
 The device name may be specified as
+.PP
 .RS
 .B ubiX_Y
 UBI device number
@@ -2196,6 +2240,7 @@ UBI device number
 volume with name
 .B NAME
 .RE
+.PP
 Alternative
 .B !
 separator may be used instead of
@@ -2204,8 +2249,7 @@ separator may be used instead of
 The following mount options are available:
 .TP
 .B bulk_read
-Enable bulk-read.  VFS read-ahead is disabled because it slows down the file
-system.  Bulk-Read is an internal optimization.  Some flashes may read faster if
+Enable bulk-read.  VFS read-ahead is disabled because it slows down the filesystem.  Bulk-Read is an internal optimization.  Some flashes may read faster if
 the data are read at one go, rather than at several read requests.  For
 example, OneNAND can do "read-while-load" if it reads more than one NAND page.
 .TP
@@ -2471,7 +2515,9 @@ Set the owner and group and mode of the file
 
 .SH DM-VERITY SUPPORT (experimental)
 The device-mapper verity target provides read-only transparent integrity
-checking of block devices using kernel crypto API.  The mount command can open
+checking of block devices using kernel crypto API.  The
+.B mount
+command can open
 the dm-verity device and do the integrity verification before on the device
 filesystem is mounted.  Requires libcryptsetup with in libmount.  If
 libcryptsetup supports extracting the root hash of an already mounted device,
@@ -2557,7 +2603,9 @@ will try to find some unused loop device and use that, for example
 .B "mount /tmp/disk.img /mnt \-o loop"
 .sp
 .RE
-The mount command
+The
+.B mount
+command
 .B automatically
 creates a loop device from a regular file if a filesystem type is
 not specified or the filesystem is known for libblkid, for example:
@@ -2586,8 +2634,10 @@ independently of
 You can also free a loop device by hand, using
 .BR "losetup \-d " or " umount \-d" .
 
-Since util-linux v2.29 mount command re-uses the loop device rather than
-initialize a new device if the same backing file is already used for some loop
+Since util-linux v2.29,
+.B mount
+re-uses the loop device rather than
+initializing a new device if the same backing file is already used for some loop
 device with the same offset and sizelimit. This is necessary to avoid
 a filesystem corruption.
 
@@ -2662,7 +2712,7 @@ The command \fBmount\fR does not pass the mount options
 and
 .B sizelimit
 to the mount.<suffix> helpers.  All other options are used in a
-comma-separated list as argument to the \fB\-o\fR option.
+comma-separated list as an argument to the \fB\-o\fR option.
 
 .SH ENVIRONMENT
 .IP LIBMOUNT_FSTAB=<path>
@@ -2693,10 +2743,14 @@ table of mounted filesystems or symlink to
 .I /proc/mounts
 .TP
 .I /etc/mtab\s+3~\s0
-lock file (unused on systems with mtab symlink)
+lock file (unused on systems with
+.I mtab
+symlink)
 .TP
 .I /etc/mtab.tmp
-temporary file (unused on systems with mtab symlink)
+temporary file (unused on systems with
+.I mtab
+symlink)
 .TP
 .I /etc/filesystems
 a list of filesystem types to try
@@ -2708,7 +2762,7 @@ command existed in Version 5 AT&T UNIX.
 It is possible for a corrupted filesystem to cause a crash.
 .PP
 Some Linux filesystems don't support
-.BR "\-o sync " nor " \-o dirsync"
+.BR "\-o sync " and " \-o dirsync"
 (the ext2, ext3, ext4, fat and vfat filesystems
 .I do
 support synchronous updates (a la BSD) when mounted with the
@@ -2732,7 +2786,9 @@ It is possible that the files
 .I /etc/mtab
 and
 .I /proc/mounts
-don't match on systems with a regular mtab file.  The first file is based only on
+don't match on systems with a regular
+.I mtab
+file.  The first file is based only on
 the mount command options, but the content of the second file also depends on
 the kernel and others settings (e.g.\& on a remote NFS server -- in certain cases
 the mount command may report unreliable information about an NFS mount point
@@ -2750,7 +2806,9 @@ Checking files on NFS filesystems referenced by file descriptors (i.e.\& the
 and
 .B ioctl
 families of functions) may lead to inconsistent results due to the lack of
-a consistency check in the kernel even if noac is used.
+a consistency check in the kernel even if the
+.B noac
+mount option is used.
 .PP
 The
 .B loop
-- 
2.26.2

