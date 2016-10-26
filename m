Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:60727 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932565AbcJZOro (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Oct 2016 10:47:44 -0400
Received: from zappa.ga.local ([87.128.112.108]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0LymHf-1cwNg325nL-0165Lb for
 <util-linux@vger.kernel.org>; Wed, 26 Oct 2016 16:47:40 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] libfdisk: fix uninizialized fdisk_labelitem
Date: Wed, 26 Oct 2016 16:47:39 +0200
Message-Id: <1477493259-14586-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

fdisk -l could crash randomly. Only seen on some i586 systems with
certain exotic compiler options.

The problem was that this item is later used in
function fdisk_reset_labelitem() like this:

    if (item.type == 's')
        free(li->data.str);

This may crash if item is randomly initialited.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libfdisk/src/label.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libfdisk/src/label.c b/libfdisk/src/label.c
index 5cbbe42..0e83fdf 100644
--- a/libfdisk/src/label.c
+++ b/libfdisk/src/label.c
@@ -416,7 +416,7 @@ int fdisk_locate_disklabel(struct fdisk_context *cxt, int n, const char **name,
  */
 int fdisk_get_disklabel_id(struct fdisk_context *cxt, char **id)
 {
-	struct fdisk_labelitem item;
+	struct fdisk_labelitem item = {0};
 	int rc;
 
 	if (!cxt || !cxt->label || !id)
-- 
1.8.5.6

