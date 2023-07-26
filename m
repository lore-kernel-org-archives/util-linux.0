Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E49C0015E
	for <util-linux@archiver.kernel.org>; Wed, 26 Jul 2023 20:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjGZUyY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 26 Jul 2023 16:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGZUyX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 26 Jul 2023 16:54:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44D3F19AD
        for <util-linux@vger.kernel.org>; Wed, 26 Jul 2023 13:54:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1568D75;
        Wed, 26 Jul 2023 13:55:04 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BBB5A3F67D;
        Wed, 26 Jul 2023 13:54:21 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     util-linux@vger.kernel.org
Cc:     Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] lscpu: Even more Arm part numbers (early 2023)
Date:   Wed, 26 Jul 2023 15:54:20 -0500
Message-ID: <20230726205420.68911-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

There have been further MIDR/part numbers published
on https://developer.arm.com, they include:

Cortex-X4, Cortex-A520, Cortex-A720, Cortex-M85,
Cortex-M55 and Cortex-R52+.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 sys-utils/lscpu-arm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index d83e948b0..779598368 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -79,8 +79,11 @@ static const struct id_part arm_part[] = {
     { 0xd0e, "Cortex-A76AE" },
     { 0xd13, "Cortex-R52" },
     { 0xd15, "Cortex-R82" },
+    { 0xd16, "Cortex-R52+" },
     { 0xd20, "Cortex-M23" },
     { 0xd21, "Cortex-M33" },
+    { 0xd22, "Cortex-M55" },
+    { 0xd23, "Cortex-M85" },
     { 0xd40, "Neoverse-V1" },
     { 0xd41, "Cortex-A78" },
     { 0xd42, "Cortex-A78AE" },
@@ -96,6 +99,9 @@ static const struct id_part arm_part[] = {
     { 0xd4d, "Cortex-A715" },
     { 0xd4e, "Cortex-X3" },
     { 0xd4f, "Neoverse-V2" },
+    { 0xd80, "Cortex-A520" },
+    { 0xd81, "Cortex-A720" },
+    { 0xd82, "Cortex-X4" },
     { -1, "unknown" },
 };
 
-- 
2.41.0

