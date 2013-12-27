Return-Path: util-linux-owner@vger.kernel.org
Received: from shell.v3.sk ([195.168.3.45]:42771 "EHLO shell.v3.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757Ab3L0VYj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Dec 2013 16:24:39 -0500
From: Lubomir Rintel <lkundrak@v3.sk>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Mikhail Gusarov <dottedmag@dottedmag.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] unshare: Add possibility to add mapping into root user in user namespace
Date: Fri, 27 Dec 2013 22:14:48 +0100
Message-Id: <1388178888-24475-1-git-send-email-lkundrak@v3.sk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes it very convenient to use make use of privileged actions
on CONFIG_USER_NS enabled kernels, without having to manually tinker
with uid_map and gid_map to obtain required credentials (as those
given upon unshare() vanish with call to execve() and lot of userspace
checks for euid==0 anyway).

Usage example:

$ unshare --uts
unshare: unshare failed: Operation not permitted

$ unshare --user --uts
[nfsnobody@odvarok ~]$ hostname swag
hostname: you must be root to change the host name

$ unshare -r --uts
[root@odvarok util-linux]# hostname swag
[root@odvarok util-linux]#

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 sys-utils/unshare.1 |  8 ++++++++
 sys-utils/unshare.c | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 1f5273e..41ea2ec 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -80,6 +80,14 @@ Just before running the program, mount the proc filesystem at the \fImountpoint\
 implies creating a new mount namespace since the /proc mount would otherwise
 mess up existing programs on the system. The new proc filesystem is explicitly
 mounted as private (by MS_PRIVATE|MS_REC).
+.TP
+.BR \-r , " \-\-map-root-user"
+Run the program only after current effective user and group ID have been mapped to
+superuser UID and GID in newly created user namespace. This makes it possible to
+conveniently gain capabilities needed to manage various aspects of newly created
+namespaces (such as configure interfaces in network namespace or mount filesystems in
+mount) even when run unprivileged. As a convenience feature, it does not support
+more sophisticated use cases, such as mapping multiple ranges of UIDs and GIDs.
 .SH SEE ALSO
 .BR unshare (2),
 .BR clone (2),
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 114f17d..7c2fa0a 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -32,6 +32,7 @@
 #include "closestream.h"
 #include "namespace.h"
 #include "exec_shell.h"
+#include "xalloc.h"
 
 static void usage(int status)
 {
@@ -50,6 +51,7 @@ static void usage(int status)
 	fputs(_(" -U, --user                unshare user namespace\n"), out);
 	fputs(_(" -f, --fork                fork before launching <program>\n"), out);
 	fputs(_("     --mount-proc[=<dir>]  mount proc filesystem first (implies --mount)\n"), out);
+	fputs(_(" -r, --map-root-user       map current user to root (implies --user)\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
@@ -75,19 +77,22 @@ int main(int argc, char *argv[])
 		{ "user", no_argument, 0, 'U' },
 		{ "fork", no_argument, 0, 'f' },
 		{ "mount-proc", optional_argument, 0, OPT_MOUNTPROC },
+		{ "map-root-user", no_argument, 0, 'r' },
 		{ NULL, 0, 0, 0 }
 	};
 
 	int unshare_flags = 0;
-	int c, forkit = 0;
+	int c, forkit = 0, maproot = 0;
 	const char *procmnt = NULL;
+	uid_t real_euid = geteuid();
+	gid_t real_egid = getegid();;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "fhVmuinpU", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "fhVmuinpUr", longopts, NULL)) != -1) {
 		switch (c) {
 		case 'f':
 			forkit = 1;
@@ -119,6 +124,10 @@ int main(int argc, char *argv[])
 			unshare_flags |= CLONE_NEWNS;
 			procmnt = optarg ? optarg : "/proc";
 			break;
+		case 'r':
+			unshare_flags |= CLONE_NEWUSER;
+			maproot = 1;
+			break;
 		default:
 			usage(EXIT_FAILURE);
 		}
@@ -147,6 +156,29 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (maproot) {
+		int fd;
+		char *buf;
+
+		fd = open("/proc/self/uid_map", O_WRONLY);
+		if (fd == -1)
+			err(EXIT_FAILURE, _("Opening %s failed"), "uid_map");
+		xasprintf(&buf, "0 %d 1", real_euid);
+		if (write(fd, buf, strlen(buf)) != (int)strlen(buf))
+			err(EXIT_FAILURE, _("Writing to %s failed"), "uid_map");
+		free(buf);
+		close(fd);
+
+		fd = open("/proc/self/gid_map", O_WRONLY);
+		if (fd == -1)
+			err(EXIT_FAILURE, _("Opening %s failed"), "gid_map");
+		xasprintf(&buf, "0 %d 1", real_egid);
+		if (write(fd, buf, strlen(buf)) != (int)strlen(buf))
+			err(EXIT_FAILURE, _("Writing to %s failed"), "gid_map");
+		free(buf);
+		close(fd);
+	}
+
 	if (procmnt &&
 	    (mount("none", procmnt, NULL, MS_PRIVATE|MS_REC, NULL) != 0 ||
 	     mount("proc", procmnt, "proc", MS_NOSUID|MS_NOEXEC|MS_NODEV, NULL) != 0))
-- 
1.8.4.2

