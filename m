Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.187]:64708 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab2GXL0N (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Jul 2012 07:26:13 -0400
Message-ID: <500E8653.8050604@bernhard-voelker.de>
Date: Tue, 24 Jul 2012 13:26:11 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] fdisk: de-duplicate disk label strings
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



>From 91b486e98aaa72083ffec491b931dbab368e8a19 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Tue, 24 Jul 2012 13:18:16 +0200
Subject: [PATCH] fdisk: de-duplicate disk label strings

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 fdisks/fdisk.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 4731918..9f06901 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -1528,7 +1528,7 @@ expert_command_prompt(struct fdisk_context *cxt)
 				fix_partition_table_order();
 			break;
 		case 'g':
-			fdisk_create_disklabel(cxt, "sgi");
+			fdisk_create_disklabel(cxt, sgi_label.name);
 			break;
 		case 'h':
 			user_heads = cxt->geom.heads = read_int(cxt, 1, cxt->geom.heads, 256, 0,
@@ -1755,7 +1755,7 @@ static void command_prompt(struct fdisk_context *cxt)
 			new_partition(cxt);
 			break;
 		case 'o':
-			fdisk_create_disklabel(cxt, "dos");
+			fdisk_create_disklabel(cxt, dos_label.name);
 			break;
 		case 'p':
 			list_table(cxt, 0);
@@ -1763,7 +1763,7 @@ static void command_prompt(struct fdisk_context *cxt)
 		case 'q':
 			handle_quit(cxt);
 		case 's':
-			fdisk_create_disklabel(cxt, "sun");
+			fdisk_create_disklabel(cxt, sun_label.name);
 			break;
 		case 't':
 			change_sysid(cxt);
-- 
1.7.7


