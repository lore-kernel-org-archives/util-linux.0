Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:62417 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab3BPSIu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Feb 2013 13:08:50 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm14so2224024wib.16
        for <util-linux@vger.kernel.org>; Sat, 16 Feb 2013 10:08:49 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] wall: use xgethostname()
Date: Sat, 16 Feb 2013 18:08:40 +0000
Message-Id: <1361038120-5880-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/wall.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/term-utils/wall.c b/term-utils/wall.c
index e370807..c2ac7ad 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -182,10 +182,9 @@ makemsg(char *fname, size_t *mbufsize, int print_banner)
 	struct stat sbuf;
 	time_t now;
 	FILE *fp;
-	char *p, *whom, *where, *hostname, *lbuf, *tmpname, *mbuf;
+	char *p, *whom, *where, *lbuf, *tmpname, *mbuf;
 	long line_max;
 
-	hostname = xmalloc(sysconf(_SC_HOST_NAME_MAX) + 1);
 	line_max = sysconf(_SC_LINE_MAX);
 	lbuf = xmalloc(line_max);
 
@@ -195,6 +194,7 @@ makemsg(char *fname, size_t *mbufsize, int print_banner)
 	free(tmpname);
 
 	if (print_banner == TRUE) {
+		char *hostname = xgethostname();
 		if (!(whom = getlogin()) || !*whom)
 			whom = (pw = getpwuid(getuid())) ? pw->pw_name : "???";
 		if (!whom) {
@@ -206,7 +206,6 @@ makemsg(char *fname, size_t *mbufsize, int print_banner)
 			where = "somewhere";
 			warn(_("cannot get tty name"));
 		}
-		gethostname(hostname, sizeof(hostname));
 		time(&now);
 		lt = localtime(&now);
 
@@ -222,6 +221,7 @@ makemsg(char *fname, size_t *mbufsize, int print_banner)
 		fprintf(fp, "\r%79s\r\n", " ");
 		sprintf(lbuf, _("Broadcast Message from %s@%s"),
 			      whom, hostname);
+		free(hostname);
 		fprintf(fp, "%-79.79s\007\007\r\n", lbuf);
 		sprintf(lbuf, "        (%s) at %d:%02d ...",
 			      where, lt->tm_hour, lt->tm_min);
@@ -229,7 +229,6 @@ makemsg(char *fname, size_t *mbufsize, int print_banner)
 	}
 	fprintf(fp, "%79s\r\n", " ");
 
-	free(hostname);
 
 	if (fname) {
 		/*
-- 
1.8.1.3

