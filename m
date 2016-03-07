Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:53127 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932859AbcCGXMH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Mar 2016 18:12:07 -0500
Received: from assos.lan ([84.185.129.97]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MEFlg-1afJO74ALQ-00FRcU for
 <util-linux@vger.kernel.org>; Tue, 08 Mar 2016 00:12:04 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 02/12] misc: again fixing many printf format strings
Date: Tue,  8 Mar 2016 00:11:52 +0100
Message-Id: <1457392322-4974-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
References: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This is again a huge patch regarding printf format strings to
fix compiler warnings seen on clang/OSX.

I'm trying to follow these rules strictly:

 #type      #format   #cast
 uintmax_t   %ju      -
 intmax_t    %jd      -
 uint64_t    PRIu64   -
 int64_t     PRId64   -
 size_t      %zu      -
 ssize_t     %zd      -
 ino_t       %ju      (uintmax_t)
 off_t       %jd      (intmax_t)

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/fdisk.c                           | 25 +++++++++++++---------
 disk-utils/fsck.minix.c                      |  5 +++--
 disk-utils/mkfs.minix.c                      |  5 +++--
 disk-utils/mkswap.c                          |  4 ++--
 disk-utils/sfdisk.c                          | 17 ++++++++-------
 libblkid/samples/partitions.c                |  4 ++--
 libblkid/src/partitions/partitions.c         |  6 +++---
 libblkid/src/probe.c                         | 28 +++++++++++++------------
 libblkid/src/superblocks/drbdproxy_datalog.c |  2 +-
 libblkid/src/superblocks/ntfs.c              |  8 +++----
 libblkid/src/superblocks/vfat.c              |  3 ++-
 libfdisk/src/alignment.c                     |  2 +-
 libfdisk/src/ask.c                           |  4 ++--
 libfdisk/src/dos.c                           |  2 +-
 libfdisk/src/gpt.c                           | 26 ++++++++++++-----------
 libfdisk/src/partition.c                     | 31 +++++++++++++++-------------
 libfdisk/src/script.c                        | 20 +++++++++---------
 libfdisk/src/table.c                         | 12 +++++++----
 misc-utils/wipefs.c                          | 12 +++++------
 19 files changed, 119 insertions(+), 97 deletions(-)

diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index 304eccc..3aa915b 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -194,7 +194,7 @@ static int ask_number(struct fdisk_context *cxt,
 	assert(q);
 
 	DBG(ASK, ul_debug("asking for number "
-			"['%s', <%ju,%ju>, default=%ju, range: %s]",
+			"['%s', <%"PRIu64",%"PRIu64">, default=%"PRIu64", range: %s]",
 			q, low, high, dflt, range));
 
 	if (range && dflt >= low && dflt <= high) {
@@ -202,7 +202,7 @@ static int ask_number(struct fdisk_context *cxt,
 			snprintf(prompt, sizeof(prompt), _("%s (%s, default %c): "),
 					q, range, tochar(dflt));
 		else
-			snprintf(prompt, sizeof(prompt), _("%s (%s, default %ju): "),
+			snprintf(prompt, sizeof(prompt), _("%s (%s, default %"PRIu64"): "),
 					q, range, dflt);
 
 	} else if (dflt >= low && dflt <= high) {
@@ -210,13 +210,14 @@ static int ask_number(struct fdisk_context *cxt,
 			snprintf(prompt, sizeof(prompt), _("%s (%c-%c, default %c): "),
 					q, tochar(low), tochar(high), tochar(dflt));
 		else
-			snprintf(prompt, sizeof(prompt), _("%s (%ju-%ju, default %ju): "),
+			snprintf(prompt, sizeof(prompt),
+					_("%s (%"PRIu64"-%"PRIu64", default %"PRIu64"): "),
 					q, low, high, dflt);
 	} else if (inchar)
 		snprintf(prompt, sizeof(prompt), _("%s (%c-%c): "),
 				q, tochar(low), tochar(high));
 	else
-		snprintf(prompt, sizeof(prompt), _("%s (%ju-%ju): "),
+		snprintf(prompt, sizeof(prompt), _("%s (%"PRIu64"-%"PRIu64"): "),
 				q, low, high);
 
 	do {
@@ -264,15 +265,19 @@ static int ask_offset(struct fdisk_context *cxt,
 
 	assert(q);
 
-	DBG(ASK, ul_debug("asking for offset ['%s', <%ju,%ju>, base=%ju, default=%ju, range: %s]",
+	DBG(ASK, ul_debug("asking for offset ['%s', <%"PRIu64",%"PRIu64">, base=%"PRIu64", default=%"PRIu64", range: %s]",
 				q, low, high, base, dflt, range));
 
 	if (range && dflt >= low && dflt <= high)
-		snprintf(prompt, sizeof(prompt), _("%s (%s, default %ju): "), q, range, dflt);
+		snprintf(prompt, sizeof(prompt), _("%s (%s, default %"PRIu64"): "),
+		         q, range, dflt);
 	else if (dflt >= low && dflt <= high)
-		snprintf(prompt, sizeof(prompt), _("%s (%ju-%ju, default %ju): "), q, low, high, dflt);
+		snprintf(prompt, sizeof(prompt),
+		         _("%s (%"PRIu64"-%"PRIu64", default %"PRIu64"): "),
+		         q, low, high, dflt);
 	else
-		snprintf(prompt, sizeof(prompt), _("%s (%ju-%ju): "), q, low, high);
+		snprintf(prompt, sizeof(prompt), _("%s (%"PRIu64"-%"PRIu64"): "),
+		         q, low, high);
 
 	do {
 		uintmax_t num = 0;
@@ -629,7 +634,7 @@ static void dump_buffer(off_t base, unsigned char *buf, size_t sz, int all)
 		if (l == 0) {
 			if (all == 0 && !next)
 				next = skip_empty(buf, i, sz);
-			printf("%08jx ", base + i);
+			printf("%08jx ", (intmax_t)base + i);
 		}
 		printf(" %02x", buf[i]);
 		if (l == 7)				/* words separator */
@@ -653,7 +658,7 @@ static void dump_blkdev(struct fdisk_context *cxt, const char *name,
 {
 	int fd = fdisk_get_devfd(cxt);
 
-	fdisk_info(cxt, _("\n%s: offset = %ju, size = %zu bytes."),
+	fdisk_info(cxt, _("\n%s: offset = %"PRIu64", size = %zu bytes."),
 			name, offset, size);
 
 	assert(fd >= 0);
diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index a040cf5..aa64569 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -626,7 +626,8 @@ read_tables(void) {
 	if (show) {
 		printf(_("%ld inodes\n"), inodes);
 		printf(_("%ld blocks\n"), zones);
-		printf(_("Firstdatazone=%jd (%jd)\n"), first_zone, norm_first_zone);
+		printf(_("Firstdatazone=%jd (%jd)\n"),
+			(intmax_t)first_zone, (intmax_t)norm_first_zone);
 		printf(_("Zonesize=%d\n"), MINIX_BLOCK_SIZE << get_zone_size());
 		printf(_("Maxsize=%zu\n"), get_max_size());
 		if (fs_version < 3)
@@ -1053,7 +1054,7 @@ check_file2(struct minix2_inode *dir, unsigned int offset) {
 	name_depth++;
 	if (list) {
 		if (verbose)
-			printf("%6ju %07o %3d ", ino, inode->i_mode,
+			printf("%6ju %07o %3d ", (uintmax_t)ino, inode->i_mode,
 			       inode->i_nlinks);
 		get_current_name();
 		printf("%s", current_name);
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 24e6188..a4118f1 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -543,7 +543,7 @@ static void setup_tables(const struct fs_control *ctl) {
 		errx(MKFS_EX_ERROR,
 		     _("First data block at %jd, which is too far (max %d).\n"
 		       "Try specifying fewer inodes by passing --inodes <num>"),
-		     first_zone_data(),
+		     (intmax_t)first_zone_data(),
 		     MINIX_MAX_INODES);
 	imaps = get_nimaps();
 	zmaps = get_nzmaps();
@@ -563,7 +563,8 @@ static void setup_tables(const struct fs_control *ctl) {
 
 	printf(P_("%lu inode\n", "%lu inodes\n", inodes), inodes);
 	printf(P_("%lu block\n", "%lu blocks\n", zones), zones);
-	printf(_("Firstdatazone=%jd (%jd)\n"), get_first_zone(), first_zone_data());
+	printf(_("Firstdatazone=%jd (%jd)\n"),
+		(intmax_t)get_first_zone(), (intmax_t)first_zone_data());
 	printf(_("Zonesize=%zu\n"), (size_t) MINIX_BLOCK_SIZE << get_zone_size());
 	printf(_("Maxsize=%zu\n\n"),get_max_size());
 }
diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index ae02de5..52ee8c6 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -443,7 +443,7 @@ int main(int argc, char **argv)
 	else if (ctl.npages > sz && !ctl.force)
 		errx(EXIT_FAILURE,
 			_("error: "
-			  "size %llu KiB is larger than device size %ju KiB"),
+			  "size %llu KiB is larger than device size %"PRIu64" KiB"),
 			ctl.npages * (ctl.pagesize / 1024), sz * (ctl.pagesize / 1024));
 
 	if (ctl.npages < MIN_GOODPAGES)
@@ -489,7 +489,7 @@ int main(int argc, char **argv)
 	sz = (ctl.npages - ctl.nbadpages - 1) * ctl.pagesize;
 	strsz = size_to_human_string(SIZE_SUFFIX_SPACE | SIZE_SUFFIX_3LETTER, sz);
 
-	printf(_("Setting up swapspace version %d, size = %s (%ju bytes)\n"),
+	printf(_("Setting up swapspace version %d, size = %s (%"PRIu64" bytes)\n"),
 		version, strsz, sz);
 	free(strsz);
 
diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 14c7cc0..3dfdd9e 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -278,7 +278,7 @@ static void backup_sectors(struct sfdisk *sf,
 	devfd = fdisk_get_devfd(sf->cxt);
 	assert(devfd >= 0);
 
-	xasprintf(&fname, "%s0x%08jx.bak", tpl, offset);
+	xasprintf(&fname, "%s0x%08"PRIx64".bak", tpl, offset);
 
 	fd = open(fname, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR);
 	if (fd < 0)
@@ -421,7 +421,7 @@ static int move_partition_data(struct sfdisk *sf, size_t partno, struct fdisk_pa
 		step--;
 
 	step_bytes = step * ss;
-	DBG(MISC, ul_debug(" step: %ju (%ju bytes)", step, step_bytes));
+	DBG(MISC, ul_debug(" step: %ju (%zu bytes)", (uintmax_t)step, step_bytes));
 
 #if defined(POSIX_FADV_SEQUENTIAL) && defined(HAVE_POSIX_FADVISE)
 	if (!backward)
@@ -437,7 +437,7 @@ static int move_partition_data(struct sfdisk *sf, size_t partno, struct fdisk_pa
 		color_disable();
 		fdisk_info(sf->cxt, _(" typescript file: %s"), typescript);
 		printf(_(" old start: %ju, new start: %ju (move %ju sectors)\n"),
-			(uintmax_t) from, (uintmax_t) to, nsectors);
+			(uintmax_t) from, (uintmax_t) to, (uintmax_t) nsectors);
 		fflush(stdout);
 	}
 
@@ -459,12 +459,15 @@ static int move_partition_data(struct sfdisk *sf, size_t partno, struct fdisk_pa
 	fprintf(f, "# Disk: %s\n", devname);
 	fprintf(f, "# Partition: %zu\n", partno + 1);
 	fprintf(f, "# Operation: move data\n");
-	fprintf(f, "# Original start offset (sectors/bytes): %ju/%ju\n", from, from * ss);
-	fprintf(f, "# New start offset (sectors/bytes): %ju/%ju\n", to, to * ss);
-	fprintf(f, "# Area size (sectors/bytes): %ju/%ju\n", nsectors, nsectors * ss);
+	fprintf(f, "# Original start offset (sectors/bytes): %ju/%ju\n",
+	        (uintmax_t)from, (uintmax_t)from * ss);
+	fprintf(f, "# New start offset (sectors/bytes): %ju/%ju\n",
+	        (uintmax_t)to, (uintmax_t)to * ss);
+	fprintf(f, "# Area size (sectors/bytes): %ju/%ju\n",
+	        (uintmax_t)nsectors, (uintmax_t)nsectors * ss);
 	fprintf(f, "# Sector size: %zu\n", ss);
 	fprintf(f, "# Step size (in bytes): %zu\n", step_bytes);
-	fprintf(f, "# Steps: %zu\n", nsectors / step);
+	fprintf(f, "# Steps: %ju\n", (uintmax_t)(nsectors / step));
 	fprintf(f, "#\n");
 	fprintf(f, "# <step>: <from> <to> (step offsets in bytes)\n");
 
diff --git a/libblkid/samples/partitions.c b/libblkid/samples/partitions.c
index fe0ad48..318e9db 100644
--- a/libblkid/samples/partitions.c
+++ b/libblkid/samples/partitions.c
@@ -49,10 +49,10 @@ int main(int argc, char *argv[])
 				 "known partition table\n", devname);
 
 	printf("size: %jd, sector size: %u, PT: %s, offset: %jd, id=%s\n---\n",
-		blkid_probe_get_size(pr),
+		(intmax_t)blkid_probe_get_size(pr),
 		blkid_probe_get_sectorsize(pr),
 		blkid_parttable_get_type(root_tab),
-		blkid_parttable_get_offset(root_tab),
+		(intmax_t)blkid_parttable_get_offset(root_tab),
 		blkid_parttable_get_id(root_tab));
 
 	/*
diff --git a/libblkid/src/partitions/partitions.c b/libblkid/src/partitions/partitions.c
index c8e0bfe..bc67e80 100644
--- a/libblkid/src/partitions/partitions.c
+++ b/libblkid/src/partitions/partitions.c
@@ -789,9 +789,9 @@ static int blkid_partitions_probe_partition(blkid_probe pr)
 				"%d", blkid_partition_get_partno(par));
 
 		blkid_probe_sprintf_value(pr, "PART_ENTRY_OFFSET", "%jd",
-				blkid_partition_get_start(par));
+				(intmax_t)blkid_partition_get_start(par));
 		blkid_probe_sprintf_value(pr, "PART_ENTRY_SIZE", "%jd",
-				blkid_partition_get_size(par));
+				(intmax_t)blkid_partition_get_size(par));
 
 		blkid_probe_sprintf_value(pr, "PART_ENTRY_DISK", "%u:%u",
 				major(disk), minor(disk));
@@ -820,7 +820,7 @@ int blkid_probe_is_covered_by_pt(blkid_probe pr,
 	int nparts, i, rc = 0;
 
 	DBG(LOWPROBE, ul_debug(
-		"=> checking if off=%jd size=%jd covered by PT",
+		"=> checking if off=%"PRIu64" size=%"PRIu64" covered by PT",
 		offset, size));
 
 	if (pr->flags & BLKID_FL_NOSCAN_DEV)
diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index cc4586b..9c48462 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -607,7 +607,7 @@ static struct blkid_bufinfo *mmap_buffer(blkid_probe pr, uint64_t real_off, uint
 
 	/* begin of the device */
 	if (real_off == 0 || real_off + len < PROBE_MMAP_BEGINSIZ) {
-		DBG(BUFFER, ul_debug("\tmapping begin of the device (max size: %ju)", pr->size));
+		DBG(BUFFER, ul_debug("\tmapping begin of the device (max size: %"PRIu64")", pr->size));
 		map_off = 0;
 		map_len = PROBE_MMAP_BEGINSIZ > pr->size ? pr->size : PROBE_MMAP_BEGINSIZ;
 
@@ -615,7 +615,7 @@ static struct blkid_bufinfo *mmap_buffer(blkid_probe pr, uint64_t real_off, uint
 	/* end of the device */
 	} else if (real_off > pr->off + pr->size - PROBE_MMAP_ENDSIZ) {
 		DBG(BUFFER, ul_debug("\tmapping end of the device (probing area: "
-					"off=%ju, size=%ju)", pr->off, pr->size));
+					"off=%"PRIu64", size=%"PRIu64")", pr->off, pr->size));
 
 		map_off = PROBE_ALIGN_OFF(pr, pr->off + pr->size - PROBE_MMAP_ENDSIZ);
 		map_len = pr->off + pr->size - map_off;
@@ -655,7 +655,7 @@ static struct blkid_bufinfo *mmap_buffer(blkid_probe pr, uint64_t real_off, uint
 	bf->len = map_len;
 	INIT_LIST_HEAD(&bf->bufs);
 
-	DBG(BUFFER, ul_debug("\tmmap  %p: off=%ju, len=%ju (%ju pages)",
+	DBG(BUFFER, ul_debug("\tmmap  %p: off=%"PRIu64", len=%"PRIu64" (%"PRIu64" pages)",
 				bf->data, map_off, map_len, map_len / pr->mmap_granularity));
 	return bf;
 }
@@ -688,7 +688,8 @@ static struct blkid_bufinfo *read_buffer(blkid_probe pr, uint64_t real_off, uint
 	bf->off = real_off;
 	INIT_LIST_HEAD(&bf->bufs);
 
-	DBG(LOWPROBE, ul_debug("\tread %p: off=%ju len=%ju", bf->data, real_off, len));
+	DBG(LOWPROBE, ul_debug("\tread %p: off=%"PRIu64" len=%"PRIu64"",
+	                       bf->data, real_off, len));
 
 	ret = read(pr->fd, bf->data, len);
 	if (ret != (ssize_t) len) {
@@ -749,7 +750,7 @@ unsigned char *blkid_probe_get_buffer(blkid_probe pr, uint64_t off, uint64_t len
 				list_entry(p, struct blkid_bufinfo, bufs);
 
 		if (real_off >= x->off && real_off + len <= x->off + x->len) {
-			DBG(BUFFER, ul_debug("\treuse %p: off=%ju len=%ju (for off=%ju len=%ju)",
+			DBG(BUFFER, ul_debug("\treuse %p: off=%"PRIu64" len=%"PRIu64" (for off=%"PRIu64" len=%"PRIu64")",
 						x->data, x->off, x->len, real_off, len));
 			bf = x;
 			break;
@@ -791,14 +792,15 @@ static void blkid_probe_reset_buffer(blkid_probe pr)
 		len += bf->len;
 		list_del(&bf->bufs);
 
-		DBG(BUFFER, ul_debug(" remove buffer: %p [off=%ju, len=%ju]", bf->data, bf->off, bf->len));
+		DBG(BUFFER, ul_debug(" remove buffer: %p [off=%"PRIu64", len=%"PRIu64"]",
+		                     bf->data, bf->off, bf->len));
 
 		if (probe_is_mmap_wanted(pr))
 			munmap(bf->data, bf->len);
 		free(bf);
 	}
 
-	DBG(LOWPROBE, ul_debug(" buffers summary: %ju bytes by %ju read/mmap() calls",
+	DBG(LOWPROBE, ul_debug(" buffers summary: %"PRIu64" bytes by %"PRIu64" read/mmap() calls",
 			len, ct));
 
 	INIT_LIST_HEAD(&pr->buffers);
@@ -932,7 +934,7 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
 		pr->flags |= BLKID_FL_CDROM_DEV;
 #endif
 
-	DBG(LOWPROBE, ul_debug("ready for low-probing, offset=%ju, size=%ju",
+	DBG(LOWPROBE, ul_debug("ready for low-probing, offset=%"PRIu64", size=%"PRIu64"",
 				pr->off, pr->size));
 	DBG(LOWPROBE, ul_debug("whole-disk: %s, regfile: %s",
 		blkid_probe_is_wholedisk(pr) ?"YES" : "NO",
@@ -961,8 +963,8 @@ int blkid_probe_set_dimension(blkid_probe pr, uint64_t off, uint64_t size)
 		return -1;
 
 	DBG(LOWPROBE, ul_debug(
-		"changing probing area pr=%p: size=%ju, off=%ju "
-		"-to-> size=%ju, off=%ju",
+		"changing probing area pr=%p: size=%"PRIu64", off=%"PRIu64" "
+		"-to-> size=%"PRIu64", off=%"PRIu64"",
 		pr, pr->size, pr->off, size, off));
 
 	pr->off = off;
@@ -1214,7 +1216,7 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)
 		len = sizeof(buf);
 
 	DBG(LOWPROBE, ul_debug(
-	    "do_wipe [offset=0x%jx (%ju), len=%zd, chain=%s, idx=%d, dryrun=%s]\n",
+	    "do_wipe [offset=0x%"PRIx64" (%"PRIu64"), len=%zu, chain=%s, idx=%d, dryrun=%s]\n",
 	    offset, offset, len, chn->driver->name, chn->idx, dryrun ? "yes" : "not"));
 
 	l = blkid_llseek(fd, offset, SEEK_SET);
@@ -1577,7 +1579,7 @@ int blkid_probe_verify_csum(blkid_probe pr, uint64_t csum, uint64_t expected)
 
 		DBG(LOWPROBE, ul_debug(
 				"incorrect checksum for type %s,"
-				" got %jX, expected %jX",
+				" got %"PRIX64", expected %"PRIX64"",
 				blkid_probe_get_probername(pr),
 				csum, expected));
 		/*
@@ -1996,7 +1998,7 @@ void blkid_probe_set_wiper(blkid_probe pr, uint64_t off, uint64_t size)
 	pr->wipe_chain = chn;
 
 	DBG(LOWPROBE,
-		ul_debug("wiper set to %s::%s off=%jd size=%jd",
+		ul_debug("wiper set to %s::%s off=%"PRIu64" size=%"PRIu64"",
 			chn->driver->name,
 			chn->driver->idinfos[chn->idx]->name,
 			pr->wipe_off, pr->wipe_size));
diff --git a/libblkid/src/superblocks/drbdproxy_datalog.c b/libblkid/src/superblocks/drbdproxy_datalog.c
index af59722..9a4c7db 100644
--- a/libblkid/src/superblocks/drbdproxy_datalog.c
+++ b/libblkid/src/superblocks/drbdproxy_datalog.c
@@ -36,7 +36,7 @@ static int probe_drbdproxy_datalog(blkid_probe pr,
 		return errno ? -errno : 1;
 
 	blkid_probe_set_uuid(pr, lh->uuid);
-	blkid_probe_sprintf_version(pr, "v%jd", le64_to_cpu(lh->version));
+	blkid_probe_sprintf_version(pr, "v%"PRIu64, le64_to_cpu(lh->version));
 
 	return 0;
 }
diff --git a/libblkid/src/superblocks/ntfs.c b/libblkid/src/superblocks/ntfs.c
index 8ff9ccd..7515811 100644
--- a/libblkid/src/superblocks/ntfs.c
+++ b/libblkid/src/superblocks/ntfs.c
@@ -149,10 +149,10 @@ static int probe_ntfs(blkid_probe pr, const struct blkid_idmag *mag)
 	off = le64_to_cpu(ns->mft_cluster_location) * sector_size *
 		sectors_per_cluster;
 
-	DBG(LOWPROBE, ul_debug("NTFS: sector_size=%d, mft_record_size=%d, "
-			"sectors_per_cluster=%d, nr_clusters=%ju "
-			"cluster_offset=%jd",
-			(int) sector_size, mft_record_size,
+	DBG(LOWPROBE, ul_debug("NTFS: sector_size=%"PRIu16", mft_record_size=%"PRIu32", "
+			"sectors_per_cluster=%"PRIu32", nr_clusters=%"PRIu64" "
+			"cluster_offset=%"PRIu64"",
+			sector_size, mft_record_size,
 			sectors_per_cluster, nr_clusters,
 			off));
 
diff --git a/libblkid/src/superblocks/vfat.c b/libblkid/src/superblocks/vfat.c
index a4f598d..cb86560 100644
--- a/libblkid/src/superblocks/vfat.c
+++ b/libblkid/src/superblocks/vfat.c
@@ -15,6 +15,7 @@
 #include <errno.h>
 #include <ctype.h>
 #include <stdint.h>
+#include <inttypes.h>
 
 #include "pt-mbr.h"
 #include "superblocks.h"
@@ -125,7 +126,7 @@ static unsigned char *search_fat_label(blkid_probe pr,
 	uint32_t i;
 
 	DBG(LOWPROBE, ul_debug("\tlook for label in root-dir "
-			"(entries: %d, offset: %jd)", entries, offset));
+			"(entries: %"PRIu32", offset: %"PRIu64")", entries, offset));
 
 	if (!blkid_probe_is_tiny(pr)) {
 		/* large disk, read whole root directory */
diff --git a/libfdisk/src/alignment.c b/libfdisk/src/alignment.c
index 1e1d07c..24f1db9 100644
--- a/libfdisk/src/alignment.c
+++ b/libfdisk/src/alignment.c
@@ -119,7 +119,7 @@ fdisk_sector_t fdisk_align_lba(struct fdisk_context *cxt, fdisk_sector_t lba, in
 				(uintmax_t) res,
 				cxt->grain / cxt->sector_size));
 	else
-		DBG(CXT, ul_debugobj(cxt, "LBA %ju -unchanged-", lba));
+		DBG(CXT, ul_debugobj(cxt, "LBA %ju -unchanged-", (uintmax_t)lba));
 
 	return res;
 }
diff --git a/libfdisk/src/ask.c b/libfdisk/src/ask.c
index 225957f..fd0555e 100644
--- a/libfdisk/src/ask.c
+++ b/libfdisk/src/ask.c
@@ -462,7 +462,7 @@ int fdisk_ask_partnum(struct fdisk_context *cxt, size_t *partnum, int wantnew)
 		}
 	}
 
-	DBG(ASK, ul_debugobj(ask, "ask limits: low: %ju, high: %ju, default: %ju",
+	DBG(ASK, ul_debugobj(ask, "ask limits: low: %"PRIu64", high: %"PRIu64", default: %"PRIu64"",
 				num->low, num->hig, num->dfl));
 
 	if (!rc && !wantnew && num->low == num->hig) {
@@ -504,7 +504,7 @@ dont_ask:
 		if (*partnum)
 			*partnum -= 1;
 	}
-	DBG(ASK, ul_debugobj(ask, "result: %ju [rc=%d]\n", fdisk_ask_number_get_result(ask), rc));
+	DBG(ASK, ul_debugobj(ask, "result: %"PRIu64" [rc=%d]\n", fdisk_ask_number_get_result(ask), rc));
 	fdisk_unref_ask(ask);
 	return rc;
 }
diff --git a/libfdisk/src/dos.c b/libfdisk/src/dos.c
index b199225..68cadcd 100644
--- a/libfdisk/src/dos.c
+++ b/libfdisk/src/dos.c
@@ -1201,7 +1201,7 @@ static int add_partition(struct fdisk_context *cxt, size_t n,
 		if (stop > start)
 			stop -= 1;
 		DBG(LABEL, ul_debug("DOS: don't align end os tiny partition [start=%ju, stop=%ju, grain=%lu]",
-			   start, stop, cxt->grain));
+			    (uintmax_t)start,  (uintmax_t)stop, cxt->grain));
 	}
 
 	if (stop < limit) {
diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index cd88df0..2b2f519 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -621,7 +621,8 @@ static int count_first_last_lba(struct fdisk_context *cxt,
 		if (rc < 0)
 			return rc;
 
-		DBG(LABEL, ul_debug("FirstLBA: script=%ju, uefi=%ju, topology=%ju.", *first, flba, cxt->first_lba));
+		DBG(LABEL, ul_debug("FirstLBA: script=%"PRIu64", uefi=%"PRIu64", topology=%ju.",
+		                    *first, flba,  (uintmax_t)cxt->first_lba));
 
 		if (rc == 0 && (*first < flba || *first > llba)) {
 			fdisk_warnx(cxt, _("First LBA specified by script is out of range."));
@@ -632,7 +633,8 @@ static int count_first_last_lba(struct fdisk_context *cxt,
 		if (rc < 0)
 			return rc;
 
-		DBG(LABEL, ul_debug("LastLBA: script=%ju, uefi=%ju, topology=%ju.", *last, llba, cxt->last_lba));
+		DBG(LABEL, ul_debug("LastLBA: script=%"PRIu64", uefi=%"PRIu64", topology=%ju.",
+		                    *last, llba,  (uintmax_t)cxt->last_lba));
 
 		if (rc == 0 && (*last > llba || *last < flba)) {
 			fdisk_warnx(cxt, _("Last LBA specified by script is out of range."));
@@ -799,7 +801,7 @@ static uint64_t last_lba(struct fdisk_context *cxt)
 	else
 		fdisk_warnx(cxt, _("gpt: cannot handle files with mode %o"), s.st_mode);
 
-	DBG(LABEL, ul_debug("GPT last LBA: %ju", sectors));
+	DBG(LABEL, ul_debug("GPT last LBA: %"PRIu64"", sectors));
 	return sectors;
 }
 
@@ -1024,13 +1026,13 @@ static struct gpt_header *gpt_read_header(struct fdisk_context *cxt,
 	else
 		free(ents);
 
-	DBG(LABEL, ul_debug("found valid GPT Header on LBA %ju", lba));
+	DBG(LABEL, ul_debug("found valid GPT Header on LBA %"PRIu64"", lba));
 	return header;
 invalid:
 	free(header);
 	free(ents);
 
-	DBG(LABEL, ul_debug("read GPT Header on LBA %ju failed", lba));
+	DBG(LABEL, ul_debug("read GPT Header on LBA %"PRIu64" failed", lba));
 	return NULL;
 }
 
@@ -2141,14 +2143,14 @@ static int gpt_add_partition(
 
 		do {
 			uint64_t x;
-			DBG(LABEL, ul_debug("testing first sector %ju", disk_f));
+			DBG(LABEL, ul_debug("testing first sector %"PRIu64"", disk_f));
 			disk_f = find_first_available(pheader, ents, disk_f);
 			if (!disk_f)
 				break;
 			x = find_last_free(pheader, ents, disk_f);
 			if (x - disk_f >= cxt->grain / cxt->sector_size)
 				break;
-			DBG(LABEL, ul_debug("first sector %ju addresses to small space, continue...", disk_f));
+			DBG(LABEL, ul_debug("first sector %"PRIu64" addresses to small space, continue...", disk_f));
 			disk_f = x + 1;
 		} while(1);
 
@@ -2170,9 +2172,9 @@ static int gpt_add_partition(
 		user_f = dflt_f;
 
 	} else if (pa && fdisk_partition_has_start(pa)) {
-		DBG(LABEL, ul_debug("first sector defined: %ju", pa->start));
+		DBG(LABEL, ul_debug("first sector defined: %ju",  (uintmax_t)pa->start));
 		if (pa->start != find_first_available(pheader, ents, pa->start)) {
-			fdisk_warnx(cxt, _("Sector %ju already used."), pa->start);
+			fdisk_warnx(cxt, _("Sector %ju already used."),  (uintmax_t)pa->start);
 			return -ERANGE;
 		}
 		user_f = pa->start;
@@ -2213,8 +2215,8 @@ static int gpt_add_partition(
 
 	} else if (pa && fdisk_partition_has_size(pa)) {
 		user_l = user_f + pa->size - 1;
-		DBG(LABEL, ul_debug("size defined: %ju, end: %ju (last possible: %ju)",
-					pa->size, user_l, dflt_l));
+		DBG(LABEL, ul_debug("size defined: %ju, end: %"PRIu64" (last possible: %"PRIu64")",
+					 (uintmax_t)pa->size, user_l, dflt_l));
 		if (user_l != dflt_l && !pa->size_explicit
 		    && user_l - user_f > (cxt->grain / fdisk_get_sector_size(cxt))) {
 			user_l = fdisk_align_lba_in_range(cxt, user_l, user_f, dflt_l);
@@ -2308,7 +2310,7 @@ static int gpt_add_partition(
 	if (pa && pa->attrs)
 		gpt_entry_attrs_from_string(cxt, e, pa->attrs);
 
-	DBG(LABEL, ul_debug("GPT new partition: partno=%zu, start=%ju, end=%ju, size=%ju",
+	DBG(LABEL, ul_debug("GPT new partition: partno=%zu, start=%"PRIu64", end=%"PRIu64", size=%"PRIu64"",
 				partnum,
 				gpt_partition_start(e),
 				gpt_partition_end(e),
diff --git a/libfdisk/src/partition.c b/libfdisk/src/partition.c
index 2031e33..5e41eed 100644
--- a/libfdisk/src/partition.c
+++ b/libfdisk/src/partition.c
@@ -780,16 +780,16 @@ int fdisk_partition_to_string(struct fdisk_partition *pa,
 		if (fdisk_partition_has_start(pa)) {
 			x = fdisk_cround(cxt, pa->start);
 			rc = pa->start_post ?
-				asprintf(&p, "%ju%c", x, pa->start_post) :
-				asprintf(&p, "%ju", x);
+				asprintf(&p, "%"PRIu64"%c", x, pa->start_post) :
+				asprintf(&p, "%"PRIu64, x);
 		}
 		break;
 	case FDISK_FIELD_END:
 		if (fdisk_partition_has_end(pa)) {
 			x = fdisk_cround(cxt, fdisk_partition_get_end(pa));
 			rc = pa->end_post ?
-					asprintf(&p, "%ju%c", x, pa->end_post) :
-					asprintf(&p, "%ju", x);
+					asprintf(&p, "%"PRIu64"%c", x, pa->end_post) :
+					asprintf(&p, "%"PRIu64, x);
 		}
 		break;
 	case FDISK_FIELD_SIZE:
@@ -798,13 +798,13 @@ int fdisk_partition_to_string(struct fdisk_partition *pa,
 
 			switch (cxt->sizeunit) {
 			case FDISK_SIZEUNIT_BYTES:
-				rc = asprintf(&p, "%ju", sz);
+				rc = asprintf(&p, "%"PRIu64"", sz);
 				break;
 			case FDISK_SIZEUNIT_HUMAN:
 				if (fdisk_is_details(cxt))
 					rc = pa->size_post ?
-							asprintf(&p, "%ju%c", sz, pa->size_post) :
-							asprintf(&p, "%ju", sz);
+							asprintf(&p, "%"PRIu64"%c", sz, pa->size_post) :
+							asprintf(&p, "%"PRIu64, sz);
 				else {
 					p = size_to_human_string(SIZE_SUFFIX_1LETTER, sz);
 					if (!p)
@@ -818,7 +818,8 @@ int fdisk_partition_to_string(struct fdisk_partition *pa,
 	{
 		uintmax_t sz = fdisk_partition_has_size(pa) ? pa->size : 0;
 		if (sz)
-			rc = asprintf(&p, "%ju", (sz / (cxt->geom.heads * cxt->geom.sectors)) + 1);
+			/* Why we need to cast that to uintmax_t? */
+			rc = asprintf(&p, "%ju", (uintmax_t)(sz / (cxt->geom.heads * cxt->geom.sectors)) + 1);
 		break;
 	}
 	case FDISK_FIELD_SECTORS:
@@ -826,13 +827,13 @@ int fdisk_partition_to_string(struct fdisk_partition *pa,
 			fdisk_partition_has_size(pa) ? (uintmax_t) pa->size : 0);
 		break;
 	case FDISK_FIELD_BSIZE:
-		rc = asprintf(&p, "%ju", pa->bsize);
+		rc = asprintf(&p, "%"PRIu64, pa->bsize);
 		break;
 	case FDISK_FIELD_FSIZE:
-		rc = asprintf(&p, "%ju", pa->fsize);
+		rc = asprintf(&p, "%"PRIu64, pa->fsize);
 		break;
 	case FDISK_FIELD_CPG:
-		rc = asprintf(&p, "%ju", pa->cpg);
+		rc = asprintf(&p, "%"PRIu64, pa->cpg);
 		break;
 	case FDISK_FIELD_TYPE:
 		p = pa->type && pa->type->name ? strdup(_(pa->type->name)) : NULL;
@@ -971,7 +972,8 @@ static int resize_get_last_possible(
 		    fdisk_partition_is_container(pa))
 			continue;
 
-		DBG(PART, ul_debugobj(pa, "checking start=%ju, size=%ju", pa->start, pa->size));
+		DBG(PART, ul_debugobj(pa, "checking start=%ju, size=%ju",
+		                      (uintmax_t)pa->start, (uintmax_t)pa->size));
 
 		if (!last) {
 			if (start >= pa->start &&  start < pa->start + pa->size) {
@@ -1039,12 +1041,13 @@ static int recount_resize(
 			start += fdisk_partition_get_start(tpl);
 
 		DBG(PART, ul_debugobj(tpl, "resize: moving start %s relative, new start: %ju",
-				tpl->movestart == FDISK_MOVE_DOWN  ? "DOWN" : "UP", start));
+				tpl->movestart == FDISK_MOVE_DOWN  ? "DOWN" : "UP", (uintmax_t)start));
 
 	/* 1b) set new start - absolute number */
 	} else if (fdisk_partition_has_start(tpl)) {
 		start = fdisk_partition_get_start(tpl);
-		DBG(PART, ul_debugobj(tpl, "resize: moving start to absolute offset: %ju", start));
+		DBG(PART, ul_debugobj(tpl, "resize: moving start to absolute offset: %ju",
+		                      (uintmax_t)start));
 	}
 
 	/* 2) verify that start is within the current partition or any freespace area */
diff --git a/libfdisk/src/script.c b/libfdisk/src/script.c
index 3ca3f59..dceb75a 100644
--- a/libfdisk/src/script.c
+++ b/libfdisk/src/script.c
@@ -405,7 +405,7 @@ int fdisk_script_read_context(struct fdisk_script *dp, struct fdisk_context *cxt
 
 		rc = fdisk_get_disklabel_item(cxt, GPT_LABELITEM_FIRSTLBA, &item);
 		if (rc == 0) {
-			snprintf(buf, sizeof(buf), "%ju", item.data.num64);
+			snprintf(buf, sizeof(buf), "%"PRIu64, item.data.num64);
 			rc = fdisk_script_set_header(dp, "first-lba", buf);
 		}
 		if (rc < 0)
@@ -413,7 +413,7 @@ int fdisk_script_read_context(struct fdisk_script *dp, struct fdisk_context *cxt
 
 		rc = fdisk_get_disklabel_item(cxt, GPT_LABELITEM_LASTLBA, &item);
 		if (rc == 0) {
-			snprintf(buf, sizeof(buf), "%ju", item.data.num64);
+			snprintf(buf, sizeof(buf), "%"PRIu64, item.data.num64);
 			rc = fdisk_script_set_header(dp, "last-lba", buf);
 		}
 		if (rc < 0)
@@ -528,9 +528,9 @@ static int write_file_json(struct fdisk_script *dp, FILE *f)
 		}
 
 		if (fdisk_partition_has_start(pa))
-			fprintf(f, ", \"start\": %ju", pa->start);
+			fprintf(f, ", \"start\": %ju", (uintmax_t)pa->start);
 		if (fdisk_partition_has_size(pa))
-			fprintf(f, ", \"size\": %ju", pa->size);
+			fprintf(f, ", \"size\": %ju", (uintmax_t)pa->size);
 
 		if (pa->type && fdisk_parttype_get_string(pa->type))
 			fprintf(f, ", \"type\": \"%s\"", fdisk_parttype_get_string(pa->type));
@@ -614,9 +614,9 @@ static int write_file_sfdisk(struct fdisk_script *dp, FILE *f)
 			fprintf(f, "%zu :", pa->partno + 1);
 
 		if (fdisk_partition_has_start(pa))
-			fprintf(f, " start=%12ju", pa->start);
+			fprintf(f, " start=%12ju", (uintmax_t)pa->start);
 		if (fdisk_partition_has_size(pa))
-			fprintf(f, ", size=%12ju", pa->size);
+			fprintf(f, ", size=%12ju", (uintmax_t)pa->size);
 
 		if (pa->type && fdisk_parttype_get_string(pa->type))
 			fprintf(f, ", type=%s", fdisk_parttype_get_string(pa->type));
@@ -1437,8 +1437,8 @@ static int test_stdin(struct fdisk_test *ts, int argc, char *argv[])
 		if (rc == 0) {
 			pa = fdisk_table_get_partition(dp->table, n);
 			printf(" #%zu  %12ju %12ju\n",	n + 1,
-						fdisk_partition_get_start(pa),
-						fdisk_partition_get_size(pa));
+						(uintmax_t)fdisk_partition_get_start(pa),
+						(uintmax_t)fdisk_partition_get_size(pa));
 		}
 	} while (rc == 0);
 
@@ -1479,8 +1479,8 @@ static int test_apply(struct fdisk_test *ts, int argc, char *argv[])
 	itr = fdisk_new_iter(FDISK_ITER_FORWARD);
 	while (fdisk_table_next_partition(tb, itr, &pa) == 0) {
 		printf(" #%zu  %12ju %12ju\n",	fdisk_partition_get_partno(pa),
-						fdisk_partition_get_start(pa),
-						fdisk_partition_get_size(pa));
+						(uintmax_t)fdisk_partition_get_start(pa),
+						(uintmax_t)fdisk_partition_get_size(pa));
 	}
 
 done:
diff --git a/libfdisk/src/table.c b/libfdisk/src/table.c
index 1a3d47a..9be5713 100644
--- a/libfdisk/src/table.c
+++ b/libfdisk/src/table.c
@@ -508,11 +508,13 @@ static int check_container_freespace(struct fdisk_context *cxt,
 	grain = cxt->grain > cxt->sector_size ?	cxt->grain / cxt->sector_size : 1;
 	fdisk_reset_iter(&itr, FDISK_ITER_FORWARD);
 
-	DBG(CXT, ul_debugobj(cxt, "initialized:  last=%ju, grain=%ju", last, grain));
+	DBG(CXT, ul_debugobj(cxt, "initialized:  last=%ju, grain=%ju",
+	                     (uintmax_t)last,  (uintmax_t)grain));
 
 	while (fdisk_table_next_partition(parts, &itr, &pa) == 0) {
 
-		DBG(CXT, ul_debugobj(cxt, "partno=%zu, start=%ju", pa->partno, pa->start));
+		DBG(CXT, ul_debugobj(cxt, "partno=%zu, start=%ju",
+		                     pa->partno, (uintmax_t)pa->start));
 
 		if (!pa->used || !fdisk_partition_is_nested(pa)
 			      || !fdisk_partition_has_start(pa))
@@ -583,12 +585,14 @@ int fdisk_get_freespaces(struct fdisk_context *cxt, struct fdisk_table **tb)
 	last = cxt->first_lba;
 	grain = cxt->grain > cxt->sector_size ?	cxt->grain / cxt->sector_size : 1;
 
-	DBG(CXT, ul_debugobj(cxt, "initialized:  last=%ju, grain=%ju", last, grain));
+	DBG(CXT, ul_debugobj(cxt, "initialized:  last=%ju, grain=%ju",
+	                     (uintmax_t)last,  (uintmax_t)grain));
 
 	/* analyze gaps between partitions */
 	while (rc == 0 && fdisk_table_next_partition(parts, &itr, &pa) == 0) {
 
-		DBG(CXT, ul_debugobj(cxt, "partno=%zu, start=%ju", pa->partno, pa->start));
+		DBG(CXT, ul_debugobj(cxt, "partno=%zu, start=%ju",
+		                     pa->partno, (uintmax_t)pa->start));
 
 		if (!pa->used || pa->wholedisk || fdisk_partition_is_nested(pa)
 			      || !fdisk_partition_has_start(pa))
diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index abcf5eb..9cd29ad 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -84,7 +84,7 @@ print_pretty(struct wipe_desc *wp, int line)
 		printf("----------------------------------------------------------------\n");
 	}
 
-	printf("0x%-17jx  %s   [%s]", wp->offset, wp->type, _(wp->usage));
+	printf("0x%-17jx  %s   [%s]", (intmax_t)wp->offset, wp->type, _(wp->usage));
 
 	if (wp->label && *wp->label)
 		printf("\n%27s %s", "LABEL:", wp->label);
@@ -101,7 +101,7 @@ print_parsable(struct wipe_desc *wp, int line)
 	if (!line)
 		printf("# offset,uuid,label,type\n");
 
-	printf("0x%jx,", wp->offset);
+	printf("0x%jx,", (intmax_t)wp->offset);
 
 	if (wp->uuid) {
 		blkid_encode_string(wp->uuid, enc, sizeof(enc));
@@ -311,7 +311,7 @@ static void do_wipe_real(blkid_probe pr, const char *devname,
 
 	if (blkid_do_wipe(pr, (flags & WP_FL_NOACT) != 0))
 		warn(_("%s: failed to erase %s magic string at offset 0x%08jx"),
-		     devname, w->type, w->offset);
+		     devname, w->type, (intmax_t)w->offset);
 
 	if (flags & WP_FL_QUIET)
 		return;
@@ -319,7 +319,7 @@ static void do_wipe_real(blkid_probe pr, const char *devname,
 	printf(P_("%s: %zd byte was erased at offset 0x%08jx (%s): ",
 		  "%s: %zd bytes were erased at offset 0x%08jx (%s): ",
 		  w->len),
-	       devname, w->len, w->offset, w->type);
+	       devname, w->len, (intmax_t)w->offset, w->type);
 
 	for (i = 0; i < w->len; i++) {
 		printf("%02x", w->magic[i]);
@@ -334,7 +334,7 @@ static void do_backup(struct wipe_desc *wp, const char *base)
 	char *fname = NULL;
 	int fd;
 
-	xasprintf(&fname, "%s0x%08jx.bak", base, wp->offset);
+	xasprintf(&fname, "%s0x%08jx.bak", base, (intmax_t)wp->offset);
 
 	fd = open(fname, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR);
 	if (fd < 0)
@@ -428,7 +428,7 @@ do_wipe(struct wipe_desc *wp, const char *devname, int flags)
 
 	for (w = wp0; w != NULL; w = w->next) {
 		if (!w->on_disk && !(flags & WP_FL_QUIET))
-			warnx(_("%s: offset 0x%jx not found"), devname, w->offset);
+			warnx(_("%s: offset 0x%jx not found"), devname, (uintmax_t)w->offset);
 	}
 
 	if (need_force)
-- 
1.9.1

