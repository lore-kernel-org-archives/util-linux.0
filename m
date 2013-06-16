Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:36062 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360Ab3FPSyt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Jun 2013 14:54:49 -0400
Received: by mail-we0-f173.google.com with SMTP id x54so1761550wes.4
        for <util-linux@vger.kernel.org>; Sun, 16 Jun 2013 11:54:48 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 14/15] hexdump: remove unnecessary global variables
Date: Sun, 16 Jun 2013 19:53:55 +0100
Message-Id: <1371408836-16663-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/display.c | 6 +++---
 text-utils/hexdump.c | 4 ++--
 text-utils/hexdump.h | 2 --
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/text-utils/display.c b/text-utils/display.c
index 1f9a11b..41ddd8d 100644
--- a/text-utils/display.c
+++ b/text-utils/display.c
@@ -295,7 +295,7 @@ get(void)
 int next(char **argv)
 {
 	static int done;
-	int statok;
+	int statok, exitval = 0;
 
 	if (argv) {
 		_argv = argv;
@@ -305,14 +305,14 @@ int next(char **argv)
 		if (*_argv) {
 			if (!(freopen(*_argv, "r", stdin))) {
 				warn("%s", *_argv);
-				exitval = EXIT_FAILURE;
+				exitval = 1;
 				++_argv;
 				continue;
 			}
 			statok = done = 1;
 		} else {
 			if (done++)
-				return(0);
+				return(exitval);
 			statok = 0;
 		}
 		if (skip)
diff --git a/text-utils/hexdump.c b/text-utils/hexdump.c
index e966cc3..411d809 100644
--- a/text-utils/hexdump.c
+++ b/text-utils/hexdump.c
@@ -47,11 +47,11 @@
 
 FS *fshead;				/* head of format strings */
 ssize_t blocksize;			/* data block size */
-int exitval;				/* final exit value */
 ssize_t length = -1;			/* max bytes to read */
 
 int main(int argc, char **argv)
 {
+	int exitval;			/* final exit value */
 	FS *tfs;
 	char *p;
 
@@ -76,7 +76,7 @@ int main(int argc, char **argv)
 	for (tfs = fshead; tfs; tfs = tfs->nextfs)
 		rewrite(tfs);
 
-	(void)next(argv);
+	exitval = next(argv);
 	display();
 	return exitval;
 }
diff --git a/text-utils/hexdump.h b/text-utils/hexdump.h
index b9e67a1..b2ea1f1 100644
--- a/text-utils/hexdump.h
+++ b/text-utils/hexdump.h
@@ -73,8 +73,6 @@ typedef struct _fs {			/* format strings */
 extern FU *endfu;
 extern FS *fshead;			/* head of format strings list */
 extern ssize_t blocksize;		/* data block size */
-extern int deprecated;			/* od compatibility */
-extern int exitval;			/* final exit value */
 extern ssize_t length;			/* max bytes to read */
 extern off_t skip;                      /* bytes to skip */
 
-- 
1.8.3.1

