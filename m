Return-Path: <SRS0=Zy3D=WL=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72881C31E40
	for <util-linux@archiver.kernel.org>; Thu, 15 Aug 2019 12:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E222173E
	for <util-linux@archiver.kernel.org>; Thu, 15 Aug 2019 12:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WAlpoc6r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V5xcA7yU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfHOMDU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 15 Aug 2019 08:03:20 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41011 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730638AbfHOMDT (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 15 Aug 2019 08:03:19 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 10CBD221DF
        for <util-linux@vger.kernel.org>; Thu, 15 Aug 2019 08:03:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 15 Aug 2019 08:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=G165+yqHbQDGaRroqd/Ae5oLgh
        LiPkK5GK1XFUFnvaA=; b=WAlpoc6rdkSBf8Gebtr9H+YgMG1LEFOSNp0YenvXW0
        SYjTl5WYgdLDqbvp7Wl+mpp6rgdfuCeov5Jc4B6HcKWBOYqF9y1023596m9AC2ew
        gkBXuYhKP2KTXkwz43AZRI/I0rlK9SZnWrHO9NiZM9uyyeNSqGcefP5bNRJLbu7N
        SMJiKwzHkXfrO1BSlv/qt8ZXvr4n+SjnmgwGZExrsgJk4CqxULvXc355sSOIhsc+
        NyAd7pAgB1vJ/bzzl5DL9RLY1DWKf63J9jEWxO2GKZ6cXzKuaB1vqGdGS/AuELLI
        KYDr1922E5P2lY9W3wAswe3+X4JlEGyj/leY5u6BlaCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=G165+yqHbQDGaRroq
        d/Ae5oLghLiPkK5GK1XFUFnvaA=; b=V5xcA7yUDm3JHFieuAa9cxwVHqDDh9+QE
        mmIzFR2Dqu73ZJEji0pUESvQOW3egajVQHhKG3Xgv9fGkpJWiCwxJCx/kmcPkDBH
        xOBS//3W7V2X6ldysWPgfmR+eSkClFm/5SpWwpYOQWlFqq+3nRlRA1aTA0hGbT4n
        Pi+J1DCbp10wbJfzcNoJBSeH8B3NB5rtO9CYiT0n68k4Wvx0Q7Qz0dKQ9x9+iDnb
        5LQEpaWXmZSBlcV+UFhKJz4ufA4AB425nTnwSJs+Xq65ETA2wmSKd01jH/s2ggm4
        zb3C0EvVuTg7qcIZKvirIbi+sx7XpPvpCnw0qItmvAJkBd7u05zmQ==
X-ME-Sender: <xms:BkpVXSoohc_aFdvUZYCDXB_inti8cKzkhC8bAJQ511W2t2dyfskTGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudefuddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecukfhppeejkedrheegrdeiuddrheefnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehpshesphhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:BkpVXfpUh0ZcegD90SyKnEA45XrgsfyxX6natpj5IzGwD4S7ifbCHg>
    <xmx:BkpVXXWqy2mttydNOBvo_5z0zAnMEdAhm91sQhwxLLLGhniTQZ7Ndw>
    <xmx:BkpVXUSZRw9WLGqWendOvtnIgNS_ur136JHrxNM8S3BhZDXzvGEaVg>
    <xmx:B0pVXWAaNqhv8POWWoSICT3zgbt-tHGhmu3KOhN2qgTLUT3pQ_MU2g>
Received: from NSJAIL (x4e363d35.dyn.telefonica.de [78.54.61.53])
        by mail.messagingengine.com (Postfix) with ESMTPA id E87D5380075
        for <util-linux@vger.kernel.org>; Thu, 15 Aug 2019 08:03:17 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id a622bf86 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 15 Aug 2019 12:03:14 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] wdctl: remove duplicate include of <unistd.h>
Date:   Thu, 15 Aug 2019 14:03:23 +0200
Message-Id: <1c54caa4c6e6643c149e968206c743f910902a94.1565870582.git.ps@pks.im>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The <unistd.h> header is included twice in "wdctl.c". Remove one
of these includes to keep "make checkincludes" happy.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sys-utils/wdctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sys-utils/wdctl.c b/sys-utils/wdctl.c
index 0bb245bae..8de5d5a2d 100644
--- a/sys-utils/wdctl.c
+++ b/sys-utils/wdctl.c
@@ -21,7 +21,6 @@
 #include <sys/ioctl.h>
 #include <getopt.h>
 #include <stdio.h>
-#include <unistd.h>
 #include <signal.h>
 #include <assert.h>
 #include <linux/watchdog.h>
-- 
2.22.1

