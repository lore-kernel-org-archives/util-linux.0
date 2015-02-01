Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:56979 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753662AbbBAVMZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Feb 2015 16:12:25 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] sfdisk: actually translate the table headers by calling gettext()
Date: Sun,  1 Feb 2015 22:12:14 +0100
Message-Id: <1422825134-18539-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/fdisk-list.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/disk-utils/fdisk-list.c b/disk-utils/fdisk-list.c
index c65b8b4..e8a0596 100644
--- a/disk-utils/fdisk-list.c
+++ b/disk-utils/fdisk-list.c
@@ -136,7 +136,7 @@ void list_disklabel(struct fdisk_context *cxt)
 			fl |= SCOLS_FL_TRUNC;
 
 		co = scols_table_new_column(out,
-				fdisk_field_get_name(field),
+				_(fdisk_field_get_name(field)),
 				fdisk_field_get_width(field), fl);
 		if (!co)
 			goto done;
-- 
1.7.0.4

