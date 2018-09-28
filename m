Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.135]:53089 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1TJK (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 28 Sep 2018 15:09:10 -0400
From: Laurent Vivier <laurent@vivier.eu>
To: util-linux@vger.kernel.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 1/2] unshare: allow to set a new root
Date: Fri, 28 Sep 2018 14:45:11 +0200
Message-Id: <20180928124512.13979-2-laurent@vivier.eu>
In-Reply-To: <20180928124512.13979-1-laurent@vivier.eu>
References: <20180928124512.13979-1-laurent@vivier.eu>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch instroduces two new parameters to set the new
root and the new working directory in this new root.

This allows to combine "unshare chroot" in one command,
and doing like this the /proc filesystem is correctly
mounted in the new root with "--mount-proc".

The new parameters are -R, --root and -w, --wd. The names
are the same as for nsenter, except for "-r" that is already
used by "--map-root-user" and replaced by "-R".

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 bash-completion/unshare |  4 +++-
 sys-utils/unshare.1     |  6 ++++++
 sys-utils/unshare.c     | 25 +++++++++++++++++++++++--
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/bash-completion/unshare b/bash-completion/unshare
index 3fda4a194..64aea6784 100644
--- a/bash-completion/unshare
+++ b/bash-completion/unshare
@@ -33,7 +33,9 @@ _unshare_module()
 				--propagation
 				--setgroups
 				--help
-				--version"
+				--version
+				--root
+				--wd"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 746c41152..40cbedbd1 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -186,6 +186,12 @@ the GID map becomes writable by unprivileged processes when
 .BR \%setgroups (2)
 is permanently disabled (with \fBdeny\fR).
 .TP
+.BR \-R, "\-\-root=\fIdir"
+run the command with root directory set to \fIdir\fP.
+.TP
+.BR \-w, "\-\-wd=\fIdir"
+change working directory to \fIdir\fP.
+.TP
 .BR \-V , " \-\-version"
 Display version information and exit.
 .TP
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 661665aeb..be2950a36 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -269,6 +269,9 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" --propagation slave|shared|private|unchanged\n"
 	        "                           modify mount propagation in mount namespace\n"), out);
 	fputs(_(" --setgroups allow|deny    control the setgroups syscall in user namespaces\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_(" -R, --root=<dir>	    run the command with root directory set to <dir>\n"), out);
+	fputs(_(" -w, --wd=<dir>	    change working directory to <dir>\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	printf(USAGE_HELP_OPTIONS(27));
@@ -283,7 +286,7 @@ int main(int argc, char *argv[])
 		OPT_MOUNTPROC = CHAR_MAX + 1,
 		OPT_PROPAGATION,
 		OPT_SETGROUPS,
-		OPT_KILLCHILD
+		OPT_KILLCHILD,
 	};
 	static const struct option longopts[] = {
 		{ "help",          no_argument,       NULL, 'h'             },
@@ -303,6 +306,8 @@ int main(int argc, char *argv[])
 		{ "map-root-user", no_argument,       NULL, 'r'             },
 		{ "propagation",   required_argument, NULL, OPT_PROPAGATION },
 		{ "setgroups",     required_argument, NULL, OPT_SETGROUPS   },
+		{ "root",          required_argument, NULL, 'R'             },
+		{ "wd",            required_argument, NULL, 'w'             },
 		{ NULL, 0, NULL, 0 }
 	};
 
@@ -311,6 +316,8 @@ int main(int argc, char *argv[])
 	int c, forkit = 0, maproot = 0;
 	int kill_child_signo = 0; /* 0 means --kill-child was not used */
 	const char *procmnt = NULL;
+	const char *newroot = NULL;
+	const char *newdir = "/";
 	pid_t pid = 0;
 	int fds[2];
 	int status;
@@ -323,7 +330,7 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "+fhVmuinpCUr", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "+fhVmuinpCUrR:w:", longopts, NULL)) != -1) {
 		switch (c) {
 		case 'f':
 			forkit = 1;
@@ -392,6 +399,12 @@ int main(int argc, char *argv[])
 				kill_child_signo = SIGKILL;
 			}
 			break;
+		case 'R':
+			newroot = optarg;
+			break;
+		case 'w':
+			newdir = optarg;
+			break;
 		default:
 			errtryhelp(EXIT_FAILURE);
 		}
@@ -471,6 +484,14 @@ int main(int argc, char *argv[])
 	if ((unshare_flags & CLONE_NEWNS) && propagation)
 		set_propagation(propagation);
 
+	if (newroot) {
+		if (chroot(newroot) != 0)
+			err(EXIT_FAILURE,
+			    _("cannot change root directory to '%s'"), newroot);
+		if (chdir(newdir))
+			err(EXIT_FAILURE, _("cannot chdir to '%s'"), newdir);
+	}
+
 	if (procmnt &&
 	    (mount("none", procmnt, NULL, MS_PRIVATE|MS_REC, NULL) != 0 ||
 	     mount("proc", procmnt, "proc", MS_NOSUID|MS_NOEXEC|MS_NODEV, NULL) != 0))
-- 
2.17.1
