Return-Path: util-linux-owner@vger.kernel.org
Received: from kawka.in.waw.pl ([178.63.212.103]:56839 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754131Ab3BNCGX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Feb 2013 21:06:23 -0500
From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCHv2 1/2] unshare,nsenter: spawn shell by default
Date: Wed, 13 Feb 2013 21:05:48 -0500
Message-Id: <1360807549-26476-1-git-send-email-zbyszek@in.waw.pl>
In-Reply-To: <20130213135212.GF7799@x2.net.home>
References: <20130213135212.GF7799@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The behaviour mimics chroot.

Possibly it would have been nicer to to query the password database in
the new namepace and run the shell of the user there, but it's hard to
do correctly. getpwuid() might need to load nss plugins, and the arch
in the new namespace might be different (in case of NEWNS mounts), or
the hostname might be different, etc. So in general it's not possible
to do it reliably.

Signed-off-by: Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl>
---
v2: - use [-$shell] instead of [$shell, -i].
    - exec_shell() invocation is slightly reordered.

 include/exec_shell.h    |  1 +
 lib/Makemodule.am       |  3 ++-
 lib/exec_shell.c        | 27 +++++++++++++++++++++++++++
 sys-utils/Makemodule.am |  1 +
 sys-utils/nsenter.1     |  5 ++++-
 sys-utils/nsenter.c     | 16 ++++++++--------
 sys-utils/unshare.c     | 12 ++++++------
 7 files changed, 49 insertions(+), 16 deletions(-)
 create mode 100644 include/exec_shell.h
 create mode 100644 lib/exec_shell.c

diff --git include/exec_shell.h include/exec_shell.h
new file mode 100644
index 0000000..a2aa757
--- /dev/null
+++ include/exec_shell.h
@@ -0,0 +1 @@
+extern void __attribute__((__noreturn__)) exec_shell(void);
diff --git lib/Makemodule.am lib/Makemodule.am
index 81e20b1..74b6bc1 100644
--- lib/Makemodule.am
+++ lib/Makemodule.am
@@ -24,7 +24,8 @@ libcommon_la_SOURCES = \
 	lib/tt.c \
 	lib/wholedisk.c \
 	lib/ttyutils.c \
-	lib/xgetpass.c
+	lib/xgetpass.c \
+	lib/exec_shell.c
 
 if LINUX
 libcommon_la_SOURCES += \
diff --git lib/exec_shell.c lib/exec_shell.c
new file mode 100644
index 0000000..95620cd
--- /dev/null
+++ lib/exec_shell.c
@@ -0,0 +1,27 @@
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+
+#include "nls.h"
+#include "c.h"
+#include "xalloc.h"
+
+#include "exec_shell.h"
+
+#define DEFAULT_SHELL "/bin/sh"
+
+void __attribute__((__noreturn__)) exec_shell(void) {
+	const char *shell = getenv("SHELL"), *shell_basename;
+	char *arg0;
+	if (!shell)
+		shell = DEFAULT_SHELL;
+
+	shell_basename = basename(shell);
+	arg0 = xmalloc(strlen(shell_basename) + 2);
+	arg0[0] = '-';
+	strcpy(arg0 + 1, shell_basename);
+
+	execl(shell, arg0, NULL);
+	err(EXIT_FAILURE, _("failed to execute %s"), shell);
+}
diff --git sys-utils/Makemodule.am sys-utils/Makemodule.am
index 86c529e..c214b92 100644
--- sys-utils/Makemodule.am
+++ sys-utils/Makemodule.am
@@ -287,6 +287,7 @@ if BUILD_UNSHARE
 usrbin_exec_PROGRAMS += unshare
 dist_man_MANS += sys-utils/unshare.1
 unshare_SOURCES = sys-utils/unshare.c
+unshare_LDADD = $(LDADD) libcommon.la
 endif
 
 if BUILD_NSENTER
diff --git sys-utils/nsenter.1 sys-utils/nsenter.1
index ea3c1b0..4a6a34d 100644
--- sys-utils/nsenter.1
+++ sys-utils/nsenter.1
@@ -4,7 +4,7 @@ nsenter \- run program with namespaces of other processes
 .SH SYNOPSIS
 .B nsenter
 .RI [ options ]
-program
+.RI [ program ]
 .RI [ arguments ]
 .SH DESCRIPTION
 Enters the contexts of one or more other processes and then executes specified
@@ -50,6 +50,9 @@ flag).
 See the
 .BR clone (2)
 for exact semantics of the flags.
+.TP
+If program is not given, run ``${SHELL} \fB\-i\fR'' (default: /bin\:/sh).
+
 .SH OPTIONS
 Argument with square brakets, such as [\fIfile\fR], means optional argument.
 Command line syntax to specify optional argument \-\-mount=/path\:/to\:/file.
diff --git sys-utils/nsenter.c sys-utils/nsenter.c
index 3df4338..106349c 100644
--- sys-utils/nsenter.c
+++ sys-utils/nsenter.c
@@ -17,8 +17,6 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-#include <sys/types.h>
-#include <sys/wait.h>
 #include <dirent.h>
 #include <errno.h>
 #include <getopt.h>
@@ -28,12 +26,15 @@
 #include <stdbool.h>
 #include <unistd.h>
 #include <assert.h>
+#include <sys/types.h>
+#include <sys/wait.h>
 
 #include "strutils.h"
 #include "nls.h"
 #include "c.h"
 #include "closestream.h"
 #include "namespace.h"
+#include "exec_shell.h"
 
 static struct namespace_file {
 	int nstype;
@@ -253,9 +254,6 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (optind >= argc)
-		usage(EXIT_FAILURE);
-
 	/*
 	 * Open remaining namespace and directory descriptors.
 	 */
@@ -317,7 +315,9 @@ int main(int argc, char *argv[])
 	if (do_fork == 1)
 		continue_as_child();
 
-	execvp(argv[optind], argv + optind);
-
-	err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
+	if (optind < argc) {
+		execvp(argv[optind], argv + optind);
+		err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
+	}
+	exec_shell();
 }
diff --git sys-utils/unshare.c sys-utils/unshare.c
index 62d2fcb..2eea165 100644
--- sys-utils/unshare.c
+++ sys-utils/unshare.c
@@ -29,6 +29,7 @@
 #include "c.h"
 #include "closestream.h"
 #include "namespace.h"
+#include "exec_shell.h"
 
 static void usage(int status)
 {
@@ -107,13 +108,12 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if(optind >= argc)
-		usage(EXIT_FAILURE);
-
 	if(-1 == unshare(unshare_flags))
 		err(EXIT_FAILURE, _("unshare failed"));
 
-	execvp(argv[optind], argv + optind);
-
-	err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
+	if (optind < argc) {
+		execvp(argv[optind], argv + optind);
+		err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
+	}
+	exec_shell();
 }
-- 
1.8.1

