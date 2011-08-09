Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.pre-sense.de ([213.238.39.107]:58890 "EHLO
	mail.pre-sense.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab1HIHom (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 9 Aug 2011 03:44:42 -0400
Received: from smtp.pre-sense.de (tetris_b.pre-sense.de [10.9.0.76])
	by mail.pre-sense.de (Postfix) with ESMTP id 208455E14C
	for <util-linux@vger.kernel.org>; Tue,  9 Aug 2011 09:39:13 +0200 (CEST)
Received: from localhost (unknown [193.174.12.196])
	by smtp.pre-sense.de (Postfix) with ESMTPS id E0D10C262E
	for <util-linux@vger.kernel.org>; Tue,  9 Aug 2011 09:39:12 +0200 (CEST)
Date: Tue, 9 Aug 2011 09:40:47 +0200
From: Timo Warns <Warns@Pre-Sense.DE>
To: util-linux@vger.kernel.org
Subject: [PATCH] befs.c: validate di_br_size !=0 and br_per_di_br != 0
Message-ID: <20110809074046.GA4237@vermeer.pre-sense.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Validate that di_br_size !=0 and br_per_di_br != 0. If one of them is 0, a
division-by-zero error will be triggered.

Signed-off-by: Timo Warns <warns@pre-sense.de>
---
diff -u util-linux-2.20-rc1-a/libblkid/src/superblocks/befs.c util-linux-2.20-rc1-b/libblkid/src/superblocks/befs.c
--- util-linux-2.20-rc1-a/libblkid/src/superblocks/befs.c	2011-07-20 21:55:23.000000000 +0200
+++ util-linux-2.20-rc1-b/libblkid/src/superblocks/befs.c	2011-08-09 09:32:56.000000000 +0200
@@ -200,9 +200,16 @@
 		int64_t di_br_size, br_per_di_br, di_index, i_index;
 
 		start -= FS64_TO_CPU(ds->max_indirect_range, fs_le);
+
 		di_br_size = (int64_t) FS16_TO_CPU(ds->double_indirect.len,
 				fs_le) << FS32_TO_CPU(bs->block_shift, fs_le);
+		if (di_br_size == 0)
+			return NULL;
+
 		br_per_di_br = di_br_size / sizeof(struct block_run);
+		if (br_per_di_br == 0)
+			return NULL;
+
 		di_index = start / (br_per_di_br * di_br_size);
 		i_index = (start % (br_per_di_br * di_br_size)) / di_br_size;
 		start = (start % (br_per_di_br * di_br_size)) % di_br_size;

