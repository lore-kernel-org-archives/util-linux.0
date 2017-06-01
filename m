Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0.ossmail.de ([79.143.186.47]:49743 "EHLO mx0.ossmail.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751083AbdFAOwa (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Jun 2017 10:52:30 -0400
From: Sebastian Schrader <sebastian.schrader@ossmail.de>
To: util-linux@vger.kernel.org
Cc: sebastian.schrader@ossmail.de
Subject: [PATCH] setpriv: Add --init-groups option
Date: Thu,  1 Jun 2017 16:52:10 +0200
Message-Id: <20170601145210.9588-2-sebastian.schrader@ossmail.de>
In-Reply-To: <20170601145210.9588-1-sebastian.schrader@ossmail.de>
References: <m3mv9sernm.fsf@gmail.com>
 <20170601145210.9588-1-sebastian.schrader@ossmail.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add an --init-groups option which initializes the supplementary groups
from the system's group database (e.g /etc/group) using initgroups(3).
---
 sys-utils/setpriv.1 |  8 ++++++
 sys-utils/setpriv.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index bf18fe050..be97c0799 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -52,6 +52,14 @@ Preserve supplementary groups.  Only useful in conjunction with
 .BR \-\-egid ", or"
 .BR \-\-regid .
 .TP
+.B \-\-init\-groups
+Initialize supplementary groups using
+.BR initgroups "(3)."
+Only useful in conjunction with
+.BR \-\-ruid
+or
+.BR \-\-reuid .
+.TP
 .BR \-\-list\-caps
 List all known capabilities.  This option must be specified alone.
 .TP
diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 2129115a0..8d996e8be 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -62,15 +62,20 @@ struct privctx {
 		have_euid:1,		/* effective uid */
 		have_rgid:1,		/* real gid */
 		have_egid:1,		/* effective gid */
+		have_passwd:1,		/* passwd entry */
 		have_groups:1,		/* add groups */
 		keep_groups:1,		/* keep groups */
 		clear_groups:1,		/* remove groups */
+		init_groups:1,		/* initialize groups */
 		have_securebits:1;	/* remove groups */
 
 	/* uids and gids */
 	uid_t ruid, euid;
 	gid_t rgid, egid;
 
+	/* real user passwd entry */
+	struct passwd passwd;
+
 	/* supplementary groups */
 	size_t num_groups;
 	gid_t *groups;
@@ -109,6 +114,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" --regid <gid>            set real and effective gid\n"), out);
 	fputs(_(" --clear-groups           clear supplementary groups\n"), out);
 	fputs(_(" --keep-groups            keep supplementary groups\n"), out);
+	fputs(_(" --init-groups            initialize supplementary groups\n"), out);
 	fputs(_(" --groups <group,...>     set supplementary groups\n"), out);
 	fputs(_(" --securebits <bits>      set securebits\n"), out);
 	fputs(_(" --selinux-label <label>  set SELinux label\n"), out);
@@ -580,6 +586,33 @@ static gid_t get_group(const char *s, const char *err)
 	return tmp;
 }
 
