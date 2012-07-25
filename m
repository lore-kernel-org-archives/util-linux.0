Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38021 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab2GYTQC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:16:02 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr14so1133220wib.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:16:02 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/19] hexdump: fix shadow declaration
Date: Wed, 25 Jul 2012 21:15:33 +0200
Message-Id: <1343243745-1172-16-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

text-utils/hexdump.h:84:5: warning: shadowed declaration is here [-Wshadow]
./include/xalloc.h:23:28: warning: declaration of 'size' shadows a global declaration [-Wshadow]
./include/xalloc.h:33:40: warning: declaration of 'size' shadows a global declaration [-Wshadow]
./include/xalloc.h:43:49: warning: declaration of 'size' shadows a global declaration [-Wshadow]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/hexdump.c | 2 +-
 text-utils/hexdump.h | 2 +-
 text-utils/parse.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/text-utils/hexdump.c b/text-utils/hexdump.c
index 90c2d77..a4a61cf 100644
--- a/text-utils/hexdump.c
+++ b/text-utils/hexdump.c
@@ -68,7 +68,7 @@ int main(int argc, char **argv)
 
 	/* figure out the data block size */
 	for (blocksize = 0, tfs = fshead; tfs; tfs = tfs->nextfs) {
-		tfs->bcnt = size(tfs);
+		tfs->bcnt = block_size(tfs);
 		if (blocksize < tfs->bcnt)
 			blocksize = tfs->bcnt;
 	}
diff --git a/text-utils/hexdump.h b/text-utils/hexdump.h
index 2222585..b9e67a1 100644
--- a/text-utils/hexdump.h
+++ b/text-utils/hexdump.h
@@ -81,7 +81,7 @@ extern off_t skip;                      /* bytes to skip */
 enum _vflag { ALL, DUP, FIRST, WAIT };	/* -v values */
 extern enum _vflag vflag;
 
-int size(FS *);
+int block_size(FS *);
 void add(const char *);
 void rewrite(FS *);
 void addfile(char *);
diff --git a/text-utils/parse.c b/text-utils/parse.c
index 481db6d..5f1e2bd 100644
--- a/text-utils/parse.c
+++ b/text-utils/parse.c
@@ -150,7 +150,7 @@ void add(const char *fmt)
 
 static const char *spec = ".#-+ 0123456789";
 
-int size(FS *fs)
+int block_size(FS *fs)
 {
 	FU *fu;
 	int bcnt, cursize;
-- 
1.7.11.3

