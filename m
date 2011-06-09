Return-Path: dave@gnu.org
Subject: [PATCH 1/2] mkfs.minix: standardize superblock attribute settings
From: Davidlohr Bueso <dave@gnu.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 09 Jun 2011 12:48:35 -0400
Message-ID: <1307638115.2155.2.camel@offworld>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Thu, 9 Jun 2011 12:01:09 -0400

Because of the dependence of fs_version, some superblock attributes will vary, so simplify the logic of assigning values to maxsize and the amount of zones related to each filesystem, thus making setup_tables() more readable.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 disk-utils/mkfs.minix.c |   32 +++++++++++++++++++++++++++-----
 1 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index d2d800f..1cebcda 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -370,6 +370,29 @@ static void make_root_inode(void)
 	return make_root_inode_v2();
 }
 
+static void super_set_nzones(void)
+{
+	switch (fs_version) {
+	case 2:
+		Super.s_zones = BLOCKS;
+		break;
+	default: /* v1 */
+		Super.s_nzones = BLOCKS;
+		break;
+	}
+}
+
+static void super_init_maxsize(void)
+{
+	switch (fs_version) {
+	case 2:
+		Super.s_max_size =  0x7fffffff;
+	default: /* v1 */
+		Super.s_max_size = (7+512+512*512)*1024;
+		break;
+	}
+}
+
 static void setup_tables(void) {
 	int i;
 	unsigned long inodes, zmaps, imaps, zones;
@@ -382,12 +405,11 @@ static void setup_tables(void) {
 	memset(boot_block_buffer,0,512);
 	Super.s_magic = magic;
 	Super.s_log_zone_size = 0;
-	Super.s_max_size = version2 ? 0x7fffffff : (7+512+512*512)*1024;
-	if (fs_version == 2)
-		zones = Super.s_zones = BLOCKS;
-	else
-		zones = Super.s_nzones = BLOCKS;
 
+	super_init_maxsize();	
+	super_set_nzones();
+	zones = get_nzones();
+	
 /* some magic nrs: 1 inode / 3 blocks */
 	if ( req_nr_inodes == 0 ) 
 		inodes = BLOCKS/3;
-- 
1.7.4.1
