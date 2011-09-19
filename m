Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:34168 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172Ab1ISN3R (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 Sep 2011 09:29:17 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id F05E98F3B5
	for <util-linux@vger.kernel.org>; Mon, 19 Sep 2011 15:29:16 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/7] sfdisk: get_disksize() returns long long
Date: Mon, 19 Sep 2011 15:29:12 +0200
Message-Id: <1316438955-20790-5-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1316438955-20790-1-git-send-email-petr.uzel@suse.cz>
References: <1316438955-20790-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

unsigned long is 4 bytes long on i586, which is not enough for big
HDD's with 512B sectors. Use unsigned long long, which is 8 bytes.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisk/sfdisk.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index 820e23e..9c94185 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -928,7 +928,7 @@ unitsize(int format) {
     }
 }
 
-static unsigned long
+static unsigned long long
 get_disksize(int format) {
     if (B.total_size && leave_last)
 	/* don't use last cylinder (--leave-last option) */
@@ -1266,7 +1266,7 @@ partitions_ok(struct disk_desc *z) {
 
     /* Do they start past zero and end before end-of-disk? */
     {
-	unsigned long ds = get_disksize(F_SECTOR);
+	unsigned long long ds = get_disksize(F_SECTOR);
 	for (p = partitions; p < partitions + partno; p++)
 	    if (p->size) {
 		if (p->start == 0) {
@@ -1925,7 +1925,7 @@ first_free(int pno, int is_extended, struct part_desc *ep, int format,
 static unsigned long
 max_length(int pno, int is_extended, struct part_desc *ep, int format,
 	   unsigned long start, struct disk_desc *z) {
-    unsigned long fu;
+    unsigned long long fu;
     unsigned long unit = unitsize(format);
     struct part_desc *partitions = &(z->partitions[0]), *pp = 0;
 
-- 
1.7.3.4

