Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:43465 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584AbaLVLrd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Dec 2014 06:47:33 -0500
Received: by mail-wi0-f169.google.com with SMTP id r20so10231535wiv.4
        for <util-linux@vger.kernel.org>; Mon, 22 Dec 2014 03:47:32 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 06/14] chsh: clean up parse_argv()
Date: Mon, 22 Dec 2014 11:47:09 +0000
Message-Id: <1419248837-4619-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
References: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chsh.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index 0112fa4..5339e55 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -129,22 +129,17 @@ static int get_shell_list(const char *shell_name)
  */
 static void parse_argv(int argc, char **argv, struct sinfo *pinfo)
 {
-	int index, c;
-
-	static struct option long_options[] = {
+	const struct option long_options[] = {
 		{"shell", required_argument, 0, 's'},
 		{"list-shells", no_argument, 0, 'l'},
 		{"help", no_argument, 0, 'u'},
 		{"version", no_argument, 0, 'v'},
 		{NULL, no_argument, 0, '0'},
 	};
+	int c;
 
-	optind = c = 0;
-	while (c != EOF) {
-		c = getopt_long(argc, argv, "s:luv", long_options, &index);
+	while ((c = getopt_long(argc, argv, "s:luv", long_options, NULL)) != -1) {
 		switch (c) {
-		case -1:
-			break;
 		case 'v':
 			printf(UTIL_LINUX_VERSION);
 			exit(EXIT_SUCCESS);
-- 
2.2.1

