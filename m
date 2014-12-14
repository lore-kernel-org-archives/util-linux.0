Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:51786 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbaLNRpE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Dec 2014 12:45:04 -0500
Received: by mail-wi0-f180.google.com with SMTP id n3so6920364wiv.13
        for <util-linux@vger.kernel.org>; Sun, 14 Dec 2014 09:45:02 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 04/16] lslogins: fix short options
Date: Sun, 14 Dec 2014 17:44:00 +0000
Message-Id: <1418579052-29386-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Usage is promising -e is an option alias of --export, so make it work.
And get rid of -x that was accepted, but not in use.

Long only enum member OPT_VER was probably a development time idea, that
never got to be used.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/lslogins.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 7fe6599..cacf83c 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -1245,8 +1245,7 @@ int main(int argc, char *argv[])
 
 	/* long only options. */
 	enum {
-		OPT_VER = CHAR_MAX + 1,
-		OPT_WTMP,
+		OPT_WTMP = CHAR_MAX + 1,
 		OPT_BTMP,
 		OPT_NOTRUNC,
 		OPT_NOHEAD,
@@ -1304,7 +1303,7 @@ int main(int argc, char *argv[])
 	add_column(columns, ncolumns++, COL_UID);
 	add_column(columns, ncolumns++, COL_USER);
 
-	while ((c = getopt_long(argc, argv, "acfGg:hLl:no:prsuVxzZ",
+	while ((c = getopt_long(argc, argv, "acefGg:hLl:no:prsuVzZ",
 				longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
-- 
2.1.3

