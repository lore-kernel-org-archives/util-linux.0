Return-Path: util-linux-owner@vger.kernel.org
Received: from kontorsmtp2.one.com ([195.47.247.17]:52507 "EHLO
	kontorsmtp2.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbaBRTs5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 18 Feb 2014 14:48:57 -0500
From: Jesper Dahl Nyerup <nyerup@one.com>
To: util-linux@vger.kernel.org
Cc: nyerup@one.com
Subject: [PATCH] script: Also flush writes to timing file.
Date: Tue, 18 Feb 2014 20:48:45 +0100
Message-Id: <1392752925-48502-1-git-send-email-nyerup@one.com>
In-Reply-To: <1392673386-42128-1-git-send-email-nyerup@one.com>
References: <1392673386-42128-1-git-send-email-nyerup@one.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If both -f and -t are given, flush the timing fd on each write, similar
to the behavior on the script fd. This allows playback of still-running
sessions, and reduces the risk of ending up with empty timing files when
script(1) exits abnormally.

Signed-off-by: Jesper Dahl Nyerup <nyerup@one.com>
---
 term-utils/script.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index a4c2e0c..d6e04d6 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -440,8 +440,11 @@ dooutput(FILE *timingfd) {
 			warn (_("cannot write script file"));
 			fail();
 		}
-		if (fflg)
+		if (fflg) {
 			fflush(fscript);
+			if (tflg)
+				fflush(timingfd);
+		}
 		if (write_all(STDOUT_FILENO, obuf, cc)) {
 			warn (_("write failed"));
 			fail();
-- 
1.8.4

