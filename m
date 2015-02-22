Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:56442 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbbBVOmL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:11 -0500
Received: by mail-wg0-f46.google.com with SMTP id a1so21253981wgh.5
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:10 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 14/16] tailf: ensure file argument really is a file
Date: Sun, 22 Feb 2015 14:41:44 +0000
Message-Id: <1424616106-580-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The tailf(1) never worked very well with block or character devices,
sockets, fifos and such.  Now after mmap() is used to find last lines
even the little command used to work is broken, so test the tailf is
asked to follow a file and when not fail.  That said symlinks are OK, as
long they point to a file.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/tailf.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/text-utils/tailf.c b/text-utils/tailf.c
index d856203..7f053a4 100644
--- a/text-utils/tailf.c
+++ b/text-utils/tailf.c
@@ -233,6 +233,28 @@ static long old_style_option(int *argc, char **argv, unsigned long *lines)
 	return ret;
 }
 
+static int is_file(const char *filename, const struct stat sb)
+{
+	switch (sb.st_mode & S_IFMT) {
+	case S_IFREG:
+		return 0;
+	case S_IFLNK:
+		{
+			char *resolved_path = NULL;
+			struct stat follow;
+			int ret;
+
+			if (realpath(filename, resolved_path)) {
+				stat(resolved_path, &follow);
+				ret = is_file(resolved_path, follow);
+				free(resolved_path);
+				return ret;
+			}
+		}
+	}
+	return 1;
+}
+
 int main(int argc, char **argv)
 {
 	const char *filename;
@@ -281,6 +303,8 @@ int main(int argc, char **argv)
 
 	if (stat(filename, &old) != 0)
 		err(EXIT_FAILURE, _("stat of %s failed"), filename);
+	if (is_file(filename, old))
+		errx(EXIT_FAILURE, _("%s: is not a file"), filename);
 	if (lines && old.st_size)
 		tailf(filename, lines, &old);
 
-- 
2.3.0

