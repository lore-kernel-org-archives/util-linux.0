Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:55762 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760266AbaGYMXN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 25 Jul 2014 08:23:13 -0400
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id DD02C24340
	for <util-linux@vger.kernel.org>; Fri, 25 Jul 2014 14:22:40 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] cfdisk: reenable cursor when quitting
Date: Fri, 25 Jul 2014 14:22:01 +0200
Message-Id: <1406290922-25357-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

After quitting cfdisk (built with slang) the cursor would be
missing at the command prompt.

Reported-by: Martin Steigerwald <Martin@Lichtvoll.de>
Addresses-Debian-Bug: #755991
Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 disk-utils/cfdisk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 5a42ab1..dfdaaf0 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1966,6 +1966,7 @@ static int ui_run(struct cfdisk *cf)
 
 	menu_pop(cf);
 
+	curs_set(1);
 	DBG(FRONTEND, ul_debug("ui: end"));
 
 	return 0;
-- 
2.0.1

