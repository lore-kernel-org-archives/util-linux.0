Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56643 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755439AbbDILWp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 9 Apr 2015 07:22:45 -0400
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Karel Zak <kzak@redhat.com>
Subject: [PATCH 1/2] unshare: allow persisting namespaces
Date: Thu,  9 Apr 2015 13:22:15 +0200
Message-Id: <1428578536-31603-1-git-send-email-kzak@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

For nsenter(1) we already support namespace specification by file
(e.g. bind mount to namespace /proc/[pid]/ns/[type] file). For
example:

  # nsenter --uts=/some/path

This patch extends unshare(1) to setup the bind mount for specified
namespace, for example

  # touch /some/path
  # unshare --uts=/some/path hostname FOO
  # nsenter --uts=/some/path hostname
  FOO

Note that the problem is mount namespace, because create bind mount
to ns/mount file within unshared namespace does not make sense.

Based on patch from Lubomir Rintel <lkundrak@v3.sk>.

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 sys-utils/unshare.1 | 70 +++++++++++++++++++++++++++++-----------
 sys-utils/unshare.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 132 insertions(+), 31 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 6fc71f4..14755e7 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -8,8 +8,17 @@ unshare \- run program with some namespaces unshared from parent
 .RI [ arguments ]
 .SH DESCRIPTION
 Unshares the indicated namespaces from the parent process and then executes
-the specified \fIprogram\fR.  The namespaces to be unshared are indicated via
-options.  Unshareable namespaces are:
+the specified \fIprogram\fR.
+.PP
+The namespaces can optionally be persisted by bind mounting /proc/[pid]/ns/[type] files
+to a filesystem path and entered with
+.BR nsenter (1)
+even after \fIprogram\fR terminates.
+Once a persistent namespace is no longer needed it can be unpersisted with
+.BR umount (8).
+See EXAMPLES section for more details.
+.PP
+The namespaces to be unshared are indicated via options.  Unshareable namespaces are:
 .TP
 .BR "mount namespace"
 Mounting and unmounting filesystems will not affect the rest of the system
@@ -47,24 +56,29 @@ The process will have a distinct set of UIDs, GIDs and capabilities.
 See \fBclone\fR(2) for the exact semantics of the flags.
 .SH OPTIONS
 .TP
-.BR \-i , " \-\-ipc"
-Unshare the IPC namespace.
+.BR \-i , " \-\-ipc"[=\fIfile\fP]
+Unshare the IPC namespace. If \fIfile\fP is specified then persistent namespace is created
+by bind mount.
 .TP
-.BR \-m , " \-\-mount"
-Unshare the mount namespace.
+.BR \-m , " \-\-mount"[=\fIfile\fP]
+Unshare the mount namespace. If \fIfile\fP is specified then persistent namespace is created
+by bind mount.
 .TP
-.BR \-n , " \-\-net"
-Unshare the network namespace.
+.BR \-n , " \-\-net"[=\fIfile\fP]
+Unshare the network namespace. If \fIfile\fP is specified then persistent namespace is created
+by bind mount.
 .TP
-.BR \-p , " \-\-pid"
-Unshare the pid namespace.
-See also the \fB--fork\fP and \fB--mount-proc\fP options.
+.BR \-p , " \-\-pid"[=\fIfile\fP]
+Unshare the pid namespace. If \fIfile\fP is specified then persistent namespace is created
+by bind mount. See also the \fB--fork\fP and \fB--mount-proc\fP options.
 .TP
-.BR \-u , " \-\-uts"
-Unshare the UTS namespace.
+.BR \-u , " \-\-uts"[=\fIfile\fP]
+Unshare the UTS namespace. If \fIfile\fP is specified then persistent namespace is created
+by bind mount.
 .TP
-.BR \-U , " \-\-user"
-Unshare the user namespace.
+.BR \-U , " \-\-user"[=\fIfile\fP]
+Unshare the user namespace. If \fIfile\fP is specified then persistent namespace is created
+by bind mount.
 .TP
 .BR \-f , " \-\-fork"
 Fork the specified \fIprogram\fR as a child process of \fBunshare\fR rather than
@@ -125,14 +139,32 @@ procfs instance.
 root
 .br
 Establish a user namespace as an unprivileged user with a root user within it.
+.TP
+.TQ
+.B # touch /root/uts-ns
+.TQ
+.B # unshare --uts=/root/uts-ns hostanme FOO
+.TQ
+.B # nsenter --uts=/root/uts-ns hostname
+.TQ
+FOO
+.TQ
+.B # umount /root/uts-ns
+.br
+Establish a persistent UTS namespace, modify hostname. The namespace maybe later entered
+by nsenter. The namespace is destroyed by umount the bind reference.
 .SH SEE ALSO
 .BR unshare (2),
 .BR clone (2),
 .BR mount (8)
-.SH BUGS
-None known so far.
-.SH AUTHOR
-Mikhail Gusarov <dottedmag@dottedmag.net>
+.SH AUTHORS
+.UR dottedmag@dottedmag.net
+Mikhail Gusarov
+.UE
+.br
+.UR kzak@redhat.com
+Karel Zak
+.UE
 .SH AVAILABILITY
 The unshare command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 18a7c7b..65d3e61 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -42,6 +42,24 @@
 /* 'private' is kernel default */
 #define UNSHARE_PROPAGATION_DEFAULT	(MS_REC | MS_PRIVATE)
 
