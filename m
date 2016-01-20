Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:55241 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932819AbcATV5J (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 20 Jan 2016 16:57:09 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 511ADAB12
	for <util-linux@vger.kernel.org>; Wed, 20 Jan 2016 21:57:07 +0000 (UTC)
Subject: [PATCH] libmount: handle btrfs default subvolume mount
To: util-linux@vger.kernel.org
References: <569FEF38.9010102@suse.cz> <56A00178.9000603@suse.cz>
Cc: =?UTF-8?B?RGF2aWQgxaB0xJtyYmE=?= <dsterba@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56A002B3.5090505@suse.cz>
Date: Wed, 20 Jan 2016 22:57:07 +0100
MIME-Version: 1.0
In-Reply-To: <56A00178.9000603@suse.cz>
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When mounting btrfs volume without subvol= and subvolid=, and the btrfs
volume has default subvolume defined, mount() mounts the default
subvolume and not the volume root as other filesystems do.

To handle this situation correctly, libmount has to be capable to detect
default subvolume.

Add btrfs.c and btrfs.h that implement needed functions.

Known problems not covered by this patch:

- Use of subvolid= in fstab is not yet handled.

- Use of type auto in combination with subvol= in fstab is not yet
  handled.

- Use of btrfs in loop devices, where image file is specified in fstab is
  not yet handled (use of /dev/loop0 in fstab works).

- If fstab uses subvol=, and subvol path changes since last "mount -a",
  subsequent "mount -a" will not recognize that it is already mounted,
  and it will attempt to mount it second time. To fix it, libmount should
  remember subvolid in time of mount (subvolid is unique for the
  subvolume, subvol is not).

- mountinfo contains subvol and subvolid since kernel 4.2. Before kernel
  4.2, there is no reasonable way to solve this situation. (One would
  create temporary mount point, mount the default, call needed ioctl() to
  determine what was mounted, deduce the default subvolume, compare it
  with subvolume of mounted volume, unmount and return result.)

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
umount btrfs_mnt
losetup /dev/loop0 $PWD/btrfs_test.img
echo "/dev/loop0 $PWD/btrfs_mnt btrfs defaults 0 0" >>/etc/fstab
mount -a
mount -a
umount btrfs_mnt
sed -i "/\/dev\/loop0/d" /etc/fstab
losetup -d /dev/loop0
rm btrfs_test.img
rmdir btrfs_mnt

Current behavior:
mount: /dev/loop0 is already mounted or /root/btrfs_mnt busy
       /dev/loop0 is already mounted on /root/btrfs_mnt

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
Cc: David ©tìrba <dsterba@suse.cz>
---
 libmount/src/Makemodule.am |   2 +
 libmount/src/btrfs.c       | 101 ++++++++++++++++++++++++++++++++++
 libmount/src/btrfs.h       | 132 +++++++++++++++++++++++++++++++++++++++++++++
 libmount/src/mountP.h      |   9 ++++
 libmount/src/tab.c         |  83 ++++++++++++++++++++++++++--
 5 files changed, 323 insertions(+), 4 deletions(-)
 create mode 100644 libmount/src/btrfs.c
 create mode 100644 libmount/src/btrfs.h

diff --git a/libmount/src/Makemodule.am b/libmount/src/Makemodule.am
index 11c6324..39d42d5 100644
--- a/libmount/src/Makemodule.am
+++ b/libmount/src/Makemodule.am
@@ -27,6 +27,8 @@ libmount_la_SOURCES = \
 
 if LINUX
 libmount_la_SOURCES += \
+	libmount/src/btrfs.c \
+	libmount/src/btrfs.h \
 	libmount/src/context.c \
 	libmount/src/context_loopdev.c \
 	libmount/src/context_mount.c \
diff --git a/libmount/src/btrfs.c b/libmount/src/btrfs.c
new file mode 100644
index 0000000..9122551
--- /dev/null
+++ b/libmount/src/btrfs.c
@@ -0,0 +1,101 @@
+/*
+ * Copyright (C) 2016 David Sterba <dsterba@suse.cz>
+ * Copyright (C) 2016 Stanislav Brabec <sbrabec@suse.cz>
+ *
+ * This file may be redistributed under the terms of the
+ * GNU Lesser General Public License.
+ */
+
+/**
+ * SECTION: btrfs
+ * @title: btrfs
+ * @short_description: special function for btrfs
+ *
+ * btrfs contains function needed for manipulation with btrfs.
+ */
+#include <dirent.h>
+#include <sys/ioctl.h>
+#include <linux/magic.h>
+#include "btrfs.h"
+
+/**
+ * btrfs_get_default_subvol_id:
+ * @path: Path to mounted btrfs volume
+ *
+ * Searches for the btrfs default subvolume id.
+ *
+ * Returns: default subvolume id or -1 in case of no default
+ * subvolume or error. In case of error, errno is set properly.
+ */
+__u64 btrfs_get_default_subvol_id(const char *path)
+{
+	int iocret;
+	int fd;
+	DIR *dirstream = NULL;
+	struct btrfs_ioctl_search_args args;
+	struct btrfs_ioctl_search_key *sk = &args.key;
+	struct btrfs_ioctl_search_header *sh;
+	__u64 found = (__u64)-1;
+
+	dirstream = opendir(path);
+	if (!dirstream) {
+		DBG(BTRFS, ul_debug("opendir() failed for \"%s\" [errno=%d %m]", path, errno));
+		return (__u64)-1;
+	}
+	fd = dirfd(dirstream);
+	if (fd < 0) {
+		DBG(BTRFS, ul_debug("dirfd(opendir()) failed for \"%s\" [errno=%d %m]", path, errno));
+		goto out;
+	}
+
+	memset(&args, 0, sizeof(args));
+	sk->tree_id = BTRFS_ROOT_TREE_OBJECTID;
+	sk->min_objectid = BTRFS_ROOT_TREE_DIR_OBJECTID;
+	sk->max_objectid = BTRFS_ROOT_TREE_DIR_OBJECTID;
+	sk->min_type = BTRFS_DIR_ITEM_KEY;
+	sk->max_type = BTRFS_DIR_ITEM_KEY;
+	sk->max_offset = (__u64)-1;
+	sk->max_transid = (__u64)-1;
+	sk->nr_items = 1;
+
+	iocret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args);
+	if (iocret < 0) {
+		DBG(BTRFS, ul_debug("ioctl() failed for \"%s\" [errno=%d %m]", path, errno));
+		goto out;
+	}
+
+	/* the ioctl returns the number of items it found in nr_items */
+	if (sk->nr_items == 0) {
+		DBG(BTRFS, ul_debug("root tree dir object id not found"));
+		goto out;
+	}
+	DBG(BTRFS, ul_debug("found %d root tree dir object id items", sk->nr_items));
+
+	sh = (struct btrfs_ioctl_search_header *)args.buf;
+
+	if (sh->type == BTRFS_DIR_ITEM_KEY) {
+		struct btrfs_dir_item *di;
+		int name_len;
+		char *name;
+
+		di = (struct btrfs_dir_item *)(sh + 1);
+		name_len = btrfs_stack_dir_name_len(di);
+		name = (char *)(di + 1);
+
+		if (!strncmp("default", name, name_len)) {
+			found = btrfs_disk_key_objectid(&di->location);
+			DBG(BTRFS, ul_debug("\"default\" id is %llu", (unsigned long long)found));
+		} else {
+			DBG(BTRFS, ul_debug("\"default\" id not found in tree root"));
+			goto out;
+		}
+	} else {
+		DBG(BTRFS, ul_debug("unexpected type found: %d", (int)sh->type));
+		goto out;
+	}
+
+out:
+	closedir(dirstream);
+
+	return found;
+}
diff --git a/libmount/src/btrfs.h b/libmount/src/btrfs.h
new file mode 100644
index 0000000..d78cf35
--- /dev/null
+++ b/libmount/src/btrfs.h
@@ -0,0 +1,132 @@
+/* This is an excerpt from btrfs-progs-v4.3.1
+ * differences: u64 replaced by __u64 */
+
+/*
+ * Copyright (C) 2007 Oracle.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+
+#include <libio.h>
+#include <linux/btrfs.h>
+#include "mountP.h"
+#include "bitops.h"
+
+
+/* from kerncompat.h */
+
+#ifdef __CHECKER__
+#define __force    __attribute__((force))
+#else
+#define __force
+#endif
+
+/* linux/btrfs.h lacks large parts of stuff needed for getting default
+ * sub-volume. Suppose that if BTRFS_DIR_ITEM_KEY is not defined, all
+ * declarations are still missing.
+ */
+#ifndef BTRFS_DIR_ITEM_KEY
+
+
+/* from ctree.h */
+
+/*
+ * dir items are the name -> inode pointers in a directory.  There is one
+ * for every name in a directory.
+ */
+#define BTRFS_DIR_ITEM_KEY	84
+
+/* holds pointers to all of the tree roots */
+#define BTRFS_ROOT_TREE_OBJECTID 1ULL
+
+/* directory objectid inside the root tree */
+#define BTRFS_ROOT_TREE_DIR_OBJECTID 6ULL
+
+/*
+ * the key defines the order in the tree, and so it also defines (optimal)
+ * block layout.  objectid corresonds to the inode number.  The flags
+ * tells us things about the object, and is a kind of stream selector.
+ * so for a given inode, keys with flags of 1 might refer to the inode
+ * data, flags of 2 may point to file data in the btree and flags == 3
+ * may point to extents.
+ *
+ * offset is the starting byte offset for this key in the stream.
+ *
+ * btrfs_disk_key is in disk byte order.  struct btrfs_key is always
+ * in cpu native order.  Otherwise they are identical and their sizes
+ * should be the same (ie both packed)
+ */
+struct btrfs_disk_key {
+	__le64 objectid;
+	__u8 type;
+	__le64 offset;
+} __attribute__ ((__packed__));
+
+struct btrfs_dir_item {
+	struct btrfs_disk_key location;
+	__le64 transid;
+	__le16 data_len;
+	__le16 name_len;
+	__u8 type;
+} __attribute__ ((__packed__));
+
+#define BTRFS_SETGET_STACK_FUNCS(name, type, member, bits)		\
+static inline __u##bits btrfs_##name(const type *s)			\
+{									\
+	return le##bits##_to_cpu(s->member);				\
+}									\
+static inline void btrfs_set_##name(type *s, __u##bits val)		\
+{									\
+	s->member = cpu_to_le##bits(val);				\
+}
+
+/* struct btrfs_disk_key */
+BTRFS_SETGET_STACK_FUNCS(disk_key_objectid, struct btrfs_disk_key,
+			 objectid, 64);
+
+static inline __u16 btrfs_stack_dir_name_len(const struct btrfs_dir_item *s)
+{
+	return ((__u16)(__le16)(s->name_len));
+}
+
+
+/* from rbtree.h */
+
+/*
+  Red Black Trees
+  (C) 1999  Andrea Arcangeli <andrea@suse.de>
+
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2 of the License, or
+  (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+struct rb_node {
+	unsigned long  __rb_parent_color;
+	struct rb_node *rb_right;
+	struct rb_node *rb_left;
+} __attribute__((aligned(sizeof(long))));
+    /* The alignment might seem pointless, but allegedly CRIS needs it */
+
+#endif
diff --git a/libmount/src/mountP.h b/libmount/src/mountP.h
index 25418a2..5362b2b 100644
--- a/libmount/src/mountP.h
+++ b/libmount/src/mountP.h
@@ -19,6 +19,9 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdarg.h>
+#if __linux__
+#include <linux/types.h>
+#endif
 
 #include "c.h"
 #include "list.h"
