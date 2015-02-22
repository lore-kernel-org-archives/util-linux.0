Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f181.google.com ([74.125.82.181]:42543 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbbBVOmJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:09 -0500
Received: by wesw62 with SMTP id w62so13565039wes.9
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:08 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 12/16] tailf: count last lines correctly at initial print out
Date: Sun, 22 Feb 2015 14:41:42 +0000
Message-Id: <1424616106-580-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When last lines happen to be greater than string buffer size for fgets()
the number of printed lines resulted to too few.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/tailf.c | 56 +++++++++++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/text-utils/tailf.c b/text-utils/tailf.c
index 0c477ad..b5ea4c2 100644
--- a/text-utils/tailf.c
+++ b/text-utils/tailf.c
@@ -36,6 +36,8 @@
 #include <ctype.h>
 #include <errno.h>
 #include <getopt.h>
+#include <sys/mman.h>
+
 #ifdef HAVE_INOTIFY_INIT
 #include <sys/inotify.h>
 #endif
@@ -49,40 +51,34 @@
 #define DEFAULT_LINES  10
 
 static void
-tailf(const char *filename, int lines)
+tailf(const char *filename, unsigned long lines, struct stat *old)
 {
-	char *buf, *p;
-	int  head = 0;
-	int  tail = 0;
-	FILE *str;
-	int  i;
+	int fd;
+	size_t i;
+	char *data;
 
-	if (!(str = fopen(filename, "r")))
+	if (!(fd = open(filename, O_RDONLY)))
 		err(EXIT_FAILURE, _("cannot open %s"), filename);
-
-	buf = xmalloc((lines ? lines : 1) * BUFSIZ);
-	p = buf;
-	while (fgets(p, BUFSIZ, str)) {
-		if (++tail >= lines) {
-			tail = 0;
-			head = 1;
+	data = mmap(0, old->st_size, PROT_READ, MAP_SHARED, fd, 0);
+	i = (size_t)old->st_size - 1;
+	/* humans do not think last new line in a file should be counted,
+	 * in that case do off by one from counter point of view */
+	if (data[i] == '\n')
+		lines++;
+	while (i) {
+		if (data[i] == '\n') {
+			if (--lines == 0) {
+				i++;
+				break;
+			}
 		}
-		p = buf + (tail * BUFSIZ);
+		i--;
 	}
-
-	if (head) {
-		for (i = tail; i < lines; i++)
-			fputs(buf + (i * BUFSIZ), stdout);
-		for (i = 0; i < tail; i++)
-			fputs(buf + (i * BUFSIZ), stdout);
-	} else {
-		for (i = head; i < tail; i++)
-			fputs(buf + (i * BUFSIZ), stdout);
-	}
-
+	while (i < (size_t)old->st_size)
+		putchar(data[i++]);
+	munmap(data, old->st_size);
+	close(fd);
 	fflush(stdout);
-	free(buf);
-	fclose(str);
 }
 
 static void
@@ -283,8 +279,8 @@ int main(int argc, char **argv)
 
 	if (stat(filename, &old) != 0)
 		err(EXIT_FAILURE, _("stat of %s failed"), filename);
-
-	tailf(filename, lines);
+	if (lines && old.st_size)
+		tailf(filename, lines, &old);
 
 #ifdef HAVE_INOTIFY_INIT
 	if (!watch_file_inotify(filename, &old))
-- 
2.3.0

