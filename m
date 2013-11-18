Return-Path: util-linux-owner@vger.kernel.org
Received: from brent.tribalogic.net ([78.86.109.144]:55952 "EHLO
	brent.tribalogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab3KROxS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Nov 2013 09:53:18 -0500
From: Colin Guthrie <colin@mageia.org>
To: util-linux@vger.kernel.org
Cc: Colin Guthrie <colin@mageia.org>
Subject: [PATCH] su: Remove the impossible -C option to request the same session.
Date: Mon, 18 Nov 2013 14:44:00 +0000
Message-Id: <1384785840-31957-1-git-send-email-colin@mageia.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It's impossible to pass this argument so it is pointless to keep the
code to support it.
---
 login-utils/su-common.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index 7fd2792..ca9f24b 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -744,7 +744,6 @@ su_main (int argc, char **argv, int mode)
   int optc;
   const char *new_user = DEFAULT_USER, *runuser_user = NULL;
   char *command = NULL;
-  int request_same_session = 0;
   char *shell = NULL;
   struct passwd *pw;
   struct passwd pw_copy;
@@ -786,11 +785,6 @@ su_main (int argc, char **argv, int mode)
 	  command = optarg;
 	  break;
 
-        case 'C':
-          command = optarg;
-          request_same_session = 1;
-          break;
-
 	case 'f':
 	  fast_startup = true;
 	  break;
@@ -924,7 +918,7 @@ su_main (int argc, char **argv, int mode)
 
   authenticate (pw);
 
-  if (request_same_session || !command || !pw->pw_uid)
+  if (!command || !pw->pw_uid)
     same_session = 1;
 
   /* initialize shell variable only if "-u <user>" not specified */
-- 
1.8.4.3

