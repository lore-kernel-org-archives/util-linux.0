Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:41071 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbaLGKOJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Dec 2014 05:14:09 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so2292126wid.17
        for <util-linux@vger.kernel.org>; Sun, 07 Dec 2014 02:14:08 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>,
        Frodo Looijaard <frodo@frodo.looijaard.name>
Subject: [PATCH 06/11] getopt: use xstrdup rather than malloc + strcpy
Date: Sun,  7 Dec 2014 10:13:50 +0000
Message-Id: <1417947235-24229-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
References: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

CC: Frodo Looijaard <frodo@frodo.looijaard.name>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/getopt.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index fcc016c..4c92e30 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -114,8 +114,7 @@ static const char *normalize(const struct getopt_control *ctl, const char *arg)
 
 	if (!ctl->quote) {
 		/* Just copy arg */
-		BUFFER = xmalloc(strlen(arg) + 1);
-		strcpy(BUFFER, arg);
+		BUFFER = xstrdup(arg);
 		return BUFFER;
 	}
 
@@ -233,7 +232,6 @@ static void __attribute__ ((__noreturn__)) parse_error(const char *message)
 /* Register a long option. The contents of name is copied. */
 static void add_longopt(struct getopt_control *ctl, const char *name, int has_arg)
 {
-	char *tmp;
 	static int flag;
 
 	if (!name) {
@@ -261,9 +259,7 @@ static void add_longopt(struct getopt_control *ctl, const char *name, int has_ar
 		ctl->long_options[ctl->long_options_nr - 1].has_arg = has_arg;
 		ctl->long_options[ctl->long_options_nr - 1].flag = &flag;
 		ctl->long_options[ctl->long_options_nr - 1].val = ctl->long_options_nr;
-		tmp = xmalloc(strlen(name) + 1);
-		strcpy(tmp, name);
-		ctl->long_options[ctl->long_options_nr - 1].name = tmp;
+		ctl->long_options[ctl->long_options_nr - 1].name = xstrdup(name);
 	}
 	ctl->long_options_nr++;
 }
@@ -407,16 +403,14 @@ int main(int argc, char *argv[])
 			print_help();
 		case 'o':
 			free(ctl.optstr);
-			ctl.optstr = xmalloc(strlen(optarg) + 1);
-			strcpy(ctl.optstr, optarg);
+			ctl.optstr = xstrdup(optarg);
 			break;
 		case 'l':
 			add_long_options(&ctl, optarg);
 			break;
 		case 'n':
 			free(name);
-			name = xmalloc(strlen(optarg) + 1);
-			strcpy(name, optarg);
+			name = xstrdup(optarg);
 			break;
 		case 'q':
 			ctl.quiet_errors = 1;
@@ -446,8 +440,7 @@ int main(int argc, char *argv[])
 		if (optind >= argc)
 			parse_error(_("missing optstring argument"));
 		else {
-			ctl.optstr = xmalloc(strlen(argv[optind]) + 1);
-			strcpy(ctl.optstr, argv[optind]);
+			ctl.optstr = xstrdup(argv[optind]);
 			optind++;
 		}
 	}
-- 
2.1.3

