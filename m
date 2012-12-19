Return-Path: util-linux-owner@vger.kernel.org
Received: from charlotte.tuxdriver.com ([70.61.120.58]:38829 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab2LSTHF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 19 Dec 2012 14:07:05 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: util-linux@vger.kernel.org
Cc: Neil Horman <nhorman@tuxdriver.com>, Karel Zak <kzak@redhat.com>
Subject: [PATCH] sys-tools: Add setns utility to sys-tools
Date: Wed, 19 Dec 2012 14:06:46 -0500
Message-Id: <1355944006-27234-1-git-send-email-nhorman@tuxdriver.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Like the unshare command, which lets a user from the command line detach from
specific namespaces of the parent process, and execute a command, setns provides
a frontend to the setns(2) syscall, which allows a user to migrate a process to
the namespaces of other processes, prior to calling exec on a command.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
CC: Karel Zak <kzak@redhat.com>
---
 configure.ac            |  11 +++++
 sys-utils/Makemodule.am |   5 ++
 sys-utils/setns.1       |  38 +++++++++++++++
 sys-utils/setns.c       | 123 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 177 insertions(+)
 create mode 100644 sys-utils/setns.1
 create mode 100644 sys-utils/setns.c

diff --git a/configure.ac b/configure.ac
index 9c08fc0..829594d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -862,6 +862,17 @@ if test "x$build_unshare" = xyes; then
   AC_CHECK_FUNCS([unshare])
 fi
 
+AC_ARG_ENABLE([setns],
+  AS_HELP_STRING([--disable-setns], [do not build setns]),
+  [], enable_unshare=check
+)
+UL_BUILD_INIT([setns])
+UL_REQUIRES_LINUX([setns])
+UL_REQUIRES_SYSCALL_CHECK([setns], [UL_CHECK_SYSCALL([setns])])
+AM_CONDITIONAL(BUILD_SETNS, test "x$build_setns" = xyes)
+if test "x$build_setns" = xyes; then
+  AC_CHECK_FUNCS([setns])
+fi
 
 AC_ARG_ENABLE([arch],
   AS_HELP_STRING([--enable-arch], [do build arch]),
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 33112fb..6d11ab3 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -283,6 +283,11 @@ dist_man_MANS += sys-utils/switch_root.8
 switch_root_SOURCES = sys-utils/switch_root.c
 endif
 
+if BUILD_SETNS
+usrbin_exec_PROGRAMS += setns
+setns_SOURCES = sys-utils/setns.c
+endif
+
 if BUILD_UNSHARE
 usrbin_exec_PROGRAMS += unshare
 dist_man_MANS += sys-utils/unshare.1
diff --git a/sys-utils/setns.1 b/sys-utils/setns.1
new file mode 100644
index 0000000..ad8c386
--- /dev/null
+++ b/sys-utils/setns.1
@@ -0,0 +1,38 @@
+.\" Process this file with
+.\" groff -man -Tascii lscpu.1
+.\"
+.TH SETNS 1 "December 2012" "util-linux" "User Commands"
+.SH NAME
+setns \- run program with namespaces of another process 
+.SH SYNOPSIS
+.B setns 
+.RI [ options ]
+program
+.RI [ arguments ]
+.SH DESCRIPTION
+Migrates to the namespaces of the specified pid/namespace pairs, and executes a
+child process.
+.SH OPTIONS
+.TP
+.BR \-h , " \-\-help"
+Print a help message,
+.TP
+.BR \-u\ <pid> , " \-\-uts=<pid>"
+Migrate to the uts namespace of <pid>
+.TP
+.BR \-i\ <pid> , " \-\-ipc=<pid>"
+Migrate to the ipc namespace of <pid>
+.TP
+.BR \-n\ <pid> , " \-\-net\<pid>"
+Migrate to the net namespace of <pid>
+.SH SEE ALSO
+.BR unshare (2),
+.BR setns (2),
+.BR clone (2)
+.SH BUGS
+None known so far.
+.SH AUTHOR
+Neil Horman <nhorman@tuxdriver.com>
+.SH AVAILABILITY
+The setns command is part of the util-linux package and is available from
+ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/sys-utils/setns.c b/sys-utils/setns.c
new file mode 100644
index 0000000..8e20748
--- /dev/null
+++ b/sys-utils/setns.c
@@ -0,0 +1,123 @@
+/*
+ * setns(1) - command-line interface for setns(2)
+ *
+ * Copyright (C) 2012 Neil Horman <nhorman@tuxdriver.com> 
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
+#include <stdlib.h>
+#include <stdio.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <unistd.h>
+#include <sched.h>
+
+/*
+ * Note: The long option strings are used
+ * to build a path via /proc/<pid>/ns, so they must
+ * match the corresponding namespace
+ */
+struct option lopts[] = {
+	{"help", 0, NULL, 'h'},
+	{"ipc", 1, NULL, 'i'},
+	{"net", 1, NULL, 'n'},
+	{"uts", 1, NULL, 'u'},
+	{0, 0, 0, 0},
+};
+
+static void usage(char **argv)
+{
+	printf("%s [--ipc|-i=<pid>] [--net|-n=pid] [--uts|-u=pid] <command>\n",
+		argv[0]); 
+}
+
+static int switch_namespace(const char *name, unsigned long pid)
+{
+	int fd;
+	char path[256];
+	
+	sprintf(path, "/proc/%d/ns/%s", (int)pid, name);
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	if (setns(fd, 0) < 0) {
+		char buf[512];	
+		sprintf(buf,"Setns failed for %s on pid %d: ", name, (int)pid);
+		perror(buf);
+		return -1;
+	}
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int opt;
+	int longind;
+	int execind = argc+1;
+	unsigned long pid;
+	int rc = 0;
+
+	while ((opt = getopt_long(argc, argv,
+		"hi:n:u:", lopts, &longind)) != -1) { 
+
+		switch (opt) {
+		case '?':
+			usage(argv);
+			exit(0);
+		case 'h':
+			usage(argv);
+			exit(0);
+
+		case 'i':
+		case 'n':
+		case 'u':
+			pid = strtoul(optarg, NULL, 10);
+			if (pid == ULONG_MAX) {
+				rc = 1;
+				printf("%s pid not properly specified\n",
+					lopts[longind].name);
+				goto out;
+			}
+			rc = switch_namespace(lopts[longind].name, pid);
+			if (rc < 0)
+				goto out;
+			break;
+
+		}
+	}
+
+	if (optind == argc) {
+		printf("no executable specified\n");
+		rc = 1;
+		goto out;
+	}
+	execind = optind;
+
+	rc = execvp(argv[execind], &argv[execind]);
+	if (rc < 0) {
+		char buf[512];
+		sprintf("execv of %s failed: ", argv[execind]);
+		perror(buf);
+	}
+out:
+	return rc;			
+}
+
-- 
1.7.11.7

