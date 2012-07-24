Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:34313 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753305Ab2GXLw7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 07:52:59 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 424D6A3F4A
	for <util-linux@vger.kernel.org>; Tue, 24 Jul 2012 13:52:58 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 1/2] fdisk: fix compiler warning [-Werror=unused-variable]
Date: Tue, 24 Jul 2012 13:52:31 +0200
Message-Id: <1343130752-6626-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisks/fdisk.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 4731918..244f0e7 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -1604,7 +1604,6 @@ gpt_warning(char *dev)
 /* Print disk geometry and partition table of a specified device (-l option) */
 static void print_partition_table_from_option(char *device, unsigned long sector_size)
 {
-	int gb;
 	struct fdisk_context *cxt;
 
 	cxt = fdisk_new_context_from_filename(device, 1);	/* read-only */
-- 
1.7.10.4

