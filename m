Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E102C433F5
	for <util-linux@archiver.kernel.org>; Thu, 20 Jan 2022 12:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbiATMQs (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 20 Jan 2022 07:16:48 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43636 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiATMQs (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 20 Jan 2022 07:16:48 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6ADC321709;
        Thu, 20 Jan 2022 12:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642681007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YbX5jwKkfwwPtG/QbEMGHb+Qmy/flGqycU5bNiNjsEA=;
        b=vPZbaE6DrmaD4eZG3lmnd/z9vkLSA6xLvwCTY5rTak/QjzKF7j1Gt10V+9bR0rc37DLDCN
        yglt7madtLJk04JBXNBPGvaYLzbPFr9nXK6TY5CH5oZ5bhhb1WM2xUNEHeG2wx3eAbfBzJ
        l0yg1W5n8WMG6X1jyvevAye/+cBKUt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642681007;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YbX5jwKkfwwPtG/QbEMGHb+Qmy/flGqycU5bNiNjsEA=;
        b=T4C4Cq/wt1DYMaUgusY8LvHwzrp1mHTqBb1Kv6y/bVbVldBna0xX9qbj4ySMj6BP+ITTXx
        /fd77jF/bqY41kDw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5E216A3B83;
        Thu, 20 Jan 2022 12:16:47 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 22B0FA05D9; Thu, 20 Jan 2022 13:16:44 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] loopdev: Properly translate errors from ul_path_read_*()
Date:   Thu, 20 Jan 2022 13:16:38 +0100
Message-Id: <20220120121639.13047-1-jack@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

A few callsites do not translate error from ul_path_read_*() and just
treat it as error code leading to confusing EPERM errors.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/loopdev.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/loopdev.c b/lib/loopdev.c
index b5da1516e37f..27ab06c66848 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -739,7 +739,8 @@ int loopcxt_get_offset(struct loopdev_cxt *lc, uint64_t *offset)
 	int rc = -EINVAL;
 
 	if (sysfs)
-		rc = ul_path_read_u64(sysfs, offset, "loop/offset");
+		if (ul_path_read_u64(sysfs, offset, "loop/offset") == 0)
+			rc = 0;
 
 	if (rc && loopcxt_ioctl_enabled(lc)) {
 		struct loop_info64 *lo = loopcxt_get_info(lc);
@@ -767,7 +768,8 @@ int loopcxt_get_blocksize(struct loopdev_cxt *lc, uint64_t *blocksize)
 	int rc = -EINVAL;
 
 	if (sysfs)
-		rc = ul_path_read_u64(sysfs, blocksize, "queue/logical_block_size");
+		if (ul_path_read_u64(sysfs, blocksize, "queue/logical_block_size") == 0)
+			rc = 0;
 
 	/* Fallback based on BLKSSZGET ioctl */
 	if (rc) {
@@ -799,7 +801,8 @@ int loopcxt_get_sizelimit(struct loopdev_cxt *lc, uint64_t *size)
 	int rc = -EINVAL;
 
 	if (sysfs)
-		rc = ul_path_read_u64(sysfs, size, "loop/sizelimit");
+		if (ul_path_read_u64(sysfs, size, "loop/sizelimit") == 0)
+			rc = 0;
 
 	if (rc && loopcxt_ioctl_enabled(lc)) {
 		struct loop_info64 *lo = loopcxt_get_info(lc);
-- 
2.31.1

