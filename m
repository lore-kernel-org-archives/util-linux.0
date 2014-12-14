Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:52033 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbaLNRp6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Dec 2014 12:45:58 -0500
Received: by mail-wg0-f45.google.com with SMTP id b13so12839270wgh.32
        for <util-linux@vger.kernel.org>; Sun, 14 Dec 2014 09:45:57 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 16/16] chfn: make command to obey login.defs CHFN_RESTRICT instructions
Date: Sun, 14 Dec 2014 17:44:12 +0000
Message-Id: <1418579052-29386-17-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reference: http://man7.org/linux/man-pages/man5/login.defs.5.html
Addresses: https://bugzilla.redhat.com/show_bug.cgi?id=138519
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/Makemodule.am |  6 +++-
 login-utils/chfn.c        | 77 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index 34c5fb4..bdf03ad 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -113,7 +113,11 @@ chfn_chsh_sources += \
 chfn_chsh_ldadd += -lselinux
 endif
 
-chfn_SOURCES = login-utils/chfn.c $(chfn_chsh_sources)
+chfn_SOURCES = \
+	login-utils/chfn.c \
+	login-utils/logindefs.c \
+	login-utils/logindefs.h \
+	$(chfn_chsh_sources)
 chfn_CFLAGS = $(chfn_chsh_cflags)
 chfn_LDFLAGS = $(chfn_chsh_ldflags)
 chfn_LDADD = $(LDADD) $(chfn_chsh_ldadd)
diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 2a06fec..c81dbd5 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -40,6 +40,7 @@
 #include "setpwnam.h"
 #include "strutils.h"
 #include "xalloc.h"
+#include "logindefs.h"
 
 #ifdef HAVE_LIBSELINUX
 # include <selinux/selinux.h>
@@ -71,6 +72,10 @@ struct chfn_control {
 	 *  In the end, "newf" is folded into "oldf".  */
 	struct finfo oldf, newf;
 	unsigned int
+		allow_fullname:1,	/* The login.defs restriction */
+		allow_room:1,		   /* see: man login.defs(5) */
+		allow_work:1,		   /* and look for CHFN_RESTRICT */
+		allow_home:1,		   /* keyword for these four. */
 		interactive:1;		/* whether to prompt for fields or not */
 };
 
@@ -143,18 +148,26 @@ static void parse_argv(struct chfn_control *ctl, int argc, char **argv)
 				&index)) != -1) {
 		switch (c) {
 		case 'f':
+			if (!ctl->allow_fullname)
+				errx(EXIT_FAILURE, _("login.defs forbids setting %s"), _("Name"));
 			ctl->newf.full_name = optarg;
 			status += check_gecos_string(_("Name"), optarg);
 			break;
 		case 'o':
+			if (!ctl->allow_room)
+				errx(EXIT_FAILURE, _("login.defs forbids setting %s"), _("Office"));
 			ctl->newf.office = optarg;
 			status += check_gecos_string(_("Office"), optarg);
 			break;
 		case 'p':
+			if (!ctl->allow_work)
+				errx(EXIT_FAILURE, _("login.defs forbids setting %s"), _("Office Phone"));
 			ctl->newf.office_phone = optarg;
 			status += check_gecos_string(_("Office Phone"), optarg);
 			break;
 		case 'h':
+			if (!ctl->allow_home)
+				errx(EXIT_FAILURE, _("login.defs forbids setting %s"), _("Home Phone"));
 			ctl->newf.home_phone = optarg;
 			status += check_gecos_string(_("Home Phone"), optarg);
 			break;
@@ -233,15 +246,68 @@ static char *prompt(const char *question, char *def_val)
 }
 
 /*
+ *  get_login_defs()
+ *	find /etc/login.defs CHFN_RESTRICT and save restrictions to run time
+ */
+static void get_login_defs(struct chfn_control *ctl)
+{
+	const char *s;
+	size_t i;
+	int broken = 0;
+
+	/* real root does not have restrictions */
+	if (geteuid() == getuid() && getuid() == 0) {
+		ctl->allow_fullname = ctl->allow_room = ctl->allow_work = ctl->allow_home = 1;
+		return;
+	}
+	s = getlogindefs_str("CHFN_RESTRICT", "");
+	if (!strcmp(s, "yes")) {
+		ctl->allow_room = ctl->allow_work = ctl->allow_home = 1;
+		return;
+	}
+	if (!strcmp(s, "no")) {
+		ctl->allow_fullname = ctl->allow_room = ctl->allow_work = ctl->allow_home = 1;
+		return;
+	}
+	for (i = 0; s[i]; i++) {
+		switch (s[i]) {
+		case 'f':
+			ctl->allow_fullname = 1;
+			break;
+		case 'r':
+			ctl->allow_room = 1;
+			break;
+		case 'w':
+			ctl->allow_work = 1;
+			break;
+		case 'h':
+			ctl->allow_home = 1;
+			break;
+		default:
+			broken = 1;
+		}
+	}
+	if (broken)
+		warnx(_("%s: CHFN_RESTRICT has unexpected value: %s"), _PATH_LOGINDEFS, s);
+	if (!ctl->allow_fullname && !ctl->allow_room && !ctl->allow_work && !ctl->allow_home)
+		errx(EXIT_FAILURE, _("%s: CHFN_RESTRICT does not allow any changes"), _PATH_LOGINDEFS);
+	return;
+}
+
+/*
  *  ask_info () --
  *	prompt the user for the finger information and store it.
  */
 static void ask_info(struct chfn_control *ctl)
 {
-	ctl->newf.full_name = prompt(_("Name"), ctl->oldf.full_name);
-	ctl->newf.office = prompt(_("Office"), ctl->oldf.office);
-	ctl->newf.office_phone = prompt(_("Office Phone"), ctl->oldf.office_phone);
-	ctl->newf.home_phone = prompt(_("Home Phone"), ctl->oldf.home_phone);
+	if (ctl->allow_fullname)
+		ctl->newf.full_name = prompt(_("Name"), ctl->oldf.full_name);
+	if (ctl->allow_room)
+		ctl->newf.office = prompt(_("Office"), ctl->oldf.office);
+	if (ctl->allow_work)
+		ctl->newf.office_phone = prompt(_("Office Phone"), ctl->oldf.office_phone);
+	if (ctl->allow_home)
+		ctl->newf.home_phone = prompt(_("Home Phone"), ctl->oldf.home_phone);
 	printf("\n");
 }
 
@@ -337,6 +403,9 @@ int main(int argc, char **argv)
 	atexit(close_stdout);
 	uid = getuid();
 
+	/* check /etc/login.defs CHFN_RESTRICT */
+	get_login_defs(&ctl);
+
 	parse_argv(&ctl, argc, argv);
 	if (!ctl.username) {
 		ctl.pw = getpwuid(uid);
-- 
2.1.3

