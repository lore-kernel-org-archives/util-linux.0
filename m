Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:63323 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab2GYTP7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:15:59 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so794233wey.19
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:15:58 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/19] setterm: fix shadow declaration
Date: Wed, 25 Jul 2012 21:15:30 +0200
Message-Id: <1343243745-1172-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

term-utils/setterm.c:221:55: warning: declaration of 'opt_term' shadows a global declaration [-Wshadow]
term-utils/setterm.c:181:5: warning: shadowed declaration is here [-Wshadow]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 3083ac8..03148f7 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -218,11 +218,11 @@ static void screendump(int vcnum, FILE *F);
  */
 
 static void
-parse_term(int argc, char **argv, int *option, char **opt_term, int *bad_arg) {
+parse_term(int argc, char **argv, int *option, char **opt_trm, int *bad_arg) {
 	/* argc: Number of arguments for this option. */
 	/* argv: Arguments for this option. */
 	/* option: Term flag to set. */
-	/* opt_term: Terminal name to set. */
+	/* opt_trm: Terminal name to set. */
 	/* bad_arg: Set to true if an error is detected. */
 
 /* Parse a -term specification. */
@@ -231,7 +231,7 @@ parse_term(int argc, char **argv, int *option, char **opt_term, int *bad_arg) {
 		*bad_arg = TRUE;
 	*option = TRUE;
 	if (argc == 1)
-		*opt_term = argv[0];
+		*opt_trm = argv[0];
 }
 
 static void
-- 
1.7.11.3

