Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:57610 "EHLO
        resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753900AbdFWViq (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Jun 2017 17:38:46 -0400
From: "W. Trevor King" <wking@tremily.us>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 7/8] sys-utils/mount.8: Split filesystem-independent options into kernel and userspace subsections
Date: Fri, 23 Jun 2017 14:30:25 -0700
Message-Id: <508d12736bcdab265cc57a78bd45585ea185786e.1498252231.git.wking@tremily.us>
In-Reply-To: <cover.1498252231.git.wking@tremily.us>
References: <cover.1498252231.git.wking@tremily.us>
In-Reply-To: <cover.1498252231.git.wking@tremily.us>
References: <cover.1498252231.git.wking@tremily.us>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The filesystem-independent userspace options are useful in fstab.
Separating those options from the filesytem-independent kernel options
avoids distracting folks reading mount(8) while setting up direct
mount(8) calls and similar.  It also makes it easy to punt to mount(2)
for defaults for the kernel-backed options, now that the defaults
entry no longer mentions rw, suid, dev, etc.

The mount(2) default reference also lets us remove "This is the
default" from the diratime entry.  Consistently punting the default
definition to mount(2) is more maintainable than duplicating all of
that mount(2) information locally in mount(8).

While the filesystem-independent userspace options aren't particularly
useful outside of fstab, it's not an error to use them in direct
mount(8) calls.  So the subection is not titled "FSTAB-SPECIFIC MOUNT
OPTIONS" or anything more opinionated.

Also add the previously-undocumentated nogroup, noowner, and nousers
options.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 sys-utils/mount.8 | 108 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 62 insertions(+), 46 deletions(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index d5ca65e..a589f76 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -835,15 +835,16 @@ Display version information and exit.
 Display help text and exit.
 
 .SH FILESYSTEM-INDEPENDENT MOUNT OPTIONS
-Some of these options are only useful when they appear in the
-.I /etc/fstab
-file.
+.SS Generic kernel mount options
 
 Some of these options could be enabled or disabled by default
-in the system kernel.  To check the current setting see the options
-in /proc/mounts.  Note that filesystems also have per-filesystem
-specific default mount options (see for example \fBtune2fs \-l\fP
-output for extN filesystems).
+in the system kernel as documented in
+.BR mount (2).
+To check the current setting see the options in
+.I /proc/mounts\fR.
+Note that filesystems also have per-filesystem specific default mount
+options (see for example \fBtune2fs \-l\fP output for extN
+filesystems).
 
 The following options apply to any filesystem that is being
 mounted (but not every filesystem actually honors them \(en e.g.\&, the
@@ -867,25 +868,6 @@ Do not update inode access times on this filesystem (e.g.\& for faster
 access on the news spool to speed up news servers).  This works for all
 inode types (directories too), so it implies \fB\%nodiratime\fR.
 .TP
-.B auto
-Can be mounted with the
-.B \-a
-option (e.g., at boot time).
-.TP
-.B noauto
-Can only be mounted explicitly (i.e., the
-.B \-a
-option will not cause the filesystem to be mounted).
-.TP
-.B comment=*
-All options prefixed with
-.BR comment=
-are interpreted as comments or as userspace application-specific options.
-These options are not stored in the user space (e.g. mtab file),
-nor sent to the mount.\fItype\fR helpers nor to the
-.BR mount (2)
-system call.  The suggested format is \fBcomment=\fIappname\fR.\fIoption\fR.
-.TP
 .na
 .BR context=\fIcontext ", " fscontext=\fIcontext ", " defcontext=\fIcontext ", and " \%rootcontext=\fIcontext
 .ad
@@ -959,9 +941,6 @@ For more details, see
 .RE
 
 .TP
-.B defaults
-A no-op placeholder with no impact to the filesystem mount options.
-.TP
 .B dev
 Interpret character or block special devices on the filesystem.
 .TP
@@ -970,7 +949,7 @@ Do not interpret character or block special devices on the file
 system.
 .TP
 .B diratime
-Update directory inode access times on this filesystem.  This is the default.
+Update directory inode access times on this filesystem.
 (This option is ignored when \fBnoatime\fR is set.)
 .TP
 .B nodiratime
@@ -990,14 +969,6 @@ Do not permit direct execution of any binaries on the mounted filesystem.
 (Until recently it was possible to run binaries anyway using a command like
 /lib/ld*.so /mnt/binary.  This trick fails since Linux 2.4.25 / 2.6.0.)
 .TP
-.B group
-Allow an ordinary user to mount the filesystem if one
-of that user's groups matches the group of the device.
-This option implies the options
-.BR nosuid " and " nodev
-(unless overridden by subsequent options, as in the option line
-.BR group,dev,suid ).
-.TP
 .B iversion
 Every time the inode is modified, the i_version field will be incremented.
 .TP
@@ -1094,14 +1065,6 @@ Turn on the silent flag.
 .B loud
 Turn off the silent flag.
 .TP
-.B owner
-Allow an ordinary user to mount the filesystem if that
-user is the owner of the device.
-This option implies the options
-.BR nosuid " and " nodev
-(unless overridden by subsequent options, as in the option line
-.BR owner,dev,suid ).
-.TP
 .B remount
 Attempt to remount an already-mounted filesystem.  This is commonly
 used to change the mount flags for a filesystem, especially to make a
@@ -1146,6 +1109,56 @@ Mount the filesystem read-write.
 All I/O to the filesystem should be done synchronously.  In the case of
 media with a limited number of write cycles
 (e.g.\& some flash drives), \fBsync\fR may cause life-cycle shortening.
+
+.SS User-space mount options
+The following filesystem-independent mount options affect the behavior of
+.BR mount (8)
+but are not passed through to the kernel.
+
+.TP
+.B auto
+Can be mounted with the
+.B \-a
+option (e.g., at boot time).
+.TP
+.B noauto
+Can only be mounted explicitly (i.e., the
+.B \-a
+option will not cause the filesystem to be mounted).
+.TP
+.B comment=*
+All options prefixed with
+.BR comment=
+are interpreted as comments or as userspace application-specific options.
+These options are not stored in the userspace (e.g. mtab file),
+nor sent to the mount.\fItype\fR helpers nor to the
+.BR mount (2)
+system call.  The suggested format is \fBcomment=\fIappname\fR.\fIoption\fR.
+.TP
+.B defaults
+A no-op placeholder with no impact to the filesystem mount options.
+.TP
+.B group
+Allow an ordinary user to mount the filesystem if one
+of that user's groups matches the group of the device.
+This option implies the options
+.BR nosuid " and " nodev
+(unless overridden by subsequent options, as in the option line
+.BR group,dev,suid ).
+.TP
+.B nogroup
+Unset \fBgroup\fR.
+.TP
+.B owner
+Allow an ordinary user to mount the filesystem if that
+user is the owner of the device.
+This option implies the options
+.BR nosuid " and " nodev
+(unless overridden by subsequent options, as in the option line
+.BR owner,dev,suid ).
+.TP
+.B noowner
+Unset \fBowner\fR.
 .TP
 .B user
 Allow an ordinary user to mount the filesystem.
@@ -1168,6 +1181,9 @@ This option implies the options
 (unless overridden by subsequent options, as in the option line
 .BR users,exec,dev,suid ).
 .TP
+.B nousers
+Unset \fBusers\fR.
+.TP
 .B X-*
 All options prefixed with
 .BR X-
-- 
2.1.0.60.g85f0837

