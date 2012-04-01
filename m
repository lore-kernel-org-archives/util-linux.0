Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53682 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332Ab2DAI6f (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 1 Apr 2012 04:58:35 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id CF94589471
	for <util-linux@vger.kernel.org>; Sun,  1 Apr 2012 10:58:33 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH] unmount: fix typo in command name
Date: Sun,  1 Apr 2012 10:58:31 +0200
Message-Id: <1333270711-28071-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I noticed a rather annoying typo in one of the command names: umount.
The patch below renames the command to the correct spelling "unmount".
This typo is so widespread that so far I managed to fix only the most
visible occurences. I'm really surprised how this typo could survive
unnoticed for such a long time (well, one of my theories is that this
is because the kernel guys did a same mistake).

This fix will hopefully make linux more appealing for new users for who
such typos are one of the major obstacles with adopting Linux as their
OS of choice.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 configure.ac          |    2 +-
 mount/.gitignore      |    2 +-
 mount/Makefile.am     |   42 ++--
 mount/umount.8        |  179 ----------
 mount/umount.c        |  874 -------------------------------------------------
 mount/unmount.8       |  180 ++++++++++
 mount/unmount.c       |  874 +++++++++++++++++++++++++++++++++++++++++++++++++
 sys-utils/Makefile.am |   26 +-
 8 files changed, 1090 insertions(+), 1089 deletions(-)
 delete mode 100644 mount/umount.8
 delete mode 100644 mount/umount.c
 create mode 100644 mount/unmount.8
 create mode 100644 mount/unmount.c

