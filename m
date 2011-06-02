Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:38359 "EHLO
	homiemail-a10.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755131Ab1FBXLu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 2 Jun 2011 19:11:50 -0400
Subject: [PATCH] mkfs.minix: use inode wrappers
From: Davidlohr Bueso <dave@gnu.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Jun 2011 19:11:45 -0400
Message-ID: <1307056305.4909.1.camel@offworld>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Thu, 2 Jun 2011 19:08:46 -0400

Use a common function for creating the root and bad inode, without worring about the fs version.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 disk-utils/mkfs.minix.c |   32 +++++++++++++++++++++-----------
 1 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 3de1d66..d2d800f 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -217,7 +217,7 @@ static inline int next(int zone) {
 	return 0;
 }
 
-static void make_bad_inode(void) {
+static void make_bad_inode_v1(void) {
 	struct minix_inode * inode = &Inode[MINIX_BAD_INO];
 	int i,j,zone;
 	int ind=0,dind=0;
@@ -266,7 +266,7 @@ end_bad:
 		write_block(dind, (char *) dind_block);
 }
 
-static void make_bad_inode2 (void) {
+static void make_bad_inode_v2 (void) {
 	struct minix2_inode *inode = &Inode2[MINIX_BAD_INO];
 	int i, j, zone;
 	int ind = 0, dind = 0;
@@ -314,7 +314,14 @@ static void make_bad_inode2 (void) {
 		write_block (dind, (char *) dind_block);
 }
 
-static void make_root_inode(void) {
+static void make_bad_inode(void)
+{
+	if (fs_version < 2)
+		return make_bad_inode_v1();
+	return make_bad_inode_v2();
+}
+
+static void make_root_inode_v1(void) {
 	struct minix_inode * inode = &Inode[MINIX_ROOT_INO];
 
 	mark_inode(MINIX_ROOT_INO);
@@ -335,7 +342,7 @@ static void make_root_inode(void) {
 	write_block(inode->i_zone[0],root_block);
 }
 
-static void make_root_inode2 (void) {
+static void make_root_inode_v2 (void) {
 	struct minix2_inode *inode = &Inode2[MINIX_ROOT_INO];
 
 	mark_inode (MINIX_ROOT_INO);
@@ -356,6 +363,13 @@ static void make_root_inode2 (void) {
 	write_block (inode->i_zone[0], root_block);
 }
 
+static void make_root_inode(void)
+{
+	if (fs_version < 2)
+		return make_root_inode_v1();
+	return make_root_inode_v2();
+}
+
 static void setup_tables(void) {
 	int i;
 	unsigned long inodes, zmaps, imaps, zones;
@@ -651,13 +665,9 @@ int main(int argc, char ** argv) {
 		check_blocks();
 	else if (listfile)
 		get_list_blocks(listfile);
-	if (fs_version == 2) {
-		make_root_inode2 ();
-		make_bad_inode2 ();
-	} else {
-		make_root_inode();
-		make_bad_inode();
-	}
+
+	make_root_inode();
+	make_bad_inode();
 
 	mark_good_blocks();
 	write_tables();
-- 
1.7.4.1



