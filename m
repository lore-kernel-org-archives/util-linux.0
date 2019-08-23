Return-Path: <SRS0=YMMD=WT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A644C3A5A5
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 10:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EAE233A0
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 10:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a9H+HJt8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ErhXNlNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387517AbfHWKRK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:17:10 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:53853 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388726AbfHWKRK (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Aug 2019 06:17:10 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 54A9546B
        for <util-linux@vger.kernel.org>; Fri, 23 Aug 2019 06:17:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 23 Aug 2019 06:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        /bI2aA8CnldxozWAKI50oVhTrPJtqFVJKOtTnQxDmkY=; b=a9H+HJt8whJ5Lr8r
        mI5U/61y/BVKK9QcfyR3t5HlL8BLrXpsAkQnk3ttjtvB2qetnNoyJOrdXB/TwIHC
        fsmOVOURIYYKvUAKqG9+zWA11P29AvuC22AFWB0aEvHbwfw3vGgHGHQpQ44YenHw
        g/ViY6sHJ70cXe/SGZEHp5chEZafo6ZB1jD8pRASCcuJqVsjNT4GnjJZFca0r216
        gpTtDJF/AOeTNj3TW7HW7cYJd+FXERBPlPewtmi6PVVs+KvtXM9OaYdy6pqR5dPg
        Gp6ZolzPGzQSyoIXTyxSINdA1X7lxq7mZNl6kAd9YRWDYw3v4X9DVm3nJ26r4yUr
        eDKeHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=/bI2aA8CnldxozWAKI50oVhTrPJtqFVJKOtTnQxDm
        kY=; b=ErhXNlNgVtEo2qN+Z78B6wiWGRwgjX6BhYgf1LnzOY9zr8mPN0jp4KHkX
        fjKVUJHzZfX4BfcCg9SH/dTij+erQodukqJ/xJJcVE4ibthJ5O5rYhVxTY07q9IN
        jnftxZxwWZ2Qn/mhnM/oakJZNvLkjwwYhXiBGf99l0tag2Wkcjt5EqRgVyBI74At
        2FC9bDaUQQ7zJURRlxmDcbX3dWxs+0iYRWJNAo7mitWhcTsMDoV7wGJzt69fFCM+
        kCt8odMH2IWTSAoTthIGdWnRGAI+Qa2H+Be/ZJxI0T+WOBZ3/TK/W0sZL3UpmgkE
        MsJav8iO8HFRNnqqF2ghWfSlr4JHg==
X-ME-Sender: <xms:JL1fXWvwQkTZhhInTzWvoa85bc8eTN9C_BvAYPnixmw7STUZvYjttg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhggtgfgsehtke
    ertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucffohhmrghinhepuhhtfhdqkedrrghsnecukfhppeejjedrudelud
    drvddufedrvddttdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:JL1fXTvznt7HyYDW2GID2j5IpsXkN02E1j6yn6rD7zvYqzubJ7RZxw>
    <xmx:JL1fXVsXObJAINpsmfFnMEobYAsPc1m8qWT6_M8-ZXFaP5NnclzAQA>
    <xmx:JL1fXYhY-EWoMs0e2m-heYq_gPNs3OIH4fUi9uUe8IfuvT4T3xpZMw>
    <xmx:JL1fXVfSUHvCS1pP1zDkpHy0POLo35HD376kRFS6C6dsVzjb6HracA>
Received: from NSJAIL (x4dbfd5c8.dyn.telefonica.de [77.191.213.200])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3A8EE80061
        for <util-linux@vger.kernel.org>; Fri, 23 Aug 2019 06:17:08 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 52d71334 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 23 Aug 2019 10:17:05 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/6] tests: column: use actually invalid multibytes to test encoding
Date:   Fri, 23 Aug 2019 12:17:00 +0200
Message-Id: <9409bf50a0f8a5ba461cb3ef733cc6cd97f28b9f.1566555078.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566555078.git.ps@pks.im>
References: <cover.1566555078.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

If reading an invalid multibyte sequence, column(1) will encode the byte
as "\x<hex>" instead. The tests try to verify that by piping "£" into
column(1). As the tests run with LC_ALL=POSIX by default, though, libc
implementations strictly adhering to the POSIX standard will treat all
characters as valid multibyte characters. As a consequence, no EILSEQ is
raised by mbtowc(3P) and the character is not encoded as hex, breaking
the test.

Fix this by setting LC_ALL=C.UTF-8. As "£" is a valid UTF-8 character,
we also change the test to use a proper illegal multibyte sequence.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 tests/expected/column/invalid-multibyte | 2 +-
 tests/ts/column/invalid-multibyte       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/expected/column/invalid-multibyte b/tests/expected/column/invalid-multibyte
index ea40a34e9..5b0c74503 100644
--- a/tests/expected/column/invalid-multibyte
+++ b/tests/expected/column/invalid-multibyte
@@ -1 +1 @@
-\xa3
+\x94~
diff --git a/tests/ts/column/invalid-multibyte b/tests/ts/column/invalid-multibyte
index a9e371003..4fcf44eb3 100755
--- a/tests/ts/column/invalid-multibyte
+++ b/tests/ts/column/invalid-multibyte
@@ -25,6 +25,6 @@ ts_check_test_command "$TS_CMD_COLUMN"
 
 ts_cd "$TS_OUTDIR"
 
-printf "�\n" | LC_ALL=C $TS_CMD_COLUMN >> $TS_OUTPUT 2>&1
+printf "\x94\x7e\n" | LC_ALL=C.UTF-8 $TS_CMD_COLUMN >> $TS_OUTPUT 2>&1
 
 ts_finalize
-- 
2.23.0

