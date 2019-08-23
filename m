Return-Path: <SRS0=YMMD=WT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772D3C41514
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 13:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E212173E
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 13:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SvZYb9Ru";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o5be9pqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389597AbfHWNdL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:33:11 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:52859 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389780AbfHWNdL (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Aug 2019 09:33:11 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 5A1D03C7;
        Fri, 23 Aug 2019 09:33:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 23 Aug 2019 09:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        /bI2aA8CnldxozWAKI50oVhTrPJtqFVJKOtTnQxDmkY=; b=SvZYb9RuWqQc9xf0
        907kPsd/5aL45F06i9yhuqUR6WqTv1oizFAQ99Py9owY5qWSz9C/zry7cPSIAZHe
        0sTNh69Pp0c81WEEVImjEo9pEHMKqB68MTYGsB5JLn2eWwUV/e2gtaVKE9K+mzIo
        neSdzka/4WBbBCuXOPAf5pG+/iwSCANIFSI8qt2Q9XJ6bOAaMqZmeUOvLaXXrCXv
        l5WX0BG6WsZsBNDzVb2BeKd8kzsHGnEeQ4OR80iI+cvcs2cSdhu5zUdtesSwY7id
        0cWs9ap7R3KqRd/7o9ZqrnxqcTA1kDIVgUcENwYv33t/JCgATp2P9tp65kezxeR7
        YxSQRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=/bI2aA8CnldxozWAKI50oVhTrPJtqFVJKOtTnQxDm
        kY=; b=o5be9pqp0D82S4RgwAPQISw3Y/ADqNZk1L6hOFxTaLZ0QhXozGykFPlPb
        7IVe5VDLU9vd/NHAPhbvdMFIShTrDDWJ1fBPX4r690iTWycvhzC3ewCRL1G2u/ZJ
        zIMaBJ8Y0LiKDQLZ7OXxlA8g+rABjeojihsmwS02s+m3UVqMFkMeObdwj9KzH/Ba
        lHLbY7TiCEncLwgF9KVCGCg9eSj8SyYnzF5arpsmzr1pMrnd6ly5kL3nEyEsQSBU
        8ZZgCorEjNEOm4pqnMOtBduD2hUAEo/hDJU1NHm1MMcAowY5Hope4VMglHY+o78u
        MYZkXaC4jEA4UwXliWcgRxIXuIWeg==
X-ME-Sender: <xms:FetfXWm4EU4dCc-P6Zp1NvPsMl1uGMHL0e_1Lg3mnCrnjIwuOipBoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuffhomhgrihhnpe
    huthhfqdekrdgrshenucfkphepjeejrdduledurddvudefrddvtddtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:FetfXZXh3Y4NSd441wY48vzcoSE2PMbQA4k_7aQBMtXUYlAoR2menA>
    <xmx:FetfXaqhMUD0l4SmmiYsbXCJPBWN3uONJppcnJ4jihLE4I0QGtbNLA>
    <xmx:FetfXYVmoJf3rfNNQR0X1iIALIXuz_jQoexRcd_jinnxN3ziDp9tuw>
    <xmx:FetfXTKLHgdhG3jny6C-wC0PHm9bgJoES8th-hmvkJAecPJ8gMuxYA>
Received: from NSJAIL (x4dbfd5c8.dyn.telefonica.de [77.191.213.200])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2BD6A8006A;
        Fri, 23 Aug 2019 09:33:09 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id d45810b8 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 23 Aug 2019 13:33:05 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Karel Zak <kzak@redhat.com>
Subject: [PATCH v2 4/6] tests: column: use actually invalid multibytes to test encoding
Date:   Fri, 23 Aug 2019 15:32:56 +0200
Message-Id: <35764c2dbbd03831b710a8ad2b36276cb0a479fc.1566566906.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566566906.git.ps@pks.im>
References: <cover.1566555078.git.ps@pks.im> <cover.1566566906.git.ps@pks.im>
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

