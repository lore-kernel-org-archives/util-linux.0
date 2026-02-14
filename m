Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C5F26299
	for <util-linux@vger.kernel.org>; Sat, 14 Feb 2026 03:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771039446; cv=none; b=p3tdqxE0ddWKP0RewL3MydAo01IF+faXMtG0hP6Vg+sZElNsCKo+xUgg6A89h4fuTgAzL6aAmwE/OCABOFs/YgVrG7jSAnbQTHpEhlX0fFLvz49AKrKRAdIpi+OOLyCrLTfHsP5HZiFYnJUizOr9PTRCu6wJJrrGz3rkSLOg6d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771039446; c=relaxed/simple;
	bh=PZE2Hdifep6xxREiQfnvI6AX7san6pPUf+WbMdE7hVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QEfO013mlV9GyAJJV2rd3Tag6M5TVslK/Uj5YtF0M2EmkBFtBDQEUzOWUpi5Ft4mFvrqw9Haog60Qw5M2MotAXqNdXsaSnbOItFl/6km+WwzLnIXoxoojZZMq2yMcezrnm97UJ7lgZzG/QdQuT3YPReJ9ACRB04XIaDjQcKxxM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtFX1/ai; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtFX1/ai"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c61343f82d7so566651a12.1
        for <util-linux@vger.kernel.org>; Fri, 13 Feb 2026 19:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771039444; x=1771644244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NrxmtvltS+fw2MlYhfc+f10DEtLVUerSa4HFfK38ULw=;
        b=DtFX1/aivhAnL8IxPNUsC8IHeJTwa4BMh3Rss6WyfNM/WAoXNVbElJPaZWN4DKHf8K
         zjc+lI5/JTyFDcrQJAwAr71y+0nFMong+X+5MGY9t30js7mT6qbnbluJ5VWJGcs+iOHc
         4h4xwMkv1co/dM9dy2vXn9inuLxv0Dan5HJwFHqyoSwDGGZ/D9jZgFHCuSQlfVorG8Me
         65jGBAIcK4DhGKRCyfaj5v66McoV+P83Aut+OPYi8a3Fw/UAqOD2K7TNk+rKKbDacDIe
         S4Ra3rQQXsexwpoYMm8nfhrvbDmAPDtqdxN4WgAwS61TimlOMqGd58EJ7u8myhZTHbP/
         +XFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771039444; x=1771644244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrxmtvltS+fw2MlYhfc+f10DEtLVUerSa4HFfK38ULw=;
        b=mRu7XljkN4GBfTuLceWdGBvU9WdmxWACfttuSrDPYH+rua0nXzBI9Mrsj54sOEEi3B
         +D/VVgDNSznyvZc+UAf67tLPdr0Bk1p1yzAj+ZW6plUmEKgNMK1fsy5leimTSNDDzqCY
         lgDu+Uitt4X4G+cKz5JRYkU7FIFygmbl0vdA0/q8Jj9JJMP8Vbyc98b+wEO4fLXpNkp8
         4iiAjZ34kFxwNq0hICypyYDHLfn0qrYgjnUlvYIcUhkIBrFZA5zqOk0in6wNzTbji3mK
         eB3q8cn9a3tOFpHA1SrCMHg6H04cFI8q2BGEW2JkOXwZHtY2LevL85nGOrySDYYx3UId
         tJyQ==
X-Gm-Message-State: AOJu0Yzxm7LxPImqv0R/k4RA+96LJ8oNiTeFg0JWi6DUpBlOJTsV7lZr
	U7lyh2Dw3/FZTRemcy1r/1QEM334aG2ZTLiUfYcjIEyeU5IpNZNKf7MKZHuyc6eQ
X-Gm-Gg: AZuq6aIVEayqxjkqjaTGJPrKBkRP4LuDjSa7ZByuEN71iEK69sL2XjaOQPfBhFfKgt/
	2oloENa9uVIyO5tGdNyJN360sNzUyMxQCzF+oN3GA6d/eCs1EaBcSmsfEhyn6s5aFgx51+OmMWD
	aOuEWu43HZlu8QjD9RlyJi9r6uqeqwTV8On4LPtgkW1oI4SI6olDse06/0H1BcoXfIaIC31qonC
	PYSZuMsSFiX73u6iYByM1ocGv010lPHukcpiW1GDs7bgym+JkDI9tRanHKtfbMmU1fCgXrha4jv
	9qKbFUsbSa8N/+jU/UNXJ8RDIUPWfN4UFVn8H/8bq4UOR5GiH4goy4Pr8L7ayctBpNC4k2WgY1s
	gVfeTZNwEBPGdaTVn4ZZyOVEb/eGYkZe/VX8Bul4bgW8LHyPExDTas3TICDlNG8wxSlTFIs7d4/
	Zgud6cVBNIdchY61aFTwpc9UouQsFitGbemrwsIFSHiDM=
