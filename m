Return-Path: <SRS0=YMMD=WT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC6CC3A5A2
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 10:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754B321726
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 10:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xf+3qfkj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dqql02uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388935AbfHWKRJ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:17:09 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:43161 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbfHWKRJ (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Aug 2019 06:17:09 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 02E89457
        for <util-linux@vger.kernel.org>; Fri, 23 Aug 2019 06:17:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 23 Aug 2019 06:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm1; bh=rx5QiZ7LLmSOQjBfbtEYO/QQmy
        8vEv8SCz5D+LddN4c=; b=Xf+3qfkjtEvShPRUSM3Vbt/I4udecZePRivkVnfPeb
        N/Qbo0ilkpM3PY7EaN5Uv++yZmXk9VmsHdcUyF6QnyAYnEm8LcFgITpWGFwi2fq1
        qb8CX9NkiOdzmM9Qk/0XJ7vlmdf697+8T7Yov4wuZp7bgaduXoGSB5tQ/0tWAMfH
        cGYFMTEoPGhYRMckIS3oMkcH1iYQdBFWlkJdxFnyOvXwH/JHn5yDP6095Zl8hSw3
        HFRlV0n3SELDbMHW6mgV1AUJN+EBe32oPj2VoldQq3d0L8ia54f4r6zrfpiLayy0
        eEAY50LJhcA1uEOFgZ5mzr9VViTb5WP0qIMPbh5rlaiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rx5QiZ
        7LLmSOQjBfbtEYO/QQmy8vEv8SCz5D+LddN4c=; b=dqql02ucEHJlNXDqn6Ki+M
        DAK4tSLVjR7r1DvS47pLPWOMC7VfTd3wLhASufLWBg2e2EXzu3kO3+jJ5y7ijK5e
        CJoobQqcj0bFFbmIYL9bWpp8tVD+CT8rgE9GPa5gGXb1UmehYf8dblInYqy9dWz/
        o9gfq+7ML7w09LpVUUYMuLXOagU1ZLF77JvrbaFYUoMad1AkvvIitdcvbB/5lrRt
        vJFS5o6HDYf+PJ13E+uPJn+WiW+xYWCAqtwGY7kGt9gw4RjiHYUIj8/UXGYw63Fe
        8VyxgMA0otIQ2sfdCgnQCIxUQRTjEyqKE8nxXRtfWLz9yiUSlnlg7VObdQvWiDoA
        ==
X-ME-Sender: <xms:I71fXVKMUGyY0iz3K5eRKfjbNC6c0Y_6GlKosBI4bfJrnE1abuYVfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofggtgfgsehtkeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucfkphepjeejrdduledurddvudefrddvtddtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:I71fXdNzOh8Qgn97vMqfcw6I5rSHWIGKsJy6PCwaFDkFX4dlZFuzxg>
    <xmx:I71fXTqdFScwe-sduW3htdCAxzDRBc6ByjYFajlejMLraSF3EjDxXQ>
    <xmx:I71fXXUbQEMcpFOWxv170EmysXYEeTwHnxtq1JFETXS6AQSJNLjG4w>
    <xmx:I71fXc_CXx2oZVeZnfix4_L6e5eFNGa5XGsbRD2iIghiHyrPxrJYnQ>
Received: from NSJAIL (x4dbfd5c8.dyn.telefonica.de [77.191.213.200])
        by mail.messagingengine.com (Postfix) with ESMTPA id CB973D6005D
        for <util-linux@vger.kernel.org>; Fri, 23 Aug 2019 06:17:06 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 74a7ec9e (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 23 Aug 2019 10:17:04 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/6] Test suite fixes for musl libc
Date:   Fri, 23 Aug 2019 12:16:57 +0200
Message-Id: <cover.1566555078.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

on latest master of util-linux, there's currently 20 test- and
subtest failures on musl based systems. There's three different
categories of failures:

    - Reliance on buffering properties of stdout/stderr.

    - Expectance of non-standard error messages returned by
      strerror(3P).

    - Expectance of EILSEQ with POSIX locale.

This patch set fixes all of the above, bringing down the number
of failures from 20 to a single test failure. The remaining
failure is in getopt(1), which documents and implicitly relies on
the POSIXLY_CORRECT environment variable when calling getopt_long
from glibc. Adhering to this variable isn't implemented by musl
libc, so to get this working correctly one would have to modify
getopt(1) itself, e.g. by automatically prepending a '+' to the
optstr if the envvar is set. But I'll leave that to another patch
series.

Regards
Patrick

Patrick Steinhardt (6):
  tests: remove reliance on buffer behaviour of stderr/stdout streams
  tests: colcrt: fix reliance on EILSEQ in POSIX locale
  tests: column: use actually invalid multibytes to test encoding
  tests: col: avoid hardcoding of errno string
  tests: fdisk: avoid hardcoding of errno string
  tests: libfdisk: remove reliance on buffer behaviour of standard
    streams

 tests/commands.sh                             |  1 +
 tests/expected/col/multibyte                  |  2 +-
 tests/expected/column/invalid-multibyte       |  2 +-
 tests/expected/fdisk/oddinput                 |  4 +-
 tests/expected/libfdisk/mkpart-full-gpt       | 14 +++---
 .../libfdisk/mkpart-full-gpt-err-overlap      |  8 ++--
 .../libfdisk/mkpart-full-gpt-nopartno         | 14 +++---
 .../libfdisk/mkpart-full-gpt-partno-gap       | 14 +++---
 .../libfdisk/mkpart-full-gpt-space-gap        | 10 ++---
 .../libfdisk/mkpart-full-mbr-err-logical      | 14 +++---
 .../libfdisk/mkpart-full-mbr-err-nospace      |  6 +--
 .../libfdisk/mkpart-full-mbr-err-primary      |  6 +--
 .../expected/libfdisk/mkpart-full-mbr-logical | 14 +++---
 .../libfdisk/mkpart-full-mbr-nopartno         | 14 +++---
 .../expected/libfdisk/mkpart-full-mbr-primary |  8 ++--
 .../libfdisk/mkpart-full-mbr-primary-nopartno |  8 ++--
 .../libfdisk/mkpart-full-mbr-space-gap        |  6 +--
 tests/expected/misc/swaplabel                 |  2 +-
 tests/expected/rename/exit_codes              |  2 +-
 tests/functions.sh                            |  7 +++
 tests/helpers/Makemodule.am                   |  3 ++
 tests/helpers/test_strerror.c                 | 44 +++++++++++++++++++
 tests/ts/col/multibyte                        |  5 ++-
 tests/ts/colcrt/regressions                   |  2 +-
 tests/ts/column/invalid-multibyte             |  2 +-
 tests/ts/fdisk/oddinput                       |  6 ++-
 tests/ts/libfdisk/mkpart-full                 | 26 +++++------
 tests/ts/misc/swaplabel                       |  4 +-
 tests/ts/rename/exit_codes                    |  2 +-
 29 files changed, 154 insertions(+), 96 deletions(-)
 create mode 100644 tests/helpers/test_strerror.c

-- 
2.23.0

