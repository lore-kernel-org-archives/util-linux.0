Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:62192 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbbACJ2J (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 Jan 2015 04:28:09 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so634874wiv.5
        for <util-linux@vger.kernel.org>; Sat, 03 Jan 2015 01:28:08 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/2] fsck.minix: fix segmentation fault
Date: Sat,  3 Jan 2015 09:20:05 +0000
Message-Id: <1420276805-3154-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1420276805-3154-1-git-send-email-kerolasa@iki.fi>
References: <1420276805-3154-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Return from check_file() and check_file2() functions when maximum name
depth is reached.  The use unsafe strncpy() is also removed just to be on
safe side.

Addresses: https://bugs.debian.org/773892
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fsck.minix.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index c0ed017..5ab19bb 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -112,6 +112,7 @@
 #include "all-io.h"
 #include "closestream.h"
 #include "rpmatch.h"
+#include "strutils.h"
 
 #define ROOT_INO 1
 #define YESNO_LENGTH 64
@@ -952,7 +953,9 @@ check_file(struct minix_inode *dir, unsigned int offset) {
 		ino = 0;
 	}
 	if (name_depth < MAX_DEPTH)
-		strncpy(name_list[name_depth], name, namelen);
+		xstrncpy(name_list[name_depth], name, namelen);
+	else
+		return;
 	name_depth++;
 	inode = get_inode(ino);
 	name_depth--;
@@ -977,7 +980,9 @@ check_file(struct minix_inode *dir, unsigned int offset) {
 	if (!inode)
 		return;
 	if (name_depth < MAX_DEPTH)
-		strncpy(name_list[name_depth], name, namelen);
+		xstrncpy(name_list[name_depth], name, namelen);
+	else
+		return;
 	name_depth++;
 	if (list) {
 		if (verbose)
@@ -1020,7 +1025,9 @@ check_file2(struct minix2_inode *dir, unsigned int offset) {
 		ino = 0;
 	}
 	if (name_depth < MAX_DEPTH)
-		strncpy(name_list[name_depth], name, namelen);
+		xstrncpy(name_list[name_depth], name, namelen);
+	else
+		return;
 	name_depth++;
 	inode = get_inode2(ino);
 	name_depth--;
-- 
2.2.1

