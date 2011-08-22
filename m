Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-out.m-online.net ([212.18.0.9]:46376 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575Ab1HVVPI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Aug 2011 17:15:08 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id E14471C0F568
	for <util-linux@vger.kernel.org>; Mon, 22 Aug 2011 23:15:04 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id DE4561C00089
	for <util-linux@vger.kernel.org>; Mon, 22 Aug 2011 23:15:04 +0200 (CEST)
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id rxEfPrqLXOxU for <util-linux@vger.kernel.org>;
	Mon, 22 Aug 2011 23:15:04 +0200 (CEST)
Received: from igel.home (ppp-88-217-124-63.dynamic.mnet-online.de [88.217.124.63])
	by mail.mnet-online.de (Postfix) with ESMTP
	for <util-linux@vger.kernel.org>; Mon, 22 Aug 2011 23:15:04 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] lomount: correct qsort compare function
Date: Mon, 22 Aug 2011 23:15:03 +0200
Message-ID: <m2obzhywq0.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Return the correct value from comparing the operands.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 mount/lomount.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mount/lomount.c b/mount/lomount.c
index 34d151a..fad58d5 100644
--- a/mount/lomount.c
+++ b/mount/lomount.c
@@ -285,7 +285,7 @@ name2minor(int hasprefix, const char *name)
 static int
 cmpnum(const void *p1, const void *p2)
 {
-	return (* (int *) p1) > (* (int *) p2);
+	return (*(int *) p1 > *(int *) p2) - (*(int *) p1 < *(int *) p2);
 }
 
 /*
-- 
1.7.6


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
