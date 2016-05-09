Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33291 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbcEIV1s (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 9 May 2016 17:27:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id r12so22517777wme.0
        for <util-linux@vger.kernel.org>; Mon, 09 May 2016 14:27:48 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 04/12] write: set atime value in term_chk() only if needed
Date: Mon,  9 May 2016 22:27:20 +0100
Message-Id: <1462829248-6935-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
References: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The atime comparison is done only in search_utmp(), the main does not use
this variable.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index 4c6a25f..dd31f59 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -104,7 +104,8 @@ static int term_chk(char *tty, int *msgsokP, time_t * atimeP, int showerror)
 		*msgsokP = 1;
 	else
 		*msgsokP = (s.st_mode & S_IWGRP) && (getegid() == s.st_gid);
-	*atimeP = s.st_atime;
+	if (atimeP)
+		*atimeP = s.st_atime;
 	return 0;
 }
 
@@ -284,7 +285,6 @@ static void do_write(char *tty, char *mytty, uid_t myuid)
 
 int main(int argc, char **argv)
 {
-	time_t atime;
 	uid_t myuid;
 	int msgsok = 0, myttyfd, c;
 	char tty[PATH_MAX], *mytty;
@@ -333,7 +333,7 @@ int main(int argc, char **argv)
 		 */
 		if (!strncmp(mytty, "/dev/", 5))
 			mytty += 5;
-		if (term_chk(mytty, &msgsok, &atime, 1))
+		if (term_chk(mytty, &msgsok, NULL, 1))
 			exit(EXIT_FAILURE);
 		if (!msgsok)
 			errx(EXIT_FAILURE,
@@ -357,7 +357,7 @@ int main(int argc, char **argv)
 			errx(EXIT_FAILURE,
 			     _("%s is not logged in on %s"),
 			     argv[1], argv[2]);
-		if (term_chk(argv[2], &msgsok, &atime, 1))
+		if (term_chk(argv[2], &msgsok, NULL, 1))
 			exit(EXIT_FAILURE);
 		if (myuid && !msgsok)
 			errx(EXIT_FAILURE,
-- 
2.8.2

