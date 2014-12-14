Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:45998 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbaLNRpK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Dec 2014 12:45:10 -0500
Received: by mail-wg0-f43.google.com with SMTP id l18so12948712wgh.16
        for <util-linux@vger.kernel.org>; Sun, 14 Dec 2014 09:45:08 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 05/16] lslogins: reject unknown time format arguments
Date: Sun, 14 Dec 2014 17:44:01 +0000
Message-Id: <1418579052-29386-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/lslogins.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index cacf83c..4b07636 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -1180,16 +1180,6 @@ static void free_user(void *f)
 	free(u);
 }
 
-struct lslogins_timefmt {
-	const char *name;
-	int val;
-};
-
-static struct lslogins_timefmt timefmts[] = {
-	{ "short", TIME_SHORT },
-	{ "full", TIME_FULL },
-	{ "iso", TIME_ISO },
-};
 
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
@@ -1398,8 +1388,18 @@ int main(int argc, char *argv[])
 			break;
 		case OPT_TIME_FMT:
 			{
+				struct lslogins_timefmt {
+					const char *name;
+					const int val;
+				};
+				const struct lslogins_timefmt timefmts[] = {
+					{ "iso", TIME_ISO },
+					{ "full", TIME_FULL },
+					{ "short", TIME_SHORT },
+				};
 				size_t i;
 
+				ctl->time_mode = TIME_INVALID;
 				for (i = 0; i < ARRAY_SIZE(timefmts); i++) {
 					if (strcmp(timefmts[i].name, optarg) == 0) {
 						ctl->time_mode = timefmts[i].val;
@@ -1407,7 +1407,7 @@ int main(int argc, char *argv[])
 					}
 				}
 				if (ctl->time_mode == TIME_INVALID)
-					usage(stderr);
+					errx(EXIT_FAILURE, _("unknown time format: %s"), optarg);
 			}
 			break;
 		case 'V':
-- 
2.1.3

