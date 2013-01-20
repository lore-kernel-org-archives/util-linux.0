Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59700 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413Ab3ATSFR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 20 Jan 2013 13:05:17 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr12so3193770wgb.23
        for <util-linux@vger.kernel.org>; Sun, 20 Jan 2013 10:05:16 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 6/6] nsenter: fix indentation
Date: Sun, 20 Jan 2013 18:04:56 +0000
Message-Id: <1358705096-21092-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358705096-21092-1-git-send-email-kerolasa@iki.fi>
References: <1358705096-21092-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/namespace.h | 55 ++++++++++++++++++++++++++---------------------------
 sys-utils/nsenter.c | 35 ++++++++++++++++++++--------------
 2 files changed, 48 insertions(+), 42 deletions(-)

diff --git a/include/namespace.h b/include/namespace.h
index 8ccc3f6..3a219ce 100644
--- a/include/namespace.h
+++ b/include/namespace.h
@@ -1,43 +1,42 @@
 /* Compat code so unshare and setns can be used with older libcs */
 #ifndef UTIL_LINUX_NAMESPACE_H
-#define UTIL_LINUX_NAMESPACE_H
+# define UTIL_LINUX_NAMESPACE_H
 
-#include <sched.h>
+# include <sched.h>
 
-#ifndef CLONE_NEWSNS
-# define CLONE_NEWNS 0x00020000
-#endif
-#ifndef CLONE_NEWUTS
-# define CLONE_NEWUTS 0x04000000
-#endif
-#ifndef CLONE_NEWIPC
-# define CLONE_NEWIPC 0x08000000
-#endif
-#ifndef CLONE_NEWNET
-# define CLONE_NEWNET 0x40000000
-#endif
-#ifndef CLONE_NEWUSER
-# define CLONE_NEWUSER 0x10000000
-#endif
-#ifndef CLONE_NEWPID
-# define CLONE_NEWPID 0x20000000
-#endif
-
-#ifndef HAVE_UNSHARE
-# include <sys/syscall.h>
+# ifndef CLONE_NEWSNS
+#  define CLONE_NEWNS 0x00020000
+# endif
+# ifndef CLONE_NEWUTS
+#  define CLONE_NEWUTS 0x04000000
+# endif
+# ifndef CLONE_NEWIPC
+#  define CLONE_NEWIPC 0x08000000
+# endif
+# ifndef CLONE_NEWNET
+#  define CLONE_NEWNET 0x40000000
+# endif
+# ifndef CLONE_NEWUSER
+#  define CLONE_NEWUSER 0x10000000
+# endif
+# ifndef CLONE_NEWPID
+#  define CLONE_NEWPID 0x20000000
+# endif
 
+# ifndef HAVE_UNSHARE
+#  include <sys/syscall.h>
 static inline int unshare(int flags)
 {
 	return syscall(SYS_unshare, flags);
 }
-#endif
+# endif
 
-#ifndef HAVE_SETNS
-# include <sys/syscall.h>
+# ifndef HAVE_SETNS
+#  include <sys/syscall.h>
 static inline int setns(int fd, int nstype)
 {
 	return syscall(SYS_setns, fd, nstype);
 }
-#endif /* HAVE_SETNS */
+# endif
 
-#endif /* UTIL_LINUX_NAMESPACE_H */
+#endif	/* UTIL_LINUX_NAMESPACE_H */
diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index 0e1c8f4..04ac314 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -34,7 +34,7 @@
 #include "closestream.h"
 #include "namespace.h"
 
-static struct namespace_file{
+static struct namespace_file {
 	int nstype;
 	const char *name;
 	int fd;
@@ -91,12 +91,13 @@ static void open_target_fd(int *fd, const char *type, const char *path)
 
 	if (!path && namespace_target_pid) {
 		snprintf(pathbuf, sizeof(pathbuf), "/proc/%u/%s",
-			namespace_target_pid, type);
+			 namespace_target_pid, type);
 		path = pathbuf;
 	}
 	if (!path)
-		errx(EXIT_FAILURE, _("neither filename nor target pid supplied for %s"),
-		    type);
+		errx(EXIT_FAILURE,
+		     _("neither filename nor target pid supplied for %s"),
+		     type);
 
 	if (*fd >= 0)
 		close(*fd);
@@ -147,8 +148,7 @@ static void continue_as_child(void)
 	/* Return the child's exit code if possible */
 	if (WIFEXITED(status)) {
 		exit(WEXITSTATUS(status));
-	}
-	else if (WIFSIGNALED(status)) {
+	} else if (WIFSIGNALED(status)) {
 		kill(getpid(), WTERMSIG(status));
 	}
 	exit(EXIT_FAILURE);
@@ -181,15 +181,18 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while((c = getopt_long(argc, argv, "hVt:m::u::i::n::p::U::er::w::", longopts, NULL)) != -1) {
-		switch(c) {
+	while ((c =
+		getopt_long(argc, argv, "hVt:m::u::i::n::p::U::er::w::",
+			    longopts, NULL)) != -1) {
+		switch (c) {
 		case 'h':
 			usage(EXIT_SUCCESS);
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
 		case 't':
-			namespace_target_pid = strtoul_or_err(optarg, _("failed to parse pid"));
+			namespace_target_pid =
+			    strtoul_or_err(optarg, _("failed to parse pid"));
 			break;
 		case 'm':
 			open_namespace_fd(CLONE_NEWNS, optarg);
@@ -224,7 +227,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if(optind >= argc)
+	if (optind >= argc)
 		usage(EXIT_FAILURE);
 
 	/*
@@ -234,7 +237,8 @@ int main(int argc, char *argv[])
 		if (nsfile->fd < 0)
 			continue;
 		if (setns(nsfile->fd, nsfile->nstype))
-			err(EXIT_FAILURE, _("reassociate to namespace '%s' failed"),
+			err(EXIT_FAILURE,
+			    _("reassociate to namespace '%s' failed"),
 			    nsfile->name);
 		close(nsfile->fd);
 		nsfile->fd = -1;
@@ -244,13 +248,15 @@ int main(int argc, char *argv[])
 	if (root_fd >= 0 && wd_fd < 0) {
 		wd_fd = open(".", O_RDONLY);
 		if (wd_fd < 0)
-			err(EXIT_FAILURE, _("cannot open current working directory"));
+			err(EXIT_FAILURE,
+			    _("cannot open current working directory"));
 	}
 
 	/* Change the root directory */
 	if (root_fd >= 0) {
 		if (fchdir(root_fd) < 0)
-			err(EXIT_FAILURE, _("change directory by root file descriptor failed"));
+			err(EXIT_FAILURE,
+			    _("change directory by root file descriptor failed"));
 
 		if (chroot(".") < 0)
 			err(EXIT_FAILURE, _("chroot failed"));
@@ -262,7 +268,8 @@ int main(int argc, char *argv[])
 	/* Change the working directory */
 	if (wd_fd >= 0) {
 		if (fchdir(wd_fd) < 0)
-			err(EXIT_FAILURE, _("change directory by working directory file descriptor failed"));
+			err(EXIT_FAILURE,
+			    _("change directory by working directory file descriptor failed"));
 
 		close(wd_fd);
 		wd_fd = -1;
-- 
1.8.1.1