+static struct passwd *get_passwd(const char *s, uid_t *uid, const char *err)
+{
+	struct passwd *pw;
+	long tmp;
+	pw = getpwnam(s);
+	if (pw) {
+		*uid = pw->pw_uid;
+	} else {
+		tmp = strtol_or_err(s, err);
+		*uid = tmp;
+		pw = getpwuid(*uid);
+	}
+	return pw;
+}
+
+static struct passwd *passwd_copy(struct passwd *dst, const struct passwd *src)
+{
+	struct passwd *rv;
+	rv = memcpy(dst, src, sizeof(*dst));
+	rv->pw_name = xstrdup(rv->pw_name);
+	rv->pw_passwd = xstrdup(rv->pw_passwd);
+	rv->pw_gecos = xstrdup(rv->pw_gecos);
+	rv->pw_dir = xstrdup(rv->pw_dir);
+	rv->pw_shell = xstrdup(rv->pw_shell);
+	return rv;
+}
+
 int main(int argc, char **argv)
 {
 	enum {
@@ -592,6 +625,7 @@ int main(int argc, char **argv)
 		REGID,
 		CLEAR_GROUPS,
 		KEEP_GROUPS,
+		INIT_GROUPS,
 		GROUPS,
 		INHCAPS,
 		LISTCAPS,
@@ -615,6 +649,7 @@ int main(int argc, char **argv)
 		{ "regid",            required_argument, NULL, REGID            },
 		{ "clear-groups",     no_argument,       NULL, CLEAR_GROUPS     },
 		{ "keep-groups",      no_argument,       NULL, KEEP_GROUPS      },
+		{ "init-groups",      no_argument,       NULL, INIT_GROUPS      },
 		{ "groups",           required_argument, NULL, GROUPS           },
 		{ "bounding-set",     required_argument, NULL, CAPBSET          },
 		{ "securebits",       required_argument, NULL, SECUREBITS       },
@@ -627,13 +662,14 @@ int main(int argc, char **argv)
 
 	static const ul_excl_t excl[] = {
 		/* keep in same order with enum definitions */
-		{CLEAR_GROUPS, KEEP_GROUPS, GROUPS},
+		{CLEAR_GROUPS, KEEP_GROUPS, INIT_GROUPS, GROUPS},
 		{0}
 	};
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
 
 	int c;
 	struct privctx opts;
+	struct passwd *pw = NULL;
 	int dumplevel = 0;
 	int total_opts = 0;
 	int list_caps = 0;
@@ -662,7 +698,11 @@ int main(int argc, char **argv)
 			if (opts.have_ruid)
 				errx(EXIT_FAILURE, _("duplicate ruid"));
 			opts.have_ruid = 1;
-			opts.ruid = get_user(optarg, _("failed to parse ruid"));
+			pw = get_passwd(optarg, &opts.ruid, _("failed to parse ruid"));
+			if (pw) {
+				passwd_copy(&opts.passwd, pw);
+				opts.have_passwd = 1;
+			}
 			break;
 		case EUID:
 			if (opts.have_euid)
@@ -674,7 +714,12 @@ int main(int argc, char **argv)
 			if (opts.have_ruid || opts.have_euid)
 				errx(EXIT_FAILURE, _("duplicate ruid or euid"));
 			opts.have_ruid = opts.have_euid = 1;
-			opts.ruid = opts.euid = get_user(optarg, _("failed to parse reuid"));
+			pw = get_passwd(optarg, &opts.ruid, _("failed to parse reuid"));
+			opts.euid = opts.ruid;
+			if (pw) {
+				passwd_copy(&opts.passwd, pw);
+				opts.have_passwd = 1;
+			}
 			break;
 		case RGID:
 			if (opts.have_rgid)
@@ -706,6 +751,12 @@ int main(int argc, char **argv)
 				     _("duplicate --keep-groups option"));
 			opts.keep_groups = 1;
 			break;
+		case INIT_GROUPS:
+			if (opts.init_groups)
+				errx(EXIT_FAILURE,
+				     _("duplicate --init-groups option"));
+			opts.init_groups = 1;
+			break;
 		case GROUPS:
 			if (opts.have_groups)
 				errx(EXIT_FAILURE,
@@ -775,9 +826,20 @@ int main(int argc, char **argv)
 		errx(EXIT_FAILURE, _("No program specified"));
 
 	if ((opts.have_rgid || opts.have_egid)
-	    && !opts.keep_groups && !opts.clear_groups && !opts.have_groups)
+	    && !opts.keep_groups && !opts.clear_groups && !opts.init_groups
+	    && !opts.have_groups)
+		errx(EXIT_FAILURE,
+		     _("--[re]gid requires --keep-groups, --clear-groups, --init-groups, or --groups"));
+
+	if (opts.init_groups && !opts.have_ruid)
+		errx(EXIT_FAILURE,
+		     _("--init-groups requires --ruid or --reuid"));
+
+	if (opts.init_groups && !opts.have_passwd)
 		errx(EXIT_FAILURE,
-		     _("--[re]gid requires --keep-groups, --clear-groups, or --groups"));
+		     _("uid %ld not found, --init-groups requires an user that "
+		       "can be found on the system"),
+		     (long) opts.ruid);
 
 	if (opts.nnp && prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) == -1)
 		err(EXIT_FAILURE, _("disallow granting new privileges failed"));
@@ -811,6 +873,9 @@ int main(int argc, char **argv)
 	if (opts.have_groups) {
 		if (setgroups(opts.num_groups, opts.groups) != 0)
 			err(SETPRIV_EXIT_PRIVERR, _("setgroups failed"));
+	} else if (opts.init_groups) {
+		if (initgroups(opts.passwd.pw_name, opts.passwd.pw_gid) != 0)
+			err(SETPRIV_EXIT_PRIVERR, _("initgroups failed"));
 	} else if (opts.clear_groups) {
 		gid_t x = 0;
 		if (setgroups(0, &x) != 0)
-- 
2.13.0

