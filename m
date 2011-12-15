Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47344 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759322Ab1LOTDF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Dec 2011 14:03:05 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so2431824eek.19
        for <util-linux@vger.kernel.org>; Thu, 15 Dec 2011 11:03:04 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 09/13] fdisk: don't use get_existing_partition() if disk label isn't dos
Date: Thu, 15 Dec 2011 20:02:45 +0100
Message-Id: <1323975769-21929-9-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
References: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c |   27 +++++++++------------------
 1 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 8f5869d..53eed25 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1472,11 +1472,16 @@ get_partition(int warn, int max) {
 	return get_partition_dflt(warn, max, 0);
 }
 
+/* User partition selection unless one partition only is available */
+
 static int
 get_existing_partition(int warn, int max) {
 	int pno = -1;
 	int i;
 
+	if (disklabel != DOS_LABEL)
+		goto not_implemented;
+
 	for (i = 0; i < max; i++) {
 		struct pte *pe = &ptes[i];
 		struct partition *p = pe->part_table;
@@ -1495,7 +1500,8 @@ get_existing_partition(int warn, int max) {
 	printf(_("No partition is defined yet!\n"));
 	return -1;
 
- not_unique:
+not_implemented:
+not_unique:
 	return get_partition(warn, max);
 }
 
@@ -1650,14 +1656,7 @@ change_sysid(void) {
 	int i, sys, origsys;
 	struct partition *p;
 
-	/* If sgi_label then don't use get_existing_partition,
-	   let the user select a partition, since get_existing_partition()
-	   only works for Linux like partition tables. */
-	if (disklabel != SGI_LABEL) {
-		i = get_existing_partition(0, partitions);
-	} else {
-		i = get_partition(0, partitions);
-	}
+	i = get_existing_partition(0, partitions);
 
 	if (i == -1)
 		return;
@@ -2922,15 +2921,7 @@ static void command_prompt(void)
 				unknown_command(c);
 			break;
 		case 'd':
-			/* If sgi_label then don't use get_existing_partition,
-			   let the user select a partition, since
-			   get_existing_partition() only works for Linux-like
-			   partition tables */
-			if (disklabel != SGI_LABEL) {
-				j = get_existing_partition(1, partitions);
-			} else {
-				j = get_partition(1, partitions);
-			}
+			j = get_existing_partition(1, partitions);
 			if (j >= 0)
 				delete_partition(j);
 			break;
-- 
1.7.7

