Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33200 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293AbcEAW4M (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 May 2016 18:56:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id r12so14853828wme.0
        for <util-linux@vger.kernel.org>; Sun, 01 May 2016 15:56:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/2] scriptreplay: improve error message
Date: Sun,  1 May 2016 23:56:04 +0100
Message-Id: <1462143365-17916-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use human numbering for lines - that is start counting from 1.  And tell in
error message what the number means.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/scriptreplay.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/term-utils/scriptreplay.c b/term-utils/scriptreplay.c
index b4549ef..51985cd 100644
--- a/term-utils/scriptreplay.c
+++ b/term-utils/scriptreplay.c
@@ -211,7 +211,7 @@ main(int argc, char *argv[])
 	/* ignore the first typescript line */
 	while((c = fgetc(sfile)) != EOF && c != '\n');
 
-	for(line = 0; ; line++) {
+	for(line = 1; ; line++) {
 		double delay;
 		size_t blk;
 		char nl;
@@ -223,7 +223,7 @@ main(int argc, char *argv[])
 				err(EXIT_FAILURE,
 					_("failed to read timing file %s"), tname);
 			errx(EXIT_FAILURE,
-				_("timings file %s: %lu: unexpected format"),
+				_("timing file %s: line %lu: unexpected format"),
 				tname, line);
 		}
 		delay /= divi;
-- 
2.8.0