diff --git a/configure.ac b/configure.ac
index 2140bc5..293bfce 100644
--- a/configure.ac
+++ b/configure.ac
@@ -344,7 +344,7 @@ AC_LINK_IFELSE([AC_LANG_PROGRAM([extern char *__progname;],
 	   AC_MSG_RESULT(no))
 
 dnl Static compilation
-m4_define([UL_STATIC_PROGRAMS], [losetup, mount, umount, fdisk, sfdisk, blkid])
+m4_define([UL_STATIC_PROGRAMS], [losetup, mount, unmount, fdisk, sfdisk, blkid])
 
 AC_ARG_ENABLE([static-programs],
   [AS_HELP_STRING([--enable-static-programs=LIST],
diff --git a/mount/.gitignore b/mount/.gitignore
index 8be9ace..391b5b5 100644
--- a/mount/.gitignore
+++ b/mount/.gitignore
@@ -1,3 +1,3 @@
 mount
 mtab_lock_test
-umount
+unmount
diff --git a/mount/Makefile.am b/mount/Makefile.am
index 3bd6da4..5683c45 100644
--- a/mount/Makefile.am
+++ b/mount/Makefile.am
@@ -1,18 +1,18 @@
 include $(top_srcdir)/config/include-Makefile.am
 
-bin_PROGRAMS = mount umount
-dist_man_MANS = fstab.5 mount.8 umount.8
+bin_PROGRAMS = mount unmount
+dist_man_MANS = fstab.5 mount.8 unmount.8
 
-# generic sources for all programs (mount, umount)
+# generic sources for all programs (mount, unmount)
 srcs_common = \
 	sundries.c \
 	$(top_srcdir)/lib/canonicalize.c \
 	sundries.h
 
-# generic header for mount and umount
+# generic header for mount and unmount
 hdrs_mount = fstab.h mount_mntent.h mount_constants.h getusername.h
 
-# generic sources for mount and umount
+# generic sources for mount and unmount
 srcs_mount = \
 	$(srcs_common) \
 	$(hdrs_mount) \
@@ -47,10 +47,10 @@ mount_CFLAGS = $(SUID_CFLAGS) $(cflags_common)
 mount_LDFLAGS = $(SUID_LDFLAGS) $(AM_LDFLAGS)
 mount_LDADD = $(ldadd_common)
 
-umount_SOURCES = umount.c $(srcs_mount)
-umount_CFLAGS = $(SUID_CFLAGS) $(cflags_common)
-umount_LDFLAGS = $(SUID_LDFLAGS) $(AM_LDFLAGS)
-umount_LDADD = $(ldadd_common)
+unmount_SOURCES = unmount.c $(srcs_mount)
+unmount_CFLAGS = $(SUID_CFLAGS) $(cflags_common)
+unmount_LDFLAGS = $(SUID_LDFLAGS) $(AM_LDFLAGS)
+unmount_LDADD = $(ldadd_common)
 
 mount_static_LDADD =
 
@@ -62,12 +62,12 @@ mount_static_LDFLAGS = $(ldflags_static)
 mount_static_LDADD += $(ldadd_static)
 endif
 
-if HAVE_STATIC_UMOUNT
-bin_PROGRAMS += umount.static
-umount_static_SOURCES = $(umount_SOURCES)
-umount_static_CFLAGS = $(cflags_common)
-umount_static_LDFLAGS = $(ldflags_static)
-umount_static_LDADD = $(ldadd_static)
+if HAVE_STATIC_UNMOUNT
+bin_PROGRAMS += unmount.static
+unmount_static_SOURCES = $(unmount_SOURCES)
+unmount_static_CFLAGS = $(cflags_common)
+unmount_static_LDFLAGS = $(ldflags_static)
+unmount_static_LDADD = $(ldadd_static)
 endif
 
 if HAVE_SELINUX
@@ -78,15 +78,15 @@ endif
 if BUILD_LIBMOUNT_MOUNT
 mount_LDADD += $(ul_libmount_la)
 mount_CFLAGS += $(AM_CFLAGS) -I$(ul_libmount_incdir)
-umount_LDADD += $(ul_libmount_la)
-umount_CFLAGS += $(AM_CFLAGS) -I$(ul_libmount_incdir)
+unmount_LDADD += $(ul_libmount_la)
+unmount_CFLAGS += $(AM_CFLAGS) -I$(ul_libmount_incdir)
 if HAVE_STATIC_MOUNT
 mount_static_LDADD += $(ul_libmount_la)
 mount_static_CFLAGS += -I$(ul_libmount_incdir)
 endif
-if HAVE_STATIC_UMOUNT
-umount_static_LDADD += $(ul_libmount_la)
-umount_static_CFLAGS += -I$(ul_libmount_incdir)
+if HAVE_STATIC_UNMOUNT
+unmount_static_LDADD += $(ul_libmount_la)
+unmount_static_CFLAGS += -I$(ul_libmount_incdir)
 endif
 endif
 
@@ -103,5 +103,5 @@ endif
 install-exec-hook:
 if MAKEINSTALL_DO_SETUID
 	chmod 4755 $(DESTDIR)$(bindir)/mount
-	chmod 4755 $(DESTDIR)$(bindir)/umount
+	chmod 4755 $(DESTDIR)$(bindir)/unmount
 endif
diff --git a/mount/umount.8 b/mount/umount.8
deleted file mode 100644
index 1c7d59a..0000000
--- a/mount/umount.8
+++ /dev/null
@@ -1,179 +0,0 @@
-.\" Copyright (c) 1996 Andries Brouwer
-.\" This page is somewhat derived from a page that was
-.\" (c) 1980, 1989, 1991 The Regents of the University of California
-.\" and had been heavily modified by Rik Faith and myself.
-.\"
-.\" This is free documentation; you can redistribute it and/or
-.\" modify it under the terms of the GNU General Public License as
-.\" published by the Free Software Foundation; either version 2 of
-.\" the License, or (at your option) any later version.
-.\"
-.\" The GNU General Public License's references to "object code"
-.\" and "executables" are to be interpreted as the output of any
-.\" document formatting or typesetting system, including
-.\" intermediate and printed output.
-.\"
-.\" This manual is distributed in the hope that it will be useful,
-.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-.\" GNU General Public License for more details.
-.\"
-.\" You should have received a copy of the GNU General Public License along
-.\" with this program; if not, write to the Free Software Foundation, Inc.,
-.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-.\"
-.TH UMOUNT 8 "March 2010" "util-linux" "System Administration"
-.SH NAME
-umount \- unmount file systems
-.SH SYNOPSIS
-.B umount
-.RB [ \-hV ]
-.LP
-.B umount \-a
-.RB [ \-dflnrv ]
-.RB [ \-t
-.IR vfstype ]
-.RB [ \-O
-.IR options ]
-.br
-.B umount
-.RB [ \-dflnrv ]
-.RI { dir | device }...
-.SH DESCRIPTION
-The
-.B umount
-command detaches the file system(s) mentioned from the file hierarchy.
-A file system is specified by giving the directory where it
-has been mounted. Giving the special device on which the file system lives
-may also work, but is obsolete, mainly because it will fail
-in case this device was mounted on more than one directory.
-
-Note that a file system cannot be unmounted when it is `busy' -
-for example, when there are open files on it, or when some process
-has its working directory there, or when a swap file on it is in use.
-The offending process could even be
-.B umount
-itself - it opens libc, and libc in its turn may open for example
-locale files.
-A lazy unmount avoids this problem.
-
-Options for the
-.B umount
-command:
-.TP
-.B \-V
-Print version and exit.
-.TP
-.B \-h
-Print help message and exit.
-.TP
-.B \-v
-Verbose mode.
-.TP
-.B \-n
-Unmount without writing in
-.IR /etc/mtab .
-.TP
-.B \-r
-In case unmounting fails, try to remount read-only.
-.TP
-.B \-d
-In case the unmounted device was a loop device, also
-free this loop device.
-.TP
-.B \-i
-Don't call the /sbin/umount.<filesystem> helper even if it exists. By default /sbin/umount.<filesystem> helper is called if one exists.
-.TP
-.B \-a
-All of the file systems described in
-.I /etc/mtab
-are unmounted. (With
-.B umount
-version 2.7 and later: the
-.I proc
-filesystem is not unmounted.)
-.TP
-.BI \-t " vfstype"
-Indicate that the actions should only be taken on file systems of the
-specified type.  More than one type may be specified in a comma separated
-list.  The list of file system types can be prefixed with
-.B no
-to specify the file system types on which no action should be taken.
-.TP
-.BI \-O " options"
-Indicate that the actions should only be taken on file systems with
-the specified options in
-.IR /etc/fstab .
-More than one option type may be specified in a comma separated
-list.  Each option can be prefixed with
-.B no
-to specify options for which no action should be taken.
-.TP
-.B \-f
-Force unmount (in case of an unreachable NFS system).
-(Requires kernel 2.1.116 or later.)
-.TP
-.B \-l
-Lazy unmount. Detach the filesystem from the filesystem hierarchy now,
-and cleanup all references to the filesystem as soon as it is not busy
-anymore.
-(Requires kernel 2.4.11 or later.)
-.IP "\fB\-\-no\-canonicalize\fP"
-Don't canonicalize paths. For more details about this option see the
-.B mount(8)
-man page.
-.IP "\fB\-\-fake\fP"
-Causes everything to be done except for the actual system call; this
-``fakes'' unmounting the filesystem.  It can  be used to remove
-entries from
-.I /etc/mtab
-that were unmounted earlier with the -n option.
-
-.SH "THE LOOP DEVICE"
-The
-.B umount
-command will free the loop device (if any) associated
-with the mount, in case it finds the option `loop=...' in
-.IR /etc/mtab ,
-or when the \-d option was given.
-Any pending loop devices can be freed using `losetup -d', see
-.BR losetup (8).
-
-.SH NOTES
-The syntax of external umount helpers is:
-
-.br
-.BI /sbin/umount. <suffix>
-.RI { dir | device }
-.RB [ \-nlfvr ]
-.RB [ \-t
-.IR type.subtype ]
-.br
-
-where the <suffix> is filesystem type or a value from "uhelper=" or "helper="
-mtab option.  The \-t option is used  for filesystems with subtypes support
-(for example /sbin/mount.fuse -t fuse.sshfs).
-
-The uhelper= (unprivileged umount helper) is possible to use when non-root user
-wants to umount a mountpoint which is not defined in the /etc/fstab file (e.g
-devices mounted by udisk).
-
-The helper= mount option redirects all umount requests to the
-/sbin/umount.<helper> independently on UID.
-
-.SH FILES
-.I /etc/mtab
-table of mounted file systems
-
-.SH "SEE ALSO"
-.BR umount (2),
-.BR mount (8),
-.BR losetup (8).
-
-.SH HISTORY
-A
-.B umount
-command appeared in Version 6 AT&T UNIX.
-.SH AVAILABILITY
-The umount command is part of the util-linux package and is available from
-ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/mount/umount.c b/mount/umount.c
deleted file mode 100644
index a6fcd33..0000000
--- a/mount/umount.c
+++ /dev/null
@@ -1,874 +0,0 @@
-/*
- * umount(8) for Linux 0.99 - jrs, 1993
- */
-
-#include <stdio.h>
-#include <unistd.h>
-#include <getopt.h>
-#include <string.h>
-#include <errno.h>
-#include <ctype.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <sys/mount.h>
-
-#include "mount_constants.h"
-#include "sundries.h"
-#include "getusername.h"
-#include "pathnames.h"
-#include "loopdev.h"
-#include "fstab.h"
-#include "env.h"
-#include "nls.h"
-#include "strutils.h"
-
-#if defined(MNT_FORCE)
-/* Interesting ... it seems libc knows about MNT_FORCE and presumably
-   about umount2 as well -- need not do anything */
-#else /* MNT_FORCE */
-
-/* Does the present kernel source know about umount2? */
-#include <linux/unistd.h>
-#ifdef __NR_umount2
-
-static int umount2(const char *path, int flags);
-
-_syscall2(int, umount2, const char *, path, int, flags);
-
-#else /* __NR_umount2 */
-
-static int
-umount2(const char *path, int flags) {
-	fprintf(stderr, _("umount: compiled without support for -f\n"));
-	errno = ENOSYS;
-	return -1;
-}
-#endif /* __NR_umount2 */
-
-#ifndef MNT_FORCE
-# define MNT_FORCE        0x00000001	/* Attempt to forcibily umount */
-#endif
-
-#endif /* MNT_FORCE */
-
-#ifndef MNT_DETACH
-# define MNT_DETACH       0x00000002	/* Just detach from the tree */
-#endif
-
-#ifndef UMOUNT_NOFOLLOW
-# define UMOUNT_NOFOLLOW  0x00000008	/* Don't follow symlink on umount */
-#endif
-
-#ifndef UMOUNT_UNUSED
-# define UMOUNT_UNUSED    0x80000000	/* Flag guaranteed to be unused */
-#endif
-
-
-/* True if we are allowed to call /sbin/umount.${FSTYPE} */
-int external_allowed = 1;
-
-/* Nonzero for force umount (-f).  There is kernel support since 2.1.116.  */
-int force = 0;
-
-/* Nonzero for lazy umount (-l).  There is kernel support since 2.4.11.  */
-int lazy = 0;
-
-/* When umount fails, attempt a read-only remount (-r). */
-int remount = 0;
-
-/* Don't write a entry in /etc/mtab (-n).  */
-int nomtab = 0;
-
-/* Call losetup -d for each unmounted loop device. */
-int delloop = 0;
-
-/* True if (ruid != euid) or (0 != ruid), i.e. only "user" umounts permitted. */
-int restricted = 1;
-
-/* Last error message */
-int complained_err = 0;
-char *complained_dev = NULL;
-
-/* True for fake umount (--fake).  */
-static int fake = 0;
-
-/*
- * check_special_umountprog()
- *	If there is a special umount program for this type, exec it.
- * returns: 0: no exec was done, 1: exec was done, status has result
- */
-static int
-check_special_umountprog(const char *node,
-			 const char *type, int *status) {
-	char search_path[] = FS_SEARCH_PATH;
-	char *path, umountprog[150];
-	struct stat statbuf;
-	int res;
-
-	if (!external_allowed)
-		return 0;
-
-	if (type == NULL || strcmp(type, "none") == 0)
-		return 0;
-
-	path = strtok(search_path, ":");
-	while (path) {
-		int type_opt = 0;
-
-		res = snprintf(umountprog, sizeof(umountprog), "%s/umount.%s",
-			       path, type);
-		path = strtok(NULL, ":");
-		if (res < 0 || (size_t) res >= sizeof(umountprog))
-			continue;
-
-		res = stat(umountprog, &statbuf);
-		if (res == -1 && errno == ENOENT && strchr(type, '.')) {
-			/* If type ends with ".subtype" try without it */
-			*strrchr(umountprog, '.') = '\0';
-			type_opt = 1;
-			res = stat(umountprog, &statbuf);
-		}
-		if (res == 0) {
-			res = fork();
-			if (res == 0) {
-				char *umountargs[10];
-				int i = 0;
-
-				if(setgid(getgid()) < 0)
-					die(EX_FAIL, _("umount: cannot set group id: %m"));
-
-				if(setuid(getuid()) < 0)
-					die(EX_FAIL, _("umount: cannot set user id: %m"));
-
-				umountargs[i++] = umountprog;
-				umountargs[i++] = xstrdup(node);
-				if (nomtab)
-					umountargs[i++] = "-n";
-				if (lazy)
-					umountargs[i++] = "-l";
-				if (force)
-					umountargs[i++] = "-f";
-				if (verbose)
-					umountargs[i++] = "-v";
-				if (remount)
-					umountargs[i++] = "-r";
-				if (type_opt) {
-					umountargs[i++] = "-t";
-					umountargs[i++] = (char *) type;
-				}
-				umountargs[i] = NULL;
-				execv(umountprog, umountargs);
-				exit(1);	/* exec failed */
-			} else if (res != -1) {
-				int st;
-				wait(&st);
-				*status = (WIFEXITED(st) ? WEXITSTATUS(st)
-					   : EX_SYSERR);
-				return 1;
-			} else {
-				int errsv = errno;
-				error(_("umount: cannot fork: %s"),
-				      strerror(errsv));
-			}
-		}
-	}
-	return 0;
-}
-
-/* complain about a failed umount */
-static void complain(int err, const char *dev) {
-
-  if (complained_err == err && complained_dev && dev &&
-		  strcmp(dev, complained_dev) == 0)
-    return;
-
-  complained_err = err;
-  free(complained_dev);
-  complained_dev = xstrdup(dev);
-
-  switch (err) {
-    case ENXIO:
-      error (_("umount: %s: invalid block device"), dev); break;
-    case EINVAL:
-      error (_("umount: %s: not mounted"), dev); break;
-    case EIO:
-      error (_("umount: %s: can't write superblock"), dev); break;
-    case EBUSY:
-     /* Let us hope fstab has a line "proc /proc ..."
-	and not "none /proc ..."*/
-      error (_("umount: %s: device is busy.\n"
-	       "        (In some cases useful info about processes that use\n"
-	       "         the device is found by lsof(8) or fuser(1))"), dev);
-      break;
-    case ENOENT:
-      error (_("umount: %s: not found"), dev); break;
-    case EPERM:
-      error (_("umount: %s: must be superuser to umount"), dev); break;
-    case EACCES:
-      error (_("umount: %s: block devices not permitted on fs"), dev); break;
-    default:
-      error (_("umount: %s: %s"), dev, strerror (err)); break;
-  }
-}
-
-/* Check whether the kernel supports UMOUNT_NOFOLLOW flag */
-static int umount_nofollow_support(void)
-{
-	int res = umount2("", UMOUNT_UNUSED);
-	if (res != -1 || errno != EINVAL)
-		return 0;
-
-	res = umount2("", UMOUNT_NOFOLLOW);
-	if (res != -1 || errno != ENOENT)
-		return 0;
-
-	return 1;
-}
-
-static const char *chdir_to_parent(const char *node, char **resbuf)
-{
-	char *tmp, *res;
-	const char *parent;
-	char buf[65536];
-
-	*resbuf = xstrdup(node);
-
-	tmp = strrchr(*resbuf, '/');
-	if (!tmp)
-		die (2, _("umount: internal error: invalid abs path: %s"), node);
-
-	if (tmp != *resbuf) {
-		*tmp = '\0';
-		res = tmp + 1;
-		parent = *resbuf;
-	} else if (tmp[1] != '\0') {
-		res = tmp + 1;
-		parent = "/";
-	} else {
-		res = ".";
-		parent = "/";
-	}
-
-	if (chdir(parent) == -1)
-		die (2, _("umount: failed to chdir to %s: %m"), parent);
-
-	if (!getcwd(buf, sizeof(buf)))
-		die (2, _("umount: failed to obtain current directory: %m"));
-
-	if (strcmp(buf, parent) != 0)
-		die (2, _("umount: mountpoint moved (%s -> %s)"), parent, buf);
-
-	if (verbose)
-		printf(_("current directory moved to %s\n"), res);
-
-	return res;
-}
-
-/* Umount a single device.  Return a status code, so don't exit
-   on a non-fatal error.  We lock/unlock around each umount.  */
-static int
-umount_one (const char *spec, const char *node, const char *type,
-	    struct mntentchn *mc) {
-	int umnt_err = 0;
-	int isroot;
-	int res = 0;
-	int status;
-	int extra_flags = 0;
-	const char *loopdev, *target = node;
-	char *targetbuf = NULL;
-	int myloop = 0;
-
-	/* Special case for root.  As of 0.99pl10 we can (almost) unmount root;
-	   the kernel will remount it readonly so that we can carry on running
-	   afterwards.  The readonly remount is illegal if any files are opened
-	   for writing at the time, so we can't update mtab for an unmount of
-	   root.  As it is only really a remount, this doesn't matter too
-	   much.  [sct May 29, 1993] */
-	isroot = (streq (node, "/") || streq (node, "root")
-		  || streq (node, "rootfs"));
-	if (isroot)
-		nomtab++;
-
-	/*
-	 * Call umount.TYPE for types that require a separate umount program.
-	 * All such special things must occur isolated in the types string.
-	 */
-	if (check_special_umountprog(node, type, &status))
-		return status;
-
-	block_signals(SIG_BLOCK);
-
-	/* Skip the actual umounting for --fake */
-	if (fake)
-		goto writemtab;
-	/*
-	 * Ignore the option "-d" for non-loop devices and loop devices with
-	 * LO_FLAGS_AUTOCLEAR flag.
-	 */
-	if (delloop && is_loopdev(spec))
-		myloop = 1;
-
-	if (restricted) {
-		if (umount_nofollow_support())
-			extra_flags |= UMOUNT_NOFOLLOW;
-
-		/* call umount(2) with relative path to avoid races */
-		target = chdir_to_parent(node, &targetbuf);
-	}
-
-	if (lazy) {
-		res = umount2 (target, MNT_DETACH | extra_flags);
-		if (res < 0)
-			umnt_err = errno;
-		goto writemtab;
-	}
-
-	if (force) {		/* only supported for NFS */
-		res = umount2 (target, MNT_FORCE | extra_flags);
-		if (res == -1) {
-			int errsv = errno;
-			perror("umount2");
-			errno = errsv;
-			if (errno == ENOSYS) {
-				if (verbose)
-					printf(_("no umount2, trying umount...\n"));
-				res = umount (target);
-			}
-		}
-	} else if (extra_flags)
-		res = umount2 (target, extra_flags);
-	else
-		res = umount (target);
-
-	free(targetbuf);
-
-	if (res < 0)
-		umnt_err = errno;
-
-	if (res < 0 && remount && umnt_err == EBUSY) {
-		/* Umount failed - let us try a remount */
-		res = mount(spec, node, NULL,
-			    MS_MGC_VAL | MS_REMOUNT | MS_RDONLY, NULL);
-		if (res == 0) {
-			fprintf(stderr,
-				_("umount: %s busy - remounted read-only\n"),
-				spec);
-			if (mc && !nomtab) {
-				/* update mtab if the entry is there */
-				struct my_mntent remnt;
-				remnt.mnt_fsname = mc->m.mnt_fsname;
-				remnt.mnt_dir = mc->m.mnt_dir;
-				remnt.mnt_type = mc->m.mnt_type;
-				remnt.mnt_opts = "ro";
-				remnt.mnt_freq = 0;
-				remnt.mnt_passno = 0;
-				update_mtab(node, &remnt);
-			}
-			block_signals(SIG_UNBLOCK);
-			return 0;
-		} else if (errno != EBUSY) { 	/* hmm ... */
-			perror("remount");
-			fprintf(stderr,
-				_("umount: could not remount %s read-only\n"),
-				spec);
-		}
-	}
-
-	loopdev = 0;
-	if (res >= 0) {
-		/* Umount succeeded */
-		if (verbose)
-			printf (_("%s has been unmounted\n"), spec);
-
-		/* Free any loop devices that we allocated ourselves */
-		if (mc) {
-			char *optl;
-
-			/* old style mtab line? */
-			if (streq(mc->m.mnt_type, "loop")) {
-				loopdev = spec;
-				goto gotloop;
-			}
-
-			/* new style mtab line? */
-			optl = mc->m.mnt_opts ? xstrdup(mc->m.mnt_opts) : "";
-			for (optl = strtok (optl, ","); optl;
-			     optl = strtok (NULL, ",")) {
-				if (!strncmp(optl, "loop=", 5)) {
-					loopdev = optl+5;
-					goto gotloop;
-				}
-			}
-		} else {
-			/*
-			 * If option "-o loop=spec" occurs in mtab,
-			 * note the mount point, and delete mtab line.
-			 */
-			if ((mc = getmntoptfile (spec)) != NULL)
-				node = mc->m.mnt_dir;
-		}
-
-		/* Also free loop devices when -d flag is given */
-		if (myloop)
-			loopdev = spec;
-	}
- gotloop:
-	if (loopdev && !loopdev_is_autoclear(loopdev))
-		loopdev_delete(loopdev);
-
- writemtab:
-	if (!nomtab &&
-	    (umnt_err == 0 || umnt_err == EINVAL || umnt_err == ENOENT)) {
-#ifdef HAVE_LIBMOUNT_MOUNT
-		struct libmnt_update *upd = mnt_new_update();
-
-		if (upd && !mnt_update_set_fs(upd, 0, node, NULL))
-			mnt_update_table(upd, NULL);
-
-		mnt_free_update(upd);
-#else
-		update_mtab (node, NULL);
-#endif
-	}
-
-	block_signals(SIG_UNBLOCK);
-
-	if (res >= 0)
-		return 0;
-	if (umnt_err)
-		complain(umnt_err, node);
-	return 1;
-}
-
-/*
- * umount_one_bw: unmount FILE that has last occurrence MC0
- *
- * Why this loop?
- * 1. People who boot a system with a bad fstab root entry
- *    will get an incorrect "/dev/foo on /" in mtab.
- *    If later /dev/foo is actually mounted elsewhere,
- *    it will occur twice in mtab.
- * 2. With overmounting one can get the situation that
- *    the same filename is used as mount point twice.
- * In both cases, it is best to try the last occurrence first.
- */
-static int
-umount_one_bw (const char *file, struct mntentchn *mc0) {
-	struct mntentchn *mc;
-	int res = 1;
-
-	mc = mc0;
-	while (res && mc) {
-		res = umount_one(mc->m.mnt_fsname, mc->m.mnt_dir,
-				 mc->m.mnt_type, mc);
-		mc = getmntdirbackward(file, mc);
-	}
-	mc = mc0;
-	while (res && mc) {
-		res = umount_one(mc->m.mnt_fsname, mc->m.mnt_dir,
-				 mc->m.mnt_type, mc);
-		mc = getmntdevbackward(file, mc);
-	}
-	return res;
-}
-
-/* Unmount all filesystems of type VFSTYPES found in mtab.  Since we are
-   concurrently updating mtab after every successful umount, we have to
-   slurp in the entire file before we start.  This isn't too bad, because
-   in any case it's important to umount mtab entries in reverse order
-   to mount, e.g. /usr/spool before /usr.  */
-static int
-umount_all (char *types, char *test_opts) {
-     struct mntentchn *mc, *hd;
-     int errors = 0;
-
-     hd = mtab_head();
-     if (!hd->prev)
-	  die (2, _("umount: cannot find list of filesystems to unmount"));
-     for (mc = hd->prev; mc != hd; mc = mc->prev) {
-	  if (matching_type (mc->m.mnt_type, types)
-	      && matching_opts (mc->m.mnt_opts, test_opts)) {
-	       errors |= umount_one (mc->m.mnt_fsname, mc->m.mnt_dir,
-				     mc->m.mnt_type, mc);
-	  }
-     }
-
-     return errors;
-}
-
-static struct option longopts[] =
-{
-  { "all", 0, 0, 'a' },
-  { "force", 0, 0, 'f' },
-  { "help", 0, 0, 'h' },
-  { "no-mtab", 0, 0, 'n' },
-  { "test-opts", 1, 0, 'O' },
-  { "verbose", 0, 0, 'v' },
-  { "version", 0, 0, 'V' },
-  { "read-only", 0, 0, 'r' },
-  { "types", 1, 0, 't' },
-
-  { "no-canonicalize", 0, 0, 144 },
-  { "fake", 0, 0, 145 },
-  { NULL, 0, 0, 0 }
-};
-
-static void
-usage (FILE *fp, int n)
-{
-  fprintf (fp, _("Usage: umount -h | -V\n"
-	       "       umount -a [-d] [-f] [-r] [-n] [-v] [-t vfstypes] [-O opts]\n"
-	       "       umount [-d] [-f] [-r] [-n] [-v] special | node...\n"));
-  exit (n);
-}
-
-/*
- * Look for an option in a comma-separated list
- */
-static int
-contains(const char *list, const char *s) {
-	int n = strlen(s);
-
-	while (list && *list) {
-		if (strncmp(list, s, n) == 0 &&
-		    (list[n] == 0 || list[n] == ','))
-			return 1;
-		while (*list && *list++ != ',') ;
-	}
-	return 0;
-}
-
-/* check if @mc contains a loop device which is associated
- * with the @file in fs
- */
-static int
-is_valid_loop(struct mntentchn *mc, struct mntentchn *fs)
-{
-	uintmax_t offset = 0;
-	char *p;
-
-	/* check if it begins with /dev/loop */
-	if (strncmp(mc->m.mnt_fsname, _PATH_DEV_LOOP,
-				sizeof(_PATH_DEV_LOOP) - 1))
-		return 0;
-
-	/* check for loop option in fstab */
-	if (!contains(fs->m.mnt_opts, "loop"))
-		return 0;
-
-	/* check for offset option in fstab */
-	p = get_option_value(fs->m.mnt_opts, "offset=");
-	if (p && strtosize(p, &offset)) {
-		if (verbose > 1)
-			printf(_("failed to parse 'offset=%s' options\n"), p);
-		return 0;
-	}
-
-	/* check association */
-	if (loopdev_is_used((char *) mc->m.mnt_fsname, fs->m.mnt_fsname,
-				offset, LOOPDEV_FL_OFFSET) == 1) {
-		if (verbose > 1)
-			printf(_("device %s is associated with %s\n"),
-			       mc->m.mnt_fsname, fs->m.mnt_fsname);
-		return 1;
-	}
-
-	if (verbose > 1)
-		printf(_("device %s is not associated with %s\n"),
-		       mc->m.mnt_fsname, fs->m.mnt_fsname);
-	return 0;
-}
-
-/*
- * umount helper call based on {u,p}helper= mount option
- */
-static int check_helper_umountprog(const char *node,
-				   const char *opts, const char *name,
-				   int *status)
-{
-	char *helper;
-
-	if (!external_allowed || !opts)
-		return 0;
-
-	helper = get_option_value(opts, name);
-	if (helper)
-		return check_special_umountprog(node, helper, status);
-
-	return 0;
-}
-
-static int
-umount_file (char *arg) {
-	struct mntentchn *mc, *fs;
-	const char *file, *options;
-	int fstab_has_user, fstab_has_users, fstab_has_owner, fstab_has_group;
-	int ok, status = 0;
-	struct stat statbuf;
-	char *loopdev = NULL;
-
-	if (!*arg) {		/* "" would be expanded to `pwd` */
-		die(2, _("Cannot unmount \"\"\n"));
-		return 0;
-	}
-
-	file = canonicalize(arg); /* mtab paths are canonicalized */
-
-try_loopdev:
-	if (verbose > 1)
-		printf(_("Trying to unmount %s\n"), file);
-
-	mc = getmntdirbackward(file, NULL);
-	if (!mc) {
-		mc = getmntdevbackward(file, NULL);
-		if (mc) {
-			struct mntentchn *mc1;
-			char *cn;
-
-			mc1 = getmntdirbackward(mc->m.mnt_dir, NULL);
-			if (!mc1)
-				/* 'mc1' must exist, though not necessarily
-				    equals to `mc'. Otherwise we go mad. */
-				die(EX_SOFTWARE,
-				    _("umount: confused when analyzing mtab"));
-
-			cn = canonicalize(mc1->m.mnt_fsname);
-			if (cn && strcmp(file, cn)) {
-				/* Something was stacked over `file' on the
-				   same mount point. */
-				die(EX_FAIL, _("umount: cannot unmount %s -- %s is "
-				    "mounted over it on the same point"),
-				    file, mc1->m.mnt_fsname);
-			}
-			free(cn);
-		}
-	}
-	if (!mc && verbose)
-		printf(_("Could not find %s in mtab\n"), file);
-
-	/* not found in mtab - check if it is associated with some loop device
-	 * (only if it is a regular file)
-	 */
-	if (!mc && !loopdev && !stat(file, &statbuf) && S_ISREG(statbuf.st_mode)) {
-		int count = loopdev_count_by_backing_file(file, &loopdev);
-
-		if (count == 1) {
-			if (verbose)
-				printf(_("%s is associated with %s\n"),
-				       arg, loopdev);
-			file = loopdev;
-			goto try_loopdev;
-
-		} else if (count > 1)
-			fprintf(stderr, _("umount: warning: %s is associated "
-				"with more than one loop device\n"), arg);
-	}
-
-	if (mc) {
-		/*
-		 * helper - umount helper (e.g. pam_mount)
-		 */
-		 if (check_helper_umountprog(arg, mc->m.mnt_opts,
-					    "helper=", &status))
-			return status;
-	}
-
-	if (restricted) {
-		char *mtab_user = NULL;
-
-		if (!mc)
-			die(2,
-			    _("umount: %s is not mounted (according to mtab)"),
-			    file);
-		/*
-		 * uhelper - unprivileged umount helper (e.g. HAL/udisks mounts)
-		 */
-		if (check_helper_umountprog(arg, mc->m.mnt_opts,
-					    "uhelper=", &status))
-			return status;
-
-		/* The 2.4 kernel will generally refuse to mount the same
-		   filesystem on the same mount point, but will accept NFS.
-		   So, unmounting must be possible. */
-		if (!is_mounted_once(file) && strcmp(mc->m.mnt_type,"nfs"))
-			die(2,
-			    _("umount: it seems %s is mounted multiple times"),
-			    file);
-
-		/* If fstab contains the two lines
-		   /dev/sda1 /mnt/zip auto user,noauto  0 0
-		   /dev/sda4 /mnt/zip auto user,noauto  0 0
-		   then "mount /dev/sda4" followed by "umount /mnt/zip"
-		   used to fail. So, we must not look for file, but for
-		   the pair (dev,file) in fstab. */
-		fs = getfs_by_devdir(mc->m.mnt_fsname, mc->m.mnt_dir);
-		if (!fs) {
-			fs = getfs_by_dir(file);
-			if (!fs && !getfs_by_spec(file))
-				die (2,
-				     _("umount: %s is not in the fstab "
-				       "(and you are not root)"),
-				     file);
-
-			/* spec could be a file which is loop mounted */
-			if (!fs || !is_valid_loop(mc, fs))
-				die (2, _("umount: %s mount disagrees with "
-					  "the fstab"), file);
-		}
-
-		/*
-		 * User mounting and unmounting is allowed only
-		 * if fstab contains one of the options `user',
-		 * `users' or `owner' or `group'.
-		 *
-		 * The option `users' allows arbitrary users to mount
-		 * and unmount - this may be a security risk.
-		 *
-		 * The options `user', `owner' and `group' only allow
-		 * unmounting by the user that mounted (visible in mtab).
-		 */
-
-		options = fs->m.mnt_opts;
-		if (!options)
-			options = "";
-		fstab_has_user = contains(options, "user");
-		fstab_has_users = contains(options, "users");
-		fstab_has_owner = contains(options, "owner");
-		fstab_has_group = contains(options, "group");
-		ok = 0;
-
-		if (fstab_has_users)
-			ok = 1;
-
-		if (!ok && (fstab_has_user || fstab_has_owner ||
-			    fstab_has_group)) {
-			char *user = getusername();
-
-			options = mc->m.mnt_opts;
-			if (!options)
-				options = "";
-			mtab_user = get_option_value(options, "user=");
-
-			if (user && mtab_user && streq (user, mtab_user))
-				ok = 1;
-		}
-		if (!ok)
-			die (2, _("umount: only %s can unmount %s from %s"),
-			     mtab_user ? mtab_user : "root",
-			     fs->m.mnt_fsname, fs->m.mnt_dir);
-
-	}
-
-	if (mc)
-		return umount_one_bw (file, mc);
-	else
-		return umount_one (arg, arg, arg, NULL);
-}
-
-int
-main (int argc, char *argv[]) {
-	int c;
-	int all = 0;
-	char *types = NULL, *test_opts = NULL, *p;
-	int result = 0;
-
-	sanitize_env();
-	setlocale(LC_ALL, "");
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-
-	progname = argv[0];
-	if ((p = strrchr(progname, '/')) != NULL)
-		progname = p+1;
-
-	umask(022);
-
-	while ((c = getopt_long (argc, argv, "adfhlnrit:O:vV",
-				 longopts, NULL)) != -1)
-		switch (c) {
-		case 'a':		/* umount everything */
-			++all;
-			break;
-			/* fall through? */
-		case 'd':		/* do losetup -d for unmounted loop devices */
-			++delloop;
-			break;
-		case 'f':		/* force umount */
-			++force;
-			break;
-		case 'h':		/* help */
-			usage (stdout, 0);
-			break;
-		case 'l':		/* lazy umount */
-			++lazy;
-			break;
-		case 'n':		/* do not write in /etc/mtab */
-			++nomtab;
-			break;
-		case 'O':		/* specify file system options */
-			test_opts = optarg;
-			break;
-		case 'r':		/* remount read-only if umount fails */
-			++remount;
-			break;
-		case 'v':		/* make noise */
-			++verbose;
-			break;
-		case 'V':		/* version */
-			printf ("umount (%s)\n", PACKAGE_STRING);
-			exit (0);
-		case 't':		/* specify file system type */
-			types = optarg;
-			break;
-		case 'i':
-			external_allowed = 0;
-			break;
-		case 144:
-			nocanonicalize = 1;
-			break;
-		case 145:
-			fake = 1;
-			break;
-		case 0:
-			break;
-		case '?':
-		default:
-			usage (stderr, 1);
-		}
-
-	{
-		const uid_t ruid = getuid();
-		const uid_t euid = geteuid();
-
-		/* if we're really root and aren't running setuid */
-		if (((uid_t)0 == ruid) && (ruid == euid)) {
-			restricted = 0;
-		}
-	}
-
-	if (restricted &&
-	    (all || types || nomtab || force || remount || nocanonicalize ||
-	     fake)) {
-		die (2, _("umount: only root can do that"));
-	}
-
-	argc -= optind;
-	argv += optind;
-
-	atexit(unlock_mtab);
-
-#ifdef HAVE_LIBMOUNT_MOUNT
-	mnt_init_debug(0);
-#endif
-	if (all) {
-		/* nodev stuff: sysfs, usbfs, oprofilefs, ... */
-		if (types == NULL)
-			types = "noproc,nodevfs,nodevpts,nosysfs,norpc_pipefs,nonfsd";
-		result = umount_all (types, test_opts);
-	} else if (argc < 1) {
-		usage (stderr, 2);
-	} else while (argc--) {
-		result += umount_file(*argv++);
-	}
-	exit (result);		/* nonzero on at least one failure */
-}
diff --git a/mount/unmount.8 b/mount/unmount.8
new file mode 100644
index 0000000..7db695b
--- /dev/null
+++ b/mount/unmount.8
@@ -0,0 +1,180 @@
+.\" Copyright (c) 1996 Andries Brouwer
+.\" This page is somewhat derived from a page that was
+.\" (c) 1980, 1989, 1991 The Regents of the University of California
+.\" and had been heavily modified by Rik Faith and myself.
+.\"
+.\" This is free documentation; you can redistribute it and/or
+.\" modify it under the terms of the GNU General Public License as
+.\" published by the Free Software Foundation; either version 2 of
+.\" the License, or (at your option) any later version.
+.\"
+.\" The GNU General Public License's references to "object code"
+.\" and "executables" are to be interpreted as the output of any
+.\" document formatting or typesetting system, including
+.\" intermediate and printed output.
+.\"
+.\" This manual is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public License along
+.\" with this program; if not, write to the Free Software Foundation, Inc.,
+.\" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+.\"
+.TH UNMOUNT 8 "March 2010" "util-linux" "System Administration"
+.SH NAME
+unmount \- unmount file systems
+.SH SYNOPSIS
+.B unmount
+.RB [ \-hV ]
+.LP
+.B unmount \-a
+.RB [ \-dflnrv ]
+.RB [ \-t
+.IR vfstype ]
+.RB [ \-O
+.IR options ]
+.br
+.B unmount
+.RB [ \-dflnrv ]
+.RI { dir | device }...
+.SH DESCRIPTION
+The
+.B unmount
+command detaches the file system(s) mentioned from the file hierarchy.
+A file system is specified by giving the directory where it
+has been mounted. Giving the special device on which the file system lives
+may also work, but is obsolete, mainly because it will fail
+in case this device was mounted on more than one directory.
+
+Note that a file system cannot be unmounted when it is `busy' -
+for example, when there are open files on it, or when some process
+has its working directory there, or when a swap file on it is in use.
+The offending process could even be
+.B unmount
+itself - it opens libc, and libc in its turn may open for example
+locale files.
+A lazy unmount avoids this problem.
+
+Options for the
+.B unmount
+command:
+.TP
+.B \-V
+Print version and exit.
+.TP
+.B \-h
+Print help message and exit.
+.TP
+.B \-v
+Verbose mode.
+.TP
+.B \-n
+Unmount without writing in
+.IR /etc/mtab .
+.TP
+.B \-r
+In case unmounting fails, try to remount read-only.
+.TP
+.B \-d
+In case the unmounted device was a loop device, also
+free this loop device.
+.TP
+.B \-i
+Don't call the /sbin/unmount.<filesystem> helper even if it exists. By default /sbin/unmount.<filesystem> helper is called if one exists.
+.TP
+.B \-a
+All of the file systems described in
+.I /etc/mtab
+are unmounted. (With
+.B unmount
+version 2.7 and later: the
+.I proc
+filesystem is not unmounted.)
+.TP
+.BI \-t " vfstype"
+Indicate that the actions should only be taken on file systems of the
+specified type.  More than one type may be specified in a comma separated
+list.  The list of file system types can be prefixed with
+.B no
+to specify the file system types on which no action should be taken.
+.TP
+.BI \-O " options"
+Indicate that the actions should only be taken on file systems with
+the specified options in
+.IR /etc/fstab .
+More than one option type may be specified in a comma separated
+list.  Each option can be prefixed with
+.B no
+to specify options for which no action should be taken.
+.TP
+.B \-f
+Force unmount (in case of an unreachable NFS system).
+(Requires kernel 2.1.116 or later.)
+.TP
+.B \-l
+Lazy unmount. Detach the filesystem from the filesystem hierarchy now,
+and cleanup all references to the filesystem as soon as it is not busy
+anymore.
+(Requires kernel 2.4.11 or later.)
+.IP "\fB\-\-no\-canonicalize\fP"
+Don't canonicalize paths. For more details about this option see the
+.B mount(8)
+man page.
+.IP "\fB\-\-fake\fP"
+Causes everything to be done except for the actual system call; this
+``fakes'' unmounting the filesystem.  It can  be used to remove
+entries from
+.I /etc/mtab
+that were unmounted earlier with the -n option.
+
+.SH "THE LOOP DEVICE"
+The
+.B unmount
+command will free the loop device (if any) associated
+with the mount, in case it finds the option `loop=...' in
+.IR /etc/mtab ,
+or when the \-d option was given.
+Any pending loop devices can be freed using `losetup -d', see
+.BR losetup (8).
+
+.SH NOTES
+The syntax of external unmount helpers is:
+
+.br
+.BI /sbin/unmount. <suffix>
+.RI { dir | device }
+.RB [ \-nlfvr ]
+.RB [ \-t
+.IR type.subtype ]
+.br
+
+where the <suffix> is filesystem type or a value from "uhelper=" or "helper="
+mtab option.  The \-t option is used  for filesystems with subtypes support
+(for example /sbin/mount.fuse -t fuse.sshfs).
+
+The uhelper= (unprivileged unmount helper) is possible to use when non-root user
+wants to unmount a mountpoint which is not defined in the /etc/fstab file (e.g
+devices mounted by udisk).
+
+The helper= mount option redirects all unmount requests to the
+/sbin/unmount.<helper> independently on UID.
+
+.SH FILES
+.I /etc/mtab
+table of mounted file systems
+
+.SH "SEE ALSO"
+.BR unmount (2),
+.BR mount (8),
+.BR losetup (8).
+
+.SH HISTORY
+A
+.B unmount
+command appeared in Version 6 AT&T UNIX.
+.SH AVAILABILITY
+earchCompleteStop()
+
+ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/mount/unmount.c b/mount/unmount.c
new file mode 100644
index 0000000..c308443
--- /dev/null
+++ b/mount/unmount.c
@@ -0,0 +1,874 @@
+/*
+ * umount(8) for Linux 0.99 - jrs, 1993
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <getopt.h>
+#include <string.h>
+#include <errno.h>
+#include <ctype.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <sys/mount.h>
+
+#include "mount_constants.h"
+#include "sundries.h"
+#include "getusername.h"
+#include "pathnames.h"
+#include "loopdev.h"
+#include "fstab.h"
+#include "env.h"
+#include "nls.h"
+#include "strutils.h"
+
+#if defined(MNT_FORCE)
+/* Interesting ... it seems libc knows about MNT_FORCE and presumably
+   about umount2 as well -- need not do anything */
+#else /* MNT_FORCE */
+
+/* Does the present kernel source know about umount2? */
+#include <linux/unistd.h>
+#ifdef __NR_umount2
+
+static int umount2(const char *path, int flags);
+
+_syscall2(int, umount2, const char *, path, int, flags);
+
+#else /* __NR_umount2 */
+
+static int
+umount2(const char *path, int flags) {
+	fprintf(stderr, _("unmount: compiled without support for -f\n"));
+	errno = ENOSYS;
+	return -1;
+}
+#endif /* __NR_umount2 */
+
+#ifndef MNT_FORCE
+# define MNT_FORCE        0x00000001	/* Attempt to forcibily umount */
+#endif
+
+#endif /* MNT_FORCE */
+
+#ifndef MNT_DETACH
+# define MNT_DETACH       0x00000002	/* Just detach from the tree */
+#endif
+
+#ifndef UMOUNT_NOFOLLOW
+# define UMOUNT_NOFOLLOW  0x00000008	/* Don't follow symlink on umount */
+#endif
+
+#ifndef UMOUNT_UNUSED
+# define UMOUNT_UNUSED    0x80000000	/* Flag guaranteed to be unused */
+#endif
+
+
+/* True if we are allowed to call /sbin/umount.${FSTYPE} */
+int external_allowed = 1;
+
+/* Nonzero for force umount (-f).  There is kernel support since 2.1.116.  */
+int force = 0;
+
+/* Nonzero for lazy umount (-l).  There is kernel support since 2.4.11.  */
+int lazy = 0;
+
+/* When umount fails, attempt a read-only remount (-r). */
+int remount = 0;
+
+/* Don't write a entry in /etc/mtab (-n).  */
+int nomtab = 0;
+
+/* Call losetup -d for each unmounted loop device. */
+int delloop = 0;
+
+/* True if (ruid != euid) or (0 != ruid), i.e. only "user" umounts permitted. */
+int restricted = 1;
+
+/* Last error message */
+int complained_err = 0;
+char *complained_dev = NULL;
+
+/* True for fake umount (--fake).  */
+static int fake = 0;
+
+/*
+ * check_special_umountprog()
+ *	If there is a special umount program for this type, exec it.
+ * returns: 0: no exec was done, 1: exec was done, status has result
+ */
+static int
+check_special_umountprog(const char *node,
+			 const char *type, int *status) {
+	char search_path[] = FS_SEARCH_PATH;
+	char *path, umountprog[150];
+	struct stat statbuf;
+	int res;
+
+	if (!external_allowed)
+		return 0;
+
+	if (type == NULL || strcmp(type, "none") == 0)
+		return 0;
+
+	path = strtok(search_path, ":");
+	while (path) {
+		int type_opt = 0;
+
+		res = snprintf(umountprog, sizeof(umountprog), "%s/umount.%s",
+			       path, type);
+		path = strtok(NULL, ":");
+		if (res < 0 || (size_t) res >= sizeof(umountprog))
+			continue;
+
+		res = stat(umountprog, &statbuf);
+		if (res == -1 && errno == ENOENT && strchr(type, '.')) {
+			/* If type ends with ".subtype" try without it */
+			*strrchr(umountprog, '.') = '\0';
+			type_opt = 1;
+			res = stat(umountprog, &statbuf);
+		}
+		if (res == 0) {
+			res = fork();
+			if (res == 0) {
+				char *umountargs[10];
+				int i = 0;
+
+				if(setgid(getgid()) < 0)
+					die(EX_FAIL, _("unmount: cannot set group id: %m"));
+
+				if(setuid(getuid()) < 0)
+					die(EX_FAIL, _("unmount: cannot set user id: %m"));
+
+				umountargs[i++] = umountprog;
+				umountargs[i++] = xstrdup(node);
+				if (nomtab)
+					umountargs[i++] = "-n";
+				if (lazy)
+					umountargs[i++] = "-l";
+				if (force)
+					umountargs[i++] = "-f";
+				if (verbose)
+					umountargs[i++] = "-v";
+				if (remount)
+					umountargs[i++] = "-r";
+				if (type_opt) {
+					umountargs[i++] = "-t";
+					umountargs[i++] = (char *) type;
+				}
+				umountargs[i] = NULL;
+				execv(umountprog, umountargs);
+				exit(1);	/* exec failed */
+			} else if (res != -1) {
+				int st;
+				wait(&st);
+				*status = (WIFEXITED(st) ? WEXITSTATUS(st)
+					   : EX_SYSERR);
+				return 1;
+			} else {
+				int errsv = errno;
+				error(_("unmount: cannot fork: %s"),
+				      strerror(errsv));
+			}
+		}
+	}
+	return 0;
+}
+
+/* complain about a failed umount */
+static void complain(int err, const char *dev) {
+
+  if (complained_err == err && complained_dev && dev &&
+		  strcmp(dev, complained_dev) == 0)
+    return;
+
+  complained_err = err;
+  free(complained_dev);
+  complained_dev = xstrdup(dev);
+
+  switch (err) {
+    case ENXIO:
+      error (_("unmount: %s: invalid block device"), dev); break;
+    case EINVAL:
+      error (_("unmount: %s: not mounted"), dev); break;
+    case EIO:
+      error (_("unmount: %s: can't write superblock"), dev); break;
+    case EBUSY:
+     /* Let us hope fstab has a line "proc /proc ..."
+	and not "none /proc ..."*/
+      error (_("unmount: %s: device is busy.\n"
+	       "        (In some cases useful info about processes that use\n"
+	       "         the device is found by lsof(8) or fuser(1))"), dev);
+      break;
+    case ENOENT:
+      error (_("unmount: %s: not found"), dev); break;
+    case EPERM:
+      error (_("unmount: %s: must be superuser to unmount"), dev); break;
+    case EACCES:
+      error (_("unmount: %s: block devices not permitted on fs"), dev); break;
+    default:
+      error (_("unmount: %s: %s"), dev, strerror (err)); break;
+  }
+}
+
+/* Check whether the kernel supports UMOUNT_NOFOLLOW flag */
+static int umount_nofollow_support(void)
+{
+	int res = umount2("", UMOUNT_UNUSED);
+	if (res != -1 || errno != EINVAL)
+		return 0;
+
+	res = umount2("", UMOUNT_NOFOLLOW);
+	if (res != -1 || errno != ENOENT)
+		return 0;
+
+	return 1;
+}
+
+static const char *chdir_to_parent(const char *node, char **resbuf)
+{
+	char *tmp, *res;
+	const char *parent;
+	char buf[65536];
+
+	*resbuf = xstrdup(node);
+
+	tmp = strrchr(*resbuf, '/');
+	if (!tmp)
+		die (2, _("unmount: internal error: invalid abs path: %s"), node);
+
+	if (tmp != *resbuf) {
+		*tmp = '\0';
+		res = tmp + 1;
+		parent = *resbuf;
+	} else if (tmp[1] != '\0') {
+		res = tmp + 1;
+		parent = "/";
+	} else {
+		res = ".";
+		parent = "/";
+	}
+
+	if (chdir(parent) == -1)
+		die (2, _("unmount: failed to chdir to %s: %m"), parent);
+
+	if (!getcwd(buf, sizeof(buf)))
+		die (2, _("unmount: failed to obtain current directory: %m"));
+
+	if (strcmp(buf, parent) != 0)
+		die (2, _("unmount: mountpoint moved (%s -> %s)"), parent, buf);
+
+	if (verbose)
+		printf(_("current directory moved to %s\n"), res);
+
+	return res;
+}
+
+/* Umount a single device.  Return a status code, so don't exit
+   on a non-fatal error.  We lock/unlock around each umount.  */
+static int
+umount_one (const char *spec, const char *node, const char *type,
+	    struct mntentchn *mc) {
+	int umnt_err = 0;
+	int isroot;
+	int res = 0;
+	int status;
+	int extra_flags = 0;
+	const char *loopdev, *target = node;
+	char *targetbuf = NULL;
+	int myloop = 0;
+
+	/* Special case for root.  As of 0.99pl10 we can (almost) unmount root;
+	   the kernel will remount it readonly so that we can carry on running
+	   afterwards.  The readonly remount is illegal if any files are opened
+	   for writing at the time, so we can't update mtab for an unmount of
+	   root.  As it is only really a remount, this doesn't matter too
+	   much.  [sct May 29, 1993] */
+	isroot = (streq (node, "/") || streq (node, "root")
+		  || streq (node, "rootfs"));
+	if (isroot)
+		nomtab++;
+
+	/*
+	 * Call umount.TYPE for types that require a separate umount program.
+	 * All such special things must occur isolated in the types string.
+	 */
+	if (check_special_umountprog(node, type, &status))
+		return status;
+
+	block_signals(SIG_BLOCK);
+
+	/* Skip the actual umounting for --fake */
+	if (fake)
+		goto writemtab;
+	/*
+	 * Ignore the option "-d" for non-loop devices and loop devices with
+	 * LO_FLAGS_AUTOCLEAR flag.
+	 */
+	if (delloop && is_loopdev(spec))
+		myloop = 1;
+
+	if (restricted) {
+		if (umount_nofollow_support())
+			extra_flags |= UMOUNT_NOFOLLOW;
+
+		/* call umount(2) with relative path to avoid races */
+		target = chdir_to_parent(node, &targetbuf);
+	}
+
+	if (lazy) {
+		res = umount2 (target, MNT_DETACH | extra_flags);
+		if (res < 0)
+			umnt_err = errno;
+		goto writemtab;
+	}
+
+	if (force) {		/* only supported for NFS */
+		res = umount2 (target, MNT_FORCE | extra_flags);
+		if (res == -1) {
+			int errsv = errno;
+			perror("umount2");
+			errno = errsv;
+			if (errno == ENOSYS) {
+				if (verbose)
+					printf(_("no umount2, trying umount...\n"));
+				res = umount (target);
+			}
+		}
+	} else if (extra_flags)
+		res = umount2 (target, extra_flags);
+	else
+		res = umount (target);
+
+	free(targetbuf);
+
+	if (res < 0)
+		umnt_err = errno;
+
+	if (res < 0 && remount && umnt_err == EBUSY) {
+		/* Umount failed - let us try a remount */
+		res = mount(spec, node, NULL,
+			    MS_MGC_VAL | MS_REMOUNT | MS_RDONLY, NULL);
+		if (res == 0) {
+			fprintf(stderr,
+				_("unmount: %s busy - remounted read-only\n"),
+				spec);
+			if (mc && !nomtab) {
+				/* update mtab if the entry is there */
+				struct my_mntent remnt;
+				remnt.mnt_fsname = mc->m.mnt_fsname;
+				remnt.mnt_dir = mc->m.mnt_dir;
+				remnt.mnt_type = mc->m.mnt_type;
+				remnt.mnt_opts = "ro";
+				remnt.mnt_freq = 0;
+				remnt.mnt_passno = 0;
+				update_mtab(node, &remnt);
+			}
+			block_signals(SIG_UNBLOCK);
+			return 0;
+		} else if (errno != EBUSY) { 	/* hmm ... */
+			perror("remount");
+			fprintf(stderr,
+				_("unmount: could not remount %s read-only\n"),
+				spec);
+		}
+	}
+
+	loopdev = 0;
+	if (res >= 0) {
+		/* Umount succeeded */
+		if (verbose)
+			printf (_("%s has been unmounted\n"), spec);
+
+		/* Free any loop devices that we allocated ourselves */
+		if (mc) {
+			char *optl;
+
+			/* old style mtab line? */
+			if (streq(mc->m.mnt_type, "loop")) {
+				loopdev = spec;
+				goto gotloop;
+			}
+
+			/* new style mtab line? */
+			optl = mc->m.mnt_opts ? xstrdup(mc->m.mnt_opts) : "";
+			for (optl = strtok (optl, ","); optl;
+			     optl = strtok (NULL, ",")) {
+				if (!strncmp(optl, "loop=", 5)) {
+					loopdev = optl+5;
+					goto gotloop;
+				}
+			}
+		} else {
+			/*
+			 * If option "-o loop=spec" occurs in mtab,
+			 * note the mount point, and delete mtab line.
+			 */
+			if ((mc = getmntoptfile (spec)) != NULL)
+				node = mc->m.mnt_dir;
+		}
+
+		/* Also free loop devices when -d flag is given */
+		if (myloop)
+			loopdev = spec;
+	}
+ gotloop:
+	if (loopdev && !loopdev_is_autoclear(loopdev))
+		loopdev_delete(loopdev);
+
+ writemtab:
+	if (!nomtab &&
+	    (umnt_err == 0 || umnt_err == EINVAL || umnt_err == ENOENT)) {
+#ifdef HAVE_LIBMOUNT_MOUNT
+		struct libmnt_update *upd = mnt_new_update();
+
+		if (upd && !mnt_update_set_fs(upd, 0, node, NULL))
+			mnt_update_table(upd, NULL);
+
+		mnt_free_update(upd);
+#else
+		update_mtab (node, NULL);
+#endif
+	}
+
+	block_signals(SIG_UNBLOCK);
+
+	if (res >= 0)
+		return 0;
+	if (umnt_err)
+		complain(umnt_err, node);
+	return 1;
+}
+
+/*
+ * umount_one_bw: unmount FILE that has last occurrence MC0
+ *
+ * Why this loop?
+ * 1. People who boot a system with a bad fstab root entry
+ *    will get an incorrect "/dev/foo on /" in mtab.
+ *    If later /dev/foo is actually mounted elsewhere,
+ *    it will occur twice in mtab.
+ * 2. With overmounting one can get the situation that
+ *    the same filename is used as mount point twice.
+ * In both cases, it is best to try the last occurrence first.
+ */
+static int
+umount_one_bw (const char *file, struct mntentchn *mc0) {
+	struct mntentchn *mc;
+	int res = 1;
+
+	mc = mc0;
+	while (res && mc) {
+		res = umount_one(mc->m.mnt_fsname, mc->m.mnt_dir,
+				 mc->m.mnt_type, mc);
+		mc = getmntdirbackward(file, mc);
+	}
+	mc = mc0;
+	while (res && mc) {
+		res = umount_one(mc->m.mnt_fsname, mc->m.mnt_dir,
+				 mc->m.mnt_type, mc);
+		mc = getmntdevbackward(file, mc);
+	}
+	return res;
+}
+
+/* Unmount all filesystems of type VFSTYPES found in mtab.  Since we are
+   concurrently updating mtab after every successful umount, we have to
+   slurp in the entire file before we start.  This isn't too bad, because
+   in any case it's important to umount mtab entries in reverse order
+   to mount, e.g. /usr/spool before /usr.  */
+static int
+umount_all (char *types, char *test_opts) {
+     struct mntentchn *mc, *hd;
+     int errors = 0;
+
+     hd = mtab_head();
+     if (!hd->prev)
+	  die (2, _("unmount: cannot find list of filesystems to unmount"));
+     for (mc = hd->prev; mc != hd; mc = mc->prev) {
+	  if (matching_type (mc->m.mnt_type, types)
+	      && matching_opts (mc->m.mnt_opts, test_opts)) {
+	       errors |= umount_one (mc->m.mnt_fsname, mc->m.mnt_dir,
+				     mc->m.mnt_type, mc);
+	  }
+     }
+
+     return errors;
+}
+
+static struct option longopts[] =
+{
+  { "all", 0, 0, 'a' },
+  { "force", 0, 0, 'f' },
+  { "help", 0, 0, 'h' },
+  { "no-mtab", 0, 0, 'n' },
+  { "test-opts", 1, 0, 'O' },
+  { "verbose", 0, 0, 'v' },
+  { "version", 0, 0, 'V' },
+  { "read-only", 0, 0, 'r' },
+  { "types", 1, 0, 't' },
+
+  { "no-canonicalize", 0, 0, 144 },
+  { "fake", 0, 0, 145 },
+  { NULL, 0, 0, 0 }
+};
+
+static void
+usage (FILE *fp, int n)
+{
+  fprintf (fp, _("Usage: unmount -h | -V\n"
+	       "       unmount -a [-d] [-f] [-r] [-n] [-v] [-t vfstypes] [-O opts]\n"
+	       "       unmount [-d] [-f] [-r] [-n] [-v] special | node...\n"));
+  exit (n);
+}
+
+/*
+ * Look for an option in a comma-separated list
+ */
+static int
+contains(const char *list, const char *s) {
+	int n = strlen(s);
+
+	while (list && *list) {
+		if (strncmp(list, s, n) == 0 &&
+		    (list[n] == 0 || list[n] == ','))
+			return 1;
+		while (*list && *list++ != ',') ;
+	}
+	return 0;
+}
+
+/* check if @mc contains a loop device which is associated
+ * with the @file in fs
+ */
+static int
+is_valid_loop(struct mntentchn *mc, struct mntentchn *fs)
+{
+	uintmax_t offset = 0;
+	char *p;
+
+	/* check if it begins with /dev/loop */
+	if (strncmp(mc->m.mnt_fsname, _PATH_DEV_LOOP,
+				sizeof(_PATH_DEV_LOOP) - 1))
+		return 0;
+
+	/* check for loop option in fstab */
+	if (!contains(fs->m.mnt_opts, "loop"))
+		return 0;
+
+	/* check for offset option in fstab */
+	p = get_option_value(fs->m.mnt_opts, "offset=");
+	if (p && strtosize(p, &offset)) {
+		if (verbose > 1)
+			printf(_("failed to parse 'offset=%s' options\n"), p);
+		return 0;
+	}
+
+	/* check association */
+	if (loopdev_is_used((char *) mc->m.mnt_fsname, fs->m.mnt_fsname,
+				offset, LOOPDEV_FL_OFFSET) == 1) {
+		if (verbose > 1)
+			printf(_("device %s is associated with %s\n"),
+			       mc->m.mnt_fsname, fs->m.mnt_fsname);
+		return 1;
+	}
+
+	if (verbose > 1)
+		printf(_("device %s is not associated with %s\n"),
+		       mc->m.mnt_fsname, fs->m.mnt_fsname);
+	return 0;
+}
+
+/*
+ * umount helper call based on {u,p}helper= mount option
+ */
+static int check_helper_umountprog(const char *node,
+				   const char *opts, const char *name,
+				   int *status)
+{
+	char *helper;
+
+	if (!external_allowed || !opts)
+		return 0;
+
+	helper = get_option_value(opts, name);
+	if (helper)
+		return check_special_umountprog(node, helper, status);
+
+	return 0;
+}
+
+static int
+umount_file (char *arg) {
+	struct mntentchn *mc, *fs;
+	const char *file, *options;
+	int fstab_has_user, fstab_has_users, fstab_has_owner, fstab_has_group;
+	int ok, status = 0;
+	struct stat statbuf;
+	char *loopdev = NULL;
+
+	if (!*arg) {		/* "" would be expanded to `pwd` */
+		die(2, _("Cannot unmount \"\"\n"));
+		return 0;
+	}
+
+	file = canonicalize(arg); /* mtab paths are canonicalized */
+
+try_loopdev:
+	if (verbose > 1)
+		printf(_("Trying to unmount %s\n"), file);
+
+	mc = getmntdirbackward(file, NULL);
+	if (!mc) {
+		mc = getmntdevbackward(file, NULL);
+		if (mc) {
+			struct mntentchn *mc1;
+			char *cn;
+
+			mc1 = getmntdirbackward(mc->m.mnt_dir, NULL);
+			if (!mc1)
+				/* 'mc1' must exist, though not necessarily
+				    equals to `mc'. Otherwise we go mad. */
+				die(EX_SOFTWARE,
+				    _("unmount: confused when analyzing mtab"));
+
+			cn = canonicalize(mc1->m.mnt_fsname);
+			if (cn && strcmp(file, cn)) {
+				/* Something was stacked over `file' on the
+				   same mount point. */
+				die(EX_FAIL, _("unmount: cannot unmount %s -- %s is "
+				    "mounted over it on the same point"),
+				    file, mc1->m.mnt_fsname);
+			}
+			free(cn);
+		}
+	}
+	if (!mc && verbose)
+		printf(_("Could not find %s in mtab\n"), file);
+
+	/* not found in mtab - check if it is associated with some loop device
+	 * (only if it is a regular file)
+	 */
+	if (!mc && !loopdev && !stat(file, &statbuf) && S_ISREG(statbuf.st_mode)) {
+		int count = loopdev_count_by_backing_file(file, &loopdev);
+
+		if (count == 1) {
+			if (verbose)
+				printf(_("%s is associated with %s\n"),
+				       arg, loopdev);
+			file = loopdev;
+			goto try_loopdev;
+
+		} else if (count > 1)
+			fprintf(stderr, _("unmount: warning: %s is associated "
+				"with more than one loop device\n"), arg);
+	}
+
+	if (mc) {
+		/*
+		 * helper - umount helper (e.g. pam_mount)
+		 */
+		 if (check_helper_umountprog(arg, mc->m.mnt_opts,
+					    "helper=", &status))
+			return status;
+	}
+
+	if (restricted) {
+		char *mtab_user = NULL;
+
+		if (!mc)
+			die(2,
+			    _("unmount: %s is not mounted (according to mtab)"),
+			    file);
+		/*
+		 * uhelper - unprivileged umount helper (e.g. HAL/udisks mounts)
+		 */
+		if (check_helper_umountprog(arg, mc->m.mnt_opts,
+					    "uhelper=", &status))
+			return status;
+
+		/* The 2.4 kernel will generally refuse to mount the same
+		   filesystem on the same mount point, but will accept NFS.
+		   So, unmounting must be possible. */
+		if (!is_mounted_once(file) && strcmp(mc->m.mnt_type,"nfs"))
+			die(2,
+			    _("unmount: it seems %s is mounted multiple times"),
+			    file);
+
+		/* If fstab contains the two lines
+		   /dev/sda1 /mnt/zip auto user,noauto  0 0
+		   /dev/sda4 /mnt/zip auto user,noauto  0 0
+		   then "mount /dev/sda4" followed by "umount /mnt/zip"
+		   used to fail. So, we must not look for file, but for
+		   the pair (dev,file) in fstab. */
+		fs = getfs_by_devdir(mc->m.mnt_fsname, mc->m.mnt_dir);
+		if (!fs) {
+			fs = getfs_by_dir(file);
+			if (!fs && !getfs_by_spec(file))
+				die (2,
+				     _("unmount: %s is not in the fstab "
+				       "(and you are not root)"),
+				     file);
+
+			/* spec could be a file which is loop mounted */
+			if (!fs || !is_valid_loop(mc, fs))
+				die (2, _("unmount: %s mount disagrees with "
+					  "the fstab"), file);
+		}
+
+		/*
+		 * User mounting and unmounting is allowed only
+		 * if fstab contains one of the options `user',
+		 * `users' or `owner' or `group'.
+		 *
+		 * The option `users' allows arbitrary users to mount
+		 * and unmount - this may be a security risk.
+		 *
+		 * The options `user', `owner' and `group' only allow
+		 * unmounting by the user that mounted (visible in mtab).
+		 */
+
+		options = fs->m.mnt_opts;
+		if (!options)
+			options = "";
+		fstab_has_user = contains(options, "user");
+		fstab_has_users = contains(options, "users");
+		fstab_has_owner = contains(options, "owner");
+		fstab_has_group = contains(options, "group");
+		ok = 0;
+
+		if (fstab_has_users)
+			ok = 1;
+
+		if (!ok && (fstab_has_user || fstab_has_owner ||
+			    fstab_has_group)) {
+			char *user = getusername();
+
+			options = mc->m.mnt_opts;
+			if (!options)
+				options = "";
+			mtab_user = get_option_value(options, "user=");
+
+			if (user && mtab_user && streq (user, mtab_user))
+				ok = 1;
+		}
+		if (!ok)
+			die (2, _("unmount: only %s can unmount %s from %s"),
+			     mtab_user ? mtab_user : "root",
+			     fs->m.mnt_fsname, fs->m.mnt_dir);
+
+	}
+
+	if (mc)
+		return umount_one_bw (file, mc);
+	else
+		return umount_one (arg, arg, arg, NULL);
+}
+
+int
+main (int argc, char *argv[]) {
+	int c;
+	int all = 0;
+	char *types = NULL, *test_opts = NULL, *p;
+	int result = 0;
+
+	sanitize_env();
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+
+	progname = argv[0];
+	if ((p = strrchr(progname, '/')) != NULL)
+		progname = p+1;
+
+	umask(022);
+
+	while ((c = getopt_long (argc, argv, "adfhlnrit:O:vV",
+				 longopts, NULL)) != -1)
+		switch (c) {
+		case 'a':		/* umount everything */
+			++all;
+			break;
+			/* fall through? */
+		case 'd':		/* do losetup -d for unmounted loop devices */
+			++delloop;
+			break;
+		case 'f':		/* force umount */
+			++force;
+			break;
+		case 'h':		/* help */
+			usage (stdout, 0);
+			break;
+		case 'l':		/* lazy umount */
+			++lazy;
+			break;
+		case 'n':		/* do not write in /etc/mtab */
+			++nomtab;
+			break;
+		case 'O':		/* specify file system options */
+			test_opts = optarg;
+			break;
+		case 'r':		/* remount read-only if umount fails */
+			++remount;
+			break;
+		case 'v':		/* make noise */
+			++verbose;
+			break;
+		case 'V':		/* version */
+			printf ("unmount (%s)\n", PACKAGE_STRING);
+			exit (0);
+		case 't':		/* specify file system type */
+			types = optarg;
+			break;
+		case 'i':
+			external_allowed = 0;
+			break;
+		case 144:
+			nocanonicalize = 1;
+			break;
+		case 145:
+			fake = 1;
+			break;
+		case 0:
+			break;
+		case '?':
+		default:
+			usage (stderr, 1);
+		}
+
+	{
+		const uid_t ruid = getuid();
+		const uid_t euid = geteuid();
+
+		/* if we're really root and aren't running setuid */
+		if (((uid_t)0 == ruid) && (ruid == euid)) {
+			restricted = 0;
+		}
+	}
+
+	if (restricted &&
+	    (all || types || nomtab || force || remount || nocanonicalize ||
+	     fake)) {
+		die (2, _("unmount: only root can do that"));
+	}
+
+	argc -= optind;
+	argv += optind;
+
+	atexit(unlock_mtab);
+
+#ifdef HAVE_LIBMOUNT_MOUNT
+	mnt_init_debug(0);
+#endif
+	if (all) {
+		/* nodev stuff: sysfs, usbfs, oprofilefs, ... */
+		if (types == NULL)
+			types = "noproc,nodevfs,nodevpts,nosysfs,norpc_pipefs,nonfsd";
+		result = umount_all (types, test_opts);
+	} else if (argc < 1) {
+		usage (stderr, 2);
+	} else while (argc--) {
+		result += umount_file(*argv++);
+	}
+	exit (result);		/* nonzero on at least one failure */
+}
diff --git a/sys-utils/Makefile.am b/sys-utils/Makefile.am
index 83f38cf..c9db459 100644
--- a/sys-utils/Makefile.am
+++ b/sys-utils/Makefile.am
@@ -81,8 +81,8 @@ if BUILD_NEW_MOUNT
 # The original (stable) mount is in mount/ directory
 # -- temporary we share some man pages
 #
