Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:57976 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbaLNRpj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Dec 2014 12:45:39 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so6848406wiv.5
        for <util-linux@vger.kernel.org>; Sun, 14 Dec 2014 09:45:38 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 13/16] chfn: add minimalistic struct chfn_control
Date: Sun, 14 Dec 2014 17:44:09 +0000
Message-Id: <1418579052-29386-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chfn.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 7ba1a51..81abd11 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -64,6 +64,11 @@ struct finfo {
 	char *other;
 };
 
+struct chfn_control {
+	unsigned int
+		interactive:1;		/* whether to prompt for fields or not */
+};
+
 /* we do not accept gecos field sizes longer than MAX_FIELD_SIZE */
 #define MAX_FIELD_SIZE		256
 
@@ -116,10 +121,9 @@ static int check_gecos_string(const char *msg, char *gecos)
  *	parse the command line arguments.
  *	returns true if no information beyond the username was given.
  */
-static int parse_argv(int argc, char *argv[], struct finfo *pinfo)
+static void parse_argv(struct chfn_control *ctl, int argc, char *argv[], struct finfo *pinfo)
 {
 	int index, c, status;
-	int info_given;
 
 	static struct option long_options[] = {
 		{"full-name", required_argument, 0, 'f'},
@@ -132,7 +136,6 @@ static int parse_argv(int argc, char *argv[], struct finfo *pinfo)
 	};
 
 	optind = 0;
-	info_given = false;
 	while (true) {
 		c = getopt_long(argc, argv, "f:r:p:h:o:uv", long_options,
 				&index);
@@ -149,7 +152,7 @@ static int parse_argv(int argc, char *argv[], struct finfo *pinfo)
 		if (!optarg)
 			usage(stderr);
 		/* ok, we were given an argument */
-		info_given = true;
+		ctl->interactive = 0;
 
 		/* now store the argument */
 		switch (c) {
@@ -181,7 +184,7 @@ static int parse_argv(int argc, char *argv[], struct finfo *pinfo)
 			usage(stderr);
 		pinfo->username = argv[optind];
 	}
-	return !info_given;
+	return;
 }
 
 /*
@@ -335,7 +338,9 @@ int main(int argc, char **argv)
 {
 	uid_t uid;
 	struct finfo oldf, newf;
-	int interactive;
+	struct chfn_control ctl = {
+		.interactive = 1
+	};
 
 	sanitize_env();
 	setlocale(LC_ALL, "");	/* both for messages and for iscntrl() below */
@@ -358,7 +363,7 @@ int main(int argc, char **argv)
 	memset(&oldf, 0, sizeof(oldf));
 	memset(&newf, 0, sizeof(newf));
 
-	interactive = parse_argv(argc, argv, &newf);
+	parse_argv(&ctl, argc, argv, &newf);
 	if (!newf.username) {
 		parse_passwd(getpwuid(uid), &oldf);
 		if (!oldf.username)
@@ -415,7 +420,7 @@ int main(int argc, char **argv)
 	}
 #endif
 
-	if (interactive)
+	if (ctl.interactive)
 		ask_info(&oldf, &newf);
 
 	if (!set_changed_data(&oldf, &newf)) {
-- 
2.1.3

