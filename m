Return-Path: util-linux-owner@vger.kernel.org
Received: from charlotte.tuxdriver.com ([70.61.120.58]:52020 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab2LTSWZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 20 Dec 2012 13:22:25 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: util-linux@vger.kernel.org
Cc: kerolasa@gmail.com, grawity@gmail.com, Neil Horman <nhorman@tuxdriver.com>,
        Karel Zak <kzak@redhat.com>
Subject: [PATCH v2] sys-tools: Enhance unshare command to support the switching of namespaces
Date: Thu, 20 Dec 2012 13:22:09 -0500
Message-Id: <1356027729-26098-1-git-send-email-nhorman@tuxdriver.com>
In-Reply-To: <1355944006-27234-1-git-send-email-nhorman@tuxdriver.com>
References: <1355944006-27234-1-git-send-email-nhorman@tuxdriver.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In addition to the unshare syscall, there exists the setns syscall, which allows
processes to migrate to the namepsaces of other processes.  Add this
functionality into the unshare command, as they operate in a fairly simmilar
fashion.

Note: There was discussion of adding a path based namespace argument to unshare
in the origional discussion thread, but I opted to leave that out as it didn't
seem to fit in nicely with the current argument pattern.  I figure we can always
add that in later if we need to

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
CC: Karel Zak <kzak@redhat.com>
---
 sys-utils/unshare.1 | 31 +++++++++++++---------
 sys-utils/unshare.c | 74 ++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 78 insertions(+), 27 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 1325e34..2478f04 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -3,15 +3,15 @@
 .\"
 .TH UNSHARE 1 "October 2008" "util-linux" "User Commands"
 .SH NAME
-unshare \- run program with some namespaces unshared from parent
+unshare \- run program with some namespaces unshared or changed from parent
 .SH SYNOPSIS
 .B unshare
 .RI [ options ]
 program
 .RI [ arguments ]
 .SH DESCRIPTION
-Unshares specified namespaces from parent process and then executes specified
-program. Unshareable namespaces are:
+Unshares or migrates specified namespaces from parent process and then executes specified
+program. Available namespaces are:
 .TP
 .BR "mount namespace"
 mounting and unmounting filesystems will not affect rest of the system
@@ -32,32 +32,39 @@ rules, the \fI/proc/net\fP and \fI/sys/class/net\fP directory trees, sockets
 etc. (\fBCLONE_NEWNET\fP flag).
 .TP
 See the \fBclone\fR(2) for exact semantics of the flags.
+.TP
 .SH OPTIONS
 .TP
 .BR \-h , " \-\-help"
 Print a help message,
 .TP
-.BR \-m , " \-\-mount"
-Unshare the mount namespace,
+.BR \-m\ [pid] , " \-\-mount[=pid]"
+Unshare the mount namespace, or, when a pid is specified, migrate the mount
+namespace to the one attached to the specified pid
 .TP
-.BR \-u , " \-\-uts"
-Unshare the UTC namespace,
+.BR \-u\ [pid] , " \-\-uts[=pid]"
+Unshare the UTC namespace, or, when a pid is specified, migrate the uts
+namespace to the one attached to the specified pid
 .TP
-.BR \-i , " \-\-ipc"
-Unshare the IPC namespace,
+.BR \-i\ [pid] , " \-\-ipc[=pid]"
+Unshare the IPC namespace, or, when a pid is specified, migrate the ipc
+namespace to the one attached to the specified pid
 .TP
-.BR \-n , " \-\-net"
-Unshare the network namespace.
+.BR \-n\ [pid] , " \-\-net[=pid]"
+Unshare the network namespace, or, when a pid is specified, migrate the net
+namespace to the one attached to the specified pid
 .SH NOTES
 The unshare command drops potential privileges before executing the
 target program. This allows to setuid unshare.
 .SH SEE ALSO
 .BR unshare (2),
+.BR setns (2),
 .BR clone (2)
 .SH BUGS
 None known so far.
-.SH AUTHOR
+.SH AUTHORS
 Mikhail Gusarov <dottedmag@dottedmag.net>
+Neil Horman <nhorman@tuxdriver.com>
 .SH AVAILABILITY
 The unshare command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 9de997b..f0af2c5 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -24,6 +24,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <getopt.h>
 
 #include "nls.h"
 #include "c.h"
@@ -42,6 +43,9 @@
 # define CLONE_NEWNET 0x40000000
 #endif
 
+#define NUM_ENTRIES 128
+static int ns_pids[128];
+
 #ifndef HAVE_UNSHARE
 # include <sys/syscall.h>
 
@@ -60,10 +64,10 @@ static void usage(int status)
 	      _(" %s [options] <program> [args...]\n"),	program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -m, --mount       unshare mounts namespace\n"
-		" -u, --uts         unshare UTS namespace (hostname etc)\n"
-		" -i, --ipc         unshare System V IPC namespace\n"
-		" -n, --net         unshare network namespace\n"), out);
+	fputs(_(" -m, --mount       unshare|migrate mounts namespace\n"
+		" -u, --uts         unshare|migrate UTS namespace (hostname etc)\n"
+		" -i, --ipc         unshare|migrate System V IPC namespace\n"
+		" -n, --net         unshare|migrate network namespace\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
@@ -73,28 +77,42 @@ static void usage(int status)
 	exit(status);
 }
 
+static void close_files(void)
+{
+	int i;
+	for (i=0; ns_pids[i] > 0; i++)
+		close(ns_pids[i]);
+	close_stdout();
+}
+
 int main(int argc, char *argv[])
 {
 	static const struct option longopts[] = {
 		{ "help", no_argument, 0, 'h' },
 		{ "version", no_argument, 0, 'V'},
-		{ "mount", no_argument, 0, 'm' },
-		{ "uts", no_argument, 0, 'u' },
-		{ "ipc", no_argument, 0, 'i' },
-		{ "net", no_argument, 0, 'n' },
+		{ "mount", optional_argument, 0, 'm' },
+		{ "uts", optional_argument, 0, 'u' },
+		{ "ipc", optional_argument, 0, 'i' },
+		{ "net", optional_argument, 0, 'n' },
 		{ NULL, 0, 0, 0 }
 	};
 
 	int unshare_flags = 0;
-
+	int nscount = 0;
 	int c;
+	char *ns;
+	unsigned long pid;
+	char path[512];
 
+	memset(ns_pids, 0, sizeof(int)*NUM_ENTRIES);
 	setlocale(LC_MESSAGES, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
-	atexit(close_stdout);
+	atexit(close_files);
+
+	while((c = getopt_long(argc, argv, "hVm:u:i:n:", longopts, NULL)) != -1) {
+		ns = NULL;
 
-	while((c = getopt_long(argc, argv, "hVmuin", longopts, NULL)) != -1) {
 		switch(c) {
 		case 'h':
 			usage(EXIT_SUCCESS);
@@ -102,25 +120,51 @@ int main(int argc, char *argv[])
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
 		case 'm':
-			unshare_flags |= CLONE_NEWNS;
+			ns = "mount";
+			if (!optarg)
+				unshare_flags |= CLONE_NEWNS;
 			break;
 		case 'u':
-			unshare_flags |= CLONE_NEWUTS;
+			ns = "uts";
+			if (!optarg)
+				unshare_flags |= CLONE_NEWUTS;
 			break;
 		case 'i':
-			unshare_flags |= CLONE_NEWIPC;
+			ns = "ipc";
+			if (!optarg)
+				unshare_flags |= CLONE_NEWIPC;
 			break;
 		case 'n':
-			unshare_flags |= CLONE_NEWNET;
+			ns = "net";
+			if (!optarg)
+				unshare_flags |= CLONE_NEWNET;
 			break;
 		default:
 			usage(EXIT_FAILURE);
 		}
+
+		if (optarg && ns) {
+				if (nscount >= NUM_ENTRIES)
+					err(EXIT_FAILURE, _("Too many new namespaces specified"));
+				pid = strtoul(optarg, NULL, 10);
+				if (pid == ULONG_MAX)
+					err(EXIT_FAILURE, _("%s pid improperly specified"), ns);
+				sprintf(path, "/proc/%d/ns/%s", (int)pid, ns); 
+				ns_pids[nscount] = open(path, O_RDONLY);
+				if (ns_pids[nscount] < 0)
+					err(EXIT_FAILURE, _("could not open %s"), path);
+				nscount++;
+		}
+		
 	}
 
 	if(optind >= argc)
 		usage(EXIT_FAILURE);
 
+	for (nscount = 0; ns_pids[nscount] > 0; nscount++)
+		if (-1 == setns(ns_pids[nscount], 0))
+			err(EXIT_FAILURE, _("setns failed"));
+	
 	if(-1 == unshare(unshare_flags))
 		err(EXIT_FAILURE, _("unshare failed"));
 
-- 
1.7.11.7

