Return-Path: <SRS0=YMMD=WT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F957C3A5A3
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 13:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6612166E
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 13:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fd/NJTxD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XNW0XML6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbfHWNdL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:33:11 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:42267 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389597AbfHWNdL (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Aug 2019 09:33:11 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 17D053BD;
        Fri, 23 Aug 2019 09:33:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 23 Aug 2019 09:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=28Kr+xhcoxGfw
        Ru4MRZxI9law17Z2FRiCriuhvu2Oos=; b=fd/NJTxDxG1qPXjl9PtfKtHcgp/F9
        fDR+bw83iufsgUFXwxARcwKqFn9kDOd7WGa6dHnymsaWz7SZR8G3O1wwmKgi5rnO
        jhqeNTT6uc0LATmDyHhGZfZsK8rywdsdACUwbi7NaTxzjfHQwvFSoiAMZH07rSNY
        pYG2q+IFb2qi3xy8b5xEm6+0bH91ZaQuHVXEbvwrt5XYa/jvhbFqgzVl8xK96pBp
        B76jIvSYv/s7i0VSZIsgyqPtYj6i1WpEgu6AoX+eBaf2cN5dRPhp9KomrFfhg/u1
        BaC6g+y2PbD5d3hr8cRZ5ztGxu+vPgqa3P7AoqF1DVFQowDDOtPC22+Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=28Kr+xhcoxGfwRu4MRZxI9law17Z2FRiCriuhvu2Oos=; b=XNW0XML6
        bG6f8Q6SUqdFlFnxy0m1EwtTMFrFRp9Mb3TNoONydPo+tAhFJWsRc/f6jTsobbHx
        6FjGAr2GJ++68qwvdlKAv6CZ6AB48kyDPX6/g+dIHd8zOM3UH1sV8BSOSdMru81S
        Ac385adEsOdf0pDz+3ON4sQMPo80KQdjE3g5p2PVWnN6mzHxM83qXh1dWTSjyDQU
        FqgV9DjuTQTzPJ1Hd0kT8IK/MMJt6nJuiRPPWWOnk2iMnXHpKqfiicIUCJBN1Rpt
        hgi5IUxBAKEuJOL6hCIMsxpaYU/jCaz2DRX5xzM9Um3jemDBU4J60C7Ah715YwVN
        QN2cAfA6zy4JzA==
X-ME-Sender: <xms:FetfXfjIscafZUTA2fAm_XM0aqCpWWdHVq6yEbRX9Kv2E6ot7DlPdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeejrddule
    durddvudefrddvtddtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:FetfXQRXBkoKv2Snw-t-8qsojH88u63Qc6HXXDX4tJ0sj8XHkcp9Nw>
    <xmx:FetfXaGRO6hlH9sOfMjO_UP01PY7s2KD86aVtp4HpNY4_q9m65udBw>
    <xmx:FetfXQmxnhO0icx_vNc7SM7Zqd5nBv-j-ij-5E-Tar1pnkTNvK5EJg>
    <xmx:FetfXcsNOv4NnBu__f8GX1aKotc5_cMxKKYmJTWWD9dnaHAolriGAQ>
Received: from NSJAIL (x4dbfd5c8.dyn.telefonica.de [77.191.213.200])
        by mail.messagingengine.com (Postfix) with ESMTPA id ECDECD6005B;
        Fri, 23 Aug 2019 09:33:08 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id d3ead370 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 23 Aug 2019 13:33:04 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Karel Zak <kzak@redhat.com>
Subject: [PATCH v2 3/6] tests: colcrt: fix reliance on EILSEQ in POSIX locale
Date:   Fri, 23 Aug 2019 15:32:55 +0200
Message-Id: <ac1dfeb380dadc07cf6939fee24338406f908f1d.1566566906.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566566906.git.ps@pks.im>
References: <cover.1566555078.git.ps@pks.im> <cover.1566566906.git.ps@pks.im>
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

