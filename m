Return-Path: util-linux-owner@vger.kernel.org
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43313 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751312AbeDFHNs (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 6 Apr 2018 03:13:48 -0400
From: Patrick Steinhardt <ps@pks.im>
To: util-linux@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, kzak@redhat.com, mail@nh2.me
Subject: [PATCH] setpriv: implement option to restore parent death signal
Date: Fri,  6 Apr 2018 08:13:42 +0100
Message-Id: <d791e27f0ccbe1af12797ce380a41be0389019f9.1522964667.git.ps@pks.im>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When a process uses the syscall `prctl(PR_SET_PDEATHSIG, ...)`, it will
get notified with a process-defined signal as soon as its parent process
dies. This is for example being used by unshare(1)'s recently added
"--kill-child" option, causing the forked child to be killed as soon as
unshare itself dies.

Unfortunately, some LSMs will cause the parent death signal to be reset
when a process changes credentials, with the most important ones being
SELinux and AppArmor. The following command will thus not work as
expected:

    unshare --fork --kill-child setpriv --reuid user <executable>

As soon as setpriv changes UID, the parent death signal is cleared and
the child will never get signalled when unshare gets killed.

Add a new flag "--keep-pdeathsig" to setpriv(1). Setting this flag will
cause it to restore the previously active parent death signal as soon as
the setpriv has applied all credential changes. Furthermore, print out
the currently set signal when dumping process state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

This has come up while I was hacking on runit, where I wanted to
start PID namespaces for my services. Using these namespaces
without "--fork" is impossible, but the forking hinders runit to
restart services correctly as it will always send SIGTERM to the
immediate child, which is now `unshare`. The "--kill-child" flag
looked like it was the perfect fit here.

Unfortunately this patch turned out rather useless for me. I
realized that as soon as `execve` is called and the new process
has an AppArmor profile, the parent death signal will get reset
again due to the process being marked as "secure". So this is
really only useful in the scenario where one is executing a new
child which is not changing credentials again and which is not
protected by a profile. I'm sending it anyway, in case somebody
finds it useful (or has some input to help my scenario).

 sys-utils/setpriv.1 |  4 ++++
 sys-utils/setpriv.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index b900f6e08..69861ab82 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -139,6 +139,10 @@ is cleared by
 .BR execve (2)
 and is therefore not allowed.
 .TP
+.BR \-\-keep\-pdeathsig
+Keep the parent death signal.  Some LSMs, most notably SELinux and AppArmor,
+clear the signal when the process' credentials change.
+.TP
 .BI \-\-selinux\-label " label"
 Request a particular SELinux transition (using a transition on exec, not
 dyntrans).  This will fail and cause
diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 4147978cc..646165468 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -38,6 +38,7 @@
 #include "strutils.h"
 #include "xalloc.h"
 #include "pathnames.h"
+#include "signames.h"
 
 #ifndef PR_SET_NO_NEW_PRIVS
 # define PR_SET_NO_NEW_PRIVS 38
@@ -102,6 +103,8 @@ struct privctx {
 
 	/* securebits */
 	int securebits;
+	/* parent death signal */
+	int pdeathsig;
 
 	/* LSMs */
 	const char *selinux_label;
@@ -135,6 +138,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" --init-groups               initialize supplementary groups\n"), out);
 	fputs(_(" --groups <group,...>        set supplementary groups\n"), out);
 	fputs(_(" --securebits <bits>         set securebits\n"), out);
+	fputs(_(" --keep-pdeathsig            keep parent death signal\n"), out);
 	fputs(_(" --selinux-label <label>     set SELinux label\n"), out);
 	fputs(_(" --apparmor-profile <pr>     set AppArmor profile\n"), out);
 
@@ -329,6 +333,25 @@ static void dump_groups(void)
 	free(groups);
 }
 
+static void dump_pdeathsig(void)
+{
+	const char *signame;
+	int pdeathsig;
+
+	if (prctl(PR_GET_PDEATHSIG, &pdeathsig) != 0) {
+		warn(_("get pdeathsig failed"));
+		return;
+	}
+
+	printf("Parent death signal: ");
+	if (pdeathsig && get_signame_by_idx(pdeathsig, &signame, NULL) == 0)
+		printf("%s\n", signame);
+	else if (pdeathsig)
+		printf("%d\n", pdeathsig);
+	else
+		printf("[none]\n");
+}
+
 static void dump(int dumplevel)
 {
 	int x;
@@ -392,6 +415,7 @@ static void dump(int dumplevel)
 	printf("\n");
 
 	dump_securebits();
+	dump_pdeathsig();
 
 	if (access(_PATH_SYS_SELINUX, F_OK) == 0)
 		dump_label(_("SELinux label"));
@@ -711,6 +735,7 @@ int main(int argc, char **argv)
 		LISTCAPS,
 		CAPBSET,
 		SECUREBITS,
+		KEEP_PDEATHSIG,
 		SELINUX_LABEL,
 		APPARMOR_PROFILE
 	};
@@ -734,6 +759,7 @@ int main(int argc, char **argv)
 		{ "groups",           required_argument, NULL, GROUPS           },
 		{ "bounding-set",     required_argument, NULL, CAPBSET          },
 		{ "securebits",       required_argument, NULL, SECUREBITS       },
+		{ "keep-pdeathsig",   no_argument,       NULL, KEEP_PDEATHSIG,  },
 		{ "selinux-label",    required_argument, NULL, SELINUX_LABEL    },
 		{ "apparmor-profile", required_argument, NULL, APPARMOR_PROFILE },
 		{ "help",             no_argument,       NULL, 'h'              },
@@ -844,6 +870,14 @@ int main(int argc, char **argv)
 				     _("duplicate --groups option"));
 			parse_groups(&opts, optarg);
 			break;
+		case KEEP_PDEATHSIG:
+			if (opts.pdeathsig)
+				errx(EXIT_FAILURE,
+				     _("duplicate --keep-pdeathsig option"));
+			if (prctl(PR_GET_PDEATHSIG, &opts.pdeathsig) != 0)
+				errx(SETPRIV_EXIT_PRIVERR,
+				     _("failed to get parent death signature"));
+			break;
 		case LISTCAPS:
 			list_caps = 1;
 			break;
@@ -989,6 +1023,9 @@ int main(int argc, char **argv)
 		do_caps(CAP_TYPE_AMBIENT, opts.ambient_caps);
 	}
 
+	if (opts.pdeathsig && prctl(PR_SET_PDEATHSIG, opts.pdeathsig) != 0)
+		err(SETPRIV_EXIT_PRIVERR, _("set parent death signal failed"));
+
 	execvp(argv[optind], argv + optind);
 	errexec(argv[optind]);
 }
-- 
2.17.0

