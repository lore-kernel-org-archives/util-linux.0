Return-Path: <SRS0=UJgV=WK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378A9C32753
	for <util-linux@archiver.kernel.org>; Wed, 14 Aug 2019 16:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF932084F
	for <util-linux@archiver.kernel.org>; Wed, 14 Aug 2019 16:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NX6UaxbG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JrZcEx4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfHNQpI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:45:08 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:59857 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbfHNQpH (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 14 Aug 2019 12:45:07 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 4640653A
        for <util-linux@vger.kernel.org>; Wed, 14 Aug 2019 12:45:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 14 Aug 2019 12:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=pDE2V8ZElaFDl
        LEwnrHbQEnKg7h4tPLSSRyp//Z5sns=; b=NX6UaxbGuQ6EUjPKJnuWq4p5lObr2
        aJHIBlcmDlkk/LCUFm3Pak5O1PdpyNceNvk/RAu3Jkuh+rwxuU3+tQYN7qEGLY/h
        pOcIcm2R01IMBq4ad1mDRKCw6anyvcEgIKlPbEhG8mmIZsxKMiJI282aO2I0BceB
        52zWQ3Yj8lN44+tiuYdfAUAkCy/o1SwuO2Ft1BvKnuImHvvRnT9YjDz5cb00evlC
        viNH7e/zyxdsChkZ/4UUGwSoQZE+WOwpw7TNkSkKLXTSyJeWKVT3N9GjOYKY5qjf
        G7Bgjnpj38/9/ySo+aegSVIQLKFjGkL6yqCAjHLr5x+XxE/pWut8Eyhqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=pDE2V8ZElaFDlLEwnrHbQEnKg7h4tPLSSRyp//Z5sns=; b=JrZcEx4W
        9GgdDudKx3ieGbXGCe2SVwSAkyIql+Iw4vYdq8Pt7ZsO+N7bVd2j4v2Y0p/c9aT/
        DDjhMRSc1z/tih/ErhBGLw9iVQIrrjYnGf+cacFvVB2xJYOqi86R+fWTrTzlwAHi
        hOv5UbWXg+DrF7DHYumQyfAJRH+DuGE92OCHVpdR3j9hjhPb9Lw9nm00c+0CZykx
        5T+Lqdurduj0m6GrjrGd7bgpmj5nF1pBDRu8xysRc+X2H5dHe8N72FpCShY253Qj
        3GpUWC4AXWRfw6S4y6OoI7K5hpU7lsHsXQUVF8X+tUO7K5fBsk9f2qI5nTSDRfMa
        j2FB+op4CoJwXA==
X-ME-Sender: <xms:kTpUXSkKs-9exVnEsmTpC2efIABq44KfQAkU9_ujzuBOQY3SyRgZlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddvledggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecukfhppeejkedrheegrddujedvrddvudehnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:kTpUXdvjJeK7tkzsmQJfjRoCP6ipCUXAScypqzUvrKFTV5QiQAHNLw>
    <xmx:kTpUXeXgkZ_VuPAMBQPi7gyeVHwccdC-5bayPNPER26S6P4kmepuAA>
    <xmx:kTpUXfnpW7fkVRP7my20vPqiIr--Bqud0xQ5jUURwBWIIzbS1PqPfg>
    <xmx:kTpUXXjaeqT0hduaZbv9JPiO8kcazJK9jDefufclx1LxS3-pYGJbMg>
Received: from NSJAIL (x4e36acd7.dyn.telefonica.de [78.54.172.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 295818005A
        for <util-linux@vger.kernel.org>; Wed, 14 Aug 2019 12:45:05 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 7d43684b (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 14 Aug 2019 16:45:00 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/4] term-utils/ttymsg: fix missing header for ARRAY_SIZE macro
Date:   Wed, 14 Aug 2019 18:45:04 +0200
Message-Id: <d7bcc791545f649a1c87ad38366d654b52187760.1565800625.git.ps@pks.im>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <cover.1565800625.git.ps@pks.im>
References: <cover.1565800625.git.ps@pks.im>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

While "term-utils/ttymsg.c" makes use of the `ARRAY_SIZE` macro, it
doesn't include the "c.h" header that declares it. Until now, it has
been transitively included via "closestream.h", but as closestream's
implementation is about to get moved to its own compilation unit in
"lib/", this transitive include is going to be removed.

Explicitly include "c.h" to fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 term-utils/ttymsg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/term-utils/ttymsg.c b/term-utils/ttymsg.c
index 2aab69f10..04c867e95 100644
--- a/term-utils/ttymsg.c
+++ b/term-utils/ttymsg.c
@@ -53,6 +53,7 @@
 #include <string.h>
 #include <stdlib.h>
 
+#include "c.h"
 #include "nls.h"
 #include "closestream.h"
 #include "pathnames.h"
-- 
2.22.1

