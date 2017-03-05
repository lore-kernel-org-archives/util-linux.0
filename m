Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33538 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752438AbdCEUwt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Mar 2017 15:52:49 -0500
Received: by mail-wr0-f193.google.com with SMTP id g10so19462218wrg.0
        for <util-linux@vger.kernel.org>; Sun, 05 Mar 2017 12:52:48 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 10/13] libfdisk: dos: fix potential null pointer dereferences
Date: Sun,  5 Mar 2017 20:52:29 +0000
Message-Id: <20170305205232.24030-11-kerolasa@iki.fi>
In-Reply-To: <20170305205232.24030-1-kerolasa@iki.fi>
References: <20170305205232.24030-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Lots of the following warnings fixed, where all originated to self_pte()
that can return NULL.

libfdisk/src/dos.c:1850:25: warning: potential null pointer dereference
[-Wnull-dereference]
   struct dos_partition *p = pe->pt_entry;

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libfdisk/src/dos.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/libfdisk/src/dos.c b/libfdisk/src/dos.c
index 11946b38c..8b9ff464c 100644
--- a/libfdisk/src/dos.c
+++ b/libfdisk/src/dos.c
@@ -311,6 +311,8 @@ static void dos_init(struct fdisk_context *cxt)
 	for (i = 0; i < 4; i++) {
 		struct pte *pe = self_pte(cxt, i);
 
+		if (pe == NULL)
+			return;
 		pe->pt_entry = mbr_get_partition(cxt->firstsector, i);
 		pe->ex_entry = NULL;
 		pe->offset = 0;
@@ -502,6 +504,8 @@ static void read_extended(struct fdisk_context *cxt, size_t ext)
 
 	l->ext_index = ext;
 	pex = self_pte(cxt, ext);
+	if (pex == NULL)
+		return;
 	pex->ex_entry = pex->pt_entry;
 
 	p = pex->pt_entry;
@@ -515,12 +519,16 @@ static void read_extended(struct fdisk_context *cxt, size_t ext)
 	while (IS_EXTENDED (p->sys_ind)) {
 		pe = self_pte(cxt, cxt->label->nparts_max);
 
+		if (pe == NULL)
+			return;
 		if (cxt->label->nparts_max >= MAXIMUM_PARTS) {
 			/* This is not a Linux restriction, but
 			   this program uses arrays of size MAXIMUM_PARTS.
 			   Do not try to `improve' this test. */
 			struct pte *pre = self_pte(cxt,
 						cxt->label->nparts_max - 1);
+			if (pre == NULL)
+				return;
 			fdisk_warnx(cxt,
 			_("Omitting partitions after #%zu. They will be deleted "
 			  "if you save this partition table."),
@@ -596,6 +604,8 @@ static void read_extended(struct fdisk_context *cxt, size_t ext)
 
 	/* remove last empty EBR */
 	pe = self_pte(cxt, cxt->label->nparts_max - 1);
+	if (pe == NULL)
+		return;
 	if (is_cleared_partition(pe->ex_entry) &&
 	    is_cleared_partition(pe->pt_entry)) {
 		DBG(LABEL, ul_debug("DOS: EBR[offset=%ju]: empty, remove", (uintmax_t) pe->offset));
@@ -610,6 +620,8 @@ static void read_extended(struct fdisk_context *cxt, size_t ext)
 	for (i = 4; i < cxt->label->nparts_max; i++) {
 		p = self_partition(cxt, i);
 
+		if (p == NULL)
+			continue;
 		if (!dos_partition_get_size(p) &&
 		    (cxt->label->nparts_max > 5 || q->sys_ind)) {
 			fdisk_info(cxt, _("omitting empty partition (%zu)"), i+1);
@@ -798,6 +810,8 @@ static int dos_probe_label(struct fdisk_context *cxt)
 	for (i = 0; i < 4; i++) {
 		struct pte *pe = self_pte(cxt, i);
 
+		if (pe == NULL)
+			return -1;
 		if (is_used_partition(pe->pt_entry))
 			cxt->label->nparts_cur++;
 
@@ -884,6 +898,8 @@ static fdisk_sector_t get_unused_start(struct fdisk_context *cxt,
 		fdisk_sector_t lastplusoff;
 		struct pte *pe = self_pte(cxt, i);
 
+		if (pe == NULL)
+			return UINT64_MAX;
 		if (start == pe->offset)
 			start += cxt->first_lba;
 		lastplusoff = last[i] + ((part_n < 4) ? 0 : cxt->first_lba);
@@ -1007,6 +1023,8 @@ static fdisk_sector_t get_unused_last(struct fdisk_context *cxt, size_t n,
 	for (i = 0; i < cxt->label->nparts_max; i++) {
 		struct pte *pe = self_pte(cxt, i);
 
+		if (pe == NULL)
+			return 0;
 		if (start < pe->offset && limit >= pe->offset)
 			limit = pe->offset - 1;
 		if (start < first[i] && limit >= first[i])
@@ -1087,6 +1105,8 @@ static int add_partition(struct fdisk_context *cxt, size_t n,
 
 		temp = start;
 		dflt = start = get_unused_start(cxt, n, start, first, last);
+		if (start == UINT64_MAX)
+			continue;
 
 		if (n >= 4 && pa && fdisk_partition_has_start(pa) && cxt->script
 		    && cxt->first_lba > 1
@@ -1133,6 +1153,8 @@ static int add_partition(struct fdisk_context *cxt, size_t n,
 		/* The second (and another) EBR */
 		struct pte *pe = self_pte(cxt, n);
 
+		if (pe == NULL)
+			return -EINVAL;
 		pe->offset = start - cxt->first_lba;
 		if (pe->offset == l->ext_offset) { /* must be corrected */
 			pe->offset++;
@@ -1235,6 +1257,11 @@ static int add_partition(struct fdisk_context *cxt, size_t n,
 	set_partition(cxt, n, 0, start, stop, sys, fdisk_partition_is_bootable(pa));
 	if (n > 4) {
 		struct pte *pe = self_pte(cxt, n);
+
+		if (pe == NULL) {
+			rc = 1;
+			goto done;
+		}
 		set_partition(cxt, n - 1, 1, pe->offset, stop,
 					MBR_DOS_EXTENDED_PARTITION, 0);
 	}
@@ -1251,6 +1278,10 @@ static int add_partition(struct fdisk_context *cxt, size_t n,
 	if (IS_EXTENDED(sys)) {
 		struct pte *pen = self_pte(cxt, n);
 
+		if (pen == NULL) {
+			rc = 1;
+			goto done;
+		}
 		l->ext_index = n;
 		l->ext_offset = start;
 		pen->ex_entry = p;
@@ -1278,6 +1309,8 @@ static int add_logical(struct fdisk_context *cxt,
 	DBG(LABEL, ul_debug("DOS: nparts max: %zu", cxt->label->nparts_max));
 	pe = self_pte(cxt, cxt->label->nparts_max);
 
+	if (pe == NULL)
+		return -1;
 	if (!pe->sectorbuffer) {
 		pe->sectorbuffer = calloc(1, cxt->sector_size);
 		if (!pe->sectorbuffer)
@@ -1476,6 +1509,8 @@ static int dos_verify_disklabel(struct fdisk_context *cxt)
 			total++;
 			p = self_partition(cxt, i);
 
+			if (p == NULL)
+				continue;
 			if (!p->sys_ind) {
 				if (i != 4 || i + 1 < cxt->label->nparts_max)
 					fdisk_warnx(cxt,
@@ -1759,7 +1794,8 @@ static int dos_write_disklabel(struct fdisk_context *cxt)
 	if (!mbr_changed) {
 		for (i = 0; i < 4; i++) {
 			struct pte *pe = self_pte(cxt, i);
-			if (pe->changed)
+
+			if (pe && pe->changed)
 				mbr_changed = 1;
 		}
 	}
@@ -1788,7 +1824,7 @@ static int dos_write_disklabel(struct fdisk_context *cxt)
 	for (i = 4; i < cxt->label->nparts_max; i++) {
 		struct pte *pe = self_pte(cxt, i);
 
-		if (!pe->changed || !pe->offset || !pe->sectorbuffer)
+		if (!pe || !pe->changed || !pe->offset || !pe->sectorbuffer)
 			continue;
 
 		mbr_set_magic(pe->sectorbuffer);
@@ -1847,7 +1883,7 @@ static int wrong_p_order(struct fdisk_context *cxt, size_t *prev)
 	for (i = 0 ; i < cxt->label->nparts_max; i++) {
 
 		struct pte *pe = self_pte(cxt, i);
-		struct dos_partition *p = pe->pt_entry;
+		struct dos_partition *p = pe ? pe->pt_entry : NULL;
 
 		if (i == 4) {
 			last_i = 4;
@@ -1913,6 +1949,8 @@ static int dos_get_partition(struct fdisk_context *cxt, size_t n,
 
 	lb = self_label(cxt);
 	pe = self_pte(cxt, n);
+	if (pe == NULL)
+		return -EINVAL;
 	p = pe->pt_entry;
 	pa->used = !is_cleared_partition(p);
 	if (!pa->used)
@@ -2058,6 +2096,8 @@ static void print_chain_of_logicals(struct fdisk_context *cxt)
 	for (i = 4; i < cxt->label->nparts_max; i++) {
 		struct pte *pe = self_pte(cxt, i);
 
+		if (pe == NULL)
+			return;
 		fprintf(stderr, "#%02zu EBR [%10ju], "
 			"data[start=%10ju (%10ju), size=%10ju], "
 			"link[start=%10ju (%10ju), size=%10ju]\n",
@@ -2140,9 +2180,12 @@ again:
 	for (i = 4; i < cxt->label->nparts_max - 1; i++) {
 		struct pte *cur = self_pte(cxt, i),
 			   *nxt = self_pte(cxt, i + 1);
+		fdisk_sector_t noff, ooff;
 
-		fdisk_sector_t noff = nxt->offset - l->ext_offset,
-			 ooff = dos_partition_get_start(cur->ex_entry);
+		if (cur == NULL || nxt == NULL)
+			continue;
+		noff = nxt->offset - l->ext_offset;
+		ooff = dos_partition_get_start(cur->ex_entry);
 
 		if (noff == ooff)
 			continue;
@@ -2182,6 +2225,8 @@ static int dos_reorder(struct fdisk_context *cxt)
 		struct dos_partition *pi, *pk, *pe, pbuf;
 		pei = self_pte(cxt, i);
 		pek = self_pte(cxt, k);
+		if (pei == NULL || pek == NULL)
+			return -1;
 
 		pe = pei->ex_entry;
 		pei->ex_entry = pek->ex_entry;
@@ -2218,6 +2263,10 @@ int fdisk_dos_move_begin(struct fdisk_context *cxt, size_t i)
 	assert(fdisk_is_label(cxt, DOS));
 
 	pe = self_pte(cxt, i);
+	if (pe == NULL) {
+		fdisk_warnx(cxt, _("Partition %zu: no pte_label."), i + 1);
+		return 0;
+	}
 	p = pe->pt_entry;
 
 	if (!is_used_partition(p) || IS_EXTENDED (p->sys_ind)) {
@@ -2236,7 +2285,7 @@ int fdisk_dos_move_begin(struct fdisk_context *cxt, size_t i)
 	for (x = 0; x < cxt->label->nparts_max; x++) {
 		unsigned int end;
 		struct pte *prev_pe = self_pte(cxt, x);
-		struct dos_partition *prev_p = prev_pe->pt_entry;
+		struct dos_partition *prev_p = prev_pe ? prev_pe->pt_entry : NULL;
 
 		if (!prev_p)
 			continue;
-- 
2.12.0

