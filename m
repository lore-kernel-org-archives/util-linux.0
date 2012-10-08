Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56748 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab2JHHJI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Oct 2012 03:09:08 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3493411wgb.1
        for <util-linux@vger.kernel.org>; Mon, 08 Oct 2012 00:09:07 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/14] more: remove few memory leaks
Date: Mon,  8 Oct 2012 08:08:19 +0100
Message-Id: <1349680100-18120-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
References: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The remaining memory leaks are related to ncurses internals, or the one
open file descriptor when user users 'q' to exit.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 2ecb218..163f016 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -432,6 +432,7 @@ int main(int argc, char **argv)
 				}
 			}
 			if (srchopt) {
+				free(previousre);
 				previousre = xstrdup(initbuf);
 				search(initbuf, stdin, 1);
 				if (noscroll)
@@ -454,6 +455,7 @@ int main(int argc, char **argv)
 			if (firstf) {
 				firstf = 0;
 				if (srchopt) {
+					free(previousre);
 					previousre = xstrdup(initbuf);
 					search(initbuf, f, 1);
 					if (noscroll)
@@ -509,6 +511,7 @@ int main(int argc, char **argv)
 	}
 	free(previousre);
 	free(initbuf);
+	free(Line);
 	reset_tty();
 	exit(EXIT_SUCCESS);
 }
@@ -766,6 +769,8 @@ void __attribute__((__noreturn__)) end_it(int dummy __attribute__((__unused__)))
 		fflush(stdout);
 	} else
 		putcerr('\n');
+	free(previousre);
+	free(Line);
 	_exit(EXIT_SUCCESS);
 }
 
@@ -1624,6 +1629,7 @@ void search(char buf[], FILE *file, register int n)
 			}
 		}
 	}
+	regfree(&re);
 	if (feof(file)) {
 		if (!no_intty) {
 			Currline = saveln;
@@ -1632,9 +1638,9 @@ void search(char buf[], FILE *file, register int n)
 			putsout(_("\nPattern not found\n"));
 			end_it(0);
 		}
-		more_error(_("Pattern not found"));
 		free(previousre);
 		previousre = NULL;
+		more_error(_("Pattern not found"));
 	}
 }
 
-- 
1.7.12.2

