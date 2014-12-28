Return-Path: util-linux-owner@vger.kernel.org
Received: from shell.v3.sk ([195.168.3.45]:52630 "EHLO shell.v3.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776AbaL1UfA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 28 Dec 2014 15:35:00 -0500
From: Lubomir Rintel <lkundrak@v3.sk>
To: util-linux@vger.kernel.org
Cc: Mikhail Gusarov <dottedmag@dottedmag.net>, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/2] unshare: allow persisting namespaces
Date: Sun, 28 Dec 2014 21:23:38 +0100
Message-Id: <1419798218-3174-2-git-send-email-lkundrak@v3.sk>
In-Reply-To: <1419798218-3174-1-git-send-email-lkundrak@v3.sk>
References: <1419798218-3174-1-git-send-email-lkundrak@v3.sk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Bind mount the namespace file to a given location after creating it if
requested (analogously to what "ip netns" and other tools do). This makes
it possible for a namespace to survive with no processes running while
processes can enter it with nsenter(1):

  # unshare --uts=utsns hostname behemoth
  # nsenter --uts=utsns hostname
  behemoth
  # umount utsns; rm utsns
  #

The ugly bit about this patch is the clone(2) call, arguably not our
fault. The stack size glibc requires for its clone(2) wrapper is not
documented anywhere and its semantics (stack growth direction) is arch
dependent. We could figure it out by comparing a return value of a helper
function that would return an address of its local variable with caller's
local variable address, but I guess that would be even more messed-up.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 sys-utils/unshare.1 |  58 +++++++++++++++-------
 sys-utils/unshare.c | 135 +++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 159 insertions(+), 34 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 3f9eccd..625a03a 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -11,8 +11,15 @@ unshare \- run program with some namespaces unshared from parent
 .RI [ arguments ]
 .SH DESCRIPTION
 Unshares the indicated namespaces from the parent process and then executes
-the specified \fIprogram\fR.  The namespaces to be unshared are indicated via
-options.  Unshareable namespaces are:
+the specified \fIprogram\fR.
+.PP
+The namespaces can optionally be persisted by mounting to a file system path
+and entered with \fBnsenter\fR even after \fIprogram\fR terminates.  Once a
+persistent namespace is no longer needed it can be unpersisted with \fBumount\fR
+and the name can be removed with \fBrm\fR.
+.PP
+The namespaces to be unshared are indicated via options.  Unshareable namespaces
+are:
 .TP
 .BR "mount namespace"
 Mounting and unmounting filesystems will not affect the rest of the system
@@ -48,24 +55,31 @@ The process will have a distinct set of UIDs, GIDs and capabilities.
 See \fBclone\fR(2) for the exact semantics of the flags.
 .SH OPTIONS
 .TP
-.BR \-i , " \-\-ipc"
-Unshare the IPC namespace.
+\fB\-i\fR, \fB\-\-ipc\fR[=\fIfile\fR]
+Unshare the IPC namespace.  If file is specified, persist the IPC namespace at
+the given path.
 .TP
-.BR \-m , " \-\-mount"
-Unshare the mount namespace.
+\fB\-m\fR, \fB\-\-mount\fR[=\fIfile\fR]
+Unshare the mount namespace.  If file is specified, fork (as if \fB\-\-fork\fR was
+specified) and persist the mount namespace at the given path in the parent's mount
+namespace.
 .TP
-.BR \-n , " \-\-net"
-Unshare the network namespace.
+\fB\-n\fR, \fB\-\-net\fR[=\fIfile\fR]
+Unshare the network namespace.  If file is specified, persist the network namespace at
+the given path.
 .TP
-.BR \-p , " \-\-pid"
-Unshare the pid namespace.
+\fB\-p\fR, \fB\-\-pid\fR[=\fIfile\fR]
+Unshare the pid namespace.  If file is specified, persist the pid namespace at
+the given path.
 See also the \fB--fork\fP and \fB--mount-proc\fP options.
 .TP
-.BR \-u , " \-\-uts"
-Unshare the UTS namespace.
+\fB\-u\fR, \fB\-\-uts\fR[=\fIfile\fR]
+Unshare the UTS namespace.  If file is specified, persist the UTS namespace at
+the given path.
 .TP
-.BR \-U , " \-\-user"
-Unshare the user namespace.
+\fB\-U\fR, \fB\-\-user\fR[=\fIfile\fR]
+Unshare the user namespace.  If file is specified, persist the user namespace at
+the given path.
 .TP
 .BR \-f , " \-\-fork"
 Fork the specified \fIprogram\fR as a child process of \fBunshare\fR rather than
@@ -105,14 +119,26 @@ procfs instance.
 root
 .br
 Establish a user namespace as an unprivileged user with a root user within it.
