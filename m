Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33963 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156AbcGCVYI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jul 2016 17:24:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id 187so17569137wmz.1
        for <util-linux@vger.kernel.org>; Sun, 03 Jul 2016 14:24:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 04/15] write: set atime value in term_chk() only when needed
Date: Sun,  3 Jul 2016 22:23:47 +0100
Message-Id: <20160703212358.1218-5-kerolasa@iki.fi>
In-Reply-To: <20160703212358.1218-1-kerolasa@iki.fi>
References: <20160703212358.1218-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The search_utmp() is needs atime but main() does not, so remove the later.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index 03af660..fb9cdf5 100644
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
2.9.0

