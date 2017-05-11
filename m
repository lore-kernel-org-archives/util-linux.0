Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-08v.sys.comcast.net ([96.114.154.167]:41246 "EHLO
        resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755662AbdEKPgZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 11 May 2017 11:36:25 -0400
From: "W. Trevor King" <wking@tremily.us>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] WIP: mount.8: Split out fstab-specific mount options
Date: Thu, 11 May 2017 06:48:54 -0700
Message-Id: <cee125bdea0faac3b4c9d7e856425fe9106756e7.1494510090.git.wking@tremily.us>
In-Reply-To: <20170511122442.qwzpw7f6xdsc7im2@ws.net.home>
References: <20170511122442.qwzpw7f6xdsc7im2@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And list the default settings for the X/noX pairs.  This clears up
some ambiguity around the meaning of "defaults" and fills in some
entries missing from the earlier man pages.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
On Thu, May 11, 2017 at 02:24:42PM +0200, Karel Zak wrote:
> It's placeholder, but kernel uses some options like "rw,exec,suid"
> by default…

And these are “everying marked with MNT_INVERT in optmap.c as well as
whatever filesystem-specific defaults”, right?

> My suggestion (man page):
>
>   default
>
>    No-op placeholder with no impact to the filesystem mount options.
>
>    The real mount options depends on built-in kernel defaults and
>    default mount options defined by filesystem superblock. The usual
>    kernel behaviour is to mount filesystems with rw, suid and exec
>    flags by default. See the beginning of this section for more details.
>
>    The "default" is interpreted as "auto" by "mount -a".

This last line means "defaults" is effectively a synonym for "auto" in
fstab, an presumably "auto" would always be preferred (because it more
clearly marks the change from the "no flag bits set" initial state).
I've started roughing out a sketch of where I think this should go
below, although there are a number of things that I'm not clear on
(e.g. are the X-* and x-* options in the same boat as comment=*?  What
is (no)sub about?).

 sys-utils/fstab.5 |  33 +----------
 sys-utils/mount.8 | 164 ++++++++++++++++++++++++++++++------------------------
 2 files changed, 95 insertions(+), 102 deletions(-)

diff --git a/sys-utils/fstab.5 b/sys-utils/fstab.5
index 07d0287..16f6662 100644
--- a/sys-utils/fstab.5
+++ b/sys-utils/fstab.5
@@ -62,7 +62,7 @@ The following is a typical example of an
 entry:
 .sp
 .RS 7
-LABEL=t-home2   /home      ext4    defaults,auto_da_alloc      0  2
+LABEL=t-home2   /home      ext4    auto,auto_da_alloc      0  2
 .RE
 
 .B The first field
@@ -155,39 +155,12 @@ deprecated).
 .RS
 This field describes the mount options associated with the filesystem.
 
-It is formatted as a comma-separated list of options.
-It contains at least the type of mount
-.RB ( ro
-or
-.BR rw ),
-plus any additional options appropriate to the filesystem
-type (including performance-tuning options).
+It is formatted as a comma-separated list of options, which may depend
+on the filesystem type (including performance-tuning options).
 For details, see
 .BR mount (8)
 or
 .BR swapon (8).
-
-Basic filesystem-independent options are:
-.TP
-.B defaults
-use default options: rw, suid, dev, exec, auto, nouser, and async.
-.TP
-.B noauto
-do not mount when "mount -a" is given (e.g., at boot time)
-.TP
-.B user
-allow a user to mount
-.TP
-.B owner
-allow device owner to mount
-.TP
-.B comment
-or
-.B x-<name>
-for use by fstab-maintaining programs
-.TP
-.B nofail
-do not report errors for this device if it does not exist.
 .RE
 
 .B The fifth field
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index bbfe71b..e39ada7 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -643,7 +643,8 @@ a comma-separated list.  For example:
 .RE
 
 For more details, see the
-.B FILESYSTEM-INDEPENDENT MOUNT OPTIONS
+.B FILESYSTEM-INDEPENDENT MOUNT OPTIONS\fR,
+.B FSTAB-SPECIFIC MOUNT OPTIONS\fR,
 and
 .B FILESYSTEM-SPECIFIC MOUNT OPTIONS
 sections.
