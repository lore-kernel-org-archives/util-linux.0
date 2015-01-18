Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:52754 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751609AbbARRtl (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 18 Jan 2015 12:49:41 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] cfdisk: actually translate the table headers and the bottom line
Date: Sun, 18 Jan 2015 18:49:35 +0100
Message-Id: <1421603375-5226-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The printout of the table headers and the bottomline descriptions
were lacking calls to gettext().

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 1d4e2d5..9c2424d 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -334,7 +334,7 @@ static char *table_to_string(struct cfdisk *cf, struct fdisk_table *tb)
 			fl |= SCOLS_FL_TREE;
 
 		if (!scols_table_new_column(table,
-				fdisk_field_get_name(field),
+				_(fdisk_field_get_name(field)),
 				fdisk_field_get_width(field), fl))
 			goto done;
 	}
@@ -1009,7 +1009,7 @@ static void ui_draw_menuitem(struct cfdisk *cf,
 	if (cf->menu->idx == idx) {
 		standend();
 		if (d->desc)
-			ui_hint(d->desc);
+			ui_hint(_(d->desc));
 	}
 }
 
-- 
1.7.0.4

