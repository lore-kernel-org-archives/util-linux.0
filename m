Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36121 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757705AbcGZSGH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 26 Jul 2016 14:06:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id x83so2856908wma.3
        for <util-linux@vger.kernel.org>; Tue, 26 Jul 2016 11:06:06 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/2] chfn: add --trim option to remove trailing commas
Date: Tue, 26 Jul 2016 19:06:01 +0100
Message-Id: <20160726180602.4914-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When running chfn(1) will add empty 'other' field, that causes trailing
commas to persist.

-- snip
$ chfn
Changing finger information for kerolasa.
Password:
Office []: foo
Office Phone []:
Home Phone []:
Finger information changed.
$ grep Sami /etc/passwd
kerolasa:x:1000:1000:Sami Kerola,foo,,,:/home/kerolasa:/bin/bash
-- snip

New --trim option will allow user to remove such pointless commas.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chfn.1 |  5 +++++
 login-utils/chfn.c | 11 ++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/login-utils/chfn.1 b/login-utils/chfn.1
index 0cb5f28..8fb5e4b 100644
--- a/login-utils/chfn.1
+++ b/login-utils/chfn.1
@@ -64,6 +64,11 @@ Specify your office phone number.
 .BR \-h , " \-\-home\-phone " \fIhome-phone
 Specify your home phone number.
 .TP
+.B \-\-trim
+Remove trailing commas from gecos.  This option will remove empty fields
+also in the case they are not managed with
+.BR chfn (1).
+.TP
 .BR \-u , " \-\-help"
 Display help text and exit.
 .TP
diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 89e6bd7..2d58fc3 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -77,6 +77,7 @@ struct chfn_control {
 		allow_room:1,		   /* see: man login.defs(5) */
 		allow_work:1,		   /* and look for CHFN_RESTRICT */
 		allow_home:1,		   /* keyword for these four. */
+		trim:1,			/* remove trailing commas from gecos */
 		changed:1,		/* is change requested */
 		interactive:1;		/* whether to prompt for fields or not */
 };
@@ -97,6 +98,7 @@ static void __attribute__((__noreturn__)) usage(FILE *fp)
 	fputs(_(" -o, --office <office>        office number\n"), fp);
 	fputs(_(" -p, --office-phone <phone>   office phone number\n"), fp);
 	fputs(_(" -h, --home-phone <phone>     home phone number\n"), fp);
+	fputs(_("     --trim                   remove trailing commas\n"), fp);
 	fputs(USAGE_SEPARATOR, fp);
 	fputs(_(" -u, --help     display this help and exit\n"), fp);
 	fputs(_(" -v, --version  output version information and exit\n"), fp);
@@ -131,12 +133,16 @@ static int check_gecos_string(const char *msg, char *gecos)
  */
 static void parse_argv(struct chfn_control *ctl, int argc, char **argv)
 {
+	enum {
+		OPT_TRIM = CHAR_MAX + 1
+	};
 	int index, c, status = 0;
 	static const struct option long_options[] = {
 		{"full-name", required_argument, 0, 'f'},
 		{"office", required_argument, 0, 'o'},
 		{"office-phone", required_argument, 0, 'p'},
 		{"home-phone", required_argument, 0, 'h'},
+		{"trim", no_argument, 0, OPT_TRIM},
 		{"help", no_argument, 0, 'u'},
 		{"version", no_argument, 0, 'v'},
 		{NULL, no_argument, 0, '0'},
@@ -169,6 +175,9 @@ static void parse_argv(struct chfn_control *ctl, int argc, char **argv)
 			ctl->newf.home_phone = optarg;
 			status += check_gecos_string(_("Home Phone"), optarg);
 			break;
+		case OPT_TRIM:
+			ctl->trim = 1;
+			break;
 		case 'v':
 			printf(UTIL_LINUX_VERSION);
 			exit(EXIT_SUCCESS);
@@ -360,7 +369,7 @@ static int save_new_data(struct chfn_control *ctl)
 			ctl->newf.other);
 
 	/* remove trailing empty fields (but not subfields of ctl->newf.other) */
-	if (!ctl->newf.other) {
+	if (!ctl->newf.other || ctl->trim) {
 		while (len > 0 && gecos[len - 1] == ',')
 			len--;
 		gecos[len] = 0;
-- 
2.9.0

