Return-Path: ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
References: <876234812z.fsf@xmission.com> <20130111161320.GA16206@x2.net.home>
Date: Fri, 11 Jan 2013 14:53:34 -0800
In-Reply-To: <20130111161320.GA16206@x2.net.home> (Karel Zak's message of
	"Fri, 11 Jan 2013 17:13:20 +0100")
Message-ID: <8738y7jpqp.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH] unshare: Add support for the pid and user namespaces
List-ID: <util-linux.vger.kernel.org>


- Update the unshare application to support the pid and user namespaces.
- Update the man page for the new options
- Fix typo in the man page where UTS was spelled UTC.
- Remove the vestigal support for running a suid unshare.
  After unsharing a user namespace setuid(getuid()) won't work because
  no uid or gid mappings have been specified yet. So it is just easier not
  to have any support for running suid.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

This is on top of unshare with Neil's unshare patch reverted.

 sys-utils/unshare.1 |   19 +++++++++++++++----
 sys-utils/unshare.c |   27 ++++++++++++++++++---------
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 1325e34..8cdc6e5 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -1,7 +1,7 @@
 .\" Process this file with
 .\" groff -man -Tascii lscpu.1
 .\"
-.TH UNSHARE 1 "October 2008" "util-linux" "User Commands"
+.TH UNSHARE 1 "January 2013" "util-linux" "User Commands"
 .SH NAME
 unshare \- run program with some namespaces unshared from parent
 .SH SYNOPSIS
@@ -31,6 +31,13 @@ process will have independent IPv4 and IPv6 stacks, IP routing tables, firewall
 rules, the \fI/proc/net\fP and \fI/sys/class/net\fP directory trees, sockets
 etc. (\fBCLONE_NEWNET\fP flag).
 .TP
+.BR "pid namespace"
+children will have a distinct set of pid to process mappings than their parent.
+(\fBCLONE_NEWPID\fP flag).
+.TP
+.BR "user namespace"
+process will have distinct set of uids, gids and capabilities. (\fBCLONE_NEWUSER\fP flag).
+.TP
 See the \fBclone\fR(2) for exact semantics of the flags.
 .SH OPTIONS
 .TP
@@ -41,16 +48,20 @@ Print a help message,
 Unshare the mount namespace,
 .TP
 .BR \-u , " \-\-uts"
-Unshare the UTC namespace,
+Unshare the UTS namespace,
 .TP
 .BR \-i , " \-\-ipc"
 Unshare the IPC namespace,
 .TP
 .BR \-n , " \-\-net"
 Unshare the network namespace.
+.TP
+.BR \-p , " \-\-pid"
+Unshare the pid namespace.
+.TP
+.BR \-U , " \-\-user"
+Unshare the user namespace.
 .SH NOTES
-The unshare command drops potential privileges before executing the
-target program. This allows to setuid unshare.
 .SH SEE ALSO
 .BR unshare (2),
 .BR clone (2)
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 9de997b..00cc2cf 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -41,6 +41,12 @@
 #ifndef CLONE_NEWNET
 # define CLONE_NEWNET 0x40000000
 #endif
+#ifndef CLONE_NEWUSER
+# define CLONE_NEWUSER 0x10000000
+#endif
+#ifndef CLONE_NEWPID
+# define CLONE_NEWPID 0x20000000
+#endif
 
 #ifndef HAVE_UNSHARE
 # include <sys/syscall.h>
@@ -63,7 +69,9 @@ static void usage(int status)
 	fputs(_(" -m, --mount       unshare mounts namespace\n"
 		" -u, --uts         unshare UTS namespace (hostname etc)\n"
 		" -i, --ipc         unshare System V IPC namespace\n"
-		" -n, --net         unshare network namespace\n"), out);
+		" -n, --net         unshare network namespace\n"
+		" -p, --pid         unshare pid namespace\n"
+		" -U, --user        unshare user namespace\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
@@ -82,6 +90,8 @@ int main(int argc, char *argv[])
 		{ "uts", no_argument, 0, 'u' },
 		{ "ipc", no_argument, 0, 'i' },
 		{ "net", no_argument, 0, 'n' },
+		{ "pid", no_argument, 0, 'p' },
+		{ "user", no_argument, 0, 'U' },
 		{ NULL, 0, 0, 0 }
 	};
 
@@ -94,7 +104,7 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while((c = getopt_long(argc, argv, "hVmuin", longopts, NULL)) != -1) {
+	while((c = getopt_long(argc, argv, "hVmuinpU", longopts, NULL)) != -1) {
 		switch(c) {
 		case 'h':
 			usage(EXIT_SUCCESS);
@@ -113,6 +123,12 @@ int main(int argc, char *argv[])
 		case 'n':
 			unshare_flags |= CLONE_NEWNET;
 			break;
+		case 'p':
+			unshare_flags |= CLONE_NEWPID;
+			break;
+		case 'U':
+			unshare_flags |= CLONE_NEWUSER;
+			break;
 		default:
 			usage(EXIT_FAILURE);
 		}
@@ -124,13 +140,6 @@ int main(int argc, char *argv[])
 	if(-1 == unshare(unshare_flags))
 		err(EXIT_FAILURE, _("unshare failed"));
 
-	/* drop potential root euid/egid if we had been setuid'd */
-	if (setgid(getgid()) < 0)
-		err(EXIT_FAILURE, _("cannot set group id"));
-
-	if (setuid(getuid()) < 0)
-		err(EXIT_FAILURE, _("cannot set user id"));
-
 	execvp(argv[optind], argv + optind);
 
 	err(EXIT_FAILURE, _("exec %s failed"), argv[optind]);
-- 
1.7.5.4
