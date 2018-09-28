Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.134]:46551 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729071AbeI1TJK (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 28 Sep 2018 15:09:10 -0400
From: Laurent Vivier <laurent@vivier.eu>
To: util-linux@vger.kernel.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 2/2] unshare: allows to set user ID and group ID
Date: Fri, 28 Sep 2018 14:45:12 +0200
Message-Id: <20180928124512.13979-3-laurent@vivier.eu>
In-Reply-To: <20180928124512.13979-1-laurent@vivier.eu>
References: <20180928124512.13979-1-laurent@vivier.eu>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch introduces two new parameters to set the
user ID and the group ID of the program to be executed.
Setting group ID also drops supplementary groups.

The option names used are the same as for nsenter,
-S, --setuid and -G, --setgid.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 bash-completion/unshare |  4 +++-
 sys-utils/unshare.1     |  7 +++++++
 sys-utils/unshare.c     | 30 +++++++++++++++++++++++++++---
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/bash-completion/unshare b/bash-completion/unshare
index 64aea6784..10afffe19 100644
--- a/bash-completion/unshare
+++ b/bash-completion/unshare
@@ -35,7 +35,9 @@ _unshare_module()
 				--help
 				--version
 				--root
-				--wd"
+				--wd
+				--setuid
+				--setgid"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 40cbedbd1..d2ba6c3a5 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -192,6 +192,13 @@ run the command with root directory set to \fIdir\fP.
 .BR \-w, "\-\-wd=\fIdir"
 change working directory to \fIdir\fP.
 .TP
+.BR \-S, "\-\-setuid \fIuid"
+Set the user ID which will be used in the entered namespace.
+.TP
+.BR \-G, "\-\-setgid \fIgid"
+Set the group ID which will be used in the entered namespace and drop
+supplementary groups.
+.TP
 .BR \-V , " \-\-version"
 Display version information and exit.
 .TP
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index be2950a36..09a2b10de 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -29,6 +29,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/prctl.h>
+#include <grp.h>
 
 /* we only need some defines missing in sys/mount.h, no libmount linkage */
 #include <libmount.h>
@@ -42,6 +43,7 @@
 #include "pathnames.h"
 #include "all-io.h"
 #include "signames.h"
+#include "strutils.h"
 
 /* synchronize parent and child by pipe */
 #define PIPE_SYNC_BYTE	0x06
@@ -272,6 +274,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_(" -R, --root=<dir>	    run the command with root directory set to <dir>\n"), out);
 	fputs(_(" -w, --wd=<dir>	    change working directory to <dir>\n"), out);
+        fputs(_(" -S, --setuid <uid>	    set uid in entered namespace\n"), out);
+        fputs(_(" -G, --setgid <gid>	    set gid in entered namespace\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	printf(USAGE_HELP_OPTIONS(27));
@@ -306,6 +310,8 @@ int main(int argc, char *argv[])
 		{ "map-root-user", no_argument,       NULL, 'r'             },
 		{ "propagation",   required_argument, NULL, OPT_PROPAGATION },
 		{ "setgroups",     required_argument, NULL, OPT_SETGROUPS   },
+		{ "setuid",        required_argument, NULL, 'S'             },
+		{ "setgid",        required_argument, NULL, 'G'             },
 		{ "root",          required_argument, NULL, 'R'             },
 		{ "wd",            required_argument, NULL, 'w'             },
 		{ NULL, 0, NULL, 0 }
@@ -322,15 +328,16 @@ int main(int argc, char *argv[])
 	int fds[2];
 	int status;
 	unsigned long propagation = UNSHARE_PROPAGATION_DEFAULT;
-	uid_t real_euid = geteuid();
-	gid_t real_egid = getegid();
+	int force_uid = 0, force_gid = 0;
+	uid_t uid = 0, real_euid = geteuid();
+	gid_t gid = 0, real_egid = getegid();
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "+fhVmuinpCUrR:w:", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "+fhVmuinpCUrR:w:S:G:", longopts, NULL)) != -1) {
 		switch (c) {
 		case 'f':
 			forkit = 1;
@@ -399,6 +406,14 @@ int main(int argc, char *argv[])
 				kill_child_signo = SIGKILL;
 			}
 			break;
+		case 'S':
+			uid = strtoul_or_err(optarg, _("failed to parse uid"));
+			force_uid = 1;
+			break;
+		case 'G':
+			gid = strtoul_or_err(optarg, _("failed to parse gid"));
+			force_gid = 1;
+			break;
 		case 'R':
 			newroot = optarg;
 			break;
@@ -497,6 +512,15 @@ int main(int argc, char *argv[])
 	     mount("proc", procmnt, "proc", MS_NOSUID|MS_NOEXEC|MS_NODEV, NULL) != 0))
 			err(EXIT_FAILURE, _("mount %s failed"), procmnt);
 
+	if (force_gid) {
+		if (setgroups(0, NULL) != 0)	/* drop supplementary groups */
+			err(EXIT_FAILURE, _("setgroups failed"));
+		if (setgid(gid) < 0)		/* change GID */
+			err(EXIT_FAILURE, _("setgid failed"));
+	}
+	if (force_uid && setuid(uid) < 0)	/* change UID */
+			err(EXIT_FAILURE, _("setuid failed"));
+
 	if (optind < argc) {
 		execvp(argv[optind], argv + optind);
 		errexec(argv[optind]);
-- 
2.17.1
