Return-Path: <SRS0=2Kk3=RE=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FC3C43381
	for <util-linux@archiver.kernel.org>; Fri,  1 Mar 2019 17:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27A920818
	for <util-linux@archiver.kernel.org>; Fri,  1 Mar 2019 17:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i5OXjLdj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ibxt8yGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbfCARgE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:36:04 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56405 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726835AbfCARgD (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 1 Mar 2019 12:36:03 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2E66A21921;
        Fri,  1 Mar 2019 12:36:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 01 Mar 2019 12:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=SU6MhCEm0M8EIx3bn/ixpHHQMS
        4us17iRPoqy//4sWI=; b=i5OXjLdjr/ZI++MQNIM5MbasKxPRMZkrCGju3uDxa2
        Rbc+UYx9P0RwVPCH4GlbBOOlz+gje5zK724hOWczHJB3Ku6J/dXGj7RglgWEaACY
        TRW6xr+akbGSYABdVTR1+O4nSdDqlgyw1ozw2EZSIaSn6wbACo0a/6aOpt3ra58Y
        fE9EInwjvH+RWKL+zH9P0YZ/b3QwpiUOi3QYFvk5ieToMM49vIWV9NHYuG9Oj7zo
        l5yullfxwi4YI6qIXGiS/DaXasccsX24q6x6vbWcJHpF1Zn/ByjmfzXF/xyU9MVk
        2l0Iz6uHNeKAPPvE81x2zUdjPPVkH/5GwrlaA5PFB+Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=SU6MhCEm0M8EIx3bn
        /ixpHHQMS4us17iRPoqy//4sWI=; b=ibxt8yGGB6/TvZ1Dnc6gKjH5Zu9JBa3yc
        6CoQxq/kP1VMIPwS6VWfSt/kOzUrYE+fVNPASNnn/UHOWSzl9P0zBnUlxDlcXja/
        GlIWjHR/wPhVMOjLXKLaP12aoBnVCv2QnSkTkaUOWhEihD2Jn+1bw/2doqNMs79z
        VvrfacHSlqDKNYXCiJcwSOKw+2HdQf0h/V+7WzkHdq/S1g7rFjL/p2HkM/lWtb7P
        zPjx4o56krIUp/ikhhzZ8HMp/KGL1Cr9qcE8bBTpeWeVUJyvtm1+RF+h4k5SxA39
        DaJL4bnO7fkCafA+tA48BXuK4LpAfXkpAJgE/qyMJt8x7307T17HA==
X-ME-Sender: <xms:gW15XHKmEq2abYtg6sUygS5yfIk0qankJV-rjN846A0-QISrZMqrvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdehgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepkeelrddugedrud
    ekkedrleejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmnecuvehl
    uhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:gW15XNtfmQ7lI1kupwfyQfRjAIV9xFYJ-UPjPIhzQG2uM_zU3YNBQw>
    <xmx:gW15XG1Zr5VE87KOI0Ua4_xJqoTTSk2fRPuBD1a7XVHUntHo9tKNbw>
    <xmx:gW15XIrHbTs3mNHlzwBPp5AZ2ck-3uB4xFIxfuy28wMaKvz5U1c2Dg>
    <xmx:gm15XD7UpZ6l3V3tdkVbDccZjaWcMuEhR9mevdM0KNTOgWtmPnVaUA>
Received: from NSJAIL (x590ebc61.dyn.telefonica.de [89.14.188.97])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9AEF0E4339;
        Fri,  1 Mar 2019 12:36:00 -0500 (EST)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 320fd83c (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 1 Mar 2019 17:35:58 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] last: do not use non-standard __UT_NAMESIZE
Date:   Fri,  1 Mar 2019 18:35:49 +0100
Message-Id: <808b43f44dd1d87ff4ee771503e97438f1d65660.1551461730.git.ps@pks.im>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

In commit b22332dd4 (last: fix wtmp user name buffer overflow
[asan], 2019-01-13), we started to make sure that the `ut_user`
field of the `utmpx` struct is always NUL-terminated. The
implementation makes use of the `__UT_NAMESIZE` define to
determine the position of the last character in that array. The
problem is that this is a non-standard define that is not
necessarily available on non-glibc platforms.

As there is no standardized define, we should just use `sizeof`.
This fixes compilation on musl libc based systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 login-utils/last.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index be744b079..303adeacd 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -600,7 +600,7 @@ static int is_phantom(const struct last_control *ctl, struct utmpx *ut)
 
 	if (ut->ut_tv.tv_sec < ctl->boot_time.tv_sec)
 		return 1;
-	ut->ut_user[__UT_NAMESIZE - 1] = '\0';
+	ut->ut_user[sizeof(ut->ut_user) - 1] = '\0';
 	pw = getpwnam(ut->ut_user);
 	if (!pw)
 		return 1;
-- 
2.21.0

