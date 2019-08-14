Return-Path: <SRS0=UJgV=WK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12579C433FF
	for <util-linux@archiver.kernel.org>; Wed, 14 Aug 2019 16:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBDA20665
	for <util-linux@archiver.kernel.org>; Wed, 14 Aug 2019 16:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="htjSEzuh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VDm2YaQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfHNQpH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:45:07 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:55827 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbfHNQpH (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 14 Aug 2019 12:45:07 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id AB32B539
        for <util-linux@vger.kernel.org>; Wed, 14 Aug 2019 12:45:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 14 Aug 2019 12:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=a+vdqdKT75IUR
        JZtLDrtQNJnq7piLMbXUZB8LfACSUM=; b=htjSEzuhXPyuxkm/LO0jgxboPXvU/
        nLgTxo4fNRRUP3WjaKcrdheAaa/G7UaQH3aiXnRUlJVmCBlUMu5GTRYMHUZBmjCw
        VQ5hLpvYZRAUPIVDeN9elcSg6p22J+8H4YKzD/lRYgKDk5iXic1M3ZPpOJPZXG+u
        CW/LxkwawRR6qULoJ3WhtxrcG7p5aurRXIg4E+nUq3gTlGHy6hH6uDVbVKw6CZuE
        VkkaMkxexg0gbqG7pZNP08HKmIzA6HLmdNHYcEPD/Eq7m7ZImKx4sYZGgsWgs24S
        m6EIshkKnK97Xpa7oGlPqbZ6D6ES8/10uV8pDckWyEt3k90TJUbWxGsOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=a+vdqdKT75IURJZtLDrtQNJnq7piLMbXUZB8LfACSUM=; b=VDm2YaQw
        i4LzjkcKieoSZbpN7IWaP6hC3z5hXLuzM1dUNc8ggbSoxNGe+wmNXETkIOQUE1Wk
        SYLd1UIofRbbk5p516d27G2hR3QdRPiGD9M+vZZ5TBF5LQOj9AZPltp3tbbf4Um/
        4cYWkJ3kYYqMiVo1wK6l9u3Rv9f8ThNl5VbM88v8drrYnKPoRiUBCsMP9LdfZ8PL
        D8mHqepwmADKIDFzBeL4RkQfca+rrtVQxgaOQ0Pwi1gI44gEMiPJ2/srQ1XLR8vj
        7DSDyF1HxR4oJSg29TRQ+XT4L3knctZPFlY3wf+8ZqFNEGPu4Nx+Mn2FAgsOavVl
        kzzgxxl1KmrdOw==
X-ME-Sender: <xms:kjpUXR8FFetNprvFTgsVSHJkGsunIEV0xXfXw6qjzxoTgh_UpGpSgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddvledggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecukfhppeejkedrheegrddujedvrddvudehnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:kjpUXYEuk3jFVSvbY_V26PIzkuCOyXapLMj-w2XP0K72hEBNX81ilw>
    <xmx:kjpUXYS08UgScnMWZM8l4YK-ohE4cLRm89jITpNF-hO_YPYb4KWU8w>
    <xmx:kjpUXYkfiaS_m8EwhClR3Ui85NqAGylkqh5ebR89f3WXY5oirAo3CQ>
    <xmx:kjpUXV-XOyYsJxrJvMDYeb4j869I1NCl8xO1HriXf8Soon0QEW3wAA>
Received: from NSJAIL (x4e36acd7.dyn.telefonica.de [78.54.172.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 87BAB380074
        for <util-linux@vger.kernel.org>; Wed, 14 Aug 2019 12:45:05 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 551f165e (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 14 Aug 2019 16:45:00 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/4] login-utils/islocal: fix missing header for err macro
Date:   Wed, 14 Aug 2019 18:45:05 +0200
Message-Id: <1356a76a4cd68b7ceb0d21308dc3b7b5f2fd605e.1565800625.git.ps@pks.im>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <cover.1565800625.git.ps@pks.im>
References: <cover.1565800625.git.ps@pks.im>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

While "login-utils/islocal.c" makes use of the `err` macro, it doesn't
include the "c.h" header that declares it. Until now, it has been
transitively included via "closestream.h", but as closestream's
implementation is about to get moved to its own compilation unit in
"lib/", this transitive include is going to be removed.

Explicitly include "c.h" to fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 login-utils/islocal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/login-utils/islocal.c b/login-utils/islocal.c
index 469bc5629..971e9626f 100644
--- a/login-utils/islocal.c
+++ b/login-utils/islocal.c
@@ -22,6 +22,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 
+#include "c.h"
 #include "closestream.h"
 #include "islocal.h"
 #include "nls.h"
-- 
2.22.1

