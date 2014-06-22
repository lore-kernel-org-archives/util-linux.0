Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h31.telenor.se ([213.150.131.4]:53401 "EHLO
	smtprelay-h31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbaFVBNc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 21 Jun 2014 21:13:32 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-h31.telenor.se (Postfix) with ESMTP id 257A1C01F
	for <util-linux@vger.kernel.org>; Sun, 22 Jun 2014 03:12:59 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH 2/2] script: silence the done message on --quiet as well
Date: Sun, 22 Jun 2014 03:12:44 +0200
Message-Id: <1403399564-10250-1-git-send-email-andreas@fatal.se>
In-Reply-To: <1403391784-9912-1-git-send-email-andreas@fatal.se>
References: <1403391784-9912-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Apparently James Hunts patch (which he provided a long time
ago) is no longer covering it all.

This followup patch also silences the "Script done ..." message
when --quiet is used.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 term-utils/script.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 21fb5af..2da7512 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -578,7 +578,8 @@ done(void) {
 			char buf[BUFSIZ];
 			tvec = time((time_t *)NULL);
 			my_strftime(buf, sizeof buf, "%c\n", localtime(&tvec));
-			fprintf(fscript, _("\nScript done on %s"), buf);
+			if (!qflg)
+				fprintf(fscript, _("\nScript done on %s"), buf);
 
 			if (close_stream(fscript) != 0)
 				errx(EXIT_FAILURE, _("write error"));
-- 
2.0.0

