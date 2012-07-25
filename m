Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:57227 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab2GYTQB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:16:01 -0400
Received: by mail-wg0-f42.google.com with SMTP id fm10so4793723wgb.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:16:00 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/19] ul: fix shadow declaration
Date: Wed, 25 Jul 2012 21:15:32 +0200
Message-Id: <1343243745-1172-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

text-utils/ul.c:641:25: warning: declaration of 'col' shadows a global declaration [-Wshadow]
text-utils/ul.c:126:5: warning: shadowed declaration is here [-Wshadow]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/ul.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/text-utils/ul.c b/text-utils/ul.c
index 80bc7a1..3c7bf50 100644
--- a/text-utils/ul.c
+++ b/text-utils/ul.c
@@ -638,11 +638,11 @@ static void setcol(int newcol) {
 		needcol(col);
 }
 
-static void needcol(int col) {
-	maxcol = col;
+static void needcol(int acol) {
+	maxcol = acol;
 
 	/* If col >= obuflen, expand obuf until obuflen > col. */
-	while (col >= obuflen) {
+	while (acol >= obuflen) {
 		/* Paranoid check for obuflen == INT_MAX. */
 		if (obuflen == INT_MAX)
 			errx(EXIT_FAILURE, _("Input line too long."));
-- 
1.7.11.3

