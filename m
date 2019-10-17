Return-Path: <SRS0=BLRm=YK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79724C4CECE
	for <util-linux@archiver.kernel.org>; Thu, 17 Oct 2019 06:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4DB2067B
	for <util-linux@archiver.kernel.org>; Thu, 17 Oct 2019 06:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="5ZG80ZMO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sYMin8/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404657AbfJQGAp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 17 Oct 2019 02:00:45 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:55391 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404249AbfJQGAp (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 17 Oct 2019 02:00:45 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 920472E9;
        Thu, 17 Oct 2019 02:00:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 17 Oct 2019 02:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=e3qe+DMXne/rpCTnahdtrbJYu9
        kWh9Y3Vyv4IPGewWQ=; b=5ZG80ZMOeDO/0KtDlb3UNcwL4ezqIUNQGJJl07FxQ2
        fx6pSWEWs/sPUnb2EV25cmHU62Lkh9wfohAzp+sR9MJNiq6E8N7xvIlKjC5y802k
        FJ5kRZHSCkcdW0VcGYV2INzShfBt3bTtcg3+igt9f2OEmQMAmYFJ06NJghuSney5
        r8T8ZkhsRxF0JR2coStRaQ2uOa092wHlvoR4TOJnvfclI6UGRCVV11ag7epUS908
        2SAEb6Q4BbyrsFgDVItsGfpjChypbEPWvKorSZpFla5Cwop5KrZ8YaMxAyJhbvQV
        sOdqXEO8f0okviQPz1JBfythy8uZzapivi/XyKh7IBsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=e3qe+DMXne/rpCTna
        hdtrbJYu9kWh9Y3Vyv4IPGewWQ=; b=sYMin8/YXeBr9de9VO+MbTP4xf5g3b0dN
        yznRC6w4v6JGQ2QOXrJlLEgGKoFby3WK7THqTFWOdL+NNnPkewUSmJECaFJi/KBU
        sOqswI9zobIORpg6XFWREfBGB45XoQhyoHW3TCXNQQ3aR9GBGWiO9GKlnF1aq1Zv
        xsAHy4U5tl2QLP0CqPvqtWUzIth/1IvmH574QlfWm4K0AxGn7E/eawWGd4wTfKmM
        KdzR5w/U0MKyAWvdvn1Gt7eez+Dw5Q9Ywnr4HigRFketoDBmdmE0ihUCva9lRojf
        8EoWb31SayOY9OEgJ7kHx3iPUiSOgcoQxXzs4Fwte+yKIx3OPeVwA==
X-ME-Sender: <xms:iAOoXQ7jVoA8K4b-D180iJLDoOpakkvU_st3Nf_oJMVdQmOGKd9oHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrjeeigddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeekrdehhedrvd
    egiedrhedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmnecuvehl
    uhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:iAOoXe3-cb3HKKCG71XYfUcOtGeu_6vwi9THbGi-FNCkdMsrtdvKDQ>
    <xmx:iAOoXbGW9xE84HPJSnsupTVVLJgdAJsoXdbKM3NXqNhfijHIKOX5AQ>
    <xmx:iAOoXdi9OKm1PwWYbDde3ifh1jCdVdFD7vba9hWKNKWZpuaZRsyiJg>
    <xmx:iQOoXfIKKS2E-alLhtLIvjYtLrBXjZF1JxRFfqOrYP4NekbI4p1e4Q>
Received: from NSJAIL (x4e37f634.dyn.telefonica.de [78.55.246.52])
        by mail.messagingengine.com (Postfix) with ESMTPA id 28CDE80059;
        Thu, 17 Oct 2019 02:00:40 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 46fa551a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Oct 2019 06:00:37 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Karel Zak <kzak@redhat.com>
Subject: [PATCH] lib/path: fix missing header for `struct stat`
Date:   Thu, 17 Oct 2019 08:00:31 +0200
Message-Id: <60c4df91a86c6d4a1f7c811d931030b9b2f5efdb.1571292019.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

In commit b1418ed14 (lib/path: add ul_path_stat(), fix absolute paths,
2019-10-15), a new function `ul_path_stat()` was added to "path.h". This
new function prototype causes a compiler warning on musl libc based
systems due to one of the parameters having the unknown type `struct
stat` due to the <sys/stat.h> header not being included.

Fix the warning by including the header.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 include/path.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/path.h b/include/path.h
index 1378a8857..a9bab6dbe 100644
--- a/include/path.h
+++ b/include/path.h
@@ -3,6 +3,7 @@
 
 #include <stdio.h>
 #include <stdint.h>
+#include <sys/stat.h>
 #include <sys/types.h>
 #include <dirent.h>
 
-- 
2.23.0

