Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44620 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755985Ab2KWUXm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 23 Nov 2012 15:23:42 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so6711237pbc.19
        for <util-linux@vger.kernel.org>; Fri, 23 Nov 2012 12:23:42 -0800 (PST)
From: Andy Lutomirski <luto@amacapital.net>
To: util-linux@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH] Add no_new_privs
Date: Fri, 23 Nov 2012 12:23:33 -0800
Message-Id: <b9e1a13168f41cde97e1fdaa21cdc5354ef535ea.1353702119.git.luto@amacapital.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---

I'm not 100% sure this is appropriate for util-linux, but it seems useful.

I've never written new programs for util-linux before, and I barely understand
autotools.  Feedback is welcome :)

 .gitignore               |  1 +
 configure.ac             |  9 +++++
 sys-utils/Makemodule.am  |  6 ++++
 sys-utils/no_new_privs.1 | 37 ++++++++++++++++++++
 sys-utils/no_new_privs.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 141 insertions(+)
 create mode 100644 sys-utils/no_new_privs.1
 create mode 100644 sys-utils/no_new_privs.c

diff --git a/.gitignore b/.gitignore
index e85eb07..dc3e993 100644
--- a/.gitignore
+++ b/.gitignore
@@ -127,6 +127,7 @@ tests/run.sh.trs
 /mountpoint
 /namei
 /newgrp
+/no_new_privs
 /partx
 /pg
 /pivot_root
diff --git a/configure.ac b/configure.ac
index 727113a..36dae32 100644
--- a/configure.ac
+++ b/configure.ac
@@ -866,6 +866,15 @@ if test "x$build_unshare" = xyes; then
 fi
 
 
+AC_ARG_ENABLE([no_new_privs],
+  AS_HELP_STRING([--disable-no_new_privs], [do not build no_new_privs]),
+  [], enable_no_new_privs=check
+)
+UL_BUILD_INIT([no_new_privs])
+UL_REQUIRES_LINUX([no_new_privs])
+AM_CONDITIONAL(BUILD_NO_NEW_PRIVS, test "x$build_no_new_privs" = xyes)
+
+
 AC_ARG_ENABLE([arch],
   AS_HELP_STRING([--enable-arch], [do build arch]),
   [], enable_arch=no
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index c7b1eb3..0789d63 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -309,3 +309,9 @@ if HAVE_AUDIT
 hwclock_LDADD += -laudit
 endif
 endif # BUILD_HWCLOCK
+
+if BUILD_NO_NEW_PRIVS
+usrbin_exec_PROGRAMS += no_new_privs
+dist_man_MANS += sys-utils/no_new_privs.1
+no_new_privs_SOURCES = sys-utils/no_new_privs.c
+endif
diff --git a/sys-utils/no_new_privs.1 b/sys-utils/no_new_privs.1
new file mode 100644
index 0000000..59dfe4b
--- /dev/null
+++ b/sys-utils/no_new_privs.1
@@ -0,0 +1,37 @@
+.\" Process this file with
+.\" groff -man -Tascii no_new_privs.1
+.\"
+.TH NO_NEW_PRIVS 1 "December 2012" "util-linux" "User Commands"
+.SH NAME
+no_new_privs \- run program with new_new_privs set
+.SH SYNOPSIS
+.B no_new_privs
+.RI [ options ]
+program
+.RI [ arguments ]
+.SH DESCRIPTION
+Sets the \fIno_new_privs\fP bit and then executes specified program.  With
+this bit set,
+.BR execve (2)
+will not grant new privileges.  For example, the setuid
+and setgid bits as well as file capabilities will not function.  This bit
+is inherited by child processes and cannot be unset.  See
+.BR prctl (2)
+and
+.IR Documentation/prctl/no_new_privs.txt
+in the Linux kernel source.
+.SH OPTIONS
+.TP
+.BR \-h , " \-\-help"
+Print a help message,
+.SH NOTES
+If setting the no_new_privs bit fails, \fIprogram\fP will not be run.
+.SH SEE ALSO
+.BR prctl (2)
+.SH BUGS
+None known so far.
+.SH AUTHOR
+Andy Lutomirski <luto@amacapital.net>
+.SH AVAILABILITY
+The no_new_privs command is part of the util-linux package and is available from
+ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/sys-utils/no_new_privs.c b/sys-utils/no_new_privs.c
new file mode 100644
index 0000000..094f5a9
--- /dev/null
+++ b/sys-utils/no_new_privs.c
@@ -0,0 +1,88 @@
+/*
+ * no_new_privs(1) - command-line interface for PR_SET_NO_NEW_PRIVS
+ *
+ * Copyright (C) 2012 Andy Lutomirski <luto@amacapital.net>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <errno.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/prctl.h>
+
+#include "nls.h"
+#include "c.h"
+#include "closestream.h"
+
+#ifndef PR_SET_NO_NEW_PRIVS
+# define PR_SET_NO_NEW_PRIVS 38
+#endif
+
+static void usage(int status)
+{
+	FILE *out = status == EXIT_SUCCESS ? stdout : stderr;
+
+	fputs(USAGE_HEADER, out);
+	fprintf(out,
+	      _(" %s <program> [args...]\n"),	program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("no_new_privs(1)"));
+
+	exit(status);
+}
+
+int main(int argc, char *argv[])
+{
+	static const struct option longopts[] = {
+		{ "help", no_argument, 0, 'h' },
+		{ "version", no_argument, 0, 'V'},
+		{ NULL, 0, 0, 0 }
+	};
+
+	int c;
+
+	setlocale(LC_MESSAGES, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	while((c = getopt_long(argc, argv, "+hV", longopts, NULL)) != -1) {
+		switch(c) {
+		case 'h':
+			usage(EXIT_SUCCESS);
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		default:
+			usage(EXIT_FAILURE);
+		}
+	}
+
+	if(optind >= argc)
+		usage(EXIT_FAILURE);
+
+	if(-1 == prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0))
+		err(EXIT_FAILURE, _("PR_SET_NO_NEW_PRIVS failed"));
+
+	execvp(argv[optind], argv + optind);
+
+	err(EXIT_FAILURE, _("exec %s failed"), argv[optind]);
+}
-- 
1.7.11.7

