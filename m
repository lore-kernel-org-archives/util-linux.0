Return-Path: dave@gnu.org
Subject: [PATCH 7/9] fdisk: sun: remove unused function
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 17 Jun 2012 18:10:26 +0200
Message-ID: <1339949426.2668.19.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisksunlabel.c |    6 ------
 fdisk/fdisksunlabel.h |    1 -
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/fdisk/fdisksunlabel.c b/fdisk/fdisksunlabel.c
index 90f52f4..5dbcef4 100644
--- a/fdisk/fdisksunlabel.c
+++ b/fdisk/fdisksunlabel.c
@@ -78,12 +78,6 @@ static void init(void)
 	partitions = SUN_NUM_PARTITIONS;
 }
 
-void sun_nolabel(struct fdisk_context *cxt)
-{
-	sunlabel->magic = 0;
-	partitions = 4;
-}
-
 int check_sun_label(struct fdisk_context *cxt)
 {
 	unsigned short *ush;
diff --git a/fdisk/fdisksunlabel.h b/fdisk/fdisksunlabel.h
index d3cd430..abb29c3 100644
--- a/fdisk/fdisksunlabel.h
+++ b/fdisk/fdisksunlabel.h
@@ -78,7 +78,6 @@ struct sun_disk_label {
 /* fdisksunlabel.c */
 extern struct systypes sun_sys_types[];
 extern int check_sun_label(struct fdisk_context *cxt);
-extern void sun_nolabel(struct fdisk_context *cxt);
 extern void create_sunlabel(struct fdisk_context *cxt);
 extern void sun_delete_partition(struct fdisk_context *cxt, int i);
 extern int sun_change_sysid(struct fdisk_context *cxt, int i, uint16_t sys);
-- 
1.7.4.1
