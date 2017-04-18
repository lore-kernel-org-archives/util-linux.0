Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-db5eur01on0109.outbound.protection.outlook.com ([104.47.2.109]:58688
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753372AbdDRQAG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Apr 2017 12:00:06 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
To: <util-linux@vger.kernel.org>
CC: <kzak@redhat.com>, <pbutsykin@virtuozzo.com>
Subject: [PATCH 1/1] libfdisk: allow to change an existing extended partition
Date: Tue, 18 Apr 2017 18:59:18 +0300
Message-ID: <20170418155918.32550-2-pbutsykin@virtuozzo.com>
In-Reply-To: <20170418155918.32550-1-pbutsykin@virtuozzo.com>
References: <20170418155918.32550-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 libfdisk/src/dos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libfdisk/src/dos.c b/libfdisk/src/dos.c
index 39e42e3e6..8f54f7369 100644
--- a/libfdisk/src/dos.c
+++ b/libfdisk/src/dos.c
@@ -2025,7 +2025,7 @@ static int dos_set_partition(struct fdisk_context *cxt, size_t n,
 	orgtype = p->sys_ind;
 
 	if (pa->type) {
-		if (IS_EXTENDED(pa->type->code) && l->ext_offset) {
+		if (IS_EXTENDED(pa->type->code) && l->ext_offset && l->ext_index != n) {
 			fdisk_warnx(cxt, _("Extended partition already exists."));
 			return -EINVAL;
 		}
-- 
2.11.0

