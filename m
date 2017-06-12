Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:59058 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752035AbdFLIuB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 12 Jun 2017 04:50:01 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlYrb-1dsILo1j3X-00bL9h for
 <util-linux@vger.kernel.org>; Mon, 12 Jun 2017 10:49:59 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/6] libmount: btrfs, remove unused setter functions
Date: Mon, 12 Jun 2017 10:49:54 +0200
Message-Id: <20170612084958.22054-3-sweet_f_a@gmx.de>
In-Reply-To: <20170612084958.22054-1-sweet_f_a@gmx.de>
References: <20170612084958.22054-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We have never used them since introduced in 2cd28fc8.
clang compiler warned about it.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libmount/src/btrfs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/libmount/src/btrfs.c b/libmount/src/btrfs.c
index be4d144bf..c387fadd5 100644
--- a/libmount/src/btrfs.c
+++ b/libmount/src/btrfs.c
@@ -67,10 +67,6 @@ struct btrfs_dir_item {
 static inline uint##bits##_t btrfs_##name(const type *s)		\
 {									\
 	return le##bits##_to_cpu(s->member);				\
-}									\
-static inline void btrfs_set_##name(type *s, uint##bits##_t val)	\
-{									\
-	s->member = cpu_to_le##bits(val);				\
 }
 
 /* struct btrfs_disk_key */
-- 
2.12.3

