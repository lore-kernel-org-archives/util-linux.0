Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:49327 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754142Ab3F1AFK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 27 Jun 2013 20:05:10 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Cc: ebiederm@xmission.com, mtk.manpages@gmail.com
Subject: [PATCH/RFC] unshare: add --fork/--mount-proc options for pid namespaces
Date: Thu, 27 Jun 2013 20:04:58 -0400
Message-Id: <1372377898-2602-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The ability of unshare to launch a new pid namespace is a bit limited.
The first process in the namespace is expected to be the "init" for it.
When it's not, you get bad behavior.

For example, trying to launch a shell in a new pid namespace fails very
quickly:
	$ sudo unshare -p dash
	# uname -r
	3.8.3
	# uname -m
	dash: 2: Cannot fork
	# ls -ld /
	dash: 3: Cannot fork
	# echo $$
	1324

For this to work smoothly, we need an init process to actively watch over
things.  But forcing people to re-use an existing init or write their own
mini init is a bit overkill.  So let's add a --fork option to unshare to
do this common bit of book keeping.  Now we can do:
	$ sudo unshare -p --fork dash
	# uname -r
	3.8.3
	# uname -m
	x86_64
	# ls -ld /
	drwxr-xr-x 22 root root 4096 May  4 14:01 /
	# echo $$
	1

When it comes to pid namespaces, it's also useful for /proc to reflect
the current namespace.  Again, this is easy to pull off, but annoying
to force everyone to do it themselves.  So let's add a --mount-proc to
do the magic for us.  The downside is that this also implies creating
a mount namespace as mounting the new pid namespace /proc over top the
system one will quickly break all other processes on the system.
	$ sudo unshare --fork -p dash --mount-proc
	# ps uaxOT
	USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
	root         1  0.0  0.0   4328   632 pts/15   S    19:51   0:00 dash
	root         2  0.0  0.0  22592  1148 pts/15   R+   19:51   0:00 ps uaxOT

Thanks to Michael Kerrisk for his namespace articles on lwn.net

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sys-utils/unshare.1 | 10 ++++++++++
 sys-utils/unshare.c | 41 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index bd0f13e..5e2c27c 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -63,6 +63,16 @@ Unshare the UTS namespace.
 .TP
 .BR \-U , " \-\-user"
 Unshare the user namespace.
+.TP
+.BR \-\-fork
+Fork the specified process as a child of unshare rather than running it
+directly.  This is useful when creating a new pid namespace.
+.TP
+.BR \-\-mount\-proc
+Just before running the program, mount the proc filesystem at /proc.  This
+is useful when creating a new pid namespace.  It also implies creating a
+new mount namespace since the /proc mount would otherwise mess up existing
+programs on the system.
 .SH SEE ALSO
 .BR unshare (2),
 .BR clone (2)
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 8cc9c46..bc25d76 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -21,9 +21,12 @@
 #include <errno.h>
 #include <getopt.h>
 #include <sched.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <sys/mount.h>
+#include <sys/wait.h>
 
 #include "nls.h"
 #include "c.h"
@@ -46,6 +49,8 @@ static void usage(int status)
 	fputs(_(" -n, --net         unshare network namespace\n"), out);
 	fputs(_(" -p, --pid         unshare pid namespace\n"), out);
 	fputs(_(" -U, --user        unshare user namespace\n"), out);
+	fputs(_("     --fork        fork before launching <program>\n"), out);
+	fputs(_("     --mount-proc  mount /proc first (implies --mount)\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
@@ -66,12 +71,17 @@ int main(int argc, char *argv[])
 		{ "net", no_argument, 0, 'n' },
 		{ "pid", no_argument, 0, 'p' },
 		{ "user", no_argument, 0, 'U' },
+		{ "fork", no_argument, 0, 1 },
+		{ "mount-proc", no_argument, 0, 2 },
 		{ NULL, 0, 0, 0 }
 	};
 
 	int unshare_flags = 0;
 
 	int c;
+	pid_t pid;
+	bool forkit = false;
+	bool mount_proc = false;
 
 	setlocale(LC_MESSAGES, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -85,6 +95,9 @@ int main(int argc, char *argv[])
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
+		case 2: /* --mount-proc */
+			mount_proc = true;
+			/* fall through */
 		case 'm':
 			unshare_flags |= CLONE_NEWNS;
 			break;
@@ -103,6 +116,9 @@ int main(int argc, char *argv[])
 		case 'U':
 			unshare_flags |= CLONE_NEWUSER;
 			break;
+		case 1: /* --fork */
+			forkit = true;
+			break;
 		default:
 			usage(EXIT_FAILURE);
 		}
@@ -111,9 +127,26 @@ int main(int argc, char *argv[])
 	if (-1 == unshare(unshare_flags))
 		err(EXIT_FAILURE, _("unshare failed"));
 
-	if (optind < argc) {
-		execvp(argv[optind], argv + optind);
-		err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
+	pid = forkit ? fork() : 1;
+	if (pid == 0) {
+		/* child */
+		if (mount_proc && mount("proc", "/proc", "proc", 0, NULL))
+			err(EXIT_FAILURE, _("mount(/proc) failed"));
+		if (optind < argc) {
+			execvp(argv[optind], argv + optind);
+			err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
+		}
+		exec_shell();
+	} else {
+		/* parent */
+		int status;
+		if (waitpid(pid, &status, 0) == -1)
+			err(EXIT_FAILURE, _("waitpid failed"));
+		if (WIFEXITED(status))
+			return WEXITSTATUS(status);
+		else if (WIFSIGNALED(status))
+			kill(getpid(), WTERMSIG(status));
+		/* still here !? */
+		err(EXIT_FAILURE, _("child exit failed"));
 	}
-	exec_shell();
 }
-- 
1.8.2.1

