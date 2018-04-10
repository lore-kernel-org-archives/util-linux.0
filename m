Return-Path: util-linux-owner@vger.kernel.org
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54399 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751774AbeDJLIa (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 10 Apr 2018 07:08:30 -0400
From: Patrick Steinhardt <ps@pks.im>
To: util-linux@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, kzak@redhat.com, mail@nh2.me
Subject: [PATCH v2] setpriv: implement option to set parent death signal
Date: Tue, 10 Apr 2018 12:08:21 +0100
Message-Id: <ee7de238f29ee5ebc68733183ffc71239252cb3a.1523358390.git.ps@pks.im>
In-Reply-To: <20180410100023.yego5fwd552id2u6@ws.net.home>
References: <20180410100023.yego5fwd552id2u6@ws.net.home>
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

Add a new option "--pdeathsig keep|clear|<signal>". Setting this flag
will cause us to either

- restore the previously active parent death signal as soon as the
  setpriv has applied all credential changes
- clear the parent death signal
- set the parent death signal to "<signal>"

Furthermore, print out the currently set signal when dumping process
state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

Thanks for your feedback, Karel. It definitely makes sense to
extend the option as you propose, which is what I did in this
version. Instead of always trying to restore the previous signal,
you can now choose to either keep it, clear it or set it to a
specific signal.

Patrick

 sys-utils/setpriv.1 |  6 ++++++
 sys-utils/setpriv.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index b900f6e08..f989bf33c 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -139,6 +139,12 @@ is cleared by
 .BR execve (2)
 and is therefore not allowed.
 .TP
+.BR "\-\-pdeathsig keep" | clear | <signal>
+Keep, clear or set the parent death signal.  Some LSMs, most notably SELinux and
+AppArmor, clear the signal when the process' credentials change.  Using
+\fB--pdeathsig keep\fR will restore the parent death signal after changing
+credentials to remedy that situation.
+.TP
 .BI \-\-selinux\-label " label"
 Request a particular SELinux transition (using a transition on exec, not
 dyntrans).  This will fail and cause
diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 4147978cc..1b25cda28 100644
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
+	fputs(_(" --pdeathsig keep|clear|<signame> set or clear parent death signal\n"), out);
 	fputs(_(" --selinux-label <label>     set SELinux label\n"), out);
 	fputs(_(" --apparmor-profile <pr>     set AppArmor profile\n"), out);
 
@@ -329,6 +333,24 @@ static void dump_groups(void)
 	free(groups);
 }
 
+static void dump_pdeathsig(void)
+{
+	int pdeathsig;
+
+	if (prctl(PR_GET_PDEATHSIG, &pdeathsig) != 0) {
+		warn(_("get pdeathsig failed"));
+		return;
+	}
+
+	printf("Parent death signal: ");
+	if (pdeathsig && signum_to_signame(pdeathsig) != NULL)
+		printf("%s\n", signum_to_signame(pdeathsig));
+	else if (pdeathsig)
+		printf("%d\n", pdeathsig);
+	else
+		printf("[none]\n");
+}
+
 static void dump(int dumplevel)
 {
 	int x;
@@ -392,6 +414,7 @@ static void dump(int dumplevel)
 	printf("\n");
 
 	dump_securebits();
+	dump_pdeathsig();
 
 	if (access(_PATH_SYS_SELINUX, F_OK) == 0)
 		dump_label(_("SELinux label"));
@@ -438,6 +461,19 @@ static void parse_groups(struct privctx *opts, const char *str)
 	free(groups);
 }
 
+static void parse_pdeathsig(struct privctx *opts, const char *str)
+{
+	if (!strcmp(str, "keep")) {
+		if (prctl(PR_GET_PDEATHSIG, &opts->pdeathsig) != 0)
+			errx(SETPRIV_EXIT_PRIVERR,
+				 _("failed to get parent death signal"));
+	} else if (!strcmp(str, "clear")) {
+		opts->pdeathsig = -1;
+	} else if ((opts->pdeathsig = signame_to_signum(str)) < 0) {
+			errx(EXIT_FAILURE, _("unknown signal \"%s\""), str);
+	}
+}
+
 static void do_setresuid(const struct privctx *opts)
 {
 	uid_t ruid, euid, suid;
@@ -711,6 +747,7 @@ int main(int argc, char **argv)
 		LISTCAPS,
 		CAPBSET,
 		SECUREBITS,
+		PDEATHSIG,
 		SELINUX_LABEL,
 		APPARMOR_PROFILE
 	};
@@ -734,6 +771,7 @@ int main(int argc, char **argv)
 		{ "groups",           required_argument, NULL, GROUPS           },
 		{ "bounding-set",     required_argument, NULL, CAPBSET          },
 		{ "securebits",       required_argument, NULL, SECUREBITS       },
+		{ "pdeathsig",        required_argument, NULL, PDEATHSIG,       },
 		{ "selinux-label",    required_argument, NULL, SELINUX_LABEL    },
 		{ "apparmor-profile", required_argument, NULL, APPARMOR_PROFILE },
 		{ "help",             no_argument,       NULL, 'h'              },
@@ -844,6 +882,12 @@ int main(int argc, char **argv)
 				     _("duplicate --groups option"));
 			parse_groups(&opts, optarg);
 			break;
+		case PDEATHSIG:
+			if (opts.pdeathsig)
+				errx(EXIT_FAILURE,
+				     _("duplicate --keep-pdeathsig option"));
+			parse_pdeathsig(&opts, optarg);
+			break;
 		case LISTCAPS:
 			list_caps = 1;
 			break;
@@ -989,6 +1033,10 @@ int main(int argc, char **argv)
 		do_caps(CAP_TYPE_AMBIENT, opts.ambient_caps);
 	}
 
+	/* Clear or set parent death signal */
+	if (opts.pdeathsig && prctl(PR_SET_PDEATHSIG, opts.pdeathsig < 0 ? 0 : opts.pdeathsig) != 0)
+		err(SETPRIV_EXIT_PRIVERR, _("set parent death signal failed"));
+
 	execvp(argv[optind], argv + optind);
 	errexec(argv[optind]);
 }
-- 
2.17.0