X-Received: by 2002:a17:902:c40e:b0:2a7:845a:7eb2 with SMTP id d9443c01a7336-2ad1745b6cemr15096445ad.14.1771039443780;
        Fri, 13 Feb 2026 19:24:03 -0800 (PST)
Received: from ws ([103.197.28.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1ace5bd1sm5204255ad.90.2026.02.13.19.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 19:24:02 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH] nsenter: Support specifying namespace by ID
Date: Sat, 14 Feb 2026 11:23:42 +0800
Message-ID: <20260214032345.32457-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux kernel v6.19 introduces listns() syscall that lists namespace IDs,
as well as the support for opening an nsfile by a file_handle of ns ID.

This patch allows specifying namespaces by ID for nsenter. For example:

  # nsenter --net=:7

enters init net namespace (7 for NET_NS_INIT_ID).

In the rare case that a ns file name starts with a colon, prepend "./"
for disambiguation.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 configure.ac             |   4 ++
 meson.build              |   3 ++
 sys-utils/nsenter.1.adoc |  34 +++++++------
 sys-utils/nsenter.c      | 104 +++++++++++++++++++++++++++++++++++----
 4 files changed, 119 insertions(+), 26 deletions(-)

diff --git a/configure.ac b/configure.ac
index 912aa85d0..a0c8d0752 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1052,6 +1052,10 @@ char *c = crypt("abc","pw");
 ])
 AM_CONDITIONAL([HAVE_LIBCRYPT], [test "x$have_libcrypt" = xyes])
 
