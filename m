Return-Path: hare@suse.de
From: Hannes Reinecke <hare@suse.de>
To: Karel Zak <kzak@redhat.com>
Cc: Werner Fink <werner@suse.de>, Stanislav Brabec <sbrabec@suse.com>,
        <util-linux@vger.kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] blkid: convert superblocks to new calling convention
Date: Thu, 20 Mar 2014 11:03:50 +0100
Message-Id: <1395309830-58744-3-git-send-email-hare@suse.de>
In-Reply-To: <1395309830-58744-1-git-send-email-hare@suse.de>
References: <1395309830-58744-1-git-send-email-hare@suse.de>
List-ID: <util-linux.vger.kernel.org>

With the previous patch the scanning functions were
modified to return a differentiated return code.
To correctly abort scanning when an I/O error occurs
we need to differentiate between 'error' (= -1) and
'not found' (= 1) in the probe functions.
This patch updates all superblock scanning functions
to the new calling convention.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 libblkid/src/partitions/aix.c                |  2 +-
 libblkid/src/partitions/bsd.c                | 28 ++++++++++-------
 libblkid/src/partitions/dos.c                | 40 ++++++++++++++----------
 libblkid/src/partitions/gpt.c                | 29 ++++++++++++------
 libblkid/src/partitions/mac.c                | 25 ++++++++++-----
 libblkid/src/partitions/minix.c              | 17 +++++-----
 libblkid/src/partitions/sgi.c                | 15 +++++----
 libblkid/src/partitions/solaris_x86.c        | 15 +++++----
 libblkid/src/partitions/sun.c                | 17 +++++-----
 libblkid/src/partitions/ultrix.c             | 15 +++++----
 libblkid/src/partitions/unixware.c           | 15 +++++----
 libblkid/src/superblocks/adaptec_raid.c      | 15 ++++-----
 libblkid/src/superblocks/bcache.c            |  4 +--
 libblkid/src/superblocks/befs.c              | 26 ++++++++--------
 libblkid/src/superblocks/btrfs.c             |  2 +-
 libblkid/src/superblocks/cramfs.c            |  2 +-
 libblkid/src/superblocks/ddf_raid.c          | 19 +++++++-----
 libblkid/src/superblocks/drbd.c              |  8 ++---
 libblkid/src/superblocks/drbdproxy_datalog.c |  2 +-
 libblkid/src/superblocks/exfat.c             |  4 ++-
 libblkid/src/superblocks/ext.c               | 30 +++++++++---------
 libblkid/src/superblocks/f2fs.c              |  2 +-
 libblkid/src/superblocks/gfs.c               |  8 ++---
 libblkid/src/superblocks/hfs.c               | 12 ++++----
 libblkid/src/superblocks/highpoint_raid.c    | 12 ++++----
 libblkid/src/superblocks/hpfs.c              |  8 ++---
 libblkid/src/superblocks/iso9660.c           |  4 +--
 libblkid/src/superblocks/isw_raid.c          | 13 ++++----
 libblkid/src/superblocks/jfs.c               |  2 +-
 libblkid/src/superblocks/jmicron_raid.c      | 13 ++++----
 libblkid/src/superblocks/linux_raid.c        | 46 ++++++++++++++++------------
 libblkid/src/superblocks/lsi_raid.c          | 10 +++---
 libblkid/src/superblocks/luks.c              |  2 +-
 libblkid/src/superblocks/lvm.c               |  6 ++--
 libblkid/src/superblocks/minix.c             | 18 ++++++-----
 libblkid/src/superblocks/netware.c           |  2 +-
 libblkid/src/superblocks/nilfs.c             |  4 +--
 libblkid/src/superblocks/ntfs.c              |  6 ++--
 libblkid/src/superblocks/nvidia_raid.c       | 12 ++++----
 libblkid/src/superblocks/ocfs.c              |  8 ++---
 libblkid/src/superblocks/promise_raid.c      | 10 +++---
 libblkid/src/superblocks/reiserfs.c          |  8 ++---
 libblkid/src/superblocks/romfs.c             |  2 +-
 libblkid/src/superblocks/silicon_raid.c      | 10 +++---
 libblkid/src/superblocks/squashfs.c          |  2 +-
 libblkid/src/superblocks/swap.c              | 24 +++++++--------
 libblkid/src/superblocks/sysv.c              |  8 ++---
 libblkid/src/superblocks/ubifs.c             |  2 +-
 libblkid/src/superblocks/udf.c               | 16 +++++-----
 libblkid/src/superblocks/ufs.c               |  4 +--
 libblkid/src/superblocks/vfat.c              | 16 +++++-----
 libblkid/src/superblocks/via_raid.c          |  6 ++--
 libblkid/src/superblocks/vmfs.c              |  4 +--
 libblkid/src/superblocks/vxfs.c              |  2 +-
 libblkid/src/superblocks/xfs.c               |  6 ++--
 libblkid/src/superblocks/zfs.c               |  6 ++--
 56 files changed, 357 insertions(+), 287 deletions(-)

diff --git a/libblkid/src/partitions/aix.c b/libblkid/src/partitions/aix.c
index de397bf..ded9dfd 100644
--- a/libblkid/src/partitions/aix.c
+++ b/libblkid/src/partitions/aix.c
@@ -34,7 +34,7 @@ static int probe_aix_pt(blkid_probe pr,
 
 	return 0;
 err:
-	return -1;
+	return 1;
 }
 
 /*
diff --git a/libblkid/src/partitions/bsd.c b/libblkid/src/partitions/bsd.c
index 3de6a58..366bdc4 100644
--- a/libblkid/src/partitions/bsd.c
+++ b/libblkid/src/partitions/bsd.c
@@ -36,20 +36,24 @@ static int probe_bsd_pt(blkid_probe pr, const struct blkid_idmag *mag)
 	blkid_partlist ls;
 	int i, nparts = BSD_MAXPARTITIONS;
 	unsigned char *data;
+	int rc = BLKID_PROBE_NONE;
 
 	if (blkid_partitions_need_typeonly(pr))
 		/* caller does not ask for details about partitions */
-		return 0;
+		return rc;
 
 	data = blkid_probe_get_sector(pr, BLKID_MAG_SECTOR(mag));
-	if (!data)
+	if (!data) {
+		if (errno)
+			rc = -errno;
 		goto nothing;
+	}
 
 	l = (struct bsd_disklabel *) data + BLKID_MAG_LASTOFFSET(mag);
 
 	ls = blkid_probe_get_partlist(pr);
 	if (!ls)
-		goto err;
+		goto nothing;
 
 	/* try to determine the real type of BSD system according to
 	 * (parental) primary partition */
@@ -75,8 +79,10 @@ static int probe_bsd_pt(blkid_probe pr, const struct blkid_idmag *mag)
 	}
 
 	tab = blkid_partlist_new_parttable(ls, name, BLKID_MAG_OFFSET(mag));
-	if (!tab)
-		goto err;
+	if (!tab) {
+		rc = -ENOMEM;
+		goto nothing;
+	}
 
 	if (le16_to_cpu(l->d_npartitions) < BSD_MAXPARTITIONS)
 		nparts = le16_to_cpu(l->d_npartitions);
@@ -112,18 +118,18 @@ static int probe_bsd_pt(blkid_probe pr, const struct blkid_idmag *mag)
 		}
 
 		par = blkid_partlist_add_partition(ls, tab, start, size);
-		if (!par)
-			goto err;
+		if (!par) {
+			rc = -ENOMEM;
+			goto nothing;
+		}
 
 		blkid_partition_set_type(par, p->p_fstype);
 	}
 
-	return 0;
+	return BLKID_PROBE_OK;
 
 nothing:
-	return 1;
-err:
-	return -1;
+	return rc;
 }
 
 
