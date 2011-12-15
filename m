Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47344 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756375Ab1LOTDA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Dec 2011 14:03:00 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so2431824eek.19
        for <util-linux@vger.kernel.org>; Thu, 15 Dec 2011 11:02:59 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 05/13] fdisk: rename try() and tryprocpt() functions
Date: Thu, 15 Dec 2011 20:02:41 +0100
Message-Id: <1323975769-21929-5-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
References: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 1ecab17..a8a1800 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -2799,8 +2799,10 @@ gpt_warning(char *dev)
 			"The util fdisk doesn't support GPT. Use GNU Parted.\n\n"), dev);
 }
 
+/* Print disk geometry and partition table of a specified device (-l option) */
+
 static void
-try(char *device)
+print_partition_table_from_option(char *device)
 {
 	int gb;
 
@@ -2837,7 +2839,8 @@ try(char *device)
  * try all things in /proc/partitions that look like a full disk
  */
 static void
-tryprocpt(void) {
+print_all_partition_table_from_option(void)
+{
 	FILE *procpt;
 	char line[128], ptname[128], devname[256];
 	int ma, mi;
@@ -2857,7 +2860,7 @@ tryprocpt(void) {
 		if (is_whole_disk(devname)) {
 			char *cn = canonicalize_path(devname);
 			if (cn) {
-				try(cn);
+				print_partition_table_from_option(cn);
 				free(cn);
 			}
 		}
@@ -3078,12 +3081,9 @@ main(int argc, char **argv) {
 			listing = 1;
 			for (k = optind; k < argc; k++)
 				if (!is_ide_cdrom_or_tape(argv[k]))
-					try(argv[k]);
-		} else {
-			/* we no longer have default device names */
-			/* but we can use /proc/partitions instead */
-			tryprocpt();
-		}
+					print_partition_table_from_option(argv[k]);
+		} else
+			print_all_partition_table_from_option();
 		exit(0);
 	}
 
-- 
1.7.7

