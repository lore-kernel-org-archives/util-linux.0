Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47344 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759320Ab1LOTDC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Dec 2011 14:03:02 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so2431824eek.19
        for <util-linux@vger.kernel.org>; Thu, 15 Dec 2011 11:03:02 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 07/13] fdisk: get rid of get_boot(create_empty_sun) call
Date: Thu, 15 Dec 2011 20:02:43 +0100
Message-Id: <1323975769-21929-7-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
References: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

create_sunlabel() should create a new empty SUN disklabel without checking data
itself writes to memory and initialize internal related fdisk variables.

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c         |    7 ++-----
 fdisk/fdisk.h         |    3 +--
 fdisk/fdisksunlabel.c |   17 +++++++++++------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index ab2e68d..aacd73f 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -51,6 +51,7 @@
 
 #include "gpt.h"
 
+static int get_boot(enum action what);
 static void delete_partition(int i);
 
 #define hex_val(c)	({ \
@@ -1090,7 +1091,7 @@ void zeroize_mbr_buffer(void)
  *    0: found or created label
  *    1: I/O error
  */
-int
+static int
 get_boot(enum action what) {
 	int i;
 
@@ -1108,9 +1109,6 @@ get_boot(enum action what) {
 		pe->changed = (what == create_empty_dos);
 	}
 
-	if (what == create_empty_sun && check_sun_label())
-		return 0;
-
 	memset(MBRbuffer, 0, 512);
 
 	if (what == create_empty_dos)
@@ -1175,7 +1173,6 @@ got_dos_table:
 		case try_only:
 		        return -1;
 		case create_empty_dos:
-		case create_empty_sun:
 			break;
 		default:
 			fprintf(stderr, _("Internal error\n"));
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index 67642cd..6641880 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -54,7 +54,7 @@ enum failure {ioctl_error,
 	unable_to_open, unable_to_read, unable_to_seek,
 	unable_to_write};
 
-enum action {fdisk, try_only, create_empty_dos, create_empty_sun};
+enum action {fdisk, try_only, create_empty_dos};
 
 struct geom {
 	unsigned int heads;
@@ -69,7 +69,6 @@ extern unsigned int display_in_cyl_units, units_per_sector;
 extern void change_units(void);
 extern void fatal(enum failure why);
 extern void get_geometry(int fd, struct geom *);
-extern int get_boot(enum action what);
 extern int  get_partition(int warn, int max);
 extern void list_types(struct systypes *sys);
 extern int read_line (int *asked);
diff --git a/fdisk/fdisksunlabel.c b/fdisk/fdisksunlabel.c
index 80408dd..4fd8545 100644
--- a/fdisk/fdisksunlabel.c
+++ b/fdisk/fdisksunlabel.c
@@ -109,6 +109,12 @@ static void set_sun_partition(int i, uint32_t start, uint32_t stop, uint16_t sys
 	print_partition_size(i + 1, start, stop, sysid);
 }
 
+static void init(void)
+{
+	disklabel = SUN_LABEL;
+	partitions = SUN_NUM_PARTITIONS;
+}
+
 void sun_nolabel(void)
 {
 	sunlabel->magic = 0;
@@ -125,6 +131,8 @@ int check_sun_label(void)
 		other_endian = 0;
 		return 0;
 	}
+
+	init();
 	other_endian = (sunlabel->magic == SUN_LABEL_MAGIC_SWAPPED);
 
 	ush = ((unsigned short *) (sunlabel + 1)) - 1;
@@ -176,8 +184,6 @@ int check_sun_label(void)
 		}
 	}
 	update_units();
-	disklabel = SUN_LABEL;
-	partitions = SUN_NUM_PARTITIONS;
 	return 1;
 }
 
@@ -195,7 +201,10 @@ void create_sunlabel(void)
 #else
 	other_endian = 0;
 #endif
+
+	init();
 	zeroize_mbr_buffer();
+
 	sunlabel->magic = SSWAP16(SUN_LABEL_MAGIC);
 	sunlabel->sanity = SSWAP32(SUN_LABEL_SANE);
 	sunlabel->version = SSWAP32(SUN_LABEL_VERSION);
@@ -249,9 +258,6 @@ void create_sunlabel(void)
 	} else
 	        ndiv = cylinders * 2 / 3;
 
-	/* Make sure print_partition_size() uses correct sysid names */
-	disklabel = SUN_LABEL;
-
 	set_sun_partition(0, 0, ndiv * heads * sectors,
 			  SUN_TAG_LINUX_NATIVE);
 	set_sun_partition(1, ndiv * heads * sectors,
@@ -270,7 +276,6 @@ void create_sunlabel(void)
 	}
 
 	set_all_unchanged();
-	get_boot(create_empty_sun);
 	set_changed(0);
 }
 
-- 
1.7.7

