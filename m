Return-Path: <SRS0=YMMD=WT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453D9C3A5A3
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 10:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1194321726
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 10:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SprJfdwW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q+S0kusg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389020AbfHWKRK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:17:10 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:43965 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387517AbfHWKRK (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Aug 2019 06:17:10 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1C8C044B
        for <util-linux@vger.kernel.org>; Fri, 23 Aug 2019 06:17:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 23 Aug 2019 06:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=28Kr+xhcoxGfw
        Ru4MRZxI9law17Z2FRiCriuhvu2Oos=; b=SprJfdwWW0jLcN7huJNKWA8C9Qanx
        m9bYsgKNZ1XOR9XcrOryd7zypS5L10/pYZypR6W/JdhahKvhw3gBl8Kj4vkLkuPv
        +SGqniLWJFd4KL2OYE5uDex4jKIEB/NqDdwlZkmKdqtAFqU28MYt3fW9bzvRbcbn
        0Ui8giuR2NOUMepZau3pukQpmEioho13HZpGFL+rKFtvggimiKPsTC+eF5r/WyOj
        cl6bGZsAoAUWe2sYjk3cyLfBFbR3tjw1aslwTj3RnLF9pkWBleTPa8DSapxb/a+e
        RXlYECO6IVQYiJoGDZxAdsn7d5pV9JF3w5vquF16O+b1GX+vvt9rEhyEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=28Kr+xhcoxGfwRu4MRZxI9law17Z2FRiCriuhvu2Oos=; b=Q+S0kusg
        A4LnGf58IXXlO3y8HmZFZk+eiG46y9Cs1C9H2vu8x7scX6ljml+Epix3rQr90vPM
        r7I0VsbB2FtuOyAl2R5LSokJuD+y+DxNZ5z1qe3Ph0KAj64UPu3IFZzsbk6jJOcl
        yhyOl5IUeMxymLEW+VkySD0fyoK4/b7Uh4kyNqfNxrfRgwGLEgIQ+c0N+6fpN4F6
        xcAUNa5NV8qVYQ8L1y8wnA5CknbNk4fV51Uig25th+S0U7Yq/MMFHoDeQjkGK3HW
        ajWQfsa8Z+Vedr2EFqZxkq3OEAcvE2UQxrz31Bs/P3ZBuCS+xwtjzCq/1LAerDtQ
        aHSsp4mihuO1mg==
X-ME-Sender: <xms:JL1fXR-LiLzMAH1r6cPwU0xqDjFoo0-12WpXT3v-j62Uv35DRiQNyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecukfhppeejjedrudeluddrvddufedrvddttdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:JL1fXY89YELClEp4MhjHC3XkK34jXBj6TtOAfcwA2Ey8iEQ5VpkQ6g>
    <xmx:JL1fXTEcrIWoeRkzzdFjtFXPktGQxz7eO4FKNL-VNMy06efPWOPDzQ>
    <xmx:JL1fXfdBU89ahlbR5F6Xvo0fMy7YARNrmpzchxwwX8Jh7rvlpXl6tQ>
    <xmx:JL1fXegzRcijYFGFlX39ayqerpDqmaAee3otH6hqgoNm0Dewmr_wow>
Received: from NSJAIL (x4dbfd5c8.dyn.telefonica.de [77.191.213.200])
        by mail.messagingengine.com (Postfix) with ESMTPA id 195FDD60057
        for <util-linux@vger.kernel.org>; Fri, 23 Aug 2019 06:17:07 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 45b45bb3 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 23 Aug 2019 10:17:05 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/6] tests: colcrt: fix reliance on EILSEQ in POSIX locale
Date:   Fri, 23 Aug 2019 12:16:59 +0200
Message-Id: <692daa9573f879346b1df398170271bd35188d59.1566555078.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566555078.git.ps@pks.im>
References: <cover.1566555078.git.ps@pks.im>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The input file "crash1" in the colcrt/regressions test contains the
illegal byte sequence "\x94\x7e". While "\x7e" is '~', "\x94" is not a
valid character. Thus, the test assumes that getwc(3P) will return
`WEOF` and set `errno=EILSEQ`, causing colcrt(1) to abort reading the
stream and thus not print the trailing '~'.

This assumption holds just fine for glibc as it will dutifully report
EILSEQ, but musl libc will happily read the complete stream without
complaining about the illegal character. But in fact, as tests run with
LC_ALL=POSIX by default, glibc's behaviour is wrong while musl is right.
Quoting mbrtowc(3P) from POSIX.1-2017:

    [EILSEQ] An invalid character sequence is detected. In the POSIX locale an
             [EILSEQ] error cannot occur since all byte values are valid
             characters.

Fix the issue by running the colcrt tests with C.UTF8 locale.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 tests/ts/colcrt/regressions | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ts/colcrt/regressions b/tests/ts/colcrt/regressions
index 394c4e823..2adeea3f3 100755
--- a/tests/ts/colcrt/regressions
+++ b/tests/ts/colcrt/regressions
@@ -24,7 +24,7 @@ ts_check_prog "timeout"
 
 check_input_file() {
 	ts_init_subtest ${1##*/}
-	timeout 2 $TS_CMD_COLCRT < $1 > $TS_OUTPUT 2>&1
+	LC_ALL=C.UTF-8 timeout 2 $TS_CMD_COLCRT < $1 > $TS_OUTPUT 2>&1
 	echo "return value: $?" >> $TS_OUTPUT
 	ts_finalize_subtest
 }
-- 
2.23.0

