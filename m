Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.24]:51492 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631AbcGJOOS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Jul 2016 10:14:18 -0400
Received: from localhost ([79.234.43.175]) by mrelayeu.kundenserver.de
 (mreue102) with ESMTPSA (Nemesis) id 0MV4iD-1buZDj3Zrp-00YOpl for
 <util-linux@vger.kernel.org>; Sun, 10 Jul 2016 16:14:10 +0200
Date: Sun, 10 Jul 2016 16:14:08 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] Fix segmentation fault in tailf on 32 bit
Message-ID: <20160710141407.GA26802@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

tailf crashes with a segmentation fault when used with a file that is
exactly 4GB in size due to an integer overflow between off_t and size_t:

$ dd if=/dev/zero of=tailf.crash bs=1 count=1 seek=4294967295
$ tailf tailf.crash
Segmentation fault
$ _

Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
---
 text-utils/tailf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/text-utils/tailf.c b/text-utils/tailf.c
index ea082c7..e9ba49b 100644
--- a/text-utils/tailf.c
+++ b/text-utils/tailf.c
@@ -42,6 +42,7 @@
 #include <errno.h>
 #include <getopt.h>
 #include <sys/mman.h>
+#include <limits.h>
 
 #ifdef HAVE_INOTIFY_INIT
 #include <sys/inotify.h>
@@ -55,7 +56,7 @@
 
 #define DEFAULT_LINES  10
 
-/* st->st_size has to be greater than zero! */
+/* st->st_size has to be greater than zero and smaller or equal to SIZE_MAX! */
 static void tailf(const char *filename, size_t lines, struct stat *st)
 {
 	int fd;
@@ -281,7 +282,7 @@ int main(int argc, char **argv)
 		err(EXIT_FAILURE, _("stat of %s failed"), filename);
 	if (!S_ISREG(st.st_mode))
 		errx(EXIT_FAILURE, _("%s: is not a file"), filename);
-	if (st.st_size)
+	if (st.st_size && st.st_size <= SIZE_MAX)
 		tailf(filename, lines, &st);
 
 #ifdef HAVE_INOTIFY_INIT
-- 
2.9.0

