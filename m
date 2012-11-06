Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:39274 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab2KFVOg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 6 Nov 2012 16:14:36 -0500
Received: by mail-wi0-f172.google.com with SMTP id hq12so4705764wib.1
        for <util-linux@vger.kernel.org>; Tue, 06 Nov 2012 13:14:35 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Daniel Narvaez <dwnarvaez@gmail.com>, Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] script: do not try to close stderr twice
Date: Tue,  6 Nov 2012 21:14:14 +0000
Message-Id: <1352236454-28312-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The commit cdd2a8c360c70d16804ace7cc923a6c6bb7c9ca9 broke script(1)
return value.

$ script -e -c "echo"; echo $?
1

The reason, as Daniel it reported, was that the script will close stderr
twice, once as timing file and atexit() in function close_stdout().  This
commit fixes the problem.

Reported-by: Daniel Narvaez <dwnarvaez@gmail.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index ccd8873..94a20da 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -159,7 +159,7 @@ main(int argc, char **argv) {
 	sigset_t block_mask, unblock_mask;
 	struct sigaction sa;
 	int ch;
-	FILE *timingfd = stderr;
+	FILE *timingfd = NULL;
 
 	enum { FORCE_OPTION = CHAR_MAX + 1 };
 
@@ -274,9 +274,11 @@ main(int argc, char **argv) {
 			warn(_("fork failed"));
 			fail();
 		}
-		if (child)
+		if (child) {
+			if (!timingfd)
+				timingfd = fdopen(STDERR_FILENO, "w");
 			dooutput(timingfd);
-		else
+		} else
 			doshell();
 	} else {
 		sa.sa_handler = resize;
-- 
1.8.0

