Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:43226 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935906AbcA0UhB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 27 Jan 2016 15:37:01 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 2E036AC06
	for <util-linux@vger.kernel.org>; Wed, 27 Jan 2016 20:36:59 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 1/2] libmount: run btrfs subvol checks for "subvolid" option
Message-ID: <56A92A6C.4030002@suse.cz>
Date: Wed, 27 Jan 2016 21:37:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It is possible to identify btrfs subvolume with "subvolid" instead of "subvol".
In such case, btrfs specific check mistakenly assumes that the default subvolume
is going to be mounted, even if subvolid specifies id of non-default subvolume.

Implement a code for "subvolid" option.

For easier review, this fix comes in two patches:
PATCH 1/2: libmount: run btrfs subvol checks for "subvolid" option
PATCH 2/2: code re-indentation

How to reproduce:
	truncate -s1G btrfs_test.img
	mkdir -p btrfs_mnt
	/sbin/mkfs.btrfs -f -d single -m single ./btrfs_test.img
	mount -o loop btrfs_test.img btrfs_mnt
	pushd .
	cd btrfs_mnt
	mkdir -p d0/dd0/ddd0
	cd d0/dd0/ddd0
	touch file{1..5}
	btrfs subvol create s1
	cd s1
	touch file{1..5}
	mkdir -p d1/dd1/ddd1
	cd d1/dd1/ddd1
	btrfs subvol create s2
	rid=$(btrfs inspect rootid s2)
	echo new default $rid
	btrfs subvol get-default .
	btrfs subvol set-default $rid .
	popd
	DEFAULT_SUBVOLID=`btrfs subvolume get-default btrfs_mnt | while read dummy id rest ; do echo $id ; done`
	NON_DEFAULT_SUBVOLID=`btrfs subvolume list btrfs_mnt | while read dummy id rest ; do if test $id = $DEFAULT_SUBVOLID ; then continue ; fi ; echo $id ; done`
	umount btrfs_mnt
	losetup /dev/loop0 $PWD/btrfs_test.img
	echo "/dev/loop0 $PWD/btrfs_mnt btrfs subvolid=$NON_DEFAULT_SUBVOLID 0 0" >>/etc/fstab
	./mount -a
	./mount -a
	umount btrfs_mnt
	sed -i "/\/dev\/loop0/d" /etc/fstab
	losetup -d /dev/loop0
	rm btrfs_test.img
	rmdir btrfs_mnt

Current behavior of second "mount -a":
    mount: /dev/loop0 is already mounted or /root/btrfs_mnt busy
           /dev/loop0 is already mounted on /root/btrfs_mnt

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libmount/src/tab.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index e8920cb..71dfbf5 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -1325,6 +1325,7 @@ struct libmnt_fs *mnt_table_get_fs_root(struct libmnt_table *tb,
 
 		DBG(BTRFS, ul_debug("lookup for FS root"));
 
+		if (mnt_fs_get_option(fs, "subvolid", &vol, &volsz)) {
 		if (mnt_fs_get_option(fs, "subvol", &vol, &volsz)) {
 			/* If fstab entry does not contain "subvol", we have to
 			 * check, whether btrfs has default subvolume defined.
@@ -1352,7 +1353,7 @@ struct libmnt_fs *mnt_table_get_fs_root(struct libmnt_table *tb,
 			snprintf(default_id_str, sizeof(default_id_str), "%llu",
 					(unsigned long long int) default_id);
 
-			DBG(BTRFS, ul_debug("target=%s subvolid=%s", target, default_id_str));
+			DBG(BTRFS, ul_debug("target=%s default subvolid=%s", target, default_id_str));
 			f = mnt_table_find_target_with_option(tb, target,
 						"subvolid", default_id_str,
 						MNT_ITER_BACKWARD);
@@ -1369,6 +1370,37 @@ struct libmnt_fs *mnt_table_get_fs_root(struct libmnt_table *tb,
 				goto dflt;
 		} else
 			DBG(BTRFS, ul_debug("setting FS root: btrfs subvol"));
+		} else {
+			char *target;
+			struct libmnt_fs *f;
+			char subvolidstr[sizeof(stringify_value(UINT64_MAX))];
+
+			assert (volsz + 1 < sizeof(stringify_value(UINT64_MAX)));
+			memcpy(subvolidstr, vol, volsz);
+			subvolidstr[volsz] = '\0';
+
+			target = mnt_resolve_spec(mnt_fs_get_target(fs), tb->cache);
+			if (!target)
+				goto err;
+
+			DBG(BTRFS, ul_debug("target=%s subvolid=%s", target, subvolidstr));
+			f = mnt_table_find_target_with_option(tb, target,
+						"subvolid", subvolidstr,
+						MNT_ITER_BACKWARD);
+			if (!tb->cache)
+				free(target);
+
+			if (!f)
+				goto dflt;
+
+			/* Instead of set of BACKREF queries constructing
+			 * subvol path corresponding to a particular subvolid,
+			 * use the one in mountinfo. Kernel keeps subvol path
+			 * up to date.
+			 */
+			if (mnt_fs_get_option(f, "subvol", &vol, &volsz))
+				goto dflt;
+		}
 
 		sz = volsz;
 		if (*vol != '/')
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
