Return-Path: <SRS0=hwxx=2B=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ADAC43603
	for <util-linux@archiver.kernel.org>; Wed, 11 Dec 2019 13:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D8520836
	for <util-linux@archiver.kernel.org>; Wed, 11 Dec 2019 13:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="0YaXrt3y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BivqsxCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfLKNoX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:44:23 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:51605 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727554AbfLKNoW (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 11 Dec 2019 08:44:22 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id BF81FAF0;
        Wed, 11 Dec 2019 08:44:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 11 Dec 2019 08:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=5JRx8abO5A3+fUk790PeNKQb09
        7vi4OqMT7Nh6vj8Bg=; b=0YaXrt3yc04G6XfPT8CGZjKMk8SmUvo2Bi03E97RI6
        aJz+OYVxrmByhWvOfSVIwzO1KJplQpnpRIAgSmzSOEF0dkMGy5zD0y/F/inmn/DG
        Rcic/zl54BqKO3ccq+pPxlQNgHTJboYEymmabcuei7DkUdXdHOCcelyybL7P4zhE
        U2b7zTo5b+tDDGovcqL2RQvSQGfngrP41r/8xQqzj67SfYMoHJ88B9Ra74VuKV/B
        JrArzBx0LKJi7IKo+frQrOeyvib+teb+uIMk6an0U/PoVfwdDBxaPajX4shZAHHr
        ojC6jqM9XZRpE3EAxQxnaH9zMmI+oruIEqNccZWvwyAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5JRx8abO5A3+fUk79
        0PeNKQb097vi4OqMT7Nh6vj8Bg=; b=BivqsxCOUDqqJR7GSNnofYLeCTCirVS71
        eUVojwkCohkmYoLf6ykH5bveGkQD1E1gmomRp9ooO8mkK2eOUrKp0jQl+q/cpZA4
        /3KEJDikFzC2MBlDFP2TIE1SnLlENrPMT8Q61iTWnRQHTc5z6Vrlp/Akz+SXh1KY
        Zqwcy5RIP5Tqt4wO58dHYVMwt90j9brRwnVynTsjIGDz5GQPw6T5Vq6D9XN/QpyV
        dnM0+g89NntLkPqSf6//ZVXbCXmKY6Lh74PIRiowptmK6n7FGuQJTZDwxeqQ+Tgy
        I8dSE0AogAOPbo8Og2Ietn6+vF9pNNNCunHCMaxz4Veok0Hmj4WbQ==
X-ME-Sender: <xms:tPLwXXcLPQjf7i6YhMBjX3mGA4gX68lb4RQXqFLFsa--0aQ_XfR7eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeejrddukeefrd
    dujeejrdduudeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:tPLwXWNlD4uktpFhFqmkcqrnp1h4OyCEmbRA5N1rB6-CaC4DJl-VSQ>
    <xmx:tPLwXdZVWWT8nZigH9hwAGN1ECB_6_KzzCMhZhTyp4_8oHHhzGAg9A>
    <xmx:tPLwXb2pww7TxalwFPrdWB48_ZEg47SND7cYtsyWdqw5o4JyjeNkCw>
    <xmx:tfLwXekE5scvCEolfNBvtDJ7keccXnv09dE7cIbfHh1BbH_7PyQ7Wg>
Received: from vm-mail (x4db7b174.dyn.telefonica.de [77.183.177.116])
        by mail.messagingengine.com (Postfix) with ESMTPA id 201618005B;
        Wed, 11 Dec 2019 08:44:20 -0500 (EST)
Received: from localhost (<unknown> [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id a2515b24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 11 Dec 2019 13:44:17 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Karel Zak <kzak@redhat.com>
Subject: [PATCH] agetty: return proper value if compiled without ISSUEDIR support
Date:   Wed, 11 Dec 2019 14:44:22 +0100
Message-Id: <bc1cb34e4f685a1e3eddcfbde6d1f4a0fc30453d.1576071846.git.ps@pks.im>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

If agetty is compiled without support for ISSUEDIR, then it implements
a stub for `issuedir_read` that simply does nothing. In fact it does
too little, as it doesn't have a proper return statement even though the
function returns an integer.

Fix the issue by always returning `1` from `issuedir_read`. This
is the same error code that the real implementation of that function
returns in case it cannot open the directory and is thus a sensible
default to pretend that the directory doesn't exist.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 term-utils/agetty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index a0d0876c3..3c20acc98 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1783,6 +1783,7 @@ static int issuedir_read(struct issue *ie __attribute__((__unused__)),
 			struct options *op __attribute__((__unused__)),
 			struct termios *tp __attribute__((__unused__)))
 {
+	return 1;
 }
 #endif /* ISSUEDIR_SUPPORT */
 
-- 
2.24.1

