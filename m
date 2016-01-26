Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:51544 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771AbcAZU75 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 Jan 2016 15:59:57 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 03D9CABB4
	for <util-linux@vger.kernel.org>; Tue, 26 Jan 2016 20:59:55 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] libmount: run btrfs subvol checks for "auto" fs type
Message-ID: <56A7DE4B.5060308@suse.cz>
Date: Tue, 26 Jan 2016 21:59:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It is possible to mount btrfs using "auto" keyword in fstab. In such
case, btrfs specific checks are skipped. Run them for "auto" as well.

Looking at the code, it is a safe approach. In case of btrfs, it will do
what is needed, in case of no btrfs, btrfs_get_default_subvol_id() will
fail, and the rest of the code is skipped.

How to reproduce:
See reproducer in 2cd28fc and replace fstab line by
	echo "/dev/loop0 $PWD/btrfs_mnt btrfs auto 0 0" >>/etc/fstab

Current behavior of second "mount -a":
	mount: /dev/loop0 is already mounted or /root/btrfs_mnt busy
	       /dev/loop0 is already mounted on /root/btrfs_mnt

Testcases for btrfs and ext4:
	truncate -s1G btrfs_test.img
	truncate -s1G ext4_test.img
	mkdir -p btrfs_mnt
	mkdir -p ext4_mnt
	/sbin/mkfs.btrfs -f -d single -m single ./btrfs_test.img
	/sbin/mkfs.ext4 ./ext4_test.img
	losetup /dev/loop0 $PWD/btrfs_test.img
	losetup /dev/loop1 $PWD/ext4_test.img
	echo "/dev/loop0 $PWD/btrfs_mnt auto defaults 0 0" >>/etc/fstab
	echo "/dev/loop1 $PWD/ext4_mnt auto defaults 0 0" >>/etc/fstab
	./mount -a
	./mount -a
	umount btrfs_mnt
	umount ext4_mnt
	sed -i "/\/dev\/loop[01]/d" /etc/fstab
	losetup -d /dev/loop0
	losetup -d /dev/loop1
	rm btrfs_test.img
	rm ext4_test.img
	rmdir btrfs_mnt
	rmdir ext4_mnt

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libmount/src/tab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 3099615..e8920cb 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -1319,7 +1319,7 @@ struct libmnt_fs *mnt_table_get_fs_root(struct libmnt_table *tb,
 	/*
 	 * btrfs-subvolume mount -- get subvolume name and use it as a root-fs path
 	 */
-	else if (fstype && !strcmp(fstype, "btrfs")) {
+	else if (fstype && (!strcmp(fstype, "btrfs") || !strcmp(fstype, "auto"))) {
 		char *vol = NULL, *p;
 		size_t sz, volsz = 0;
 
-- 
2.7.0

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
