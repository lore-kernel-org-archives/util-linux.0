Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f41.google.com ([74.125.82.41]:32960 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068AbcEMKmY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 13 May 2016 06:42:24 -0400
Received: by mail-wm0-f41.google.com with SMTP id g17so2722639wme.0
        for <util-linux@vger.kernel.org>; Fri, 13 May 2016 03:42:24 -0700 (PDT)
From: Sassan Panahinejad <sassan@sassan.me.uk>
To: util-linux@vger.kernel.org
Cc: Sassan Panahinejad <sassan@sassan.me.uk>
Subject: [PATCH v3 2/3] fdisk: Add support for altering GPT size
Date: Fri, 13 May 2016 11:42:14 +0100
Message-Id: <1463136134-2854-1-git-send-email-sassan@sassan.me.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Adds an options (l) to the GPT menu to resize the GPT.
---

v3 updated to fix miscalculation of maximum value

 disk-utils/fdisk-menu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/disk-utils/fdisk-menu.c b/disk-utils/fdisk-menu.c
index b099cc3..ce3422c 100644
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
+	                rc =  fdisk_ask_number(cxt, 1, fdisk_get_npartitions(cxt),
+	                                ~(uint32_t)0, _("New maximum entries"), &length);
+			if (rc)
+				return rc;
+			return fdisk_gpt_set_npartitions(cxt, length);
 		case 'M':
 			mbr = fdisk_new_nested_context(cxt, "dos");
 			if (!mbr)
-- 
2.1.0

