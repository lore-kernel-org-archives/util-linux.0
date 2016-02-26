Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:64875 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161AbcBZDDg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Feb 2016 22:03:36 -0500
Received: from tenfore.ga-group.nl ([95.114.239.233]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0MPppG-1ad0Zo0x0c-004x5t for
 <util-linux@vger.kernel.org>; Fri, 26 Feb 2016 04:03:34 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 03/14] fdisk: fix warning, incompatible pointer types passing 'uint64_t *'
Date: Fri, 26 Feb 2016 04:03:26 +0100
Message-Id: <1456455812-19453-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/fdisk.c | 4 ++--
 libfdisk/src/gpt.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index 0b22983..2f95fe8 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -276,7 +276,7 @@ static int ask_offset(struct fdisk_context *cxt,
 		snprintf(prompt, sizeof(prompt), _("%s (%ju-%ju): "), q, low, high);
 
 	do {
-		uint64_t num = 0;
+		uintmax_t num = 0;
 		char sig = 0, *p;
 		int pwr = 0;
 
@@ -313,7 +313,7 @@ static int ask_offset(struct fdisk_context *cxt,
 		if (num >= low && num <= high) {
 			if (sig && pwr)
 				fdisk_ask_number_set_relative(ask, 1);
-			return fdisk_ask_number_set_result(ask, num);
+			return fdisk_ask_number_set_result(ask, (uint64_t)num);
 		}
 		fdisk_warnx(cxt, _("Value out of range."));
 	} while (1);
diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index f795b35..cd88df0 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -2564,7 +2564,8 @@ static int gpt_toggle_partition_flag(
 		unsigned long flag)
 {
 	struct fdisk_gpt_label *gpt;
-	uint64_t attrs, tmp;
+	uint64_t attrs;
+	uintmax_t tmp;
 	char *bits;
 	const char *name = NULL;
 	int bit = -1, rc;
-- 
1.8.4.5