-bin_PROGRAMS += mount umount
-dist_man_MANS += mount.8 ../mount/fstab.5 ../mount/umount.8
+bin_PROGRAMS += mount unmount
+dist_man_MANS += mount.8 ../mount/fstab.5 ../mount/unmount.8
 
 mount_SOURCES = \
 	mount.c \
@@ -94,10 +94,10 @@ mount_LDADD = $(ul_libmount_la) $(SELINUX_LIBS)
 mount_CFLAGS = $(SUID_CFLAGS) $(AM_CFLAGS) -I$(ul_libmount_incdir)
 mount_LDFLAGS = $(SUID_LDFLAGS) $(AM_LDFLAGS)
 
-umount_SOURCES = umount.c $(top_srcdir)/lib/env.c
-umount_LDADD = $(ul_libmount_la)
-umount_CFLAGS = $(AM_CFLAGS) $(SUID_CFLAGS) -I$(ul_libmount_incdir)
-umount_LDFLAGS = $(SUID_LDFLAGS) $(AM_LDFLAGS)
+unmount_SOURCES = unmount.c $(top_srcdir)/lib/env.c
+unmount_LDADD = $(ul_libmount_la)
+unmount_CFLAGS = $(AM_CFLAGS) $(SUID_CFLAGS) -I$(ul_libmount_incdir)
+unmount_LDFLAGS = $(SUID_LDFLAGS) $(AM_LDFLAGS)
 
 if HAVE_STATIC_MOUNT
 bin_PROGRAMS += mount.static
