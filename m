Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48629 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759320Ab1LOTDE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Dec 2011 14:03:04 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so2431841eek.19
        for <util-linux@vger.kernel.org>; Thu, 15 Dec 2011 11:03:04 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 08/13] fdisk: remove unused guess_device_type() function
Date: Thu, 15 Dec 2011 20:02:44 +0100
Message-Id: <1323975769-21929-8-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
References: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c         |    1 -
 fdisk/fdisksunlabel.c |   38 --------------------------------------
 fdisk/fdisksunlabel.h |    1 -
 3 files changed, 0 insertions(+), 40 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index aacd73f..8f5869d 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1031,7 +1031,6 @@ get_geometry(int fd, struct geom *g) {
 	unsigned long long llcyls, nsects = 0;
 
 	get_topology(fd);
-	guess_device_type(fd);
 	heads = cylinders = sectors = 0;
 	kern_heads = kern_sectors = 0;
 	pt_heads = pt_sectors = 0;
diff --git a/fdisk/fdisksunlabel.c b/fdisk/fdisksunlabel.c
index 4fd8545..4a6db35 100644
--- a/fdisk/fdisksunlabel.c
+++ b/fdisk/fdisksunlabel.c
@@ -15,24 +15,17 @@
 #include <string.h>		/* strstr */
 #include <unistd.h>		/* write */
 #include <sys/ioctl.h>		/* ioctl */
-#include <sys/stat.h>		/* stat */
-#include <sys/sysmacros.h>	/* major */
 
 #include "nls.h"
 #include "blkdev.h"
 
 #include <endian.h>
-#ifdef HAVE_LINUX_MAJOR_H
-#include <linux/major.h>	/* FLOPPY_MAJOR */
-#endif
 
 #include "common.h"
 #include "fdisk.h"
 #include "fdisksunlabel.h"
 
 static int     other_endian = 0;
-static int     scsi_disk = 0;
-static int     floppy = 0;
 
 struct systypes sun_sys_types[] = {
 	{SUN_TAG_UNASSIGNED, N_("Unassigned")},
@@ -66,37 +59,6 @@ static inline uint32_t __swap32(uint32_t x) {
 #define SSWAP32(x) (other_endian ? __swap32(x) \
 				 : (uint32_t)(x))
 
-#ifndef FLOPPY_MAJOR
-#define FLOPPY_MAJOR 2
-#endif
-#ifndef IDE0_MAJOR
-#define IDE0_MAJOR 3
-#endif
-#ifndef IDE1_MAJOR
-#define IDE1_MAJOR 22
-#endif
-void guess_device_type(int fd)
-{
-	struct stat bootstat;
-
-	if (fstat (fd, &bootstat) < 0) {
-                scsi_disk = 0;
-                floppy = 0;
-	} else if (S_ISBLK(bootstat.st_mode)
-		   && (major(bootstat.st_rdev) == IDE0_MAJOR ||
-		       major(bootstat.st_rdev) == IDE1_MAJOR)) {
-                scsi_disk = 0;
-                floppy = 0;
-	} else if (S_ISBLK(bootstat.st_mode)
-		   && major(bootstat.st_rdev) == FLOPPY_MAJOR) {
-                scsi_disk = 0;
-                floppy = 1;
-	} else {
-                scsi_disk = 1;
-                floppy = 0;
-	}
-}
-
 static void set_sun_partition(int i, uint32_t start, uint32_t stop, uint16_t sysid)
 {
 	sunlabel->part_tags[i].tag = SSWAP16(sysid);
diff --git a/fdisk/fdisksunlabel.h b/fdisk/fdisksunlabel.h
index b7419cb..fa3f964 100644
--- a/fdisk/fdisksunlabel.h
+++ b/fdisk/fdisksunlabel.h
@@ -77,7 +77,6 @@ struct sun_disk_label {
 
 /* fdisksunlabel.c */
 extern struct systypes sun_sys_types[];
-extern void guess_device_type(int fd);
 extern int check_sun_label(void);
 extern void sun_nolabel(void);
 extern void create_sunlabel(void);
-- 
1.7.7