+/* /proc namespace files and mountpoints for binds */
+static struct namespace_file {
+	int		type;		/* CLONE_NEW* */
+	const char	*name;		/* ns/<type> */
+	const char	*target;	/* user specified target for bind mount */
+} namespace_files[] = {
+	{ .type = CLONE_NEWUSER, .name = "ns/user" },
+	{ .type = CLONE_NEWIPC,  .name = "ns/ipc"  },
+	{ .type = CLONE_NEWUTS,  .name = "ns/uts"  },
+	{ .type = CLONE_NEWNET,  .name = "ns/net"  },
+	{ .type = CLONE_NEWPID,  .name = "ns/pid"  },
+	{ .type = CLONE_NEWNS,   .name = "ns/mnt"  },
+	{ .name = NULL }
+};
+
+static int npersists;	/* number of persistent namespaces */
+
+
 enum {
 	SETGROUPS_NONE = -1,
 	SETGROUPS_DENY = 0,
@@ -133,6 +151,40 @@ static void set_propagation(unsigned long flags)
 		err(EXIT_FAILURE, _("cannot change root filesystem propagation"));
 }
 
+
+static int set_ns_target(int type, const char *path)
+{
+	struct namespace_file *ns;
+
+	for (ns = namespace_files; ns->name; ns++) {
+		if (ns->type != type)
+			continue;
+		ns->target = path;
+		npersists++;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int bind_ns_files(pid_t pid)
+{
+	struct namespace_file *ns;
+	char src[PATH_MAX];
+
+	for (ns = namespace_files; ns->name; ns++) {
+		if (!ns->target)
+			continue;
+
+		snprintf(src, sizeof(src), "/proc/%u/%s", (unsigned) pid, ns->name);
+
+		if (mount(src, ns->target, NULL, MS_BIND, NULL) != 0)
+			err(EXIT_FAILURE, _("mount %s on %s failed"), src, ns->target);
+	}
+
+	return 0;
+}
+
 static void usage(int status)
 {
 	FILE *out = status == EXIT_SUCCESS ? stdout : stderr;
@@ -145,12 +197,12 @@ static void usage(int status)
 	fputs(_("Run a program with some namespaces unshared from the parent.\n"), out);
 
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
@@ -176,12 +228,14 @@ int main(int argc, char *argv[])
 	static const struct option longopts[] = {
 		{ "help", no_argument, 0, 'h' },
 		{ "version", no_argument, 0, 'V'},
-		{ "mount", no_argument, 0, 'm' },
-		{ "uts", no_argument, 0, 'u' },
-		{ "ipc", no_argument, 0, 'i' },
-		{ "net", no_argument, 0, 'n' },
-		{ "pid", no_argument, 0, 'p' },
-		{ "user", no_argument, 0, 'U' },
+
+		{ "mount", optional_argument, 0, 'm' },
+		{ "uts",   optional_argument, 0, 'u' },
+		{ "ipc",   optional_argument, 0, 'i' },
+		{ "net",   optional_argument, 0, 'n' },
+		{ "pid",   optional_argument, 0, 'p' },
+		{ "user",  optional_argument, 0, 'U' },
+
 		{ "fork", no_argument, 0, 'f' },
 		{ "mount-proc", optional_argument, 0, OPT_MOUNTPROC },
 		{ "map-root-user", no_argument, 0, 'r' },
@@ -215,21 +269,33 @@ int main(int argc, char *argv[])
 			return EXIT_SUCCESS;
 		case 'm':
 			unshare_flags |= CLONE_NEWNS;
+			if (optarg)
+				set_ns_target(CLONE_NEWNS, optarg);
 			break;
 		case 'u':
 			unshare_flags |= CLONE_NEWUTS;
+			if (optarg)
+				set_ns_target(CLONE_NEWUTS, optarg);
 			break;
 		case 'i':
 			unshare_flags |= CLONE_NEWIPC;
+			if (optarg)
+				set_ns_target(CLONE_NEWIPC, optarg);
 			break;
 		case 'n':
 			unshare_flags |= CLONE_NEWNET;
+			if (optarg)
+				set_ns_target(CLONE_NEWNET, optarg);
 			break;
 		case 'p':
 			unshare_flags |= CLONE_NEWPID;
+			if (optarg)
+				set_ns_target(CLONE_NEWPID, optarg);
 			break;
 		case 'U':
 			unshare_flags |= CLONE_NEWUSER;
+			if (optarg)
+				set_ns_target(CLONE_NEWUSER, optarg);
 			break;
 		case OPT_MOUNTPROC:
 			unshare_flags |= CLONE_NEWNS;
@@ -273,6 +339,9 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (npersists)
+		bind_ns_files(getpid());
+
 	if (maproot) {
 		if (setgrpcmd == SETGROUPS_ALLOW)
 			errx(EXIT_FAILURE, _("options --setgroups=allow and "
-- 
2.1.0

