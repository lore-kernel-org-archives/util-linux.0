Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:41926 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754175Ab2BPT70 (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 16 Feb 2012 14:59:26 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id F26CA654CD
	for <util-linux-ng@vger.kernel.org>; Thu, 16 Feb 2012 19:59:25 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux-ng@vger.kernel.org
Subject: [PATCH] umount: respect fs search path
Date: Thu, 16 Feb 2012 14:59:26 -0500
Message-Id: <1329422366-576-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This brings search path support to umount to match existing behavior
in fsck and mount.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 mount/umount.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/mount/umount.c b/mount/umount.c
index ad93e75..a6fcd33 100644
--- a/mount/umount.c
+++ b/mount/umount.c
@@ -100,7 +100,8 @@ static int fake = 0;
 static int
 check_special_umountprog(const char *node,
 			 const char *type, int *status) {
-	char umountprog[120];
+	char search_path[] = FS_SEARCH_PATH;
+	char *path, umountprog[150];
 	struct stat statbuf;
 	int res;
 
@@ -110,10 +111,16 @@ check_special_umountprog(const char *node,
 	if (type == NULL || strcmp(type, "none") == 0)
 		return 0;
 
-	if (strlen(type) < 100) {
+	path = strtok(search_path, ":");
+	while (path) {
 		int type_opt = 0;
 
-		sprintf(umountprog, "/sbin/umount.%s", type);
+		res = snprintf(umountprog, sizeof(umountprog), "%s/umount.%s",
+			       path, type);
+		path = strtok(NULL, ":");
+		if (res < 0 || (size_t) res >= sizeof(umountprog))
+			continue;
+
 		res = stat(umountprog, &statbuf);
 		if (res == -1 && errno == ENOENT && strchr(type, '.')) {
 			/* If type ends with ".subtype" try without it */
-- 
1.7.8.4

