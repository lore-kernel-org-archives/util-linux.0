Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:59838 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753283AbcJZPEe (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Oct 2016 11:04:34 -0400
Received: from zappa.ga.local ([87.128.112.108]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MdoR7-1cG8iR3eij-00PgxG for
 <util-linux@vger.kernel.org>; Wed, 26 Oct 2016 17:04:31 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH v2] libfdisk: fix uninitialized fdisk_labelitem
Date: Wed, 26 Oct 2016 17:04:30 +0200
Message-Id: <1477494270-15856-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1477493259-14586-1-git-send-email-sweet_f_a@gmx.de>
References: <1477493259-14586-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

fdisk -l could crash randomly. Only seen on some i586 systems with
certain exotic compiler options.

The problem was that this item is later used in
function fdisk_reset_labelitem() like this:

    if (li->type == 's')
        free(li->data.str);

This may crash if item is randomly initialized.

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

