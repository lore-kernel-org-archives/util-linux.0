Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:64149 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab3GBOnA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Jul 2013 10:43:00 -0400
From: Bernhard Voelker <mail@bernhard-voelker.de>
To: util-linux@vger.kernel.org
Cc: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: [PATCH] findmnt: avoid unused parameter warning
Date: Tue,  2 Jul 2013 16:42:29 +0200
Message-Id: <1372776149-20214-1-git-send-email-mail@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 misc-utils/findmnt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 85d8b63..e78362a 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -431,6 +431,8 @@ static const char *get_tag(struct libmnt_fs *fs, const char *tagname, int col)
 #ifdef HAVE_LIBUDEV
 		if (dev)
 			res = get_tag_from_udev(dev, col);
+#else
+    (void) col; /* avoid unused parameter warning */
 #endif
 		if (!res)
 			res = mnt_cache_find_tag_value(cache, dev, tagname);
-- 
1.8.3.1