+.TP
+.B # unshare --uts=utsns hostname behemoth
+.TQ
+.B # nsenter --uts=utsns hostname
+.TQ
+behemoth
+.TQ
+.B # umount utsns; rm utsns
+.br
+Create a persistent UTS namespace and tear it down.
 .SH SEE ALSO
 .BR unshare (2),
 .BR clone (2),
-.BR mount (8)
+.BR mount (8),
+.BR umount (8)
 .SH BUGS
 None known so far.
 .SH AUTHOR
-Mikhail Gusarov <dottedmag@dottedmag.net>
+Mikhail Gusarov <dottedmag@dottedmag.net>,
+Lubomir Rintel <lkundrak@v3.sk>
 .SH AVAILABILITY
 The unshare command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 933f621..a8569b9 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -2,6 +2,7 @@
  * unshare(1) - command-line interface for unshare(2)
  *
  * Copyright (C) 2009 Mikhail Gusarov <dottedmag@dottedmag.net>
+ * Copyright (C) 2013,2014 Lubomir Rintel <lkundrak@v3.sk>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -24,8 +25,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <setjmp.h>
 #include <sys/wait.h>
 #include <sys/mount.h>
+#include <sys/stat.h>
 
 /* we only need some defines missing in sys/mount.h, no libmount linkage */
 #include <libmount.h>
@@ -39,6 +42,41 @@
 #include "pathnames.h"
 #include "all-io.h"
 
+static struct namespace_file {
+	int nstype;
+	const char *proc_name;
+	const char *target_name;
+} namespace_files[] = {
+	{ .nstype = CLONE_NEWUSER, .proc_name = "ns/user", .target_name = NULL },
+	{ .nstype = CLONE_NEWIPC,  .proc_name = "ns/ipc",  .target_name = NULL },
+	{ .nstype = CLONE_NEWUTS,  .proc_name = "ns/uts",  .target_name = NULL },
+	{ .nstype = CLONE_NEWNET,  .proc_name = "ns/net",  .target_name = NULL },
+	{ .nstype = CLONE_NEWPID,  .proc_name = "ns/pid",  .target_name = NULL },
+	{ .nstype = CLONE_NEWNS,   .proc_name = "ns/mnt",  .target_name = NULL },
+	{ .nstype = 0, .proc_name = NULL, .target_name = NULL }
+};
+
+int c, forkit = 0, maproot = 0;
+const char *procmnt = NULL;
+
+static int ns_path(int nstype, const char *path)
+{
+	struct namespace_file *nsfile;
+
+	if (path == NULL)
+		return 0;
+
+	for (nsfile = namespace_files; nsfile->nstype; nsfile++) {
+		if (nstype != nsfile->nstype)
+			continue;
+
+		nsfile->target_name = path;
+		break;
+	}
+
+	return 1;
+}
+
 static void map_id(const char *file, uint32_t from, uint32_t to)
 {
 	char *buf;
@@ -64,12 +102,12 @@ static void usage(int status)
 		program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -m, --mount               unshare mounts namespace\n"), out);
-	fputs(_(" -u, --uts                 unshare UTS namespace (hostname etc)\n"), out);
-	fputs(_(" -i, --ipc                 unshare System V IPC namespace\n"), out);
-	fputs(_(" -n, --net                 unshare network namespace\n"), out);
-	fputs(_(" -p, --pid                 unshare pid namespace\n"), out);
-	fputs(_(" -U, --user                unshare user namespace\n"), out);
+	fputs(_(" -m, --mount[=<file>]      unshare mounts namespace\n"), out);
+	fputs(_(" -u, --uts[=<file>]        unshare UTS namespace (hostname etc)\n"), out);
+	fputs(_(" -i, --ipc[=<file>]        unshare System V IPC namespace\n"), out);
+	fputs(_(" -n, --net[=<file>]        unshare network namespace\n"), out);
+	fputs(_(" -p, --pid[=<file>]        unshare pid namespace\n"), out);
+	fputs(_(" -U, --user[=<file>]       unshare user namespace\n"), out);
 	fputs(_(" -f, --fork                fork before launching <program>\n"), out);
 	fputs(_("     --mount-proc[=<dir>]  mount proc filesystem first (implies --mount)\n"), out);
 	fputs(_(" -r, --map-root-user       map current user to root (implies --user)\n"), out);
@@ -82,6 +120,61 @@ static void usage(int status)
 	exit(status);
 }
 
