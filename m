Return-Path: <SRS0=jXkZ=NX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F44BC43441
	for <util-linux@archiver.kernel.org>; Mon, 12 Nov 2018 19:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2795D223B0
	for <util-linux@archiver.kernel.org>; Mon, 12 Nov 2018 19:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2795D223B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fatal.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbeKMFpJ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:45:09 -0500
Received: from 82-209-166-85.cust.bredband2.com ([82.209.166.85]:56040 "EHLO
        pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeKMFpJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Nov 2018 00:45:09 -0500
Received: by pi.fatal.se (Postfix, from userid 1000)
        id 42FAB246BB; Mon, 12 Nov 2018 20:50:25 +0100 (CET)
From:   Andreas Henriksson <andreas@fatal.se>
To:     util-linux@vger.kernel.org
Cc:     Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] Fix hidding typo
Date:   Mon, 12 Nov 2018 20:50:23 +0100
Message-Id: <20181112195023.20746-1-andreas@fatal.se>
X-Mailer: git-send-email 2.11.0
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Spelling error spotted by lintian.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 libblkid/src/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 081f8826e..96aecf38b 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -625,7 +625,7 @@ static int hide_buffer(blkid_probe pr, uint64_t off, uint64_t len)
 
 			data = real_off ? x->data + (real_off - x->off) : x->data;
 
-			DBG(BUFFER, ul_debug("\thidding: off=%"PRIu64" len=%"PRIu64,
+			DBG(BUFFER, ul_debug("\thiding: off=%"PRIu64" len=%"PRIu64,
 						off, len));
 			memset(data, 0, len);
 			ct++;
-- 
2.19.1

