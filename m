Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:63057 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754157AbaGULhQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Jul 2014 07:37:16 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] cfdisk: actually translate the partition types in the menu
Date: Mon, 21 Jul 2014 13:37:11 +0200
Message-Id: <1405942631-28636-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 715e07d..f3ca42c 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1507,7 +1507,7 @@ static struct fdisk_parttype *ui_get_parttype(struct cfdisk *cf,
 			continue;
 		cm[i].userdata = x;
 		if (!has_typestr)
-			xasprintf(&name, "%2x %s", x->type, x->name);
+			xasprintf(&name, "%2x %s", x->type, _(x->name));
 		else {
 			name = (char *) x->name;
 			cm[i].desc = x->typestr;
-- 
1.7.0.4

