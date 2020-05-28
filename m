Return-Path: <SRS0=us4l=7K=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C31C433DF
	for <util-linux@archiver.kernel.org>; Thu, 28 May 2020 14:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED2B2075F
	for <util-linux@archiver.kernel.org>; Thu, 28 May 2020 14:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6/BSDXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403842AbgE1O6n (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 28 May 2020 10:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403820AbgE1O6f (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 28 May 2020 10:58:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE95C08C5C9
        for <util-linux@vger.kernel.org>; Thu, 28 May 2020 07:58:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x6so14629020wrm.13
        for <util-linux@vger.kernel.org>; Thu, 28 May 2020 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=waPvfuewkFgBs2DXt2KUfkR/H9Jm3hBZWzViulDH+Ms=;
        b=I6/BSDXazVD1A6yTe47vwVXCBJqBNv5bsrTusRHgUsl0hSdm76XFScuXlCjN+eDrJt
         AFTL4Ej6ORqvzf2R1AKk9qS4G9/P8DVCoG4hVGixok114Msp3Q6Oi1D6ToUxP9Khe5Y7
         ck8gB97EP9hHWit2oQgglEoTvSPGpiZ9IhTEuYr7TueEEWod3i+oTpiAcML8Y57DimTC
         OEZP7YNSw4sZ4DyPdvU7mcpvgvZSEMZkGwnZXn+aC4TlOkX4P9mjnu0bMvxfbLej1h+o
         JF7Qm8vI27WaLyVOvaerxX+O+ETe0Y7WdE5sQWmQ47qWcOa6/6ki+p61YmIXlBPjvwby
         1y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=waPvfuewkFgBs2DXt2KUfkR/H9Jm3hBZWzViulDH+Ms=;
        b=V9pfOdHHhCLOGV7T6fR9ReoHneLAC84zoOyfb3606W0NdpmZeDyyMNYfyRV/txe5Is
         ESRJGaets0SBBrBlj7GpeG1Bt4idnlfF7f8rhLOGm/dUCoHw2dx7xi4+FSihgb4RMRa6
         ygXYvblOwpOs8d5Axk4qIs4UDd6PM3/ig90AaWF7MpEBqM0kOwJMMfPaxBI6vwJ7H2hz
         uL5x5qbqiL255dUi3Gihjjf445LiZmnEp4DEK+H5qjqoFQA9chJxWwa1A7P9ldONjzFi
         dLwnXMiaTuGJlatjZ8gUKkde8ly0ma18xXoN/rnbhjdJr9uTFnu1PQ/2QfQBuQFlwhzJ
         OIJQ==
X-Gm-Message-State: AOAM532/CAFgtiMbXyv90GUCtlo0C895G1mMFipvh2KPamZddpWOoQL6
        wZZXNmn5zZOVLbwhdZjoWno=
X-Google-Smtp-Source: ABdhPJy1feQQjPxazgPJ7kY+KCOaUC3/HNsCTNp3iWRGiBJBbO6iIgnRVPPgBH1kSumCTcPZvqlQMg==
X-Received: by 2002:adf:9166:: with SMTP id j93mr3719612wrj.289.1590677913633;
        Thu, 28 May 2020 07:58:33 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2516:6501:a84b:ccd6:785a:2f0f])
        by smtp.gmail.com with ESMTPSA id v7sm6482630wre.93.2020.05.28.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:58:32 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 05/10] Manual pages: mount.8, umount.8: Consistently format pathnames with italic
Date:   Thu, 28 May 2020 16:58:19 +0200
Message-Id: <20200528145823.978508-5-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528145823.978508-1-mtk.manpages@gmail.com>
References: <20200528145823.978508-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 sys-utils/mount.8  | 163 ++++++++++++++++++++++++++++++++++-----------
 sys-utils/umount.8 |  31 ++++++---
 2 files changed, 146 insertions(+), 48 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index fff060ad1..7a1782284 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -171,7 +171,9 @@ file.  Tags are
 more readable, robust and portable.  The
 .BR mount (8)
 command internally uses udev
