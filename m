Return-Path: <SRS0=Ur/j=QA=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBD3C282C3
	for <util-linux@archiver.kernel.org>; Thu, 24 Jan 2019 10:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BBB217D4
	for <util-linux@archiver.kernel.org>; Thu, 24 Jan 2019 10:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfAXKdt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:33:49 -0500
Received: from hermes.aosc.io ([199.195.250.187]:44507 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbfAXKdt (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 24 Jan 2019 05:33:49 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 5F20A120300;
        Thu, 24 Jan 2019 10:33:45 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     util-linux@vger.kernel.org
Cc:     Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] libfdisk: (gpt) add HiFive Unleashed bootloader partition UUIDs
Date:   Thu, 24 Jan 2019 18:33:34 +0800
Message-Id: <20190124103334.51808-1-icenowy@aosc.io>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The HiFive Unleashed SBC's bootloader seeks for GPT partitions with
specific UUID for loading the next stage bootloader (ZSBL loads FSBL,
and FSBL loads BBL).

Add these partition type UUIDs.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 libfdisk/src/gpt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index d1d0c434d..b12a9cb60 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -284,7 +284,11 @@ static struct fdisk_parttype gpt_parttypes[] =
 	DEF_GUID("CEF5A9AD-73BC-4601-89F3-CDEEEEE321A1", N_("QNX6 file system")),
 
 	/* Plan 9 */
-	DEF_GUID("C91818F9-8025-47AF-89D2-F030D7000C2C", N_("Plan 9 partition"))
+	DEF_GUID("C91818F9-8025-47AF-89D2-F030D7000C2C", N_("Plan 9 partition")),
+
+	/* HiFive Unleased bootloaders */
+	DEF_GUID("5B193300-FC78-40CD-8002-E86C45580B47", N_("HiFive Unleashed FSBL")),
+	DEF_GUID("2E54B353-1271-4842-806F-E436D6AF6985", N_("HiFive Unleashed BBL")),
 };
 
 #define alignment_required(_x)  ((_x)->grain != (_x)->sector_size)
-- 
2.18.1

