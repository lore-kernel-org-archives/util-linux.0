Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f49.google.com ([74.125.82.49]:64537 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbbBVOmI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:08 -0500
Received: by mail-wg0-f49.google.com with SMTP id l18so21232876wgh.8
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:07 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 11/16] tailf: check printing criteria more carefully
Date: Sun, 22 Feb 2015 14:41:41 +0000
Message-Id: <1424616106-580-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier size check did not print out contents of a file if it happen to
be same size as last time roll_file() function ran.  The earlier buggy
behavior was easy to reproduce with two terminal windows.  Contents of
the second echo were not visible.

term1> tailf /tmp/tailf-test
terminal2> echo 1 >| /tmp/tailf-test
terminal2> echo 2 >| /tmp/tailf-test

In this commit also a mount point and a file changes are detected,
leading to full printout of a file in such cases.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/tailf.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/text-utils/tailf.c b/text-utils/tailf.c
index 38df99f..0c477ad 100644
--- a/text-utils/tailf.c
+++ b/text-utils/tailf.c
@@ -86,7 +86,7 @@ tailf(const char *filename, int lines)
 }
 
 static void
-roll_file(const char *filename, off_t *size)
+roll_file(const char *filename, struct stat *old)
 {
 	char buf[BUFSIZ];
 	int fd;
@@ -100,12 +100,17 @@ roll_file(const char *filename, off_t *size)
 	if (fstat(fd, &st) == -1)
 		err(EXIT_FAILURE, _("stat of %s failed"), filename);
 
-	if (st.st_size == *size) {
+	if (st.st_size == old->st_size && st.st_mtime == old->st_mtime &&
+	    st.st_ino == old->st_ino && st.st_dev == old->st_dev) {
 		close(fd);
 		return;
 	}
 
-	if (lseek(fd, *size, SEEK_SET) != (off_t)-1) {
+	if (st.st_ino != old->st_ino || st.st_dev != old->st_dev
+	    || (old->st_mtime < st.st_mtime && st.st_size <= old->st_size))
+		old->st_size = 0;
+
+	if (lseek(fd, old->st_size, SEEK_SET) != (off_t)-1) {
 		ssize_t rc, wc;
 
 		while ((rc = read(fd, buf, sizeof(buf))) > 0) {
@@ -123,16 +128,16 @@ roll_file(const char *filename, off_t *size)
 	 * avoids data duplication. If we read nothing or hit an error, reset
 	 * to the reported size, this handles truncated files.
 	 */
-	*size = (pos != -1 && pos != *size) ? pos : st.st_size;
+	old->st_size = (pos != -1 && pos != old->st_size) ? pos : 0;
 
 	close(fd);
 }
 
 static void
-watch_file(const char *filename, off_t *size)
+watch_file(const char *filename, struct stat *old)
 {
 	do {
-		roll_file(filename, size);
+		roll_file(filename, old);
 		xusleep(250000);
 	} while(1);
 }
@@ -144,7 +149,7 @@ watch_file(const char *filename, off_t *size)
 #define NEVENTS		4
 
 static int
-watch_file_inotify(const char *filename, off_t *size)
+watch_file_inotify(const char *filename, struct stat *old)
 {
 	char buf[ NEVENTS * sizeof(struct inotify_event) ];
 	int fd, ffd, e;
@@ -176,7 +181,7 @@ watch_file_inotify(const char *filename, off_t *size)
 			struct inotify_event *ev = (struct inotify_event *) &buf[e];
 
 			if (ev->mask & IN_MODIFY)
-				roll_file(filename, size);
+				roll_file(filename, old);
 			else {
 				close(ffd);
 				ffd = -1;
@@ -237,8 +242,7 @@ int main(int argc, char **argv)
 	const char *filename;
 	long lines;
 	int ch;
-	struct stat st;
-	off_t size = 0;
+	struct stat old;
 
 	static const struct option longopts[] = {
 		{ "lines",   required_argument, 0, 'n' },
@@ -277,16 +281,15 @@ int main(int argc, char **argv)
 
 	filename = argv[optind];
 
-	if (stat(filename, &st) != 0)
+	if (stat(filename, &old) != 0)
 		err(EXIT_FAILURE, _("stat of %s failed"), filename);
 
-	size = st.st_size;;
 	tailf(filename, lines);
 
 #ifdef HAVE_INOTIFY_INIT
-	if (!watch_file_inotify(filename, &size))
+	if (!watch_file_inotify(filename, &old))
 #endif
-		watch_file(filename, &size);
+		watch_file(filename, &old);
 
 	return EXIT_SUCCESS;
 }
-- 
2.3.0