+AC_CHECK_TYPES([struct nsfs_file_handle], [], [], [[
+#include <linux/nsfs.h>
+]])
+
 
 AC_ARG_WITH([selinux],
   AS_HELP_STRING([--with-selinux], [compile with SELinux support]),
diff --git a/meson.build b/meson.build
index 1f4a5babb..5b8d03270 100644
--- a/meson.build
+++ b/meson.build
@@ -915,6 +915,9 @@ conf.set('USE_COLORS_BY_DEFAULT', get_option('colors-default') ? 1 : false)
 
 is_glibc = cc.has_header_symbol('limits.h', '__GLIBC__')
 
+have = cc.has_type('struct nsfs_file_handle', prefix : '#include <linux/nsfs.h>')
+conf.set('HAVE_STRUCT_NSFS_FILE_HANDLE', have ? 1 : false)
+
 ############################################################
 
 
diff --git a/sys-utils/nsenter.1.adoc b/sys-utils/nsenter.1.adoc
index d12097472..3dec46d66 100644
--- a/sys-utils/nsenter.1.adoc
+++ b/sys-utils/nsenter.1.adoc
@@ -87,36 +87,36 @@ Optionally, a process can be addressed with the format _PID:inode_. The _inode_
 identifies the unique process's file descriptor. To retrieve a process's inode
 number you can use the *getino*(1) utility.
 
-*-m*, *--mount*[**=**_file_]::
-Enter the mount namespace. If no file is specified, enter the mount namespace of the target process. If _file_ is specified, enter the mount namespace specified by _file_.
+*-m*, *--mount*[**=**<__file__|:__nsid__>]::
+Enter the mount namespace. If no argument is specified, enter the mount namespace of the target process. If _file_ or :__nsid__ is specified, enter the mount namespace specified by _file_ or _nsid_.
 
-*-u*, *--uts*[**=**_file_]::
-Enter the UTS namespace. If no file is specified, enter the UTS namespace of the target process. If _file_ is specified, enter the UTS namespace specified by _file_.
+*-u*, *--uts*[**=**<__file__|:__nsid__>]::
+Enter the UTS namespace. If no argument is specified, enter the UTS namespace of the target process. If _file_ or :__nsid__ is specified, enter the UTS namespace specified by _file_ or _nsid_.
 
-*-i*, *--ipc*[**=**_file_]::
-Enter the IPC namespace. If no file is specified, enter the IPC namespace of the target process. If _file_ is specified, enter the IPC namespace specified by _file_.
+*-i*, *--ipc*[**=**<__file__|:__nsid__>]::
+Enter the IPC namespace. If no argument is specified, enter the IPC namespace of the target process. If _file_ or :__nsid__ is specified, enter the IPC namespace specified by _file_ or _nsid_.
 
-*-n*, *--net*[**=**_file_]::
-Enter the network namespace. If no file is specified, enter the network namespace of the target process. If _file_ is specified, enter the network namespace specified by _file_.
+*-n*, *--net*[**=**<__file__|:__nsid__>]::
+Enter the network namespace. If no argument is specified, enter the network namespace of the target process. If _file_ or :__nsid__ is specified, enter the network namespace specified by _file_ or _nsid_.
 
 *-N*, *--net-socket* _fd_::
 Enter the network namespace of the target process's socket. It requires *--target* process specified. Supported since Linux 5.6.
 
-*-p*, *--pid*[**=**_file_]::
-Enter the PID namespace. If no file is specified, enter the PID namespace of the target process. If _file_ is specified, enter the PID namespace specified by _file_.
+*-p*, *--pid*[**=**<__file__|:__nsid__>]::
+Enter the PID namespace. If no argument is specified, enter the PID namespace of the target process. If _file_ or :__nsid__ is specified, enter the PID namespace specified by _file_ or _nsid_.
 
-*-U*, *--user*[**=**_file_]::
-Enter the user namespace. If no file is specified, enter the user namespace of the target process. If _file_ is specified, enter the user namespace specified by _file_. See also the *--setuid* and *--setgid* options.
+*-U*, *--user*[**=**<__file__|:__nsid__>]::
+Enter the user namespace. If no argument is specified, enter the user namespace of the target process. If _file_ or :__nsid__ is specified, enter the user namespace specified by _file_ or _nsid_. See also the *--setuid* and *--setgid* options.
 
 *--user-parent*::
 Enter the parent user namespace. Parent user namespace will be acquired from any other enabled namespace.
 If combined with *--user* option the parent user namespace will be fetched from the user namespace and replace it.
 
-*-C*, *--cgroup*[**=**_file_]::
-Enter the cgroup namespace. If no file is specified, enter the cgroup namespace of the target process. If _file_ is specified, enter the cgroup namespace specified by _file_.
+*-C*, *--cgroup*[**=**<__file__|:__nsid__>]::
+Enter the cgroup namespace. If no argument is specified, enter the cgroup namespace of the target process. If _file_ or :__nsid__ is specified, enter the cgroup namespace specified by _file_ or _nsid_.
 
-*-T*, *--time*[**=**_file_]::
-Enter the time namespace. If no file is specified, enter the time namespace of the target process. If _file_ is specified, enter the time namespace specified by _file_.
+*-T*, *--time*[**=**<__file__|:__nsid__>]::
+Enter the time namespace. If no argument is specified, enter the time namespace of the target process. If _file_ or :__nsid__ is specified, enter the time namespace specified by _file_ or _nsid_.
 
 *-G*, *--setgid* _gid_::
 Set the group ID which will be used in the entered namespace and drop supplementary groups.
@@ -161,6 +161,8 @@ include::man-common/help-version.adoc[]
 
 The *--user-parent* option requires Linux 4.9 or higher, older kernels will raise inappropriate ioctl for device error.
 
+Specifying namesapces by _nsid_ requires Linux 6.19 or higher.
+
 == AUTHORS
 
 mailto:biederm@xmission.com[Eric Biederman],
diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index b45f626b1..2820a7123 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -93,16 +93,16 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --all                    enter all namespaces\n"), out);
 	fputs(_(" -t, --target <PID>           target process to get namespaces from\n"), out);
-	fputs(_(" -m, --mount[=<file>]         enter mount namespace\n"), out);
-	fputs(_(" -u, --uts[=<file>]           enter UTS namespace (hostname etc)\n"), out);
-	fputs(_(" -i, --ipc[=<file>]           enter System V IPC namespace\n"), out);
-	fputs(_(" -n, --net[=<file>]           enter network namespace\n"), out);
+	fputs(_(" -m, --mount[=<file|:nsid>]   enter mount namespace\n"), out);
+	fputs(_(" -u, --uts[=<file|:nsid>]     enter UTS namespace (hostname etc)\n"), out);
+	fputs(_(" -i, --ipc[=<file|:nsid>]     enter System V IPC namespace\n"), out);
+	fputs(_(" -n, --net[=<file|:nsid>]     enter network namespace\n"), out);
 	fputs(_(" -N, --net-socket <fd>        enter socket's network namespace (use with --target)\n"), out);
-	fputs(_(" -p, --pid[=<file>]           enter pid namespace\n"), out);
-	fputs(_(" -C, --cgroup[=<file>]        enter cgroup namespace\n"), out);
-	fputs(_(" -U, --user[=<file>]          enter user namespace\n"), out);
+	fputs(_(" -p, --pid[=<file|:nsid>]     enter pid namespace\n"), out);
+	fputs(_(" -C, --cgroup[=<file|:nsid>]  enter cgroup namespace\n"), out);
+	fputs(_(" -U, --user[=<file|:nsid>]    enter user namespace\n"), out);
 	fputs(_("     --user-parent            enter parent user namespace\n"), out);
-	fputs(_(" -T, --time[=<file>]          enter time namespace\n"), out);
+	fputs(_(" -T, --time[=<file|:nsid>]    enter time namespace\n"), out);
 	fputs(_(" -S, --setuid[=<uid>]         set uid in entered namespace\n"), out);
 	fputs(_(" -G, --setgid[=<gid>]         set gid in entered namespace\n"), out);
 	fputs(_("     --preserve-credentials   do not touch uids or gids\n"), out);
@@ -177,10 +177,89 @@ static void open_target_fd(int *fd, const char *type, const char *path)
 		err(EXIT_FAILURE, _("cannot open %s"), path);
 }
 
