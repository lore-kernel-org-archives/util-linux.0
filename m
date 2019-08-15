Return-Path: <SRS0=Zy3D=WL=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9BCC433FF
	for <util-linux@archiver.kernel.org>; Thu, 15 Aug 2019 10:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1D8208C2
	for <util-linux@archiver.kernel.org>; Thu, 15 Aug 2019 10:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tn6u+3eC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XOKfUfOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbfHOKuC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 15 Aug 2019 06:50:02 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34471 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730969AbfHOKuC (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 15 Aug 2019 06:50:02 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E636721B6A
        for <util-linux@vger.kernel.org>; Thu, 15 Aug 2019 06:50:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 15 Aug 2019 06:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=9I04Zxw6M/tqWfvftN/C/4Uap8
        sIdjLRXpmBqITvIAI=; b=tn6u+3eC3jGMAZZG13sx1w5B62lT0cqR9jopHsPFdx
        sPAbVwmkEcDB6Xuorf5lr+1nFGl4QAgGlUHwidF6U97y9j5P/cPKZX+qyVFyaaJU
        huzBIG9I+kqQUgbfyeySd5bXEA0XENtJm64yKXGeLUp6KOovbOuCyhFXROFKsAG2
        CzhF43fS2P5fZaAHzqTpSjQ3eyU6kaA8mlHvaDl3RA4fjKyWFVDTHC922NlpUCsh
        fE1CXwYifSdw+DtykTgeXjzqb35+i/Xray+vDptqoA3Lxtz6y/L1K8d5ikrYIjJv
        hVpmjPtccc5abP+n3cWXL1S+CM8q19+IxRgSBhF7PkVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=9I04Zxw6M/tqWfvft
        N/C/4Uap8sIdjLRXpmBqITvIAI=; b=XOKfUfOpkUICxQk/4piCd8qaOk6pjtS21
        CqfY7Ize/YMNE/E/HYb2jt1XM7JxJ0YppIQNY0iZxo/rEGDxPr5LRADf13za+7A/
        8WdlN+XEJ8hYyiDJ6Fdn2QvR1yDpj3dwsH1wdh/KtDcZuv4jWsMHSEzAvTRbNTDl
        JxZfsiqd0gBF7wJGEYs6imlb5C2KkCKO/1u3KkqcCleNNOmom7IT5rmRdumDsmig
        Qs5LAoWb8kxgDv96gTyNaDika0n92IiCMX4Fxvsn5oNyCIwUH68dc4/z0Vf5Aife
        GUx2REANl7fFDkZ1PxHjxSgcO2M0/qyuD3s7eBqc4N/4aPzMO/Vig==
X-ME-Sender: <xms:2DhVXZvKiYyHsePS0Qfz1DPUTHiM__lAvO3NC9rcKpdNHN25CmdenQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudefuddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecukfhppeejkedrheegrdeiuddrheefnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehpshesphhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:2DhVXZ59aIX-8N21yjjABk7CQa1KUzC2re1YK6RIP3jml9uISmWPlA>
    <xmx:2DhVXaJ4f7SuH4lUDDfn9g1oQi8mMfq5tvS7A17RV7_j3xr-Ebu4UA>
    <xmx:2DhVXZ5syvqjwE9M0zy6nyQ2MqoFJFJ5X6HQeshuDsw0LZD_Tyuwsg>
    <xmx:2DhVXXzk8LAOnQuGSB--7ejlqMxt2XgzNPSAt9azBkefedc1bVCWLw>
Received: from NSJAIL (x4e363d35.dyn.telefonica.de [78.54.61.53])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1ED3F80061
        for <util-linux@vger.kernel.org>; Thu, 15 Aug 2019 06:49:59 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 98c5fc7a (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Thu, 15 Aug 2019 10:49:55 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] libmount: fix comment referring to passno field
Date:   Thu, 15 Aug 2019 12:50:05 +0200
Message-Id: <4e258644af41a4170100c49895d1d6efd4374d7a.1565866178.git.ps@pks.im>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

There's an obvious copy-paste error in `mnt_parse_table_line` when
referring to the 6th field of the fstab format, where it says "freq"
instead of "passno". This has probably been copied from the 5th field,
which is in fact correctly labelled as "freq".

Fix the mistake by changing the comment to say "passno" instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 libmount/src/tab_parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmount/src/tab_parse.c b/libmount/src/tab_parse.c
index 8e94715d2..2dfa6cbb4 100644
--- a/libmount/src/tab_parse.c
+++ b/libmount/src/tab_parse.c
@@ -154,7 +154,7 @@ static int mnt_parse_table_line(struct libmnt_fs *fs, const char *s)
 	if (!s || !*s)
 		goto done;
 
-	/* (6) freq (optional) */
+	/* (6) passno (optional) */
 	s = next_s32(s, &fs->passno, &rc);
 	if (s && *s && rc) {
 		DBG(TAB, ul_debug("tab parse error: [passno]"));
-- 
2.22.1

