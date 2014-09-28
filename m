Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f175.google.com ([74.125.82.175]:34780 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbaI1TwL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:52:11 -0400
Received: by mail-we0-f175.google.com with SMTP id q59so743324wes.6
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:52:09 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/23] hexdump: remove deprecation message
Date: Sun, 28 Sep 2014 20:51:36 +0100
Message-Id: <1411933916-30576-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Message 'calling hexdump as od has been deprecated in favor of GNU
coreutils od' has informed the hexdump not to be used like that for three
and half years, and five releases.  It is time to get rid of notice.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/hexdump.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/text-utils/hexdump.c b/text-utils/hexdump.c
index 50b593e..afae334 100644
--- a/text-utils/hexdump.c
+++ b/text-utils/hexdump.c
@@ -179,7 +179,6 @@ int main(int argc, char **argv)
 	struct list_head *p;
 	struct hexdump_fs *tfs;
 	int ret;
-	char *c;
 
 	struct hexdump *hex = xcalloc(1, sizeof (struct hexdump));
 	hex->length = -1;
@@ -190,11 +189,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	if (!(c = strrchr(argv[0], 'o')) || strcmp(c, "od")) {
-		argv += parse_args(argc, argv, hex);
-	} else
-		errx(EXIT_FAILURE, _("calling hexdump as od has been deprecated "
-				     "in favor of GNU coreutils od"));
+	argv += parse_args(argc, argv, hex);
 
 	/* figure out the data block size */
 	hex->blocksize = 0;
-- 
2.1.1