+#ifdef HAVE_STRUCT_NSFS_FILE_HANDLE
+
+static struct file_handle nsfs_fh_tmpl = {};
+static int nsfs_fd = -1;
+
+static int fill_nsfs_file_handle(struct file_handle *fh, uint64_t ns_id)
+{
+	struct nsfs_file_handle *nsfh = (struct nsfs_file_handle *)fh->f_handle;
+	int pidfd_self;
+	int mount_id;
+
+	if (nsfs_fh_tmpl.handle_type) {
+		*fh = nsfs_fh_tmpl;
+		goto out;
+	}
+
+	/*
+	 * Before we can build a file handle of the namespace file of given
+	 * nsid and open it, we need the handle_type of nsfs and a "mount_fd"
+	 * for open_by_handle_at(2)). However,
+	 *
+	 *  1. FILEID_NSFS is currently not exposed to userspace, and
+	 *  2. linux/fcntl.h, in which FD_NSFS_ROOT is defined, conflicts with
+	 *     fcntl.h,
+	 *
+	 * so we retrieve the information by grabbing a temporary ns file.
+	 */
+	pidfd_self = pidfd_open(getpid(), 0);
+	if (pidfd_self < 0)
+		return -errno;
+
+	/* Mount namespace can not be disabled by kernel config */
+	nsfs_fd = ioctl(pidfd_self, PIDFD_GET_MNT_NAMESPACE, 0);
+	if (nsfs_fd < 0)
+		return -errno;
+	close(pidfd_self);
+
+	fh->handle_bytes = sizeof(struct nsfs_file_handle);
+	if (name_to_handle_at(nsfs_fd, "", fh, &mount_id,
+			      AT_EMPTY_PATH | AT_HANDLE_FID) == -1)
+		return -errno;
+	assert(fh->handle_type);
+	nsfs_fh_tmpl = *fh;
+
+out:
+	memset(nsfh, 0, sizeof(*nsfh));
+	nsfh->ns_id = ns_id;
+	return 0;
+}
+
+static void open_target_fd_by_nsid(int *fd, const char *idstr)
+{
+	unsigned char fh_buf[sizeof(struct file_handle) +
+		sizeof(struct nsfs_file_handle)];
+	struct file_handle *fh = (struct file_handle *)fh_buf;
+	uint64_t ns_id;
+
+	if (ul_strtou64(idstr, &ns_id, 10) != 0)
+		errx(EXIT_FAILURE, _("failed to parse nsid: %s"), idstr);
+
+	if (fill_nsfs_file_handle(fh, ns_id) != 0)
+		err(EXIT_FAILURE, _("failed to fill namespace file handle"));
+
+	if (*fd >= 0)
+		close(*fd);
+
+	*fd = open_by_handle_at(nsfs_fd, fh, O_RDONLY);
+	if (*fd < 0)
+		err(EXIT_FAILURE, _("cannot open namespace of id %"PRIu64),
+		    ns_id);
+}
+#endif /* HAVE_STRUCT_NSFS_FILE_HANDLE */
+
 static void enable_nsfile(struct namespace_file *n, const char *path)
 {
-	if (path)
-		open_target_fd(&n->fd, n->name, path);
+	if (path) {
+#ifdef HAVE_STRUCT_NSFS_FILE_HANDLE
+		if (*path == ':')
+			open_target_fd_by_nsid(&n->fd, path + 1);
+		else
+#endif
+			open_target_fd(&n->fd, n->name, path);
+	}
 	n->enabled = true;
 }
 
@@ -776,6 +855,11 @@ int main(int argc, char *argv[])
 	if (pid_fd >= 0)
 		close(pid_fd);
 
+#ifdef HAVE_STRUCT_NSFS_FILE_HANDLE
+	if (nsfs_fd >= 0)
+		close(nsfs_fd);
+#endif
+
 	/* Remember the current working directory if I'm not changing it */
 	if (root_fd >= 0 && wd_fd < 0 && wdns == NULL) {
 		wd_fd = open(".", O_RDONLY);
-- 
2.53.0