diff --git a/libblkid/src/partitions/dos.c b/libblkid/src/partitions/dos.c
index 14f326d..3466458 100644
--- a/libblkid/src/partitions/dos.c
+++ b/libblkid/src/partitions/dos.c
@@ -52,10 +52,13 @@ static int parse_dos_extended(blkid_probe pr, blkid_parttable tab,
 		uint32_t start, size;
 
 		if (++ct_nodata > 100)
-			return 0;
+			return BLKID_PROBE_OK;
 		data = blkid_probe_get_sector(pr, cur_start);
-		if (!data)
+		if (!data) {
+			if (errno)
+				return -errno;
 			goto leave;	/* malformed partition? */
+		}
 
 		if (!mbr_is_valid_magic(data))
 			goto leave;
@@ -98,7 +101,7 @@ static int parse_dos_extended(blkid_probe pr, blkid_parttable tab,
 
 			par = blkid_partlist_add_partition(ls, tab, abs_start, size);
 			if (!par)
-				goto err;
+				return -ENOMEM;
 
 			blkid_partition_set_type(par, p->sys_ind);
 			blkid_partition_set_flags(par, p->boot_ind);
@@ -123,9 +126,7 @@ static int parse_dos_extended(blkid_probe pr, blkid_parttable tab,
 		cur_size = size;
 	}
 leave:
-	return 0;
-err:
-	return -1;
+	return BLKID_PROBE_OK;
 }
 
 static int probe_dos_pt(blkid_probe pr,
@@ -142,8 +143,11 @@ static int probe_dos_pt(blkid_probe pr,
 
 
 	data = blkid_probe_get_sector(pr, 0);
-	if (!data)
+	if (!data) {
+		if (errno)
+			return -errno;
 		goto nothing;
+	}
 
 	/* ignore disks with AIX magic number -- for more details see aix.c */
 	if (memcmp(data, BLKID_AIX_MAGIC_STRING, BLKID_AIX_MAGIC_STRLEN) == 0)
@@ -198,6 +202,8 @@ static int probe_dos_pt(blkid_probe pr,
 	}
 
 	ls = blkid_probe_get_partlist(pr);
+	if (!ls)
+		goto nothing;
 
 	/* sector size factor (the start and size are in the real sectors, but
 	 * we need to convert all sizes to 512 logical sectors
@@ -207,7 +213,7 @@ static int probe_dos_pt(blkid_probe pr,
 	/* allocate a new partition table */
 	tab = blkid_partlist_new_parttable(ls, "dos", MBR_PT_OFFSET);
 	if (!tab)
-		goto err;
+		return -ENOMEM;
 
 	if (id)
 		blkid_parttable_set_id(tab, (unsigned char *) idstr);
@@ -227,7 +233,7 @@ static int probe_dos_pt(blkid_probe pr,
 		}
 		par = blkid_partlist_add_partition(ls, tab, start, size);
 		if (!par)
-			goto err;
+			return -ENOMEM;
 
 		blkid_partition_set_type(par, p->sys_ind);
 		blkid_partition_set_flags(par, p->boot_ind);
@@ -248,13 +254,14 @@ static int probe_dos_pt(blkid_probe pr,
 			continue;
 		if (is_extended(p) &&
 		    parse_dos_extended(pr, tab, start, size, ssf) == -1)
-			goto err;
+			goto nothing;
 	}
 
 	/* Parse subtypes (nested partitions) on large disks */
 	if (!blkid_probe_is_tiny(pr)) {
 		for (p = p0, i = 0; i < 4; i++, p++) {
 			size_t n;
+			int rc;
 
 			if (!dos_partition_get_size(p) || is_extended(p))
 				continue;
@@ -263,20 +270,19 @@ static int probe_dos_pt(blkid_probe pr,
 				if (dos_nested[n].type != p->sys_ind)
 					continue;
 
-				if (blkid_partitions_do_subprobe(pr,
+				rc = blkid_partitions_do_subprobe(pr,
 						blkid_partlist_get_partition(ls, i),
-						dos_nested[n].id) == -1)
-					goto err;
+						dos_nested[n].id);
+				if (rc < 0)
+					return rc;
 				break;
 			}
 		}
 	}
-	return 0;
+	return BLKID_PROBE_OK;
 
 nothing:
-	return 1;
-err:
-	return -1;
+	return BLKID_PROBE_NONE;
 }
 
 
diff --git a/libblkid/src/partitions/gpt.c b/libblkid/src/partitions/gpt.c
index 65a0f43..a561c75 100644
--- a/libblkid/src/partitions/gpt.c
+++ b/libblkid/src/partitions/gpt.c
@@ -168,8 +168,11 @@ static int is_pmbr_valid(blkid_probe pr, int *has)
 		goto ok;			/* skip PMBR check */
 
 	data = blkid_probe_get_sector(pr, 0);
-	if (!data)
+	if (!data) {
+		if (errno)
+			return -errno;
 		goto failed;
+	}
 
 	if (!mbr_is_valid_magic(data))
 		goto failed;
@@ -302,19 +305,26 @@ static int probe_gpt_pt(blkid_probe pr,
 	uint64_t fu, lu;
 	uint32_t ssf, i;
 	efi_guid_t guid;
+	int ret;
 
 	if (last_lba(pr, &lastlba))
 		goto nothing;
 
-	if (!is_pmbr_valid(pr, NULL))
+	ret = is_pmbr_valid(pr, NULL);
+	if (ret < 0)
+		return ret;
+	else if (ret == 0)
 		goto nothing;
 
 	h = get_gpt_header(pr, &hdr, &e, (lba = GPT_PRIMARY_LBA), lastlba);
-	if (!h)
+	if (!h && !errno)
 		h = get_gpt_header(pr, &hdr, &e, (lba = lastlba), lastlba);
 
-	if (!h)
+	if (!h) {
+		if (errno)
+			return -errno;
 		goto nothing;
+	}
 
 	blkid_probe_use_wiper(pr, lba * blkid_probe_get_size(pr), 8);
 
@@ -330,12 +340,12 @@ static int probe_gpt_pt(blkid_probe pr,
 		/* Non-binary interface -- caller does not ask for details
 		 * about partitions, just set generic varibles only. */
 		blkid_partitions_set_ptuuid(pr, (unsigned char *) &guid);
-		return 0;
+		return BLKID_PROBE_OK;
 	}
 
 	ls = blkid_probe_get_partlist(pr);
 	if (!ls)
-		goto err;
+		goto nothing;
 
 	tab = blkid_partlist_new_parttable(ls, "gpt", lba << 9);
 	if (!tab)
@@ -389,12 +399,13 @@ static int probe_gpt_pt(blkid_probe pr,
 		blkid_partition_set_flags(par, le64_to_cpu(e->attributes));
 	}
 
-	return 0;
+	return BLKID_PROBE_OK;
 
 nothing:
-	return 1;
+	return BLKID_PROBE_NONE;
+
 err:
-	return -1;
+	return -ENOMEM;
 }
 
 
diff --git a/libblkid/src/partitions/mac.c b/libblkid/src/partitions/mac.c
index 7f8bb75..3b302d9 100644
--- a/libblkid/src/partitions/mac.c
+++ b/libblkid/src/partitions/mac.c
@@ -87,8 +87,11 @@ static int probe_mac_pt(blkid_probe pr,
 	 * the first block on the disk.
 	 */
 	md = (struct mac_driver_desc *) blkid_probe_get_sector(pr, 0);
-	if (!md)
+	if (!md) {
+		if (errno)
+			return -errno;
 		goto nothing;
+	}
 
 	block_size = be16_to_cpu(md->block_size);
 
@@ -96,8 +99,11 @@ static int probe_mac_pt(blkid_probe pr,
 	 * the second block on the disk.
 	 */
 	p = (struct mac_partition *) get_mac_block(pr, block_size, 1);
-	if (!p)
+	if (!p) {
+		if (errno)
+			return -errno;
 		goto nothing;
+	}
 
 	/* check the first partition signature */
 	if (!has_part_signature(p))
@@ -109,7 +115,7 @@ static int probe_mac_pt(blkid_probe pr,
 
 	ls = blkid_probe_get_partlist(pr);
 	if (!ls)
-		goto err;
+		goto nothing;
 
 	tab = blkid_partlist_new_parttable(ls, "mac", 0);
 	if (!tab)
@@ -124,15 +130,18 @@ static int probe_mac_pt(blkid_probe pr,
 		uint32_t size;
 
 		p = (struct mac_partition *) get_mac_block(pr, block_size, i);
-		if (!p)
+		if (!p) {
+			if (errno)
+				return -errno;
 			goto nothing;
+		}
 		if (!has_part_signature(p))
 			goto nothing;
 
 		if (be32_to_cpu(p->map_count) != nblks) {
 			DBG(LOWPROBE, blkid_debug(
 				"mac: inconsisten map_count in partition map, "
-			        "entry[0]: %d, entry[%d]: %d",
+				"entry[0]: %d, entry[%d]: %d",
 				nblks, i - 1,
 				be32_to_cpu(p->map_count)));
 		}
@@ -157,12 +166,12 @@ static int probe_mac_pt(blkid_probe pr,
 						sizeof(p->type));
 	}
 
-	return 0;
+	return BLKID_PROBE_OK;
 
 nothing:
-	return 1;
+	return BLKID_PROBE_NONE;
 err:
-	return -1;
+	return -ENOMEM;
 }
 
 /*
diff --git a/libblkid/src/partitions/minix.c b/libblkid/src/partitions/minix.c
index 0a597fb..2e2a221 100644
--- a/libblkid/src/partitions/minix.c
+++ b/libblkid/src/partitions/minix.c
@@ -25,26 +25,29 @@ static int probe_minix_pt(blkid_probe pr,
 	int i;
 
 	data = blkid_probe_get_sector(pr, 0);
-	if (!data)
+	if (!data) {
+		if (errno)
+			return -errno;
 		goto nothing;
+	}
 
 	ls = blkid_probe_get_partlist(pr);
 	if (!ls)
-		goto err;
+		goto nothing;
 
 	/* Parent is required, because Minix uses the same PT as DOS and
 	 * difference is only in primary partition (parent) type.
 	 */
 	parent = blkid_partlist_get_parent(ls);
 	if (!parent)
-		goto nothing;
+		goto err;
 
 	if (blkid_partition_get_type(parent) != MBR_MINIX_PARTITION)
 		goto nothing;
 
 	if (blkid_partitions_need_typeonly(pr))
 		/* caller does not ask for details about partitions */
-		return 0;
+		return BLKID_PROBE_OK;
 
 	tab = blkid_partlist_new_parttable(ls, "minix", MBR_PT_OFFSET);
 	if (!tab)
@@ -77,12 +80,12 @@ static int probe_minix_pt(blkid_probe pr,
 		blkid_partition_set_flags(par, p->boot_ind);
 	}
 
-	return 0;
+	return BLKID_PROBE_OK;
 
 nothing:
-	return 1;
+	return BLKID_PROBE_NONE;
 err:
-	return -1;
+	return -ENOMEM;
 }
 
 /* same as DOS */
diff --git a/libblkid/src/partitions/sgi.c b/libblkid/src/partitions/sgi.c
index 36dda38..4446e53 100644
--- a/libblkid/src/partitions/sgi.c
+++ b/libblkid/src/partitions/sgi.c
@@ -25,8 +25,11 @@ static int probe_sgi_pt(blkid_probe pr,
 	int i;
 
 	l = (struct sgi_disklabel *) blkid_probe_get_sector(pr, 0);
-	if (!l)
+	if (!l) {
+		if (errno)
+			return -errno;
 		goto nothing;
+	}
 
 	if (sgi_pt_checksum(l)) {
 		DBG(LOWPROBE, blkid_debug(
@@ -36,11 +39,11 @@ static int probe_sgi_pt(blkid_probe pr,
 
 	if (blkid_partitions_need_typeonly(pr))
 		/* caller does not ask for details about partitions */
-		return 0;
+		return BLKID_PROBE_OK;
 
 	ls = blkid_probe_get_partlist(pr);
 	if (!ls)
-		goto err;
+		goto nothing;
 
 	tab = blkid_partlist_new_parttable(ls, "sgi", 0);
 	if (!tab)
@@ -63,12 +66,12 @@ static int probe_sgi_pt(blkid_probe pr,
 		blkid_partition_set_type(par, type);
 	}
 
-	return 0;
+	return BLKID_PROBE_OK;
 
 nothing:
-	return 1;
+	return BLKID_PROBE_NONE;
 err:
-	return -1;
+	return -ENOMEM;
 }
 
 const struct blkid_idinfo sgi_pt_idinfo =
diff --git a/libblkid/src/partitions/solaris_x86.c b/libblkid/src/partitions/solaris_x86.c
index 4e08caf..16ad0f1 100644
--- a/libblkid/src/partitions/solaris_x86.c
+++ b/libblkid/src/partitions/solaris_x86.c
@@ -69,8 +69,11 @@ static int probe_solaris_pt(blkid_probe pr,
 	uint16_t nparts;
 
 	l = (struct solaris_vtoc *) blkid_probe_get_sector(pr, SOLARIS_SECTOR);
-	if (!l)
+	if (!l) {
+		if (errno)
+			return -errno;
 		goto nothing;
+	}
 
 	if (le32_to_cpu(l->v_version) != 1) {
 		DBG(LOWPROBE, blkid_debug(
@@ -81,11 +84,11 @@ static int probe_solaris_pt(blkid_probe pr,
 
 	if (blkid_partitions_need_typeonly(pr))
 		/* caller does not ask for details about partitions */
-		return 0;
+		return BLKID_PROBE_OK;
 
 	ls = blkid_probe_get_partlist(pr);
 	if (!ls)
-		goto err;
+		goto nothing;
 
 	parent = blkid_partlist_get_parent(ls);
 
@@ -126,12 +129,12 @@ static int probe_solaris_pt(blkid_probe pr,
 		blkid_partition_set_flags(par, le16_to_cpu(p->s_flag));
 	}
 
-	return 0;
+	return BLKID_PROBE_OK;
 
 nothing:
-	return 1;
+	return BLKID_PROBE_NONE;
 err:
-	return -1;
+	return -ENOMEM;
 }
 
 const struct blkid_idinfo solaris_x86_pt_idinfo =
diff --git a/libblkid/src/partitions/sun.c b/libblkid/src/partitions/sun.c
index ba7ca3a..306a758 100644
--- a/libblkid/src/partitions/sun.c
+++ b/libblkid/src/partitions/sun.c
@@ -27,8 +27,11 @@ static int probe_sun_pt(blkid_probe pr,
 	int i, use_vtoc;
 
 	l = (struct sun_disklabel *) blkid_probe_get_sector(pr, 0);
-	if (!l)
+	if (!l) {
+		if (errno)
+			return -errno;
 		goto nothing;
+	}
 
 	if (sun_pt_checksum(l)) {
 		DBG(LOWPROBE, blkid_debug(
@@ -38,11 +41,11 @@ static int probe_sun_pt(blkid_probe pr,
 
 	if (blkid_partitions_need_typeonly(pr))
 		/* caller does not ask for details about partitions */
-		return 0;
+		return BLKID_PROBE_OK;
 
 	ls = blkid_probe_get_partlist(pr);
 	if (!ls)
-		goto err;
+		goto nothing;
 
 	tab = blkid_partlist_new_parttable(ls, "sun", 0);
 	if (!tab)
@@ -76,7 +79,7 @@ static int probe_sun_pt(blkid_probe pr,
 		uint16_t type = 0, flags = 0;
 		blkid_partition par;
 
-                start = be32_to_cpu(p->start_cylinder) * spc;
+		start = be32_to_cpu(p->start_cylinder) * spc;
 		size = be32_to_cpu(p->num_sectors);
 		if (use_vtoc) {
 			type = be16_to_cpu(l->vtoc.infos[i].id);
@@ -96,12 +99,12 @@ static int probe_sun_pt(blkid_probe pr,
 		if (flags)
 			blkid_partition_set_flags(par, flags);
 	}
-	return 0;
+	return BLKID_PROBE_OK;
 
 nothing:
-	return 1;
+	return BLKID_PROBE_NONE;
 err:
-	return -1;
+	return -ENOMEM;
 }
 
 
diff --git a/libblkid/src/partitions/ultrix.c b/libblkid/src/partitions/ultrix.c
index 853ae6e..9c060be 100644
--- a/libblkid/src/partitions/ultrix.c
+++ b/libblkid/src/partitions/ultrix.c
@@ -44,8 +44,11 @@ static int probe_ultrix_pt(blkid_probe pr,
 	int i;
 
 	data = blkid_probe_get_sector(pr, ULTRIX_SECTOR);
-	if (!data)
+	if (!data) {
+		if (errno)
+			return -errno;
 		goto nothing;
+	}
 
 	l = (struct ultrix_disklabel *) (data + ULTRIX_OFFSET);
 
@@ -59,11 +62,11 @@ static int probe_ultrix_pt(blkid_probe pr,
 
 	if (blkid_partitions_need_typeonly(pr))
 		/* caller does not ask for details about partitions */
-		return 0;
+		return BLKID_PROBE_OK;
 
 	ls = blkid_probe_get_partlist(pr);
 	if (!ls)
-		goto err;
+		goto nothing;
 
 	tab = blkid_partlist_new_parttable(ls, "ultrix", 0);
 	if (!tab)
@@ -80,11 +83,11 @@ static int probe_ultrix_pt(blkid_probe pr,
 		}
 	}
 
-	return 0;
+	return BLKID_PROBE_OK;
 nothing:
-	return 1;
+	return BLKID_PROBE_NONE;
 err:
-	return -1;
+	return -ENOMEM;
 }
 
 const struct blkid_idinfo ultrix_pt_idinfo =
diff --git a/libblkid/src/partitions/unixware.c b/libblkid/src/partitions/unixware.c
index ce176b8..81393fd 100644
--- a/libblkid/src/partitions/unixware.c
+++ b/libblkid/src/partitions/unixware.c
@@ -106,19 +106,22 @@ static int probe_unixware_pt(blkid_probe pr,
 
 	l = (struct unixware_disklabel *)
 			blkid_probe_get_sector(pr, UNIXWARE_SECTOR);
-	if (!l)
+	if (!l) {
+		if (errno)
+			return -errno;
 		goto nothing;
+	}
 
 	if (le32_to_cpu(l->vtoc.v_magic) != UNIXWARE_VTOCMAGIC)
 		goto nothing;
 
 	if (blkid_partitions_need_typeonly(pr))
 		/* caller does not ask for details about partitions */
-		return 0;
+		return BLKID_PROBE_OK;
 
 	ls = blkid_probe_get_partlist(pr);
 	if (!ls)
-		goto err;
+		goto nothing;
 
 	parent = blkid_partlist_get_parent(ls);
 
@@ -161,12 +164,12 @@ static int probe_unixware_pt(blkid_probe pr,
 		blkid_partition_set_flags(par, flg);
 	}
 
-	return 0;
+	return BLKID_PROBE_OK;
 
 nothing:
-	return 1;
+	return BLKID_PROBE_NONE;
 err:
-	return -1;
+	return -ENOMEM;
 }
 
 
diff --git a/libblkid/src/superblocks/adaptec_raid.c b/libblkid/src/superblocks/adaptec_raid.c
index 02e900d..4113a47 100644
--- a/libblkid/src/superblocks/adaptec_raid.c
+++ b/libblkid/src/superblocks/adaptec_raid.c
@@ -80,10 +80,10 @@ static int probe_adraid(blkid_probe pr,
 	struct adaptec_metadata *ad;
 
 	if (pr->size < 0x10000)
-		return -1;
+		return 1;
 
 	if (!S_ISREG(pr->mode) && !blkid_probe_is_wholedisk(pr))
-		return -1;
+		return 1;
 
 	off = ((pr->size / 0x200)-1) * 0x200;
 	ad = (struct adaptec_metadata *)
@@ -91,16 +91,17 @@ static int probe_adraid(blkid_probe pr,
 					off,
 					sizeof(struct adaptec_metadata));
 	if (!ad)
-		return -1;
+		return errno ? -errno : 1;
+
 	if (ad->smagic != be32_to_cpu(AD_SIGNATURE))
-		return -1;
+		return 1;
 	if (ad->b0idcode != be32_to_cpu(AD_MAGIC))
-		return -1;
+		return 1;
 	if (blkid_probe_sprintf_version(pr, "%u", ad->resver) != 0)
-		return -1;
+		return 1;
 	if (blkid_probe_set_magic(pr, off, sizeof(ad->b0idcode),
 				(unsigned char *) &ad->b0idcode))
-		return -1;
+		return 1;
 	return 0;
 }
 
diff --git a/libblkid/src/superblocks/bcache.c b/libblkid/src/superblocks/bcache.c
index 303f7ee..0d2fab5 100644
--- a/libblkid/src/superblocks/bcache.c
+++ b/libblkid/src/superblocks/bcache.c
@@ -104,7 +104,7 @@ static int probe_bcache (blkid_probe pr, const struct blkid_idmag *mag)
 
 	bcs = blkid_probe_get_sb(pr, mag, struct bcache_super_block);
 	if (!bcs)
-		return -1;
+		return errno ? -errno : 1;
 
 	if (le64_to_cpu(bcs->offset) != BCACHE_SB_OFF / 512)
 		return 1;
@@ -112,7 +112,7 @@ static int probe_bcache (blkid_probe pr, const struct blkid_idmag *mag)
 		return 1;
 
 	if (blkid_probe_set_uuid(pr, bcs->uuid) < 0)
-		return -1;
+		return 1;
 
 	return 0;
 };
diff --git a/libblkid/src/superblocks/befs.c b/libblkid/src/superblocks/befs.c
index 452da1e..4093762 100644
--- a/libblkid/src/superblocks/befs.c
+++ b/libblkid/src/superblocks/befs.c
@@ -264,10 +264,10 @@ static int64_t get_key_value(blkid_probe pr, const struct befs_super_block *bs,
 	bh = (struct bplustree_header *) get_tree_node(pr, bs, &bi->data, 0,
 					sizeof(struct bplustree_header), fs_le);
 	if (!bh)
-		return -1;
+		return errno ? -errno : -ENOENT;
 
 	if ((int32_t) FS32_TO_CPU(bh->magic, fs_le) != BPLUSTREE_MAGIC)
-		return -1;
+		return -ENOKEY;
 
 	node_pointer = FS64_TO_CPU(bh->root_node_pointer, fs_le);
 
@@ -275,7 +275,7 @@ static int64_t get_key_value(blkid_probe pr, const struct befs_super_block *bs,
 		bn = (struct bplustree_node *) get_tree_node(pr, bs, &bi->data,
 			node_pointer, FS32_TO_CPU(bh->node_size, fs_le), fs_le);
 		if (!bn)
-			return -1;
+			return errno ? -errno : -ENOENT;
 
 		keylengths = (uint16_t *) ((uint8_t *) bn
 				+ ((sizeof(struct bplustree_node)
@@ -336,10 +336,10 @@ static int get_uuid(blkid_probe pr, const struct befs_super_block *bs,
 
 	bi = (struct befs_inode *) get_block_run(pr, bs, &bs->root_dir, fs_le);
 	if (!bi)
-		return -1;
+		return errno ? -errno : 1;
 
 	if (FS32_TO_CPU(bi->magic1, fs_le) != INODE_MAGIC1)
-		return -1;
+		return BLKID_PROBE_NONE;
 
 	sd = (struct small_data *) bi->small_data;
 
@@ -376,10 +376,10 @@ static int get_uuid(blkid_probe pr, const struct befs_super_block *bs,
 		bi = (struct befs_inode *) get_block_run(pr, bs,
 							&bi->attributes, fs_le);
 		if (!bi)
-			return -1;
+			return errno ? -errno : 1;
 
 		if (FS32_TO_CPU(bi->magic1, fs_le) != INODE_MAGIC1)
-			return -1;
+			return 1;
 
 		value = get_key_value(pr, bs, bi, KEY_NAME, fs_le);
 
@@ -390,10 +390,10 @@ static int get_uuid(blkid_probe pr, const struct befs_super_block *bs,
 				value << FS32_TO_CPU(bs->block_shift, fs_le),
 				FS32_TO_CPU(bs->block_size, fs_le));
 			if (!bi)
-				return -1;
+				return errno ? -errno : 1;
 
 			if (FS32_TO_CPU(bi->magic1, fs_le) != INODE_MAGIC1)
-				return -1;
+				return 1;
 
 			if (FS32_TO_CPU(bi->type, fs_le) == B_UINT64_TYPE
 				&& FS64_TO_CPU(bi->data.size, fs_le) == KEY_SIZE
@@ -404,7 +404,7 @@ static int get_uuid(blkid_probe pr, const struct befs_super_block *bs,
 				attr_data = (uint64_t *) get_block_run(pr, bs,
 						&bi->data.direct[0], fs_le);
 				if (!attr_data)
-					return -1;
+					return errno ? -1 : 1;
 
 				*uuid = *attr_data;
 			}
@@ -424,7 +424,7 @@ static int probe_befs(blkid_probe pr, const struct blkid_idmag *mag)
 					mag->sboff - B_OS_NAME_LENGTH,
 					sizeof(struct befs_super_block));
 	if (!bs)
-		return -1;
+		return errno ? -errno : 1;
 
 	if (le32_to_cpu(bs->magic1) == SUPER_BLOCK_MAGIC1
 		&& le32_to_cpu(bs->magic2) == SUPER_BLOCK_MAGIC2
@@ -439,11 +439,11 @@ static int probe_befs(blkid_probe pr, const struct blkid_idmag *mag)
 		fs_le = 0;
 		version = "big-endian";
 	} else
-		return -1;
+		return 1;
 
 	ret = get_uuid(pr, bs, &volume_id, fs_le);
 
-	if (ret < 0)
+	if (ret != 0)
 		return ret;
 
 	/*
diff --git a/libblkid/src/superblocks/btrfs.c b/libblkid/src/superblocks/btrfs.c
index 434be34..7ce3dff 100644
--- a/libblkid/src/superblocks/btrfs.c
+++ b/libblkid/src/superblocks/btrfs.c
@@ -65,7 +65,7 @@ static int probe_btrfs(blkid_probe pr, const struct blkid_idmag *mag)
 
 	bfs = blkid_probe_get_sb(pr, mag, struct btrfs_super_block);
 	if (!bfs)
-		return -1;
+		return errno ? -errno : 1;
 
 	if (*bfs->label)
 		blkid_probe_set_label(pr,
diff --git a/libblkid/src/superblocks/cramfs.c b/libblkid/src/superblocks/cramfs.c
index b58ed08..6d01b0b 100644
--- a/libblkid/src/superblocks/cramfs.c
+++ b/libblkid/src/superblocks/cramfs.c
@@ -40,7 +40,7 @@ static int probe_cramfs(blkid_probe pr, const struct blkid_idmag *mag)
 
 	cs = blkid_probe_get_sb(pr, mag, struct cramfs_super);
 	if (!cs)
-		return -1;
+		return errno ? -errno : 1;
 
 	blkid_probe_set_label(pr, cs->name, sizeof(cs->name));
 	return 0;
diff --git a/libblkid/src/superblocks/ddf_raid.c b/libblkid/src/superblocks/ddf_raid.c
index 24df421..b907a9f 100644
--- a/libblkid/src/superblocks/ddf_raid.c
+++ b/libblkid/src/superblocks/ddf_raid.c
@@ -81,7 +81,7 @@ static int probe_ddf(blkid_probe pr,
 	uint64_t off, lba;
 
 	if (pr->size < 0x30000)
-		return -1;
+		return 1;
 
 	for (i = 0; i < ARRAY_SIZE(hdrs); i++) {
 		off = ((pr->size / 0x200) - hdrs[i]) * 0x200;
@@ -90,8 +90,7 @@ static int probe_ddf(blkid_probe pr,
 					off,
 					sizeof(struct ddf_header));
 		if (!ddf)
-			return -1;
-
+			return errno ? -errno : 1;
 		if (ddf->signature == cpu_to_be32(DDF_MAGIC) ||
 		    ddf->signature == cpu_to_le32(DDF_MAGIC))
 			break;
@@ -99,7 +98,7 @@ static int probe_ddf(blkid_probe pr,
 	}
 
 	if (!ddf)
-		return -1;
+		return 1;
 
 	lba = ddf->signature == cpu_to_be32(DDF_MAGIC) ?
 			be64_to_cpu(ddf->primary_lba) :
@@ -111,8 +110,12 @@ static int probe_ddf(blkid_probe pr,
 
 		buf = blkid_probe_get_buffer(pr,
 					lba << 9, sizeof(ddf->signature));
-		if (!buf || memcmp(buf, &ddf->signature, 4))
-			return -1;
+		if (!buf) {
+			if (errno)
+				return -errno;
+			if (memcmp(buf, &ddf->signature, 4))
+				return 1;
+		}
 	}
 
 	blkid_probe_strncpy_uuid(pr, ddf->guid, sizeof(ddf->guid));
@@ -121,11 +124,11 @@ static int probe_ddf(blkid_probe pr,
 	*(version + sizeof(ddf->ddf_rev)) = '\0';
 
 	if (blkid_probe_set_version(pr, version) != 0)
-		return -1;
+		return 1;
 	if (blkid_probe_set_magic(pr, off,
 			sizeof(ddf->signature),
 			(unsigned char *) &ddf->signature))
-		return -1;
+		return 1;
 	return 0;
 }
 
diff --git a/libblkid/src/superblocks/drbd.c b/libblkid/src/superblocks/drbd.c
index 43e544e..e88e9f3 100644
--- a/libblkid/src/superblocks/drbd.c
+++ b/libblkid/src/superblocks/drbd.c
@@ -75,18 +75,18 @@ static int probe_drbd(blkid_probe pr,
 
 	/* Small devices cannot be drbd (?) */
 	if (pr->size < 0x10000)
-		return -1;
+		return 1;
 
 	md = (struct md_on_disk_08 *)
 			blkid_probe_get_buffer(pr,
 					off,
 					sizeof(struct md_on_disk_08));
 	if (!md)
-		return -1;
+		return errno ? -errno : 1;
 
 	if (be32_to_cpu(md->magic) != DRBD_MD_MAGIC_08 &&
 			be32_to_cpu(md->magic) != DRBD_MD_MAGIC_84_UNCLEAN)
-		return -1;
+		return 1;
 
 	/*
 	 * DRBD does not have "real" uuids; the following resembles DRBD's
@@ -102,7 +102,7 @@ static int probe_drbd(blkid_probe pr,
 				off + offsetof(struct md_on_disk_08, magic),
 				sizeof(md->magic),
 				(unsigned char *) &md->magic))
-		return -1;
+		return 1;
 
 	return 0;
 }
diff --git a/libblkid/src/superblocks/drbdproxy_datalog.c b/libblkid/src/superblocks/drbdproxy_datalog.c
index afe4725..af59722 100644
--- a/libblkid/src/superblocks/drbdproxy_datalog.c
+++ b/libblkid/src/superblocks/drbdproxy_datalog.c
@@ -33,7 +33,7 @@ static int probe_drbdproxy_datalog(blkid_probe pr,
 
 	lh = (struct log_header_t *) blkid_probe_get_buffer(pr, 0, sizeof(*lh));
 	if (!lh)
-		return -1;
+		return errno ? -errno : 1;
 
 	blkid_probe_set_uuid(pr, lh->uuid);
 	blkid_probe_sprintf_version(pr, "v%jd", le64_to_cpu(lh->version));
diff --git a/libblkid/src/superblocks/exfat.c b/libblkid/src/superblocks/exfat.c
index 215c671..ed313c2 100644
--- a/libblkid/src/superblocks/exfat.c
+++ b/libblkid/src/superblocks/exfat.c
@@ -115,12 +115,14 @@ static int probe_exfat(blkid_probe pr, const struct blkid_idmag *mag)
 
 	sb = blkid_probe_get_sb(pr, mag, struct exfat_super_block);
 	if (!sb)
-		return -1;
+		return errno ? -errno : 1;
 
 	label = find_label(pr, sb);
 	if (label)
 		blkid_probe_set_utf8label(pr, label->name,
 				min(label->length * 2, 30), BLKID_ENC_UTF16LE);
+	else if (errno)
+		return -1;
 
 	blkid_probe_sprintf_uuid(pr, sb->volume_serial, 4,
 			"%02hhX%02hhX-%02hhX%02hhX",
diff --git a/libblkid/src/superblocks/ext.c b/libblkid/src/superblocks/ext.c
index 6f6d8a6..1de6022 100644
--- a/libblkid/src/superblocks/ext.c
+++ b/libblkid/src/superblocks/ext.c
@@ -198,9 +198,9 @@ static int probe_jbd(blkid_probe pr,
 
 	es = ext_get_super(pr, NULL, &fi, NULL);
 	if (!es)
-		return -BLKID_ERR_PARAM;
+		return errno ? -errno : 1;
 	if (!(fi & EXT3_FEATURE_INCOMPAT_JOURNAL_DEV))
-		return -BLKID_ERR_PARAM;
+		return 1;
 
 	ext_get_info(pr, 2, es);
 	blkid_probe_set_uuid_as(pr, es->s_uuid, "LOGUUID");
@@ -216,16 +216,16 @@ static int probe_ext2(blkid_probe pr,
 
 	es = ext_get_super(pr, &fc, &fi, &frc);
 	if (!es)
-		return -BLKID_ERR_PARAM;
+		return errno ? -errno : 1;
 
 	/* Distinguish between ext3 and ext2 */
 	if (fc & EXT3_FEATURE_COMPAT_HAS_JOURNAL)
-		return -BLKID_ERR_PARAM;
+		return 1;
 
 	/* Any features which ext2 doesn't understand */
 	if ((frc & EXT2_FEATURE_RO_COMPAT_UNSUPPORTED) ||
 	    (fi  & EXT2_FEATURE_INCOMPAT_UNSUPPORTED))
-		return -BLKID_ERR_PARAM;
+		return 1;
 
 	ext_get_info(pr, 2, es);
 	return 0;
@@ -239,16 +239,16 @@ static int probe_ext3(blkid_probe pr,
 
 	es = ext_get_super(pr, &fc, &fi, &frc);
 	if (!es)
-		return -BLKID_ERR_PARAM;
+		return errno ? -errno : 1;
 
 	/* ext3 requires journal */
 	if (!(fc & EXT3_FEATURE_COMPAT_HAS_JOURNAL))
-		return -BLKID_ERR_PARAM;
+		return 1;
 
 	/* Any features which ext3 doesn't understand */
 	if ((frc & EXT3_FEATURE_RO_COMPAT_UNSUPPORTED) ||
 	    (fi  & EXT3_FEATURE_INCOMPAT_UNSUPPORTED))
-		return -BLKID_ERR_PARAM;
+		return 1;
 
 	ext_get_info(pr, 3, es);
 	return 0;
@@ -263,14 +263,14 @@ static int probe_ext4dev(blkid_probe pr,
 
 	es = ext_get_super(pr, &fc, &fi, &frc);
 	if (!es)
-		return -BLKID_ERR_PARAM;
+		return errno ? -errno : 1;
 
 	/* Distinguish from jbd */
 	if (fi & EXT3_FEATURE_INCOMPAT_JOURNAL_DEV)
-		return -BLKID_ERR_PARAM;
+		return 1;
 
 	if (!(le32_to_cpu(es->s_flags) & EXT2_FLAGS_TEST_FILESYS))
-		return -BLKID_ERR_PARAM;
+		return 1;
 
 	ext_get_info(pr, 4, es);
 	return 0;
@@ -284,16 +284,16 @@ static int probe_ext4(blkid_probe pr,
 
 	es = ext_get_super(pr, &fc, &fi, &frc);
 	if (!es)
-		return -1;
+		return errno ? -errno : 1;
 
 	/* Distinguish from jbd */
 	if (fi & EXT3_FEATURE_INCOMPAT_JOURNAL_DEV)
-		return -BLKID_ERR_PARAM;
+		return 1;
 
 	/* Ext4 has at least one feature which ext3 doesn't understand */
 	if (!(frc & EXT3_FEATURE_RO_COMPAT_UNSUPPORTED) &&
 	    !(fi  & EXT3_FEATURE_INCOMPAT_UNSUPPORTED))
-		return -BLKID_ERR_PARAM;
+		return 1;
 
 	/*
 	 * If the filesystem is a OK for use by in-development
@@ -306,7 +306,7 @@ static int probe_ext4(blkid_probe pr,
 	 * ext4dev.
 	 */
 	if (le32_to_cpu(es->s_flags) & EXT2_FLAGS_TEST_FILESYS)
-		return -BLKID_ERR_PARAM;
+		return 1;
 
 	ext_get_info(pr, 4, es);
 	return 0;
diff --git a/libblkid/src/superblocks/f2fs.c b/libblkid/src/superblocks/f2fs.c
index 1543a7a..2bf0f5e 100644
--- a/libblkid/src/superblocks/f2fs.c
+++ b/libblkid/src/superblocks/f2fs.c
@@ -62,7 +62,7 @@ static int probe_f2fs(blkid_probe pr, const struct blkid_idmag *mag)
 
 	sb = blkid_probe_get_sb(pr, mag, struct f2fs_super_block);
 	if (!sb)
-		return -1;
+		return errno ? -errno : 1;
 
 	major = le16_to_cpu(sb->major_ver);
 	minor = le16_to_cpu(sb->minor_ver);
diff --git a/libblkid/src/superblocks/gfs.c b/libblkid/src/superblocks/gfs.c
index b2c0163..1b26558 100644
--- a/libblkid/src/superblocks/gfs.c
+++ b/libblkid/src/superblocks/gfs.c
@@ -64,7 +64,7 @@ static int probe_gfs(blkid_probe pr, const struct blkid_idmag *mag)
 
 	sbd = blkid_probe_get_sb(pr, mag, struct gfs2_sb);
 	if (!sbd)
-		return -1;
+		return errno ? -errno : 1;
 
 	if (be32_to_cpu(sbd->sb_fs_format) == GFS_FORMAT_FS &&
 	    be32_to_cpu(sbd->sb_multihost_format) == GFS_FORMAT_MULTI)
@@ -78,7 +78,7 @@ static int probe_gfs(blkid_probe pr, const struct blkid_idmag *mag)
 		return 0;
 	}
 
-	return -1;
+	return 1;
 }
 
 static int probe_gfs2(blkid_probe pr, const struct blkid_idmag *mag)
@@ -87,7 +87,7 @@ static int probe_gfs2(blkid_probe pr, const struct blkid_idmag *mag)
 
 	sbd = blkid_probe_get_sb(pr, mag, struct gfs2_sb);
 	if (!sbd)
-		return -1;
+		return errno ? -errno : 1;
 
 	if (be32_to_cpu(sbd->sb_fs_format) == GFS2_FORMAT_FS &&
 	    be32_to_cpu(sbd->sb_multihost_format) == GFS2_FORMAT_MULTI)
@@ -100,7 +100,7 @@ static int probe_gfs2(blkid_probe pr, const struct blkid_idmag *mag)
 		blkid_probe_set_version(pr, "1");
 		return 0;
 	}
-	return -1;
+	return 1;
 }
 
 const struct blkid_idinfo gfs_idinfo =
diff --git a/libblkid/src/superblocks/hfs.c b/libblkid/src/superblocks/hfs.c
index 6d960e9..fe57241 100644
--- a/libblkid/src/superblocks/hfs.c
+++ b/libblkid/src/superblocks/hfs.c
@@ -154,7 +154,7 @@ static int probe_hfs(blkid_probe pr, const struct blkid_idmag *mag)
 
 	hfs = blkid_probe_get_sb(pr, mag, struct hfs_mdb);
 	if (!hfs)
-		return -1;
+		return errno ? -errno : 1;
 
 	if ((memcmp(hfs->embed_sig, "H+", 2) == 0) ||
 	    (memcmp(hfs->embed_sig, "HX", 2) == 0))
@@ -193,7 +193,7 @@ static int probe_hfsplus(blkid_probe pr, const struct blkid_idmag *mag)
 
 	sbd = blkid_probe_get_sb(pr, mag, struct hfs_mdb);
 	if (!sbd)
-		return -1;
+		return errno ? -errno : 1;
 
 	/* Check for a HFS+ volume embedded in a HFS volume */
 	if (memcmp(sbd->signature, "BD", 2) == 0) {
@@ -218,7 +218,7 @@ static int probe_hfsplus(blkid_probe pr, const struct blkid_idmag *mag)
 				struct hfsplus_vol_header);
 
 	if (!hfsplus)
-		return -1;
+		return errno ? -errno : 1;
 
 	if ((memcmp(hfsplus->signature, "H+", 2) != 0) &&
 	    (memcmp(hfsplus->signature, "HX", 2) != 0))
@@ -228,7 +228,7 @@ static int probe_hfsplus(blkid_probe pr, const struct blkid_idmag *mag)
 
 	blocksize = be32_to_cpu(hfsplus->blocksize);
 	if (blocksize < HFSPLUS_SECTOR_SIZE)
-		return -1;
+		return 1;
 
 	memcpy(extents, hfsplus->cat_file.extents, sizeof(extents));
 	cat_block = be32_to_cpu(extents[0].start_block);
@@ -236,7 +236,7 @@ static int probe_hfsplus(blkid_probe pr, const struct blkid_idmag *mag)
 	buf = blkid_probe_get_buffer(pr,
 			off + ((blkid_loff_t) cat_block * blocksize), 0x2000);
 	if (!buf)
-		return 0;
+		return errno ? -errno : 0;
 
 	bnode = (struct hfsplus_bheader_record *)
 		&buf[sizeof(struct hfsplus_bnode_descriptor)];
@@ -271,7 +271,7 @@ static int probe_hfsplus(blkid_probe pr, const struct blkid_idmag *mag)
 				(blkid_loff_t) off + leaf_off,
 				leaf_node_size);
 	if (!buf)
-		return 0;
+		return errno ? -errno : 0;
 
 	descr = (struct hfsplus_bnode_descriptor *) buf;
 	record_count = be16_to_cpu(descr->num_recs);
diff --git a/libblkid/src/superblocks/highpoint_raid.c b/libblkid/src/superblocks/highpoint_raid.c
index 0b41344..ad3b538 100644
--- a/libblkid/src/superblocks/highpoint_raid.c
+++ b/libblkid/src/superblocks/highpoint_raid.c
@@ -30,9 +30,9 @@ static int probe_highpoint45x(blkid_probe pr,
 	uint32_t magic;
 
 	if (pr->size < 0x10000)
-		return -1;
+		return 1;
 	if (!S_ISREG(pr->mode) && !blkid_probe_is_wholedisk(pr))
-		return -1;
+		return 1;
 
 	off = ((pr->size / 0x200) - 11) * 0x200;
 	hpt = (struct hpt45x_metadata *)
@@ -40,13 +40,13 @@ static int probe_highpoint45x(blkid_probe pr,
 					off,
 					sizeof(struct hpt45x_metadata));
 	if (!hpt)
-		return -1;
+		return errno ? -errno : 1;
 	magic = le32_to_cpu(hpt->magic);
 	if (magic != HPT45X_MAGIC_OK && magic != HPT45X_MAGIC_BAD)
-		return -1;
+		return 1;
 	if (blkid_probe_set_magic(pr, off, sizeof(hpt->magic),
 				(unsigned char *) &hpt->magic))
-		return -1;
+		return 1;
 	return 0;
 }
 
@@ -54,7 +54,7 @@ static int probe_highpoint37x(blkid_probe pr,
 		const struct blkid_idmag *mag __attribute__((__unused__)))
 {
 	if (!S_ISREG(pr->mode) && !blkid_probe_is_wholedisk(pr))
-		return -1;
+		return 1;
 	return 0;
 }
 
diff --git a/libblkid/src/superblocks/hpfs.c b/libblkid/src/superblocks/hpfs.c
index f9b851a..0565d37 100644
--- a/libblkid/src/superblocks/hpfs.c
+++ b/libblkid/src/superblocks/hpfs.c
@@ -68,7 +68,7 @@ static int probe_hpfs(blkid_probe pr, const struct blkid_idmag *mag)
 	/* super block */
 	hs = blkid_probe_get_sb(pr, mag, struct hpfs_super_block);
 	if (!hs)
-		return -1;
+		return errno ? -errno : 1;
 	version = hs->version;
 
 	/* spare super block */
@@ -77,9 +77,9 @@ static int probe_hpfs(blkid_probe pr, const struct blkid_idmag *mag)
 				HPFS_SBSPARE_OFFSET,
 				sizeof(struct hpfs_spare_super));
 	if (!hss)
-		return -1;
+		return errno ? -errno : 1;
 	if (memcmp(hss->magic, "\x49\x18\x91\xf9", 4) != 0)
-		return -1;
+		return 1;
 
 	/* boot block (with UUID and LABEL) */
 	hbb = (struct hpfs_boot_block *)
@@ -87,7 +87,7 @@ static int probe_hpfs(blkid_probe pr, const struct blkid_idmag *mag)
 				0,
 				sizeof(struct hpfs_boot_block));
 	if (!hbb)
-		return -1;
+		return errno ? -errno : 1;
 	if (memcmp(hbb->magic, "\x55\xaa", 2) == 0 &&
 	    memcmp(hbb->sig_hpfs, "HPFS", 4) == 0 &&
 	    hbb->sig_28h == 0x28) {
diff --git a/libblkid/src/superblocks/iso9660.c b/libblkid/src/superblocks/iso9660.c
index 148587b..d099467 100644
--- a/libblkid/src/superblocks/iso9660.c
+++ b/libblkid/src/superblocks/iso9660.c
@@ -100,7 +100,7 @@ static int probe_iso9660_hsfs(blkid_probe pr, const struct blkid_idmag *mag)
 
 	iso = blkid_probe_get_sb(pr, mag, struct high_sierra_volume_descriptor);
 	if (!iso)
-		return -1;
+		return errno ? -errno : 1;
 
 	blkid_probe_set_version(pr, "High Sierra");
 	blkid_probe_set_label(pr, iso->volume_id, sizeof(iso->volume_id));
@@ -178,7 +178,7 @@ int probe_iso9660(blkid_probe pr, const struct blkid_idmag *mag)
 
 	iso = blkid_probe_get_sb(pr, mag, struct iso_volume_descriptor);
 	if (!iso)
-		return -1;
+		return errno ? -errno : 1;
 
 	memcpy(label, iso->volume_id, sizeof(label));
 
diff --git a/libblkid/src/superblocks/isw_raid.c b/libblkid/src/superblocks/isw_raid.c
index 755c1b6..065c2b2 100644
--- a/libblkid/src/superblocks/isw_raid.c
+++ b/libblkid/src/superblocks/isw_raid.c
@@ -33,9 +33,9 @@ static int probe_iswraid(blkid_probe pr,
 	struct isw_metadata *isw;
 
 	if (pr->size < 0x10000)
-		return -1;
+		return 1;
 	if (!S_ISREG(pr->mode) && !blkid_probe_is_wholedisk(pr))
-		return -1;
+		return 1;
 
 	off = ((pr->size / 0x200) - 2) * 0x200;
 	isw = (struct isw_metadata *)
@@ -43,15 +43,16 @@ static int probe_iswraid(blkid_probe pr,
 					off,
 					sizeof(struct isw_metadata));
 	if (!isw)
-		return -1;
+		return errno ? -errno : 1;
+
 	if (memcmp(isw->sig, ISW_SIGNATURE, sizeof(ISW_SIGNATURE)-1) != 0)
-		return -1;
+		return 1;
 	if (blkid_probe_sprintf_version(pr, "%6s",
 			&isw->sig[sizeof(ISW_SIGNATURE)-1]) != 0)
-		return -1;
+		return 1;
 	if (blkid_probe_set_magic(pr, off, sizeof(isw->sig),
 				(unsigned char *) isw->sig))
-		return -1;
+		return 1;
 	return 0;
 }
 
diff --git a/libblkid/src/superblocks/jfs.c b/libblkid/src/superblocks/jfs.c
index 78c018c..ac684d8 100644
--- a/libblkid/src/superblocks/jfs.c
+++ b/libblkid/src/superblocks/jfs.c
@@ -40,7 +40,7 @@ static int probe_jfs(blkid_probe pr, const struct blkid_idmag *mag)
 
 	js = blkid_probe_get_sb(pr, mag, struct jfs_super_block);
 	if (!js)
-		return -1;
+		return errno ? -errno : 1;
 	if (le32_to_cpu(js->js_bsize) != (1U << le16_to_cpu(js->js_l2bsize)))
 		return 1;
 	if (le32_to_cpu(js->js_pbsize) != (1U << le16_to_cpu(js->js_l2pbsize)))
diff --git a/libblkid/src/superblocks/jmicron_raid.c b/libblkid/src/superblocks/jmicron_raid.c
index c708078..ca79867 100644
--- a/libblkid/src/superblocks/jmicron_raid.c
+++ b/libblkid/src/superblocks/jmicron_raid.c
@@ -32,9 +32,9 @@ static int probe_jmraid(blkid_probe pr,
 	struct jm_metadata *jm;
 
 	if (pr->size < 0x10000)
-		return -1;
+		return 1;
 	if (!S_ISREG(pr->mode) && !blkid_probe_is_wholedisk(pr))
-		return -1;
+		return 1;
 
 	off = ((pr->size / 0x200) - 1) * 0x200;
 	jm = (struct jm_metadata *)
@@ -42,15 +42,16 @@ static int probe_jmraid(blkid_probe pr,
 				off,
 				sizeof(struct jm_metadata));
 	if (!jm)
-		return -1;
+		return errno ? -errno : 1;
+
 	if (memcmp(jm->signature, JM_SIGNATURE, sizeof(JM_SIGNATURE) - 1) != 0)
-		return -1;
+		return 1;
 	if (blkid_probe_sprintf_version(pr, "%u.%u",
 				jm->major_version, jm->minor_version) != 0)
-		return -1;
+		return 1;
 	if (blkid_probe_set_magic(pr, off, sizeof(jm->signature),
 				(unsigned char *) jm->signature))
-		return -1;
+		return 1;
 	return 0;
 }
 
diff --git a/libblkid/src/superblocks/linux_raid.c b/libblkid/src/superblocks/linux_raid.c
index a3f9d67..ca5b99e 100644
--- a/libblkid/src/superblocks/linux_raid.c
+++ b/libblkid/src/superblocks/linux_raid.c
@@ -110,13 +110,13 @@ static int probe_raid0(blkid_probe pr, blkid_loff_t off)
 	uint64_t size;
 
 	if (pr->size < MD_RESERVED_BYTES)
-		return -1;
+		return 1;
 	mdp0 = (struct mdp0_super_block *)
 			blkid_probe_get_buffer(pr,
 				off,
 				sizeof(struct mdp0_super_block));
 	if (!mdp0)
-		return -1;
+		return errno ? -errno : 1;
 
 	memset(uuid.ints, 0, sizeof(uuid.ints));
 
@@ -173,12 +173,12 @@ static int probe_raid0(blkid_probe pr, blkid_loff_t off)
 	}
 
 	if (blkid_probe_sprintf_version(pr, "%u.%u.%u", ma, mi, pa) != 0)
-		return -1;
+		return 1;
 	if (blkid_probe_set_uuid(pr, (unsigned char *) uuid.bytes) != 0)
-		return -1;
+		return 1;
 	if (blkid_probe_set_magic(pr, off, sizeof(mdp0->md_magic),
 				(unsigned char *) &mdp0->md_magic))
-		return -1;
+		return 1;
 	return 0;
 }
 
@@ -191,24 +191,24 @@ static int probe_raid1(blkid_probe pr, off_t off)
 				off,
 				sizeof(struct mdp1_super_block));
 	if (!mdp1)
-		return -1;
+		return errno ? -errno : 1;
 	if (le32_to_cpu(mdp1->magic) != MD_SB_MAGIC)
-		return -1;
+		return 1;
 	if (le32_to_cpu(mdp1->major_version) != 1U)
-		return -1;
+		return 1;
 	if (le64_to_cpu(mdp1->super_offset) != (uint64_t) off >> 9)
-		return -1;
+		return 1;
 	if (blkid_probe_set_uuid(pr, (unsigned char *) mdp1->set_uuid) != 0)
-		return -1;
+		return 1;
 	if (blkid_probe_set_uuid_as(pr,
 			(unsigned char *) mdp1->device_uuid, "UUID_SUB") != 0)
-		return -1;
+		return 1;
 	if (blkid_probe_set_label(pr, mdp1->set_name,
 				sizeof(mdp1->set_name)) != 0)
-		return -1;
+		return 1;
 	if (blkid_probe_set_magic(pr, off, sizeof(mdp1->magic),
 				(unsigned char *) &mdp1->magic))
-		return -1;
+		return 1;
 	return 0;
 }
 
@@ -216,23 +216,31 @@ int probe_raid(blkid_probe pr,
 		const struct blkid_idmag *mag __attribute__((__unused__)))
 {
 	const char *ver = NULL;
+	int ret;
 
 	if (pr->size > MD_RESERVED_BYTES) {
 		/* version 0 at the end of the device */
 		uint64_t sboff = (pr->size & ~(MD_RESERVED_BYTES - 1))
-			         - MD_RESERVED_BYTES;
-		if (probe_raid0(pr, sboff) == 0)
-			return 0;
+			- MD_RESERVED_BYTES;
+		ret = probe_raid0(pr, sboff);
+		if (ret < 1)
+			return ret;
 
 		/* version 1.0 at the end of the device */
 		sboff = (pr->size & ~(0x1000 - 1)) - 0x2000;
-		if (probe_raid1(pr, sboff) == 0)
+		ret = probe_raid1(pr, sboff);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
 			ver = "1.0";
 	}
 
 	if (!ver) {
 		/* version 1.1 at the start of the device */
-		if (probe_raid1(pr, 0) == 0)
+		ret = probe_raid1(pr, 0);
+		if (ret < 0)
+			return ret;
+		if (ret == 0)
 			ver = "1.1";
 
 		/* version 1.2 at 4k offset from the start */
@@ -244,7 +252,7 @@ int probe_raid(blkid_probe pr,
 		blkid_probe_set_version(pr, ver);
 		return 0;
 	}
-	return -1;
+	return 1;
 }
 
 
diff --git a/libblkid/src/superblocks/lsi_raid.c b/libblkid/src/superblocks/lsi_raid.c
index 56721dd..697b0fe 100644
--- a/libblkid/src/superblocks/lsi_raid.c
+++ b/libblkid/src/superblocks/lsi_raid.c
@@ -30,9 +30,9 @@ static int probe_lsiraid(blkid_probe pr,
 	struct lsi_metadata *lsi;
 
 	if (pr->size < 0x10000)
-		return -1;
+		return 1;
 	if (!S_ISREG(pr->mode) && !blkid_probe_is_wholedisk(pr))
-		return -1;
+		return 1;
 
 	off = ((pr->size / 0x200) - 1) * 0x200;
 	lsi = (struct lsi_metadata *)
@@ -40,13 +40,13 @@ static int probe_lsiraid(blkid_probe pr,
 				off,
 				sizeof(struct lsi_metadata));
 	if (!lsi)
-		return -1;
+		return errno ? -errno : 1;
 
 	if (memcmp(lsi->sig, LSI_SIGNATURE, sizeof(LSI_SIGNATURE)-1) != 0)
-		return -1;
+		return 1;
 	if (blkid_probe_set_magic(pr, off, sizeof(lsi->sig),
 				(unsigned char *) lsi->sig))
-		return -1;
+		return 1;
 	return 0;
 }
 
diff --git a/libblkid/src/superblocks/luks.c b/libblkid/src/superblocks/luks.c
index f716e31..00696f2 100644
--- a/libblkid/src/superblocks/luks.c
+++ b/libblkid/src/superblocks/luks.c
@@ -45,7 +45,7 @@ static int probe_luks(blkid_probe pr, const struct blkid_idmag *mag)
 
 	header = blkid_probe_get_sb(pr, mag, struct luks_phdr);
 	if (header == NULL)
-		return -1;
+		return errno ? -errno : 1;
 
 	blkid_probe_strncpy_uuid(pr, (unsigned char *) header->uuid,
 			sizeof(header->uuid));
diff --git a/libblkid/src/superblocks/lvm.c b/libblkid/src/superblocks/lvm.c
index 65c7c35..3c6df74 100644
--- a/libblkid/src/superblocks/lvm.c
+++ b/libblkid/src/superblocks/lvm.c
@@ -82,7 +82,7 @@ static int probe_lvm2(blkid_probe pr, const struct blkid_idmag *mag)
 			mag->kboff << 10,
 			512 + sizeof(struct lvm2_pv_label_header));
 	if (!buf)
-		return -1;
+		return errno ? -errno : 1;
 
 	/* buf is at 0k or 1k offset; find label inside */
 	if (memcmp(buf, "LABELONE", 8) == 0) {
@@ -128,7 +128,7 @@ static int probe_lvm1(blkid_probe pr, const struct blkid_idmag *mag)
 
 	label = blkid_probe_get_sb(pr, mag, struct lvm1_pv_label_header);
 	if (!label)
-		return -1;
+		return errno ? -errno : 1;
 
 	version = le16_to_cpu(label->version);
 	if (version != 1 && version != 2)
@@ -163,7 +163,7 @@ static int probe_verity(blkid_probe pr, const struct blkid_idmag *mag)
 
 	sb = blkid_probe_get_sb(pr, mag, struct verity_sb);
 	if (sb == NULL)
-		return -1;
+		return errno ? -errno : 1;
 
 	version = le32_to_cpu(sb->version);
 	if (version != 1)
diff --git a/libblkid/src/superblocks/minix.c b/libblkid/src/superblocks/minix.c
index 0e7cd93..3e80e5b 100644
--- a/libblkid/src/superblocks/minix.c
+++ b/libblkid/src/superblocks/minix.c
@@ -80,17 +80,17 @@ static int probe_minix(blkid_probe pr, const struct blkid_idmag *mag)
 			max(sizeof(struct minix_super_block),
 			    sizeof(struct minix3_super_block)));
 	if (!data)
-		return -1;
+		return errno ? -errno : 1;
 	version = get_minix_version(data, &swabme);
 	if (version < 1)
-		return -1;
+		return 1;
 
 	if (version <= 2) {
 		struct minix_super_block *sb = (struct minix_super_block *) data;
 		int zones, ninodes, imaps, zmaps, firstz;
 
 		if (sb->s_imap_blocks == 0 || sb->s_zmap_blocks == 0)
-			return -1;
+			return 1;
 
 		zones = version == 2 ? minix_swab32(swabme, sb->s_zones) :
 				       minix_swab16(swabme, sb->s_nzones);
@@ -101,15 +101,15 @@ static int probe_minix(blkid_probe pr, const struct blkid_idmag *mag)
 
 		/* sanity checks to be sure that the FS is really minix */
 		if (imaps * MINIX_BLOCK_SIZE * 8 < ninodes + 1)
-			return -1;
+			return 1;
 		if (zmaps * MINIX_BLOCK_SIZE * 8 < zones - firstz + 1)
-			return -1;
+			return 1;
 
 	} else if (version == 3) {
 		struct minix3_super_block *sb = (struct minix3_super_block *) data;
 
 		if (sb->s_imap_blocks == 0 || sb->s_zmap_blocks == 0)
-			return -1;
+			return 1;
 	}
 
 	/* unfortunately, some parts of ext3 is sometimes possible to
@@ -117,8 +117,10 @@ static int probe_minix(blkid_probe pr, const struct blkid_idmag *mag)
 	 * string. (For extN magic string and offsets see ext.c.)
 	 */
 	ext = blkid_probe_get_buffer(pr, 0x400 + 0x38, 2);
-	if (ext && memcmp(ext, "\123\357", 2) == 0)
-		return -1;
+	if (!ext)
+		return errno ? -errno : 1;
+	else if (memcmp(ext, "\123\357", 2) == 0)
+		return 1;
 
 	blkid_probe_sprintf_version(pr, "%d", version);
 	return 0;
diff --git a/libblkid/src/superblocks/netware.c b/libblkid/src/superblocks/netware.c
index 7ef2162..af81cf5 100644
--- a/libblkid/src/superblocks/netware.c
+++ b/libblkid/src/superblocks/netware.c
@@ -71,7 +71,7 @@ static int probe_netware(blkid_probe pr, const struct blkid_idmag *mag)
 
 	nw = blkid_probe_get_sb(pr, mag, struct netware_super_block);
 	if (!nw)
-		return -1;
+		return errno ? -errno : 1;
 
 	blkid_probe_set_uuid(pr, nw->SBH_PoolID);
 
diff --git a/libblkid/src/superblocks/nilfs.c b/libblkid/src/superblocks/nilfs.c
index 24ccf63..894dadf 100644
--- a/libblkid/src/superblocks/nilfs.c
+++ b/libblkid/src/superblocks/nilfs.c
@@ -93,12 +93,12 @@ static int probe_nilfs2(blkid_probe pr, const struct blkid_idmag *mag)
 	sbp = (struct nilfs_super_block *) blkid_probe_get_buffer(
 			pr, NILFS_SB_OFFSET, sizeof(struct nilfs_super_block));
 	if (!sbp)
-		return -1;
+		return errno ? -errno : 1;
 	/* backup */
 	sbb = (struct nilfs_super_block *) blkid_probe_get_buffer(
 			pr, ((pr->size / 0x200) - 8) * 0x200, sizeof(struct nilfs_super_block));
 	if (!sbp)
-		return -1;
+		return errno ? -errno : 1;
 
 	/*
 	 * Compare two super blocks and set 1 in swp if the secondary
diff --git a/libblkid/src/superblocks/ntfs.c b/libblkid/src/superblocks/ntfs.c
index d767cb4..41eab26 100644
--- a/libblkid/src/superblocks/ntfs.c
+++ b/libblkid/src/superblocks/ntfs.c
@@ -91,7 +91,7 @@ static int probe_ntfs(blkid_probe pr, const struct blkid_idmag *mag)
 
 	ns = blkid_probe_get_sb(pr, mag, struct ntfs_super_block);
 	if (!ns)
-		return -1;
+		return errno ? -errno : 1;
 
 	/*
 	 * Check bios parameters block
@@ -158,7 +158,7 @@ static int probe_ntfs(blkid_probe pr, const struct blkid_idmag *mag)
 
 	buf_mft = blkid_probe_get_buffer(pr, off, mft_record_size);
 	if (!buf_mft)
-		return 1;
+		return errno ? -errno : 1;
 
 	if (memcmp(buf_mft, "FILE", 4))
 		return 1;
@@ -167,7 +167,7 @@ static int probe_ntfs(blkid_probe pr, const struct blkid_idmag *mag)
 
 	buf_mft = blkid_probe_get_buffer(pr, off, mft_record_size);
 	if (!buf_mft)
-		return 1;
+		return errno ? -errno : 1;
 
 	if (memcmp(buf_mft, "FILE", 4))
 		return 1;
diff --git a/libblkid/src/superblocks/nvidia_raid.c b/libblkid/src/superblocks/nvidia_raid.c
index dd86cdc..5db8ec2 100644
--- a/libblkid/src/superblocks/nvidia_raid.c
+++ b/libblkid/src/superblocks/nvidia_raid.c
@@ -32,9 +32,9 @@ static int probe_nvraid(blkid_probe pr,
 	struct nv_metadata *nv;
 
 	if (pr->size < 0x10000)
-		return -1;
+		return 1;
 	if (!S_ISREG(pr->mode) && !blkid_probe_is_wholedisk(pr))
-		return -1;
+		return 1;
 
 	off = ((pr->size / 0x200) - 2) * 0x200;
 	nv = (struct nv_metadata *)
@@ -42,15 +42,15 @@ static int probe_nvraid(blkid_probe pr,
 				off,
 				sizeof(struct nv_metadata));
 	if (!nv)
-		return -1;
+		return errno ? -errno : 1;
 
 	if (memcmp(nv->vendor, NVIDIA_SIGNATURE, sizeof(NVIDIA_SIGNATURE)-1) != 0)
-		return -1;
+		return 1;
 	if (blkid_probe_sprintf_version(pr, "%u", le16_to_cpu(nv->version)) != 0)
-		return -1;
+		return 1;
 	if (blkid_probe_set_magic(pr, off, sizeof(nv->vendor),
 				(unsigned char *) nv->vendor))
-		return -1;
+		return 1;
 	return 0;
 }
 
diff --git a/libblkid/src/superblocks/ocfs.c b/libblkid/src/superblocks/ocfs.c
index 82170ac..3fe199d 100644
--- a/libblkid/src/superblocks/ocfs.c
+++ b/libblkid/src/superblocks/ocfs.c
@@ -109,14 +109,14 @@ static int probe_ocfs(blkid_probe pr, const struct blkid_idmag *mag)
 	buf = blkid_probe_get_buffer(pr, mag->kboff << 10,
 			sizeof(struct ocfs_volume_header));
 	if (!buf)
-		return -1;
+		return errno ? -errno : 1;
 	memcpy(&ovh, buf, sizeof(ovh));
 
 	/* label */
 	buf = blkid_probe_get_buffer(pr, (mag->kboff << 10) + 512,
 			sizeof(struct ocfs_volume_label));
 	if (!buf)
-		return -1;
+		return errno ? -errno : 1;
 	memcpy(&ovl, buf, sizeof(ovl));
 
 	maj = ocfsmajor(ovh);
@@ -144,7 +144,7 @@ static int probe_ocfs2(blkid_probe pr, const struct blkid_idmag *mag)
 
 	osb = blkid_probe_get_sb(pr, mag, struct ocfs2_super_block);
 	if (!osb)
-		return -1;
+		return errno ? -errno : 1;
 
 	blkid_probe_set_label(pr, (unsigned char *) osb->s_label, sizeof(osb->s_label));
 	blkid_probe_set_uuid(pr, osb->s_uuid);
@@ -162,7 +162,7 @@ static int probe_oracleasm(blkid_probe pr, const struct blkid_idmag *mag)
 
 	dl = blkid_probe_get_sb(pr, mag, struct oracle_asm_disk_label);
 	if (!dl)
-		return -1;
+		return errno ? -errno : 1;
 
 	blkid_probe_set_label(pr, (unsigned char *) dl->dl_id, sizeof(dl->dl_id));
 	return 0;
diff --git a/libblkid/src/superblocks/promise_raid.c b/libblkid/src/superblocks/promise_raid.c
index 01e4e37..678460a 100644
--- a/libblkid/src/superblocks/promise_raid.c
+++ b/libblkid/src/superblocks/promise_raid.c
@@ -33,9 +33,9 @@ static int probe_pdcraid(blkid_probe pr,
 	};
 
 	if (pr->size < 0x40000)
-		return -1;
+		return 1;
 	if (!S_ISREG(pr->mode) && !blkid_probe_is_wholedisk(pr))
-		return -1;
+		return 1;
 
 	for (i = 0; sectors[i] != 0; i++) {
 		uint64_t off;
@@ -47,18 +47,18 @@ static int probe_pdcraid(blkid_probe pr,
 					off,
 					sizeof(struct promise_metadata));
 		if (!pdc)
-			return -1;
+			return errno ? -errno : 1;
 
 		if (memcmp(pdc->sig, PDC_SIGNATURE,
 				sizeof(PDC_SIGNATURE) - 1) == 0) {
 
 			if (blkid_probe_set_magic(pr, off, sizeof(pdc->sig),
 						(unsigned char *) pdc->sig))
-				return -1;
+				return 1;
 			return 0;
 		}
 	}
-	return -1;
+	return 1;
 }
 
 const struct blkid_idinfo pdcraid_idinfo = {
diff --git a/libblkid/src/superblocks/reiserfs.c b/libblkid/src/superblocks/reiserfs.c
index 152571f..edbaaa9 100644
--- a/libblkid/src/superblocks/reiserfs.c
+++ b/libblkid/src/superblocks/reiserfs.c
@@ -45,17 +45,17 @@ static int probe_reiser(blkid_probe pr, const struct blkid_idmag *mag)
 
 	rs = blkid_probe_get_sb(pr, mag, struct reiserfs_super_block);
 	if (!rs)
-		return -1;
+		return errno ? -errno : 1;
 
 	blocksize = le16_to_cpu(rs->rs_blocksize);
 
 	/* The blocksize must be at least 512B */
 	if ((blocksize >> 9) == 0)
-		return -BLKID_ERR_PARAM;
+		return 1;
 
 	/* If the superblock is inside the journal, we have the wrong one */
 	if (mag->kboff / (blocksize >> 9) > le32_to_cpu(rs->rs_journal_block) / 2)
-		return -BLKID_ERR_BIG;
+		return 1;
 
 	/* LABEL/UUID are only valid for later versions of Reiserfs v3.6. */
 	if (mag->magic[6] == '2' || mag->magic[6] == '3') {
@@ -82,7 +82,7 @@ static int probe_reiser4(blkid_probe pr, const struct blkid_idmag *mag)
 
 	rs4 = blkid_probe_get_sb(pr, mag, struct reiser4_super_block);
 	if (!rs4)
-		return -1;
+		return errno ? -errno : 1;
 
 	if (*rs4->rs4_label)
 		blkid_probe_set_label(pr, rs4->rs4_label, sizeof(rs4->rs4_label));
diff --git a/libblkid/src/superblocks/romfs.c b/libblkid/src/superblocks/romfs.c
index 91ef996..8e63c10 100644
--- a/libblkid/src/superblocks/romfs.c
+++ b/libblkid/src/superblocks/romfs.c
@@ -29,7 +29,7 @@ static int probe_romfs(blkid_probe pr, const struct blkid_idmag *mag)
 
 	ros = blkid_probe_get_sb(pr, mag, struct romfs_super_block);
 	if (!ros)
-		return -1;
+		return errno ? -errno : 1;
 
 	if (strlen((char *) ros->ros_volume))
 		blkid_probe_set_label(pr, ros->ros_volume,
diff --git a/libblkid/src/superblocks/silicon_raid.c b/libblkid/src/superblocks/silicon_raid.c
index 10a3023..edbefbc 100644
--- a/libblkid/src/superblocks/silicon_raid.c
+++ b/libblkid/src/superblocks/silicon_raid.c
@@ -88,9 +88,9 @@ static int probe_silraid(blkid_probe pr,
 	struct silicon_metadata *sil;
 
 	if (pr->size < 0x10000)
-		return -1;
+		return 1;
 	if (!S_ISREG(pr->mode) && !blkid_probe_is_wholedisk(pr))
-		return -1;
+		return 1;
 
 	off = ((pr->size / 0x200) - 1) * 0x200;
 
@@ -98,7 +98,7 @@ static int probe_silraid(blkid_probe pr,
 			blkid_probe_get_buffer(pr, off,
 				sizeof(struct silicon_metadata));
 	if (!sil)
-		return -1;
+		return errno ? -errno : 1;
 
 	if (le32_to_cpu(sil->magic) != SILICON_MAGIC)
 		return 1;
@@ -110,13 +110,13 @@ static int probe_silraid(blkid_probe pr,
 	if (blkid_probe_sprintf_version(pr, "%u.%u",
 				le16_to_cpu(sil->major_ver),
 				le16_to_cpu(sil->minor_ver)) != 0)
-		return -1;
+		return 1;
 
 	if (blkid_probe_set_magic(pr,
 			off + offsetof(struct silicon_metadata, magic),
 			sizeof(sil->magic),
 			(unsigned char *) &sil->magic))
-		return -1;
+		return 1;
 	return 0;
 }
 
diff --git a/libblkid/src/superblocks/squashfs.c b/libblkid/src/superblocks/squashfs.c
index 45f1029..595c8e2 100644
--- a/libblkid/src/superblocks/squashfs.c
+++ b/libblkid/src/superblocks/squashfs.c
@@ -34,7 +34,7 @@ static int probe_squashfs(blkid_probe pr, const struct blkid_idmag *mag)
 
 	sq = blkid_probe_get_sb(pr, mag, struct sqsh_super_block);
 	if (!sq)
-		return -1;
+		return errno ? -errno : 1;
 
 	if (strcmp(mag->magic, "sqsh") == 0 ||
 	    strcmp(mag->magic, "qshs") == 0)
diff --git a/libblkid/src/superblocks/swap.c b/libblkid/src/superblocks/swap.c
index 4297a9c..ee6d455 100644
--- a/libblkid/src/superblocks/swap.c
+++ b/libblkid/src/superblocks/swap.c
@@ -44,27 +44,27 @@ static int swap_set_info(blkid_probe pr, const char *version)
 	hdr = (struct swap_header_v1_2 *) blkid_probe_get_buffer(pr, 1024,
 				sizeof(struct swap_header_v1_2));
 	if (!hdr)
-		return -1;
+		return errno ? -errno : 1;
 
 	/* SWAPSPACE2 - check for wrong version or zeroed pagecount */
-        if (strcmp(version, "1") == 0) {
+	if (strcmp(version, "2") == 0) {
 		if (hdr->version != 1 && swab32(hdr->version) != 1) {
 			DBG(LOWPROBE, blkid_debug("incorrect swap version"));
-			return -1;
+			return 1;
 		}
 		if (hdr->lastpage == 0) {
 			DBG(LOWPROBE, blkid_debug("not set last swap page"));
-			return -1;
+			return 1;
 		}
-        }
+	}
 
 	/* arbitrary sanity check.. is there any garbage down there? */
 	if (hdr->padding[32] == 0 && hdr->padding[33] == 0) {
 		if (hdr->volume[0] && blkid_probe_set_label(pr, hdr->volume,
 				sizeof(hdr->volume)) < 0)
-			return -1;
+			return 1;
 		if (blkid_probe_set_uuid(pr, hdr->uuid) < 0)
-			return -1;
+			return 1;
 	}
 
 	blkid_probe_set_version(pr, version);
@@ -76,12 +76,12 @@ static int probe_swap(blkid_probe pr, const struct blkid_idmag *mag)
 	unsigned char *buf;
 
 	if (!mag)
-		return -1;
+		return 1;
 
 	/* TuxOnIce keeps valid swap header at the end of the 1st page */
 	buf = blkid_probe_get_buffer(pr, 0, TOI_MAGIC_STRLEN);
 	if (!buf)
-		return -1;
+		return errno ? -errno : 1;
 
 	if (memcmp(buf, TOI_MAGIC_STRING, TOI_MAGIC_STRLEN) == 0)
 		return 1;	/* Ignore swap signature, it's TuxOnIce */
@@ -94,13 +94,13 @@ static int probe_swap(blkid_probe pr, const struct blkid_idmag *mag)
 	} else if (!memcmp(mag->magic, "SWAPSPACE2", mag->len))
 		return swap_set_info(pr, "1");
 
-	return -1;
+	return 1;
 }
 
 static int probe_swsuspend(blkid_probe pr, const struct blkid_idmag *mag)
 {
 	if (!mag)
-		return -1;
+		return 1;
 	if (!memcmp(mag->magic, "S1SUSPEND", mag->len))
 		return swap_set_info(pr, "s1suspend");
 	if (!memcmp(mag->magic, "S2SUSPEND", mag->len))
@@ -112,7 +112,7 @@ static int probe_swsuspend(blkid_probe pr, const struct blkid_idmag *mag)
 	if (!memcmp(mag->magic, "LINHIB0001", mag->len))
 		return swap_set_info(pr, "linhib0001");
 
-	return -1;	/* no signature detected */
+	return 1;	/* no signature detected */
 }
 
 const struct blkid_idinfo swap_idinfo =
diff --git a/libblkid/src/superblocks/sysv.c b/libblkid/src/superblocks/sysv.c
index 80b0cc5..4b34591 100644
--- a/libblkid/src/superblocks/sysv.c
+++ b/libblkid/src/superblocks/sysv.c
@@ -80,7 +80,7 @@ static int probe_xenix(blkid_probe pr, const struct blkid_idmag *mag)
 
 	sb = blkid_probe_get_sb(pr, mag, struct xenix_super_block);
 	if (!sb)
-		return -1;
+		return errno ? -errno : 1;
 	blkid_probe_set_label(pr, sb->s_fname, sizeof(sb->s_fname));
 	return 0;
 }
@@ -105,21 +105,21 @@ static int probe_sysv(blkid_probe pr,
 					off,
 					sizeof(struct sysv_super_block));
 		if (!sb)
-			return -1;
+			return errno ? -errno : 1;
 
 		if (sb->s_magic == cpu_to_le32(0xfd187e20) ||
 		    sb->s_magic == cpu_to_be32(0xfd187e20)) {
 
 			if (blkid_probe_set_label(pr, sb->s_fname,
 						sizeof(sb->s_fname)))
-				return -1;
+				return 1;
 
 			if (blkid_probe_set_magic(pr,
 					off + offsetof(struct sysv_super_block,
 								s_magic),
 					sizeof(sb->s_magic),
 					(unsigned char *) &sb->s_magic))
-				return -1;
+				return 1;
 
 			return 0;
 		}
diff --git a/libblkid/src/superblocks/ubifs.c b/libblkid/src/superblocks/ubifs.c
index ef84f53..dc84260 100644
--- a/libblkid/src/superblocks/ubifs.c
+++ b/libblkid/src/superblocks/ubifs.c
@@ -99,7 +99,7 @@ static int probe_ubifs(blkid_probe pr, const struct blkid_idmag *mag)
 
 	sb = blkid_probe_get_sb(pr, mag, struct ubifs_sb_node);
 	if (!sb)
-		return -1;
+		return errno ? -errno : 1;
 
 	blkid_probe_set_uuid(pr, sb->uuid);
 	blkid_probe_sprintf_version(pr, "w%dr%d",
diff --git a/libblkid/src/superblocks/udf.c b/libblkid/src/superblocks/udf.c
index 8702dd0..5cde3cc 100644
--- a/libblkid/src/superblocks/udf.c
+++ b/libblkid/src/superblocks/udf.c
@@ -85,11 +85,11 @@ static int probe_udf(blkid_probe pr,
 					UDF_VSD_OFFSET + b,
 					sizeof(*vsd));
 		if (!vsd)
-			return 1;
+			return errno ? -errno : 1;
 		if (vsd->id[0] != '\0')
 			goto nsr;
 	}
-	return -1;
+	return 1;
 
 nsr:
 	/* search the list of VSDs for a NSR descriptor */
@@ -99,15 +99,15 @@ nsr:
 					UDF_VSD_OFFSET + ((blkid_loff_t) b * 0x800),
 					sizeof(*vsd));
 		if (!vsd)
-			return -1;
+			return errno ? -errno : 1;
 		if (vsd->id[0] == '\0')
-			return -1;
+			return 1;
 		if (memcmp(vsd->id, "NSR02", 5) == 0)
 			goto anchor;
 		if (memcmp(vsd->id, "NSR03", 5) == 0)
 			goto anchor;
 	}
-	return -1;
+	return 1;
 
 anchor:
 	/* read Anchor Volume Descriptor (AVDP), checking block size */
@@ -115,7 +115,7 @@ anchor:
 		vd = (struct volume_descriptor *)
 			blkid_probe_get_buffer(pr, 256 * pbs[i], sizeof(*vd));
 		if (!vd)
-			return -1;
+			return errno ? -errno : 1;
 
 		type = le16_to_cpu(vd->tag.id);
 		if (type == 2) /* TAG_ID_AVDP */
@@ -138,7 +138,7 @@ real_blksz:
 					(blkid_loff_t) (loc + b) * bs,
 					sizeof(*vd));
 		if (!vd)
-			return -1;
+			return errno ? -errno : 1;
 	}
 
 	/* Try extract all possible ISO9660 information -- if there is
@@ -155,7 +155,7 @@ real_blksz:
 					(blkid_loff_t) (loc + b) * bs,
 					sizeof(*vd));
 		if (!vd)
-			return -1;
+			return errno ? -errno : 1;
 		type = le16_to_cpu(vd->tag.id);
 		if (type == 0)
 			break;
diff --git a/libblkid/src/superblocks/ufs.c b/libblkid/src/superblocks/ufs.c
index 673a528..6ef2acd 100644
--- a/libblkid/src/superblocks/ufs.c
+++ b/libblkid/src/superblocks/ufs.c
@@ -185,7 +185,7 @@ static int probe_ufs(blkid_probe pr,
 					offsets[i] * 1024,
 					sizeof(struct ufs_super_block));
 		if (!ufs)
-			return -1;
+			return errno ? -errno : 1;
 
 		magBE = be32_to_cpu(ufs->fs_magic);
 		magLE = le32_to_cpu(ufs->fs_magic);
@@ -231,7 +231,7 @@ found:
 				offsetof(struct ufs_super_block, fs_magic),
 			sizeof(ufs->fs_magic),
 			(unsigned char *) &ufs->fs_magic))
-		return -1;
+		return 1;
 
 	return 0;
 }
diff --git a/libblkid/src/superblocks/vfat.c b/libblkid/src/superblocks/vfat.c
index 8ff241b..6d7cda9 100644
--- a/libblkid/src/superblocks/vfat.c
+++ b/libblkid/src/superblocks/vfat.c
@@ -261,10 +261,10 @@ int blkid_probe_is_vfat(blkid_probe pr)
 
 	ms = blkid_probe_get_sb(pr, mag, struct msdos_super_block);
 	if (!ms)
-		return 0;
+		return errno ? -errno : 0;
 	vs = blkid_probe_get_sb(pr, mag, struct vfat_super_block);
 	if (!vs)
-		return 0;
+		return errno ? -errno : 0;
 
 	return fat_valid_superblock(mag, ms, vs, NULL, NULL);
 }
@@ -283,10 +283,12 @@ static int probe_vfat(blkid_probe pr, const struct blkid_idmag *mag)
 
 	ms = blkid_probe_get_sb(pr, mag, struct msdos_super_block);
 	if (!ms)
-		return 0;
+		return errno ? -errno : 1;
+
 	vs = blkid_probe_get_sb(pr, mag, struct vfat_super_block);
 	if (!vs)
-		return 0;
+		return errno ? -errno : 1;
+
 	if (!fat_valid_superblock(mag, ms, vs, &cluster_count, &fat_size))
 		return 1;
 
@@ -376,16 +378,16 @@ static int probe_vfat(blkid_probe pr, const struct blkid_idmag *mag)
 					(blkid_loff_t) fsinfo_sect * sector_size,
 					sizeof(struct fat32_fsinfo));
 			if (buf == NULL)
-				return -1;
+				return errno ? -errno : 1;
 
 			fsinfo = (struct fat32_fsinfo *) buf;
 			if (memcmp(fsinfo->signature1, "\x52\x52\x61\x41", 4) != 0 &&
 			    memcmp(fsinfo->signature1, "\x52\x52\x64\x41", 4) != 0 &&
 			    memcmp(fsinfo->signature1, "\x00\x00\x00\x00", 4) != 0)
-				return -1;
+				return 1;
 			if (memcmp(fsinfo->signature2, "\x72\x72\x41\x61", 4) != 0 &&
 			    memcmp(fsinfo->signature2, "\x00\x00\x00\x00", 4) != 0)
-				return -1;
+				return 1;
 		}
 	}
 
diff --git a/libblkid/src/superblocks/via_raid.c b/libblkid/src/superblocks/via_raid.c
index 5c15167..ee3ab65 100644
--- a/libblkid/src/superblocks/via_raid.c
+++ b/libblkid/src/superblocks/via_raid.c
@@ -63,7 +63,7 @@ static int probe_viaraid(blkid_probe pr,
 				off,
 				sizeof(struct via_metadata));
 	if (!v)
-		return -1;
+		return errno ? -errno : 1;
 
 	if (le16_to_cpu(v->signature) != VIA_SIGNATURE)
 		return 1;
@@ -73,11 +73,11 @@ static int probe_viaraid(blkid_probe pr,
 		return 1;
 
 	if (blkid_probe_sprintf_version(pr, "%u", v->version_number) != 0)
-		return -1;
+		return 1;
 	if (blkid_probe_set_magic(pr, off,
 				sizeof(v->signature),
 				(unsigned char *) &v->signature))
-		return -1;
+		return 1;
 	return 0;
 }
 
diff --git a/libblkid/src/superblocks/vmfs.c b/libblkid/src/superblocks/vmfs.c
index ead09a8..fac87ab 100644
--- a/libblkid/src/superblocks/vmfs.c
+++ b/libblkid/src/superblocks/vmfs.c
@@ -28,7 +28,7 @@ static int probe_vmfs_fs(blkid_probe pr, const struct blkid_idmag *mag)
 
 	header = blkid_probe_get_sb(pr, mag, struct vmfs_fs_info);
 	if (header == NULL)
-		return -1;
+		return errno ? -errno : 1;
 
 	blkid_probe_sprintf_uuid(pr, (unsigned char *) header->uuid, 16,
 		"%02x%02x%02x%02x-%02x%02x%02x%02x-"
@@ -53,7 +53,7 @@ static int probe_vmfs_volume(blkid_probe pr, const struct blkid_idmag *mag)
 
 	header = blkid_probe_get_sb(pr, mag, struct vmfs_volume_info);
 	if (header == NULL)
-		return -1;
+		return errno ? -errno : 1;
 
 	blkid_probe_sprintf_value(pr, "UUID_SUB",
 		"%02x%02x%02x%02x-%02x%02x%02x%02x-"
diff --git a/libblkid/src/superblocks/vxfs.c b/libblkid/src/superblocks/vxfs.c
index fdab85a..19d284c 100644
--- a/libblkid/src/superblocks/vxfs.c
+++ b/libblkid/src/superblocks/vxfs.c
@@ -20,7 +20,7 @@ static int probe_vxfs(blkid_probe pr, const struct blkid_idmag *mag)
 
 	vxs = blkid_probe_get_sb(pr, mag, struct vxfs_super_block);
 	if (!vxs)
-		return -1;
+		return errno ? -errno : 1;
 
 	blkid_probe_sprintf_version(pr, "%u", (unsigned int) vxs->vs_version);
 	return 0;
diff --git a/libblkid/src/superblocks/xfs.c b/libblkid/src/superblocks/xfs.c
index f4bb721..a6c04a2 100644
--- a/libblkid/src/superblocks/xfs.c
+++ b/libblkid/src/superblocks/xfs.c
@@ -164,7 +164,7 @@ static int probe_xfs(blkid_probe pr, const struct blkid_idmag *mag)
 
 	xs = blkid_probe_get_sb(pr, mag, struct xfs_super_block);
 	if (!xs)
-		return -1;
+		return errno ? -errno : 1;
 
 	if (!xfs_verify_sb(xs))
 		return 1;
@@ -249,7 +249,7 @@ static int probe_xfs_log(blkid_probe pr, const struct blkid_idmag *mag)
 
 	buf = blkid_probe_get_buffer(pr, 0, 256*1024);
 	if (!buf)
-		return -1;
+		return errno ? -errno : 1;
 
 	if (memcmp(buf, "XFSB", 4) == 0)
 		return 1;			/* this is regular XFS, ignore */
@@ -264,7 +264,7 @@ static int probe_xfs_log(blkid_probe pr, const struct blkid_idmag *mag)
 		}
 	}
 
-	return -1;
+	return 1;
 }
 
 const struct blkid_idinfo xfs_log_idinfo =
diff --git a/libblkid/src/superblocks/zfs.c b/libblkid/src/superblocks/zfs.c
index fb86aec..406ba2b 100644
--- a/libblkid/src/superblocks/zfs.c
+++ b/libblkid/src/superblocks/zfs.c
@@ -185,7 +185,7 @@ static int probe_zfs(blkid_probe pr,
 			blkid_probe_get_buffer(pr, offset,
 					       sizeof(struct zfs_uberblock));
 		if (ub == NULL)
-			return -1;
+			return errno ? -errno : 1;
 
 		if (ub->ub_magic == UBERBLOCK_MAGIC) {
 			ub_offset = offset;
@@ -202,7 +202,7 @@ static int probe_zfs(blkid_probe pr,
 	}
 
 	if (found < 4)
-		return -1;
+		return 1;
 
 	/* If we found the 4th uberblock, then we will have exited from the
 	 * scanning loop immediately, and ub will be a valid uberblock. */
@@ -214,7 +214,7 @@ static int probe_zfs(blkid_probe pr,
 	if (blkid_probe_set_magic(pr, ub_offset,
 				sizeof(ub->ub_magic),
 				(unsigned char *) &ub->ub_magic))
-		return -1;
+		return 1;
 
 	return 0;
 }
-- 
1.7.12.4
