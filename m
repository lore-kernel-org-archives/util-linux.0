Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50022 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331Ab1KNNsE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Nov 2011 08:48:04 -0500
Received: by wyh15 with SMTP id 15so5874662wyh.19
        for <util-linux@vger.kernel.org>; Mon, 14 Nov 2011 05:48:02 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 2/3] fdisk: avoid segfault validating a sgi label (boot/swap not set)
Date: Mon, 14 Nov 2011 14:47:18 +0100
Message-Id: <1321278439-9392-2-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1321278439-9392-1-git-send-email-cosoleto@gmail.com>
References: <1321278439-9392-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

swap_part or boot_part can be set to -1 when they don't exist.

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisksgilabel.c |    8 ++++----
 fdisk/fdisksgilabel.h |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fdisk/fdisksgilabel.c b/fdisk/fdisksgilabel.c
index 091902a..002688a 100644
--- a/fdisk/fdisksgilabel.c
+++ b/fdisk/fdisksgilabel.c
@@ -262,13 +262,13 @@ sgi_get_sysid(int i)
 int
 sgi_get_bootpartition(void)
 {
-	return SSWAP16(sgilabel->boot_part);
+	return (short) SSWAP16(sgilabel->boot_part);
 }
 
 int
 sgi_get_swappartition(void)
 {
-	return SSWAP16(sgilabel->swap_part);
+	return (short) SSWAP16(sgilabel->swap_part);
 }
 
 void
@@ -513,10 +513,10 @@ verify_sgi(int verbose)
 	 * Go for details now
 	 */
 	if (verbose) {
-		if (!sgi_get_num_sectors(sgi_get_bootpartition())) {
+		if (sgi_get_bootpartition() < 0 || !sgi_get_num_sectors(sgi_get_bootpartition())) {
 			printf(_("\nThe boot partition does not exist.\n"));
 		}
-		if (!sgi_get_num_sectors(sgi_get_swappartition())) {
+		if (sgi_get_swappartition() < 0 || !sgi_get_num_sectors(sgi_get_swappartition())) {
 			printf(_("\nThe swap partition does not exist.\n"));
 		} else {
 			if ((sgi_get_sysid(sgi_get_swappartition()) != SGI_SWAP)
diff --git a/fdisk/fdisksgilabel.h b/fdisk/fdisksgilabel.h
index 1445fa9..1c47bb4 100644
--- a/fdisk/fdisksgilabel.h
+++ b/fdisk/fdisksgilabel.h
@@ -63,8 +63,8 @@ struct device_parameter { /* 48 bytes */
 
 typedef struct {
 	unsigned int   magic;		 /* expect SGI_LABEL_MAGIC */
-	unsigned short boot_part;        /* active boot partition */
-	unsigned short swap_part;        /* active swap partition */
+	short boot_part;		/* active boot partition */
+	short swap_part;		/* active swap partition */
 	unsigned char  boot_file[16];    /* name of the bootfile */
 	struct device_parameter devparam;	/*  1 * 48 bytes */
 	struct volume_directory {		/* 15 * 16 bytes */
-- 
1.7.3.4