@@ -107,12 +107,12 @@ mount_static_LDFLAGS = $(mount_LDFLAGS) -all-static
 mount_static_LDADD = $(mount_LDADD) $(SELINUX_LIBS_STATIC)
 endif
 
-if HAVE_STATIC_UMOUNT
-bin_PROGRAMS += umount.static
-umount_static_SOURCES = $(umount_SOURCES)
-umount_static_CFLAGS = $(umount_CFLAGS)
-umount_static_LDFLAGS = $(umount_LDFLAGS) -all-static
-umount_static_LDADD = $(umount_LDADD)
+if HAVE_STATIC_UNMOUNT
+bin_PROGRAMS += unmount.static
+unmount_static_SOURCES = $(unmount_SOURCES)
+unmount_static_CFLAGS = $(unmount_CFLAGS)
+unmount_static_LDFLAGS = $(unmount_LDFLAGS) -all-static
+unmount_static_LDADD = $(unmount_LDADD)
 endif
 endif # BUILD_NEW_MOUNT
 
@@ -241,7 +241,7 @@ endif
 if BUILD_NEW_MOUNT
 if MAKEINSTALL_DO_SETUID
 	chmod 4755 $(DESTDIR)$(bindir)/mount
-	chmod 4755 $(DESTDIR)$(bindir)/umount
+	chmod 4755 $(DESTDIR)$(bindir)/unmount
 endif
 endif
 	for I in $(SETARCH_LINKS); do \
-- 
1.7.7

