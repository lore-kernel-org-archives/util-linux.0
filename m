Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50467 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab2LJMjm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Dec 2012 07:39:42 -0500
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id A22DEA500D
	for <util-linux@vger.kernel.org>; Mon, 10 Dec 2012 13:39:41 +0100 (CET)
From: Werner Fink <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Werner Fink <werner@suse.de>
Subject: [PATCH 4/5] sulogin: mount temporary /dev and /proc if not found
Date: Mon, 10 Dec 2012 13:27:10 +0100
Message-Id: <1355142431-8199-1-git-send-email-werner@suse.de>
In-Reply-To: <20121207170118.GG603@rampage>
References: <20121207170118.GG603@rampage>
In-Reply-To: <20121207170118.GG603@rampage>
References: <20121207170118.GG603@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 07, 2012 at 12:01:18PM -0500, Dave Reisner wrote:
>
> If you're in the initramfs, rootfs is tmpfs. Won't your statfs check
> return a buffer which has f_type == TMPFS_MAGIC even if /dev is not
> mounted?

Indeed it could be a poroblem, therefore I've moved the stuff to lib/conosle.c
and switch over to device comparission as you suggested.  Also if /dev has
been mounted by this code I'll also create missing nodes during scan of e.g.
/proc/consoles

On Fri, Dec 07, 2012 at 09:00:57AM +0100, Werner Fink wrote:
> 
> This is very usefull if initrd can not loaded that is no /dev and no
> /proc is found.  Also if the /etc/shadow and /etc/passwd is copied into
> the initrd the sulogin can be used in initrd even before /dev and/or /proc
> are mounted.


Signed-off-by: Werner Fink <werner@suse.de>
---
 configure.ac   |   10 +++++++++
 lib/consoles.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git configure.ac configure.ac
index 3be3715..631002f 100644
--- configure.ac
+++ configure.ac
@@ -1296,6 +1296,16 @@ if test "x$enable_use_tty_group" = xyes; then
   AC_DEFINE(USE_TTY_GROUP, 1, [Should wall and write be installed setgid tty?])
 fi
 
+AC_ARG_ENABLE([use-emergency-dev],
+  AS_HELP_STRING([--disable-use-emergency-dev], [do not use emergency mount of /dev and /proc for sulogin]),
+  [], enable_use_emergency_dev=yes
+)
+AM_CONDITIONAL(USE_EMERGENCY_DEV, test "x$enable_use_emergency_dev" = xyes)
+
+if test "x$enable_use_emergency_dev" = xyes; then
+  AC_DEFINE(USE_EMERGENCY_DEV, 1, [Should sulogin use a emergency mount of /dev and /proc?])
+fi
+
 AC_ARG_ENABLE([makeinstall-chown],
   AS_HELP_STRING([--disable-makeinstall-chown], [do not do chown-like operations during "make install"]),
   [], enable_makeinstall_chown=yes
diff --git lib/consoles.c lib/consoles.c
index 38c8208..9f0617a 100644
--- lib/consoles.c
+++ lib/consoles.c
@@ -39,6 +39,16 @@
 #include <dirent.h>
 #include <unistd.h>
 
+#ifdef USE_EMERGENCY_DEV
+# include <sys/mount.h>
+# include <linux/fs.h>
+# include <linux/magic.h>
+# include <linux/major.h>
+# ifndef MNT_DETACH
+#  define MNT_DETACH   2
+# endif
+#endif
+
 #include "c.h"
 #include "canonicalize.h"
 #include "consoles.h"
@@ -77,6 +87,57 @@ dbgprint(const char *mesg, ...)
 	fputc('\n', stderr);
 }
 
+#ifdef USE_EMERGENCY_DEV
+/*
+ * Make C library standard calls such like ttyname(3) work
+ * even if the system does not show any of the standard
+ * directories.
+ */
+
+static uint32_t mounts;
+# define MNT_PROCFS    0x0001
+# define MNT_DEVTMPFS  0x0002
+
+static __attribute__((__destructor__)) void putmounts(void)
+{
+	if (mounts & MNT_DEVTMPFS)
+		umount2("/dev", MNT_DETACH);
+	if (mounts & MNT_PROCFS)
+		umount2("/proc", MNT_DETACH);
+}
+
+# define dovoid(f)     if ((f)){}
+static __attribute__((__constructor__)) void getmounts(void)
+{
+	struct stat rt;
+	struct stat xt;
+	if (mounts) {
+		mounts = 0;
+		return;
+	}
+	if (stat("/", &rt) != 0) {
+		warn("can not get file status of root file system\n");
+		return;
+	}
+	if (stat("/proc", &xt) == 0 && rt.st_dev == xt.st_dev) {
+		if (mount("proc", "/proc", "proc", MS_RELATIME, NULL) == 0)
+			mounts |= MNT_PROCFS;
+	}
+	if (stat("/dev", &xt) == 0 && rt.st_dev == xt.st_dev) {
+		if (mount("devtmpfs", "/dev", "devtmpfs", MS_RELATIME, "mode=0755,nr_inodes=0") == 0) {
+			mounts |= MNT_DEVTMPFS;
+			(void)mknod("/dev/console", S_IFCHR|S_IRUSR|S_IWUSR, makedev(TTYAUX_MAJOR, 1));
+			if (symlink("/proc/self/fd", "/dev/fd") == 0) {
+				dovoid(symlink("fd/0", "/dev/stdin"));
+				dovoid(symlink("fd/1", "/dev/stdout"));
+				dovoid(symlink("fd/2", "/dev/stderr"));
+			}
+		}
+	}
+}
+# undef dovoid
+#endif
+
 /*
  * Read and allocate one line from file,
  * the caller has to free the result
@@ -182,6 +243,11 @@ char* scandev(DIR *dir, dev_t comparedev)
 			continue;
 		if ((size_t)snprintf(path, sizeof(path), "/dev/%s", dent->d_name) >= sizeof(path))
 			continue;
+#ifdef USE_EMERGENCY_DEV
+		if (mounts & MNT_DEVTMPFS)
+			(void)mknod(path, S_IFCHR|S_IRUSR|S_IWUSR, comparedev);
+#endif
+
 		name = canonicalize_path(path);
 		break;
 	}
-- 
1.7.10.4