-symlinks, so the use of symlinks in /etc/fstab has no advantage over tags.
+symlinks, so the use of symlinks in
+.I /etc/fstab
+has no advantage over tags.
 For more details see
 .BR libblkid (3).
 
@@ -284,10 +286,13 @@ are specified.  For example, to mount device
 .sp
 .RE
 This default behaviour is possible to change by command line option
-\fB\-\-options\-source\-force\fR to always read configuration from fstab. For
-non-root users
+\fB\-\-options\-source\-force\fR to always read configuration from
+.IR fstab .
+For non-root users
 .B mount
-always read fstab configuration.
+always read
+.I fstab
+configuration.
 
 .SS Non-superuser mounts
 Normally, only the superuser can mount filesystems.
@@ -310,7 +315,9 @@ using the command:
 .sp
 .RE
 Note that \fBmount\fR is very strict about non-root users and all paths
-specified on command line are verified before fstab is parsed or a helper
+specified on command line are verified before
+.I fstab
+is parsed or a helper
 program is executed. It's strongly recommended to use a valid mountpoint to
 specify filesystem, otherwise \fBmount\fR may fail. For example it's bad idea
 to use NFS or CIFS source on command line.
@@ -353,7 +360,9 @@ Remount part of the file hierarchy somewhere else.  The call is:
 .I olddir newdir
 .RE
 
-or by using this fstab entry:
+or by using this
+.I fstab
+entry:
 
 .RS
 .br
@@ -583,14 +592,18 @@ keyword).  The filesystems are mounted following their order in
 The mount command compares filesystem source, target (and fs root for bind
 mount or btrfs) to detect already mounted filesystems. The kernel table with
 already mounted filesystems is cached during \fBmount \-\-all\fR. It means
-that all duplicated fstab entries will be mounted.
+that all duplicated
+.I fstab
+entries will be mounted.
 .sp
 The option \fB\-\-all\fR is possible to use for remount operation too. In this
 case all filters (\fB\-t\fR and \fB\-O\fR) are applied to the table of already
 mounted filesystems.
 .sp
 Since version 2.35 is possible to use the command line option \fB\-o\fR to
-alter mount options from fstab (see also \fB\-\-options\-mode\fR).
+alter mount options from
+.I fstab
+(see also \fB\-\-options\-mode\fR).
 .sp
 Note that it is a bad practice to use \fBmount \-a\fR for
 .I fstab
@@ -602,7 +615,9 @@ in both places).  See above, under \fBBind mounts\fR.
 .TP
 .BR \-c , " \-\-no\-canonicalize"
 Don't canonicalize paths.  The mount command canonicalizes all paths
-(from command line or fstab) by default.  This option can be used
+(from command line or
+.IR fstab )
+by default.  This option can be used
 together with the
 .B \-f
 flag for already canonicalized absolute paths.  The option is designed for mount
@@ -633,7 +648,9 @@ flag to determine what the
 .B mount
 command is trying to do.  It can also be used to add entries for devices
 that were mounted earlier with the \fB\-n\fR option.  The \fB\-f\fR option
-checks for an existing record in /etc/mtab and fails when the record already
+checks for an existing record in
+.I /etc/mtab
+and fails when the record already
 exists (with a regular non-fake mount, this check is done by the kernel).
 .IP "\fB\-i, \-\-internal\-only\fP"
 Don't call the \fB/sbin/mount.\fIfilesystem\fR helper even if it exists.
@@ -669,8 +686,13 @@ Perform mount in the mount namespace specified by \fIns\fR.
 or special file representing that namespace.
 .sp
 .BR mount (8)
-switches to the mount namespace when it reads /etc/fstab,
-writes /etc/mtab (or writes to /run/mount) and calls
+switches to the mount namespace when it reads
+.IR /etc/fstab ,
+writes
+.I /etc/mtab
+(or writes to
+.IR /run/mount )
+and calls
 .BR mount (2)
 system call, otherwise it runs in the original mount namespace.
 It means that the target namespace does not have
@@ -741,11 +763,17 @@ sections.
 
 .TP
 .BR "\-\-options\-mode " \fImode
