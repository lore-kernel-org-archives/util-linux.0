Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33004 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbcEKOy1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 11 May 2016 10:54:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id r12so9962501wme.0
        for <util-linux@vger.kernel.org>; Wed, 11 May 2016 07:54:27 -0700 (PDT)
From: Sassan Panahinejad <sassan@sassan.me.uk>
To: util-linux@vger.kernel.org
Cc: Sassan Panahinejad <sassan@sassan.me.uk>
Subject: [PATCH 2/3] fdisk: Add support for altering GPT size
Date: Wed, 11 May 2016 15:54:17 +0100
Message-Id: <1462978458-13908-2-git-send-email-sassan@sassan.me.uk>
In-Reply-To: <1462978458-13908-1-git-send-email-sassan@sassan.me.uk>
References: <1462978458-13908-1-git-send-email-sassan@sassan.me.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Adds an options (l) to the GPT menu to resize the GPT.
---
 disk-utils/fdisk-menu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/disk-utils/fdisk-menu.c b/disk-utils/fdisk-menu.c
index b099cc3..21cde24 100644
--- a/disk-utils/fdisk-menu.c
+++ b/disk-utils/fdisk-menu.c
@@ -165,6 +165,7 @@ struct menu menu_gpt = {
 		MENU_XENT('i', N_("change disk GUID")),
 		MENU_XENT('n', N_("change partition name")),
 		MENU_XENT('u', N_("change partition UUID")),
+		MENU_XENT('l', N_("change table length")),
 		MENU_XENT('M', N_("enter protective/hybrid MBR")),
 
 		MENU_XSEP(""),
@@ -691,6 +692,7 @@ static int gpt_menu_cb(struct fdisk_context **cxt0,
 	struct fdisk_partition *pa = NULL;
 	size_t n;
 	int rc = 0;
+	unsigned long length;
 
 	assert(cxt);
 	assert(ent);
@@ -702,6 +704,12 @@ static int gpt_menu_cb(struct fdisk_context **cxt0,
 		switch (ent->key) {
 		case 'i':
 			return fdisk_set_disklabel_id(cxt);
+		case 'l':
+	                rc =  fdisk_ask_number(cxt, 1, fdisk_get_disklabel_length(cxt),
+	                                ~0UL, _("New maximum entries"), &length);
+			if (rc)
+				return rc;
+			return fdisk_set_disklabel_length(cxt, length);
 		case 'M':
 			mbr = fdisk_new_nested_context(cxt, "dos");
 			if (!mbr)
-- 
2.1.0