+static void persist_ns(pid_t pid)
+{
+	struct namespace_file *nsfile;
+
+	for (nsfile = namespace_files; nsfile->nstype; nsfile++) {
+		char pathbuf[PATH_MAX];
+
+		if (!nsfile->target_name)
+			continue;
+
+		snprintf(pathbuf, sizeof(pathbuf), "/proc/%u/%s", pid,
+			nsfile->proc_name);
+
+		umount(nsfile->target_name);
+		unlink(nsfile->target_name);
+
+		if (-1 == mknod(nsfile->target_name, 0666, 0)) {
+			warn(_("failed to create %s"), nsfile->target_name);
+			continue;
+		}
+
+		if (-1 == mount(pathbuf, nsfile->target_name, NULL, MS_BIND, NULL)) {
+			warn(_("mount %s failed"), nsfile->target_name);
+			unlink(nsfile->target_name);
+		}
+	}
+}
+
+static int in_child (void *arg)
+{
+	jmp_buf *child = arg;
+
+	longjmp(*child, 1);
+}
+
+#define STACK_SIZE 0x100000
+static pid_t unshare_fork(int unshare_flags)
+{
+	/* Twice the size, as we might be running of parisc
+	 * or metag where stack grows the other way. *sigh* */
+	static char stack[2*STACK_SIZE];
+	static jmp_buf child;
+	pid_t pid;
+
+	if (setjmp (child))
+		return 0;
+
+	pid = clone(in_child, &stack[STACK_SIZE],
+		SIGCHLD | unshare_flags, &child);
+	if (pid != -1)
+		persist_ns(pid);
+
+	return pid;
+}
+
 int main(int argc, char *argv[])
 {
 	enum {
@@ -90,12 +183,12 @@ int main(int argc, char *argv[])
 	static const struct option longopts[] = {
 		{ "help", no_argument, 0, 'h' },
 		{ "version", no_argument, 0, 'V'},
-		{ "mount", no_argument, 0, 'm' },
-		{ "uts", no_argument, 0, 'u' },
-		{ "ipc", no_argument, 0, 'i' },
-		{ "net", no_argument, 0, 'n' },
-		{ "pid", no_argument, 0, 'p' },
-		{ "user", no_argument, 0, 'U' },
+		{ "mount", optional_argument, 0, 'm' },
+		{ "uts", optional_argument, 0, 'u' },
+		{ "ipc", optional_argument, 0, 'i' },
+		{ "net", optional_argument, 0, 'n' },
+		{ "pid", optional_argument, 0, 'p' },
+		{ "user", optional_argument, 0, 'U' },
 		{ "fork", no_argument, 0, 'f' },
 		{ "mount-proc", optional_argument, 0, OPT_MOUNTPROC },
 		{ "map-root-user", no_argument, 0, 'r' },
@@ -103,8 +196,6 @@ int main(int argc, char *argv[])
 	};
 
 	int unshare_flags = 0;
-	int c, forkit = 0, maproot = 0;
-	const char *procmnt = NULL;
 	uid_t real_euid = geteuid();
 	gid_t real_egid = getegid();;
 
@@ -125,21 +216,28 @@ int main(int argc, char *argv[])
 			return EXIT_SUCCESS;
 		case 'm':
 			unshare_flags |= CLONE_NEWNS;
+			if (ns_path(CLONE_NEWNS, optarg))
+				forkit = 1;
 			break;
 		case 'u':
 			unshare_flags |= CLONE_NEWUTS;
+			ns_path(CLONE_NEWUTS, optarg);
 			break;
 		case 'i':
 			unshare_flags |= CLONE_NEWIPC;
+			ns_path(CLONE_NEWIPC, optarg);
 			break;
 		case 'n':
 			unshare_flags |= CLONE_NEWNET;
+			ns_path(CLONE_NEWNET, optarg);
 			break;
 		case 'p':
 			unshare_flags |= CLONE_NEWPID;
+			ns_path(CLONE_NEWPID, optarg);
 			break;
 		case 'U':
 			unshare_flags |= CLONE_NEWUSER;
+			ns_path(CLONE_NEWUSER, optarg);
 			break;
 		case OPT_MOUNTPROC:
 			unshare_flags |= CLONE_NEWNS;
@@ -154,12 +252,9 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (-1 == unshare(unshare_flags))
-		err(EXIT_FAILURE, _("unshare failed"));
-
 	if (forkit) {
 		int status;
-		pid_t pid = fork();
+		pid_t pid = unshare_fork(unshare_flags);
 
 		switch(pid) {
 		case -1:
@@ -175,6 +270,10 @@ int main(int argc, char *argv[])
 				kill(getpid(), WTERMSIG(status));
 			err(EXIT_FAILURE, _("child exit failed"));
 		}
+	} else {
+		if (-1 == unshare(unshare_flags))
+			err(EXIT_FAILURE, _("unshare failed"));
+		persist_ns(getpid());
 	}
 
 	if (maproot) {
-- 
2.1.0

