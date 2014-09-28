Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:58840 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbaI1Twj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:52:39 -0400
Received: by mail-wi0-f178.google.com with SMTP id ho1so714283wib.11
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:52:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/23] lsblk: fix compiler warning
Date: Sun, 28 Sep 2014 20:51:44 +0100
Message-Id: <1411933916-30576-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

warning: ISO C forbids empty initializer braces [-Wpedantic]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/lsblk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index dc1cf69..a87d997 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -1143,7 +1143,7 @@ static int list_partitions(struct blkdev_cxt *wholedisk_cxt, struct blkdev_cxt *
 {
 	DIR *dir;
 	struct dirent *d;
-	struct blkdev_cxt part_cxt = {};
+	struct blkdev_cxt part_cxt = { 0 };
 	int r = -1;
 
 	assert(wholedisk_cxt);
@@ -1242,7 +1242,7 @@ static int list_deps(struct blkdev_cxt *cxt)
 {
 	DIR *dir;
 	struct dirent *d;
-	struct blkdev_cxt dep = {};
+	struct blkdev_cxt dep = { 0 };
 	char dirname[PATH_MAX];
 	const char *depname;
 
@@ -1293,7 +1293,7 @@ static int iterate_block_devices(void)
 {
 	DIR *dir;
 	struct dirent *d;
-	struct blkdev_cxt cxt = {};
+	struct blkdev_cxt cxt = { 0 };
 
 	if (!(dir = opendir(_PATH_SYS_BLOCK)))
 		return EXIT_FAILURE;
@@ -1341,7 +1341,7 @@ static char *devno_to_sysfs_name(dev_t devno, char *devname, char *buf, size_t b
 
 static int process_one_device(char *devname)
 {
-	struct blkdev_cxt parent = {}, cxt = {};
+	struct blkdev_cxt parent = { 0 }, cxt = { 0 };
 	struct stat st;
 	char buf[PATH_MAX + 1], *name, *diskname = NULL;
 	dev_t disk = 0;
-- 
2.1.1

