Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52330 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756315Ab1LOTBr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Dec 2011 14:01:47 -0500
Received: by eekc4 with SMTP id c4so2430546eek.19
        for <util-linux@vger.kernel.org>; Thu, 15 Dec 2011 11:01:46 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH] libblkid: minor docs changes
Date: Thu, 15 Dec 2011 20:01:40 +0100
Message-Id: <1323975700-21696-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 libblkid/src/partitions/partitions.c |    4 ++--
 libblkid/src/probe.c                 |   14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/libblkid/src/partitions/partitions.c b/libblkid/src/partitions/partitions.c
index aa8ca7c..6d8e86f 100644
--- a/libblkid/src/partitions/partitions.c
+++ b/libblkid/src/partitions/partitions.c
@@ -361,7 +361,7 @@ static void reset_partlist(blkid_partlist ls)
 	ls->next_partno = 1;
 	INIT_LIST_HEAD(&ls->l_tabs);
 
-	DBG(DEBUG_LOWPROBE, printf("partlist reseted\n"));
+	DBG(DEBUG_LOWPROBE, printf("partlist reset\n"));
 }
 
 static blkid_partlist partitions_init_data(struct blkid_chain *chn)
@@ -673,7 +673,7 @@ int blkid_partitions_do_subprobe(blkid_probe pr, blkid_partition parent,
 
 	blkid_probe_set_dimension(prc, off, sz);
 
-	/* clone is always with reseted chain, fix it */
+	/* clone is always with reset chain, fix it */
 	prc->cur_chain = blkid_probe_get_chain(pr);
 
 	/*
diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index ee01a65..27d9b27 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -21,7 +21,7 @@
  * The probing routines is possible to filter (enable/disable) by type (e.g.
  * fstype "vfat" or partype "gpt") or by usage flags (e.g. BLKID_USAGE_RAID).
  * These filters are per-chain. Note that always when you touch the chain
- * filter the current probing position is reseted and probing starts from
+ * filter the current probing position is reset and probing starts from
  * scratch.  It means that the chain filter should not be modified during
  * probing, for example in loop where you call blkid_do_probe().
  *
@@ -36,7 +36,7 @@
  *      The interface is always specific to the probing chain.
  *
  *  Note that the previous probing result (binary or NAME=value) is always
- *  zeroized when a chain probing function is called. For example
+ *  zeroized when a chain probing function is called. For example:
  *
  * <informalexample>
  *   <programlisting>
@@ -131,7 +131,7 @@ static void blkid_probe_reset_buffer(blkid_probe pr);
 /**
  * blkid_new_probe:
  *
- * Returns: a pointer to the newly allocated probe struct.
+ * Returns: a pointer to the newly allocated probe struct or NULL in case of error.
  */
 blkid_probe blkid_new_probe(void)
 {
@@ -434,7 +434,7 @@ unsigned long *blkid_probe_get_filter(blkid_probe pr, int chain, int create)
 
 	chn = &pr->chains[chain];
 
-	/* always when you touch the chain filter all indexes are reseted and
+	/* always when you touch the chain filter all indexes are reset and
 	 * probing starts from scratch
 	 */
 	blkid_probe_chain_reset_position(chn);
@@ -831,7 +831,7 @@ static inline void blkid_probe_end(blkid_probe pr)
  * Calls probing functions in all enabled chains. The superblocks chain is
  * enabled by default. The blkid_do_probe() stores result from only one
  * probing function. It's necessary to call this routine in a loop to get
- * results from all probing functions in all chains. The probing is reseted
+ * results from all probing functions in all chains. The probing is reset
  * by blkid_reset_probe() or by filter functions.
  *
  * This is string-based NAME=value interface only.
@@ -1263,7 +1263,7 @@ int blkid_probe_set_magic(blkid_probe pr, blkid_loff_t offset,
  * blkid_probe_get_devno:
  * @pr: probe
  *
- * Returns: block device number, or 0 for regilar files.
+ * Returns: block device number, or 0 for regular files.
  */
 dev_t blkid_probe_get_devno(blkid_probe pr)
 {
@@ -1274,7 +1274,7 @@ dev_t blkid_probe_get_devno(blkid_probe pr)
  * blkid_probe_get_wholedisk_devno:
  * @pr: probe
  *
- * Returns: device number of the wholedisk, or 0 for regilar files.
+ * Returns: device number of the wholedisk, or 0 for regular files.
  */
 dev_t blkid_probe_get_wholedisk_devno(blkid_probe pr)
 {
-- 
1.7.3.4