-Controls how to combine options from fstab/mtab with options from command line.
+Controls how to combine options from
+.IR fstab / mtab
+with options from command line.
 \fImode\fR can be one of
 .BR ignore ", " append ", " prepend " or " replace .
-For example \fBappend\fR means that options from fstab are appended to options from command line.
-Default value is \fBprepend\fR -- it means command line options are evaluated after fstab options.
+For example \fBappend\fR means that options from
+.I fstab
+are appended to options from command line.
+Default value is \fBprepend\fR -- it means command line options are evaluated after
+.I fstab
+options.
 Note that the last option wins if there are conflicting ones.
 
 .TP
@@ -760,7 +788,9 @@ Default value is \fBfstab,mtab\fR.
 
 .TP
 .B \-\-options\-source\-force
-Use options from fstab/mtab even if both \fIdevice\fR and \fIdir\fR are specified.
+Use options from
+.IR fstab / mtab
+even if both \fIdevice\fR and \fIdir\fR are specified.
 
 .TP
 .BR \-R , " \-\-rbind"
@@ -797,30 +827,44 @@ explicitly define that the argument is the mount target.
 .TP
 .BI \-\-target\-prefix " directory"
 Prepend specified directory to all mount targets.  This option allows to follow
-fstab, but mount operations is done on another place, for example:
+.IR fstab ,
+but mount operations is done on another place, for example:
 .RS
 .RS
 .sp
 .B "mount \-\-all \-\-target\-prefix /chroot \-o X\-mount.mkdir
 .sp
 .RE
-mounts all from system fstab to /chroot, all missing muontpoint are created
-(due to X-mount.mkdir).  See also \fB\-\-fstab\fP to use an alternative fstab.
+mounts all from system
+.I fstab
+to
+.IR /chroot ,
+all missing muontpoint are created
+(due to X-mount.mkdir).  See also \fB\-\-fstab\fP to use an alternative
+.IR fstab .
 .RE
 .TP
 .BR \-T , " \-\-fstab " \fIpath
-Specifies an alternative fstab file.  If \fIpath\fP is a directory then the files
+Specifies an alternative
+.I fstab
+file.  If \fIpath\fP is a directory then the files
 in the directory are sorted by
 .BR strverscmp (3);
-files that start with "."\& or without an \&.fstab extension are ignored.  The option
+files that start with "."\& or without an
+.I \&.fstab
+extension are ignored.  The option
 can be specified more than once.  This option is mostly designed for initramfs
 or chroot scripts where additional configuration is specified beyond standard
 system configuration.
 .sp
 Note that \fBmount\fR(8) does not pass the option \fB\-\-fstab\fP to the
-\fB/sbin/mount.\fItype\fR helpers, meaning that the alternative fstab files will be
+\fB/sbin/mount.\fItype\fR helpers, meaning that the alternative
+.I fstab
+files will be
 invisible for the helpers.  This is no problem for normal mounts, but user
-(non-root) mounts always require fstab to verify the user's rights.
+(non-root) mounts always require
+.I fstab
+to verify the user's rights.
 .TP
 .BR \-t , " \-\-types " \fIfstype
 The argument following the
@@ -958,7 +1002,9 @@ file.
 
 Some of these options could be enabled or disabled by default
 in the system kernel.  To check the current setting see the options
-in /proc/mounts.  Note that filesystems also have per-filesystem
+in
+.IR /proc/mounts .
+Note that filesystems also have per-filesystem
 specific default mount options (see for example \fBtune2fs \-l\fP
 output for extN filesystems).
 
@@ -1160,7 +1206,8 @@ possible for the kernel to default to
 or
 .B \%noatime
 but still allow userspace to override it.  For more details about the default
-system mount options see /proc/mounts.
+system mount options see
+.IR /proc/mounts .
 .TP
 .B nostrictatime
 Use the kernel's default behavior for inode access time updates.
@@ -1223,8 +1270,13 @@ The remount operation together with the
 flag has special semantic. See above, the subsection \fBBind mounts\fR.
 
 The remount functionality follows the standard way the mount command works
