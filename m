Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:50112 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313Ab3IHQJ1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Sep 2013 12:09:27 -0400
Received: by mail-wg0-f52.google.com with SMTP id m14so4503349wgh.31
        for <util-linux@vger.kernel.org>; Sun, 08 Sep 2013 09:09:26 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Ondrej Oprala <ooprala@redhat.com>
Subject: [PATCH 4/4] hexdump: revert global exitval variable change
Date: Sun,  8 Sep 2013 17:09:09 +0100
Message-Id: <1378656549-3729-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1378656549-3729-1-git-send-email-kerolasa@iki.fi>
References: <1378656549-3729-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The change f2a037fb7b153954d5d34cca48182b6d8832fcfa had unfavorable
effect of making hexdump to return non-zero exit value always.

This happen because oversight when 'exitval' gets to be set.  By clance,
one might expect main() to call next() which will return value for
'exitval'.  That assessment misses later call chain main() -> display()
-> get() -> next(), which in reverse should return correct value for
'exitval'.

It was mentioned in util-linux maillist that Ondrej Oprala is working on
major renewal of the hexdump .  That in mind it seems best to simply to
revert the global 'exitval' and avoid conflict with Ondrej's work.

Reference: http://markmail.org/message/sbnvuhkboreujj5p
Reported-by: Dave Reisner <d@falconindy.com>
CC: Ondrej Oprala <ooprala@redhat.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/display.c | 6 +++---
 text-utils/hexdump.c | 4 ++--
 text-utils/hexdump.h | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/text-utils/display.c b/text-utils/display.c
index 41ddd8d..1f9a11b 100644
--- a/text-utils/display.c
+++ b/text-utils/display.c
@@ -295,7 +295,7 @@ get(void)
 int next(char **argv)
 {
 	static int done;
-	int statok, exitval = 0;
+	int statok;
 
 	if (argv) {
 		_argv = argv;
@@ -305,14 +305,14 @@ int next(char **argv)
 		if (*_argv) {
 			if (!(freopen(*_argv, "r", stdin))) {
 				warn("%s", *_argv);
-				exitval = 1;
+				exitval = EXIT_FAILURE;
 				++_argv;
 				continue;
 			}
 			statok = done = 1;
 		} else {
 			if (done++)
-				return(exitval);
+				return(0);
 			statok = 0;
 		}
 		if (skip)
diff --git a/text-utils/hexdump.c b/text-utils/hexdump.c
index 411d809..e966cc3 100644
--- a/text-utils/hexdump.c
+++ b/text-utils/hexdump.c
@@ -47,11 +47,11 @@
 
 FS *fshead;				/* head of format strings */
 ssize_t blocksize;			/* data block size */
+int exitval;				/* final exit value */
 ssize_t length = -1;			/* max bytes to read */
 
 int main(int argc, char **argv)
 {
-	int exitval;			/* final exit value */
 	FS *tfs;
 	char *p;
 
@@ -76,7 +76,7 @@ int main(int argc, char **argv)
 	for (tfs = fshead; tfs; tfs = tfs->nextfs)
 		rewrite(tfs);
 
-	exitval = next(argv);
+	(void)next(argv);
 	display();
 	return exitval;
 }
diff --git a/text-utils/hexdump.h b/text-utils/hexdump.h
index b2ea1f1..fa8f632 100644
--- a/text-utils/hexdump.h
+++ b/text-utils/hexdump.h
@@ -73,6 +73,7 @@ typedef struct _fs {			/* format strings */
 extern FU *endfu;
 extern FS *fshead;			/* head of format strings list */
 extern ssize_t blocksize;		/* data block size */
+extern int exitval;			/* final exit value */
 extern ssize_t length;			/* max bytes to read */
 extern off_t skip;                      /* bytes to skip */
 
-- 
1.8.4