@@ -40,6 +43,7 @@
 #define MNT_DEBUG_CXT		(1 << 9)
 #define MNT_DEBUG_DIFF		(1 << 10)
 #define MNT_DEBUG_MONITOR	(1 << 11)
+#define MNT_DEBUG_BTRFS		(1 << 12)
 
 #define MNT_DEBUG_ALL		0xFFFF
 
@@ -411,4 +415,9 @@ extern int mnt_update_set_filename(struct libmnt_update *upd,
 extern int mnt_update_already_done(struct libmnt_update *upd,
 				   struct libmnt_lock *lc);
 
+#if __linux__
+/* btrfs.c */
+extern __u64 btrfs_get_default_subvol_id(const char *path);
+#endif
+
 #endif /* _LIBMOUNT_PRIVATE_H */
diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 951fe8c..d33ab70 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -1059,6 +1059,49 @@ struct libmnt_fs *mnt_table_find_tag(struct libmnt_table *tb, const char *tag,
 }
 
 /**
+ * mnt_table_find_target_with_option:
+ * @tb: tab pointer
+ * @path: mountpoint directory
+ * @option: option name (e.g "subvol", "subvolid", ...)
+ * @val: option value
+ * @direction: MNT_ITER_{FORWARD,BACKWARD}
+ *
+ * Try to lookup an entry in the given tab that matches combination of
+ * @path and @option. In difference to mnt_table_find_target(), only
+ * @path iteration is done. No lookup by device name, no canonicalization.
+ *
+ * Returns: a tab entry or NULL.
+ */
+struct libmnt_fs *mnt_table_find_target_with_option(struct libmnt_table *tb, const char *path,
+			const char *option, const char *val, int direction)
+{
+	struct libmnt_iter itr;
+	struct libmnt_fs *fs = NULL;
+	char *optval = NULL;
+	size_t optvalsz = 0, valsz = strlen(val);
+
+	if (!tb || !path || !*path || !option || !*option || !val)
+		return NULL;
+	if (direction != MNT_ITER_FORWARD && direction != MNT_ITER_BACKWARD)
+		return NULL;
+
+	DBG(TAB, ul_debugobj(tb, "lookup TARGET: '%s' with OPTION %s %s", path, option, val));
+
+	/* look up by native @target with OPTION */
+	mnt_reset_iter(&itr, direction);
+	while(mnt_table_next_fs(tb, &itr, &fs) == 0) {
+		if (mnt_fs_streq_target(fs, path))
+		{
+			if (!mnt_fs_get_option(fs, option, &optval, &optvalsz))
+				if ((optvalsz == valsz) &&
+				    !strncmp(optval, val, optvalsz))
+					return fs;
+		}
+	}
+	return NULL;
+}
+
+/**
  * mnt_table_find_source:
  * @tb: tab pointer
  * @source: TAG or path
@@ -1241,9 +1284,10 @@ struct libmnt_fs *mnt_table_get_fs_root(struct libmnt_table *tb,
 		}
 
 		/* It's possible that fstab_fs source is subdirectory on btrfs
-		 * subvolume or anothe bind mount. For example:
+		 * subvolume or another bind mount. For example:
 		 *
 		 * /dev/sdc        /mnt/test       btrfs   subvol=/anydir
+		 * /dev/sdc        /mnt/test       btrfs   defaults
 		 * /mnt/test/foo   /mnt/test2      auto    bind
 		 *
 		 * in this case, the root for /mnt/test2 will be /anydir/foo on
@@ -1278,9 +1322,40 @@ struct libmnt_fs *mnt_table_get_fs_root(struct libmnt_table *tb,
 		size_t sz, volsz = 0;
 
 		if (mnt_fs_get_option(fs, "subvol", &vol, &volsz))
-			goto dflt;
-
-		DBG(TAB, ul_debug("setting FS root: btrfs subvol"));
+		{
+			/* If fstab entry does not contain "subvol", we have to
+			 * check, whether btrfs has default subvolume
+			 * defined. */
+
+			__u64 default_id;
+			const char *target;
+			char default_id_str[16]; /* should be safe for u64 */
+
+			default_id = btrfs_get_default_subvol_id(mnt_fs_get_target(fs));
+			if (default_id == (__u64)-1)
+				goto dflt;
+
+			/* Volume has default subvolume. Check if it
+			 * matches to the one in mountinfo.
+			 *
+			 * Only kernel >= 4.2 reports subvolid. On older
+			 * kernels, there is no reasonable way to detect which
+			 * subvolume was mounted. */
+			target = mnt_resolve_spec(mnt_fs_get_target(fs), tb->cache);
+			snprintf(default_id_str, 16, "%llu", (unsigned long long int)default_id);
+			DBG(TAB, ul_debug("target = %s subvolid = %s", target, &default_id_str));
+			struct libmnt_fs *f = mnt_table_find_target_with_option(tb, target, "subvolid", default_id_str, MNT_ITER_BACKWARD);
+			if (!f)
+				goto dflt;
+
+			/* Instead of set of BACKREF queries constructing
+			 * subvol path, use the one in mountinfo. Kernel does
+			 * the evaluation for us. */
+			DBG(TAB, ul_debug("setting FS root: btrfs default subvolid = %s", &default_id_str));
+			if (mnt_fs_get_option(f, "subvol", &vol, &volsz))
+				goto dflt;
+		} else
+			DBG(TAB, ul_debug("setting FS root: btrfs subvol"));
 
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