-with options from fstab.  This means that \fBmount\fR does not
-read fstab (or mtab) only when both
+with options from
+.IR fstab .
+This means that \fBmount\fR does not read
+.I fstab
+(or
+.IR mtab )
+only when both
 .I device
 and
 .I dir
@@ -1235,16 +1287,23 @@ are specified.
 .in
 .sp
 After this call all old mount options are replaced and arbitrary stuff from
-fstab (or mtab) is ignored, except the loop= option which is internally
+.I fstab
+(or
+.IR mtab )
+is ignored, except the loop= option which is internally
 generated and maintained by the mount command.
 .sp
 .in +4
 .B "mount \-o remount,rw  /dir"
 .in
 .sp
-After this call, mount reads fstab and merges these options with
+After this call, mount reads
+.I fstab
+and merges these options with
 the options from the command line (\fB\-o\fR).
-If no mountpoint is found in fstab, then a remount with unspecified source is
+If no mountpoint is found in
+.IR fstab ,
+then a remount with unspecified source is
 allowed.
 .sp
 mount(8) allows to use \fB\-\-all\fR to remount all already mounted filesystems
@@ -1256,7 +1315,11 @@ which match a specified filter (\fB\-O\fR and \fB\-t\fR).  For example:
 .sp
 remounts all already mounted vfat filesystems in read-only mode. The each of the
 filesystems is remounted by "mount \-o remount,ro /dir" semantic. It means the
-mount command reads fstab or mtab and merges these options with the options
+mount command reads
+.I fstab
+or
+.I mtab
+and merges these options with the options
 from the command line.
 .TP
 .B ro
@@ -1272,8 +1335,14 @@ media with a limited number of write cycles
 .TP
 .B user
 Allow an ordinary user to mount the filesystem.
-The name of the mounting user is written to the mtab file (or to the private
-libmount file in /run/mount on systems without a regular mtab) so that this
+The name of the mounting user is written to the
+.I mtab
+file (or to the private
+libmount file in
+.I /run/mount
+on systems without a regular
+.IR mtab )
+so that this
 same user can unmount the filesystem again.
 This option implies the options
 .BR noexec ", " nosuid ", and " nodev
@@ -1294,7 +1363,10 @@ This option implies the options
 .TP
 .B X-*
 All options prefixed with "X-" are interpreted as comments or as userspace
-application-specific options.  These options are not stored in the user space (e.g., mtab file),
+application-specific options.
+These options are not stored in the user space (e.g.,
+.I mtab
+file),
 nor sent to the mount.\fItype\fR helpers nor to the
 .BR mount (2)
 system call.  The suggested format is \fBX-\fIappname\fR.\fIoption\fR.
@@ -1309,7 +1381,9 @@ available (for example after a move mount operation or in unshared namespace).
 Note that before util-linux v2.30 the x-* options have not been maintained by
 libmount and stored in user space (functionality was the same as have X-* now),
 but due to growing number of use-cases (in initrd, systemd etc.) the
-functionality have been extended to keep existing fstab configurations usable
+functionality have been extended to keep existing
+.I fstab
+configurations usable
 without a change.
 .TP
 .BR X-mount.mkdir [ = \fImode\fR ]
@@ -2578,9 +2652,13 @@ comma-separated list as argument to the \fB\-o\fR option.
 
 .SH ENVIRONMENT
 .IP LIBMOUNT_FSTAB=<path>
-overrides the default location of the fstab file (ignored for suid)
+overrides the default location of the
+.I fstab
+file (ignored for suid)
 .IP LIBMOUNT_MTAB=<path>
-overrides the default location of the mtab file (ignored for suid)
+overrides the default location of the
+.I mtab
+file (ignored for suid)
 .IP LIBMOUNT_DEBUG=all
 enables libmount debug output
 .IP LIBBLKID_DEBUG=all
@@ -2597,7 +2675,8 @@ filesystem table
 libmount private runtime directory
 .TP
 .I /etc/mtab
