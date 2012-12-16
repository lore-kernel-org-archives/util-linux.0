Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:53911 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614Ab2LPKoZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Dec 2012 05:44:25 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so2061774wgb.1
        for <util-linux@vger.kernel.org>; Sun, 16 Dec 2012 02:44:24 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/14] more: remove unnecessary variable
Date: Sun, 16 Dec 2012 10:43:55 +0000
Message-Id: <1355654642-22106-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
References: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 163f016..41caeb1 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1578,7 +1578,7 @@ void search(char buf[], FILE *file, register int n)
 	register long line2 = startline;
 	register long line3 = startline;
 	register int lncount;
-	int saveln, rv, rc;
+	int saveln, rc;
 	regex_t re;
 
 	context.line = saveln = Currline;
@@ -1595,7 +1595,7 @@ void search(char buf[], FILE *file, register int n)
 		line1 = Ftell(file);
 		rdline(file);
 		lncount++;
-		if ((rv = regexec(&re, Line, 0, NULL, 0)) == 0) {
+		if (regexec(&re, Line, 0, NULL, 0) == 0) {
 			if (--n == 0) {
 				if (lncount > 3 || (lncount > 1 && no_intty)) {
 					putchar('\n');
-- 
1.8.0.2

