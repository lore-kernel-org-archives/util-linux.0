Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37811 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab1HPWTL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 16 Aug 2011 18:19:11 -0400
Received: by wyg24 with SMTP id 24so281582wyg.19
        for <util-linux@vger.kernel.org>; Tue, 16 Aug 2011 15:19:09 -0700 (PDT)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 1/5] fdisk: print a message with size and type of created partition
Date: Wed, 17 Aug 2011 00:19:02 +0200
Message-Id: <1313533146-2806-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/Makefile.am     |    2 +-
 fdisk/fdisk.c         |   13 +++++++++++++
 fdisk/fdisk.h         |    1 +
 fdisk/fdisksgilabel.c |    8 +++++++-
 fdisk/fdisksunlabel.c |    4 ++++
 5 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/fdisk/Makefile.am b/fdisk/Makefile.am
index 7cad805..4409db5 100644
--- a/fdisk/Makefile.am
+++ b/fdisk/Makefile.am
@@ -4,7 +4,7 @@ EXTRA_DIST = README.fdisk README.cfdisk sfdisk.examples partitiontype.c
 
 fdisk_common = i386_sys_types.c common.h gpt.c gpt.h \
 	$(top_srcdir)/lib/blkdev.c $(top_srcdir)/lib/wholedisk.c \
-	$(top_srcdir)/lib/mbsalign.c
+	$(top_srcdir)/lib/mbsalign.c $(top_srcdir)/lib/strutils.c
 
 if LINUX
 fdisk_common += $(top_srcdir)/lib/linux_version.c
diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 038536d..a08a4d4 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -32,6 +32,7 @@
 #include "wholedisk.h"
 #include "pathnames.h"
 #include "canonicalize.h"
+#include "strutils.h"
 
 #include "fdisksunlabel.h"
 #include "fdisksgilabel.h"
@@ -614,6 +615,10 @@ set_partition(int i, int doext, unsigned long long start,
 	p->sys_ind = sysid;
 	set_start_sect(p, start - offset);
 	set_nr_sects(p, stop - start + 1);
+
+	if (!doext)
+		print_partition_size(i + 1, start, stop, sysid);
+
 	if (dos_compatible_flag && (start/(sectors*heads) > 1023))
 		start = heads*sectors*1024 - 1;
 	set_hsc(p->head, p->sector, p->cyl, start);
@@ -2319,6 +2324,14 @@ get_unused_start(int part_n,
 	return start;
 }
 
+void print_partition_size(int num, unsigned long long start, unsigned long long stop, int sysid)
+{
+	char *str = size_to_human_string(SIZE_SUFFIX_3LETTER | SIZE_SUFFIX_SPACE,
+				     (stop - start + 1) * sector_size);
+	printf(_("Partition %d of type %s and of size %s is set\n"), num, partition_type(sysid), str);
+	free(str);
+}
+
 static void
 add_partition(int n, int sys) {
 	char mesg[256];		/* 48 does not suffice in Japanese */
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index 9b7f4c7..e289043 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -75,6 +75,7 @@ extern struct partition *get_part_table(int);
 extern int valid_part_table_flag(unsigned char *b);
 extern unsigned int read_int(unsigned int low, unsigned int dflt,
 			     unsigned int high, unsigned int base, char *mesg);
+extern void print_partition_size(int num, unsigned long long start, unsigned long long stop, int sysid);
 
 extern unsigned char *MBRbuffer;
 extern void zeroize_mbr_buffer(void);
diff --git a/fdisk/fdisksgilabel.c b/fdisk/fdisksgilabel.c
index 8179bc1..20ed92d 100644
--- a/fdisk/fdisksgilabel.c
+++ b/fdisk/fdisksgilabel.c
@@ -570,6 +570,7 @@ sgi_set_partition(int i, unsigned int start, unsigned int length, int sys) {
 	set_changed(i);
 	if (sgi_gaps() < 0)	/* rebuild freelist */
 		printf(_("Do You know, You got a partition overlap on the disk?\n"));
+	print_partition_size(i + 1, start, start + length, sys);
 }
 
 static void
@@ -733,7 +734,6 @@ create_sgilabel(void)
 				old[i].sysid = get_part_table(i)->sys_ind;
 				old[i].start = get_start_sect(get_part_table(i));
 				old[i].nsect = get_nr_sects(get_part_table(i));
-				printf(_("Trying to keep parameters of partition %d.\n"), i);
 				if (debug)
 					printf(_("ID=%02x\tSTART=%d\tLENGTH=%d\n"),
 					       old[i].sysid, old[i].start, old[i].nsect);
@@ -741,6 +741,12 @@ create_sgilabel(void)
 		}
 	}
 
+	for (i = 0; i < 4; i++)
+		if (old[i].sysid) {
+			printf(_("Trying to keep parameters of partitions already set.\n"));
+			break;
+		}
+
 	zeroize_mbr_buffer();
 	sgilabel->magic = SSWAP32(SGI_LABEL_MAGIC);
 	sgilabel->boot_part = SSWAP16(0);
diff --git a/fdisk/fdisksunlabel.c b/fdisk/fdisksunlabel.c
index 9335e75..7d3aa09 100644
--- a/fdisk/fdisksunlabel.c
+++ b/fdisk/fdisksunlabel.c
@@ -106,6 +106,7 @@ static void set_sun_partition(int i, uint32_t start, uint32_t stop, uint16_t sys
 	sunlabel->partitions[i].num_sectors =
 		SSWAP32(stop - start);
 	set_changed(i);
+	print_partition_size(i + 1, start, stop, sysid);
 }
 
 void sun_nolabel(void)
@@ -250,6 +251,9 @@ void create_sunlabel(void)
 	} else
 	        ndiv = cylinders * 2 / 3;
 
+	/* Make sure print_partition_size() uses correct sysid names */
+	disklabel = SUN_LABEL;
+
 	set_sun_partition(0, 0, ndiv * heads * sectors,
 			  SUN_TAG_LINUX_NATIVE);
 	set_sun_partition(1, ndiv * heads * sectors,
-- 
1.7.3.4