-table of mounted filesystems or symlink to /proc/mounts
+table of mounted filesystems or symlink to
+.I /proc/mounts
 .TP
 .I /etc/mtab\s+3~\s0
 lock file (unused on systems with mtab symlink)
@@ -2643,8 +2722,12 @@ don't match on systems with a regular mtab file.  The first file is based only o
 the mount command options, but the content of the second file also depends on
 the kernel and others settings (e.g.\& on a remote NFS server -- in certain cases
 the mount command may report unreliable information about an NFS mount point
-and the /proc/mounts file usually contains more reliable information.)  This is
-another reason to replace the mtab file with a symlink to the
+and the
+.I /proc/mount
+file usually contains more reliable information.)  This is
+another reason to replace the
+.I mtab
+file with a symlink to the
 .I /proc/mounts
 file.
 .PP
diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index edcb6cc1f..c56e51e18 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -62,7 +62,8 @@ issues. See \fB\-\-lazy\fR description below.
 .BR \-a , " \-\-all"
 All of the filesystems described in
 .I /proc/self/mountinfo
-(or in deprecated /etc/mtab)
+(or in deprecated
+.IR /etc/mtab )
 are unmounted, except the proc, devfs, devpts, sysfs, rpc_pipefs and nfsd
 filesystems. This list of the filesystems may be replaced by \fB\-\-types\fR
 umount option.
@@ -73,8 +74,11 @@ for the specified filesystem.
 The filesystem can be specified by one of the mountpoints or the device name (or
 UUID, etc.).  When this option is used together with \fB\-\-recursive\fR, then
 all nested mounts within the filesystem are recursively unmounted.
-This option is only supported on systems where /etc/mtab is a symlink
-to /proc/mounts.
+This option is only supported on systems where
+.I /etc/mtab
+is a symlink
+to
+.IR /proc/mounts .
 .TP
 .BR \-c , " \-\-no\-canonicalize"
 Do not canonicalize paths.  The paths canonicalization is based on
@@ -135,7 +139,13 @@ Perform umount in the mount namespace specified by \fIns\fR.
 or special file representing that namespace.
 .sp
 .BR umount (8)
-switches to the namespace when it reads /etc/fstab, writes /etc/mtab (or writes to /run/mount) and calls
+switches to the namespace when it reads
+.IR /etc/fstab ,
+writes
+.IR /etc/mtab
+(or writes to
+.IR /run/mount )
+and calls
 .BR umount (2)
 system call, otherwise it runs in the original namespace.
 It means that the target mount namespace does not have
@@ -163,7 +173,9 @@ Suppress "not mounted" error messages.
 .BR \-R , " \-\-recursive"
 Recursively unmount each specified directory.  Recursion for each directory will
 stop if any unmount operation in the chain fails for any reason.  The relationship
-between mountpoints is determined by /proc/self/mountinfo entries.  The filesystem
+between mountpoints is determined by
+.I /proc/self/mountinfo
+entries.  The filesystem
 must be specified by mountpoint path; a recursive unmount by device name (or UUID)
 is unsupported.
 .TP
@@ -181,7 +193,8 @@ to indicate that no action should be taken for all of the mentioned types.
 Note that
 .B umount
 reads information about mounted filesystems from kernel (/proc/mounts) and
-filesystem names may be different than filesystem names used in the /etc/fstab
+filesystem names may be different than filesystem names used in the
+.I /etc/fstab
 (e.g., "nfs4" vs. "nfs").
 .TP
 .BR \-v , " \-\-verbose"
@@ -216,7 +229,8 @@ The
 .B umount
 command will automatically detach loop device previously initialized by
 .BR mount (8)
-command independently of /etc/mtab.
+command independently of
+.IR /etc/mtab .
 
 In this case the device is initialized with "autoclear" flag (see
 .BR losetup (8)
@@ -266,7 +280,8 @@ enables libmount debug output
 .TP
 .I /etc/mtab
 table of mounted filesystems (deprecated and usually replaced by
-symlink to /proc/mounts)
+symlink to
+.IR /proc/mounts )
 .TP
 .I /etc/fstab
 table of known filesystems
-- 
2.26.2

