Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E88ECAAD2
	for <util-linux@archiver.kernel.org>; Thu,  1 Sep 2022 21:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiIAVwk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 1 Sep 2022 17:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIAVwj (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 1 Sep 2022 17:52:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DB0478584
        for <util-linux@vger.kernel.org>; Thu,  1 Sep 2022 14:52:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21535D6E;
        Thu,  1 Sep 2022 14:52:44 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF6863F7B4;
        Thu,  1 Sep 2022 14:52:37 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     util-linux@vger.kernel.org
Cc:     Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] lscpu: Even more Arm part numbers
Date:   Thu,  1 Sep 2022 16:52:30 -0500
Message-Id: <20220901215230.2543624-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Arm has published further MIDR/part numbers on
https://developer.arm.com/ip-products/processors/cortex-a.
Some of the new ones have already been merged, so lets
fill in the gaps with A34, A65AE and X1C.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 sys-utils/lscpu-arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index ac3703e1e..9222b77ed 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -64,6 +64,7 @@ static const struct id_part arm_part[] = {
     { 0xc27, "Cortex-M7" },
     { 0xc60, "Cortex-M0+" },
     { 0xd01, "Cortex-A32" },
+    { 0xd02, "Cortex-A34" },
     { 0xd03, "Cortex-A53" },
     { 0xd04, "Cortex-A35" },
     { 0xd05, "Cortex-A55" },
@@ -82,6 +83,7 @@ static const struct id_part arm_part[] = {
     { 0xd40, "Neoverse-V1" },
     { 0xd41, "Cortex-A78" },
     { 0xd42, "Cortex-A78AE" },
+    { 0xd43, "Cortex-A65AE" },
     { 0xd44, "Cortex-X1" },
     { 0xd46, "Cortex-A510" },
     { 0xd47, "Cortex-A710" },
@@ -89,6 +91,7 @@ static const struct id_part arm_part[] = {
     { 0xd49, "Neoverse-N2" },
     { 0xd4a, "Neoverse-E1" },
     { 0xd4b, "Cortex-A78C" },
+    { 0xd4c, "Cortex-X1C" },
     { 0xd4d, "Cortex-A715" },
     { 0xd4e, "Cortex-X3" },
     { -1, "unknown" },
-- 
2.35.3

