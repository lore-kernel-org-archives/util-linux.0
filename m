Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2742FC55ABD
	for <util-linux@archiver.kernel.org>; Tue, 10 Nov 2020 16:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD21F20797
	for <util-linux@archiver.kernel.org>; Tue, 10 Nov 2020 16:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgKJQFI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 10 Nov 2020 11:05:08 -0500
Received: from foss.arm.com ([217.140.110.172]:58098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730186AbgKJQFI (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 10 Nov 2020 11:05:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D1EE1396;
        Tue, 10 Nov 2020 08:05:07 -0800 (PST)
Received: from u200856.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 533AC3F718;
        Tue, 10 Nov 2020 08:05:07 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     util-linux@vger.kernel.org
Cc:     jbastian@redhat.com, kzak@redhat.com, riku.voipio@iki.fi,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH] lscpu: Even more Arm part numbers
Date:   Tue, 10 Nov 2020 10:05:04 -0600
Message-Id: <20201110160504.134143-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Over the past two years Arm has published further MIDR/part numbers
on https://developer.arm.com/ip-products/processors/cortex-a.

Lets sync the arm_part structure for A65, A76AE, A77 and A78*.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 sys-utils/lscpu-arm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 20c7291e5..18e542bfe 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -74,16 +74,22 @@ static const struct id_part arm_part[] = {
     { 0xd03, "Cortex-A53" },
     { 0xd04, "Cortex-A35" },
     { 0xd05, "Cortex-A55" },
+    { 0xd06, "Cortex-A65" },
     { 0xd07, "Cortex-A57" },
     { 0xd08, "Cortex-A72" },
     { 0xd09, "Cortex-A73" },
     { 0xd0a, "Cortex-A75" },
     { 0xd0b, "Cortex-A76" },
     { 0xd0c, "Neoverse-N1" },
+    { 0xd0d, "Cortex-A77" },
+    { 0xd0e, "Cortex-A76AE" },
     { 0xd13, "Cortex-R52" },
     { 0xd20, "Cortex-M23" },
     { 0xd21, "Cortex-M33" },
+    { 0xd41, "Cortex-A78" },
+    { 0xd42, "Cortex-A78AE" },
     { 0xd4a, "Neoverse-E1" },
+    { 0xd4b, "Cortex-A78C" },
     { -1, "unknown" },
 };
 
-- 
2.26.2

