Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:50527 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbaKBU1I (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Nov 2014 15:27:08 -0500
Received: by mail-wi0-f172.google.com with SMTP id bs8so4940305wib.17
        for <util-linux@vger.kernel.org>; Sun, 02 Nov 2014 12:27:07 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/8] mkswap: use err() rather than perror() && exit()
Date: Sun,  2 Nov 2014 20:26:27 +0000
Message-Id: <1414959991-8369-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
References: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The messsages in err() are verified from po/util-linux.pot to be already
part of translations.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkswap.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index b2713ab..14adf0f 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -209,10 +209,8 @@ get_size(const char *file)
 	unsigned long long size;
 
 	fd = open(file, O_RDONLY);
-	if (fd < 0) {
-		perror(file);
-		exit(EXIT_FAILURE);
-	}
+	if (fd < 0)
+		err(EXIT_FAILURE, _("cannot open %s"), file);
 	if (blkdev_get_size(fd, &size) == 0)
 		size /= pagesize;
 
@@ -434,19 +432,14 @@ main(int argc, char **argv) {
 			"%s is mounted; will not make swapspace"),
 			device_name);
 
-	if (stat(device_name, &statbuf) < 0) {
-		perror(device_name);
-		exit(EXIT_FAILURE);
-	}
+	if (stat(device_name, &statbuf) < 0)
+		err(EXIT_FAILURE, _("stat failed %s"), device_name);
 	if (S_ISBLK(statbuf.st_mode))
 		DEV = open(device_name, O_RDWR | O_EXCL);
 	else
 		DEV = open(device_name, O_RDWR);
-
-	if (DEV < 0) {
-		perror(device_name);
-		exit(EXIT_FAILURE);
-	}
+	if (DEV < 0)
+		err(EXIT_FAILURE, _("cannot open %s"), device_name);
 
 	if (!S_ISBLK(statbuf.st_mode))
 		check=0;
-- 
2.1.3