@@ -821,9 +822,6 @@ Display version information and exit.
 Display help text and exit.
 
 .SH FILESYSTEM-INDEPENDENT MOUNT OPTIONS
-Some of these options are only useful when they appear in the
-.I /etc/fstab
-file.
 
 Some of these options could be enabled or disabled by default
 in the system kernel.  To check the current setting see the options
@@ -837,7 +835,7 @@ mounted (but not every filesystem actually honors them \(en e.g.\&, the
 option today has an effect only for ext2, ext3, fat, vfat and ufs):
 
 .TP
-.B async
+.B async \fR(default)
 All I/O to the filesystem should be done asynchronously.  (See also the
 .B sync
 option.)
@@ -848,21 +846,11 @@ by kernel defaults.  See also the descriptions of the \fB\%relatime\fR and
 .B strictatime
 mount options.
 .TP
-.B noatime
+.B noatime \fR(default)
 Do not update inode access times on this filesystem (e.g.\& for faster
 access on the news spool to speed up news servers).  This works for all
 inode types (directories too), so it implies \fB\%nodiratime\fR.
 .TP
-.B auto
-Can be mounted with the
-.B \-a
-option.
-.TP
-.B noauto
-Can only be mounted explicitly (i.e., the
-.B \-a
-option will not cause the filesystem to be mounted).
-.TP
 .na
 .BR context=\fIcontext ", " fscontext=\fIcontext ", " defcontext=\fIcontext ", and " \%rootcontext=\fIcontext
 .ad
@@ -936,22 +924,15 @@ For more details, see
 .RE
 
 .TP
-.B defaults
-Use the default options:
-.BR rw ", " suid ", " dev ", " exec ", " auto ", " nouser ", and " async .
-
-Note that the real set of all default mount options depends on kernel
-and filesystem type.  See the beginning of this section for more details.
-.TP
-.B dev
+.B dev \fR(default)
 Interpret character or block special devices on the filesystem.
 .TP
 .B nodev
 Do not interpret character or block special devices on the file
 system.
 .TP
-.B diratime
-Update directory inode access times on this filesystem.  This is the default.
+.B diratime \fR(default)
+Update directory inode access times on this filesystem.
 (This option is ignored when \fBnoatime\fR is set.)
 .TP
 .B nodiratime
@@ -963,7 +944,7 @@ All directory updates within the filesystem should be done synchronously.
 This affects the following system calls: creat, link, unlink, symlink,
 mkdir, rmdir, mknod and rename.
 .TP
-.B exec
+.B exec \fR(default)
 Permit execution of binaries.
 .TP
 .B noexec
@@ -971,25 +952,17 @@ Do not permit direct execution of any binaries on the mounted filesystem.
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
-.B noiversion
+.B noiversion \fR(default)
 Do not increment the i_version inode field.
 .TP
 .B mand
 Allow mandatory locks on this filesystem.  See
 .BR fcntl (2).
 .TP
-.B nomand
+.B nomand \fR(default)
 Do not allow mandatory locks on this filesystem.
 .TP
 .B _netdev
@@ -1016,7 +989,7 @@ option is required to obtain traditional semantics.  In addition, since Linux
 2.6.30, the file's last access time is always updated if it is more than 1
 day old.
 .TP
-.B norelatime
+.B norelatime \fR(default)
 Do not use the
 .B relatime
 feature.  See also the
@@ -1032,7 +1005,7 @@ or
 but still allow userspace to override it.  For more details about the default
 system mount options see /proc/mounts.
 .TP
-.B nostrictatime
+.B nostrictatime \fR(default)
 Use the kernel's default behavior for inode access time updates.
 .TP
 .B lazytime
@@ -1058,10 +1031,10 @@ or
 .RE
 .sp
 .TP
-.B nolazytime
+.B nolazytime \fR(default)
 Do not use the lazytime feature.
 .TP
-.B suid
+.B suid \fR(default)
 Allow set-user-ID or set-group-ID bits to take
 effect.
 .TP
@@ -1072,17 +1045,9 @@ effect.
 .B silent
 Turn on the silent flag.
 .TP
-.B loud
+.B loud \fR(default)
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
@@ -1124,28 +1089,6 @@ All I/O to the filesystem should be done synchronously.  In the case of
 media with a limited number of write cycles
 (e.g.\& some flash drives), \fBsync\fR may cause life-cycle shortening.
 .TP
-.B user
-Allow an ordinary user to mount the filesystem.
-The name of the mounting user is written to the mtab file (or to the private
-libmount file in /run/mount on systems without a regular mtab) so that this
-same user can unmount the filesystem again.
-This option implies the options
-.BR noexec ", " nosuid ", and " nodev
-(unless overridden by subsequent options, as in the option line
-.BR user,exec,dev,suid ).
-.TP
-.B nouser
-Forbid an ordinary user to mount the filesystem.
-This is the default; it does not imply any other options.
-.TP
-.B users
-Allow any user to mount and to unmount the filesystem, even
-when some other ordinary user mounted it.
-This option implies the options
-.BR noexec ", " nosuid ", and " nodev
-(unless overridden by subsequent options, as in the option line
-.BR users,exec,dev,suid ).
-.TP
 .B X-*
 All options prefixed with "X-" are interpreted as comments or as userspace
 application-specific options.  These options are not stored in the user space (e.g. mtab file),
@@ -1175,6 +1118,83 @@ in octal notation.  The default mode is 0755.  This functionality is supported
 only for root users.  The option is also supported as x-mount.mkdir, this notation
 is deprecated for mount.mkdir since v2.30.
 
+.SH FSTAB-SPECIFIC MOUNT OPTIONS
+The following options apply only to fstab entries and are not useful when calling
+.BR mount
+directly.
+See
+.BR fstab (5)
+for more details on the file format.
+
+.TP
+.B auto
+Can be mounted with the
+.B \-a
+option (e.g., at boot time).
+.TP
+.B noauto \fR(default)
+Can only be mounted explicitly (i.e., the
+.B \-a
+option will not cause the filesystem to be mounted).
+.TP
+.B comment=*
+All options prefixed with
+.BR comment=
+are interpreted as comments or as userspace application-specific options.
+These options are not stored in the user space (e.g. mtab file),
+nor sent to the mount.\fItype\fR helpers nor to the
+.BR mount (2)
+system call.  The suggested format is \fBcomment=\fIappname\fR.\fIoption\fR.
+.TP
+.B defaults
+A synonym for \fBauto\fR.
+.TP
+.B group
+Allow an ordinary user to mount the filesystem if one
+of that user's groups matches the group of the device.
+This option implies the options
+.BR nosuid " and " nodev
+(unless overridden by subsequent options, as in the option line
+.BR group,dev,suid ).
+.TP
+.B nogroup \fR(default)
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
+.B noowner \fR(default)
+Unset \fBowner\fR.
+.TP
+.B user
+Allow an ordinary user to mount the filesystem.
+The name of the mounting user is written to the mtab file (or to the private
+libmount file in /run/mount on systems without a regular mtab) so that this
+same user can unmount the filesystem again.
+This option implies the options
+.BR noexec ", " nosuid ", and " nodev
+(unless overridden by subsequent options, as in the option line
+.BR user,exec,dev,suid ).
+.TP
+.B nouser \fR(default)
+Unset \fBuser\fR.
+.TP
+.B users
+Allow any user to mount and to unmount the filesystem, even
+when some other ordinary user mounted it.
+This option implies the options
+.BR noexec ", " nosuid ", and " nodev
+(unless overridden by subsequent options, as in the option line
+.BR users,exec,dev,suid ).
+.TP
+.B nousers \fR(default)
+Unset \fBusers\fR.
+
 .SH "FILESYSTEM-SPECIFIC MOUNT OPTIONS"
 The following options apply only to certain filesystems.
 We sort them by filesystem.  They all follow the
-- 
2.1.0.60.g85f0837

