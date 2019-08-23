Return-Path: <SRS0=YMMD=WT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD157C3A5A2
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 13:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724FC2166E
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 13:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D6cz7wD6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WAMBPkxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392084AbfHWNdL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:33:11 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:39027 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730419AbfHWNdK (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Aug 2019 09:33:10 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2E7763BE;
        Fri, 23 Aug 2019 09:33:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 23 Aug 2019 09:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        9XivK47VF2kN+4DLvW+UE5X/cNJZX5JNFuk1Sd0aLtw=; b=D6cz7wD6w6yIoJz5
        19phDlKUDV1+B8VTXc8NbujwD+i8bnRK26exhvT5QFVTqrl0Jjz5xhgWyJJyCnV0
        ee+uluENKGzrzsFQxHvAl5oeY1AYF7d+H3iTEHCgPpayt2Mw/gay8Khzm237Czhr
        ryejw/YC+a0s1Je0wasSzaLjKwAo7Fd2fnXJN8HbK9ODCJwf3b4Krc6g8mSlJSfQ
        spULDfJfdXdAF/Mtv8GWy1C9ADyOFgp4vtkq+xkvykEg3uHUl1U2d0BF42ZY9e6b
        lDi902iqzRVoy5HloS4uBe/L1+oAsO0k8zkHEUwPyfygqI7hNV2Hiho8kRZyItAi
        Bvci0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=9XivK47VF2kN+4DLvW+UE5X/cNJZX5JNFuk1Sd0aL
        tw=; b=WAMBPkxfTroMyQ2FWTPxewpqJOtvz8+mDVqd4sTVfZZbe229Ejy3nXTa/
        QYnfskcJrF6FUYLrszw282DgpwYCNg+FI//m28Aw2qhvCdyZ/idqLoDQgcjeu0lw
        Ov7zZrW7FkS/msEUJSbBItvRQ6vPDO85Q4W9YO2GHmocq/5ddnbS0yx3pXGBHgAY
        UwWSmWMbYUvZRaJxh/Wg31HbOT3d8wiWUjRBplNgMWi+JvT7a2hwTbEJoxwnDbGu
        tSxZGYHx34tfFL50Rra+P+5EtidaKDLmGYJuGji5F35dPDQUHsgcoUcYklRiybBS
        Y6NQ2sL1iPSfHSJx4IbKkOxH9yhlg==
X-ME-Sender: <xms:FOtfXf4JqJc2Y7ot0yrLn49WuS1DX_EEFKACddowuoYdkrWto0zU6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecukfhppeejjedrud
    eluddrvddufedrvddttdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:FOtfXX2TrxUZQS0hfX2dnSyZiSAI0GjG3wJS9zIuxUIhL9PWbwaQ0g>
    <xmx:FOtfXepuSLQNTXyqbQ2ZDpNZU6uTi-znMtOu8JUFwKV9_YSSOjWBgw>
    <xmx:FOtfXe8ZL59oiAJqH82IXdIezzMrICkxdJ7gIUajrB7zCL-oVGU7LA>
    <xmx:FOtfXXJFawRmNIDRq-2ZPEyDDSNXNqpkkpoQLujFmd8R0FZhsSqw0g>
Received: from NSJAIL (x4dbfd5c8.dyn.telefonica.de [77.191.213.200])
        by mail.messagingengine.com (Postfix) with ESMTPA id 77591D6005D;
        Fri, 23 Aug 2019 09:33:07 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id cbdd3e1c (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 23 Aug 2019 13:33:03 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Karel Zak <kzak@redhat.com>
Subject: [PATCH v2 0/6] Test suite fixes for musl libc
Date:   Fri, 23 Aug 2019 15:32:52 +0200
Message-Id: <cover.1566566906.git.ps@pks.im>
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

Hi,

Changes in v2
=============

As proposed by Karel, this removes ts_unbuffered and instead
extends ts_run. Instead of accepting parameters like "leak" or
"unbuf" though, I opted to instead accept dashed longopts only as
that should allow us to keep all existing invocations of `ts_run`
the same. At least as far as I've seen, there is none that ever
starts with "-".

So one may now execute `ts_run --unbuffered $TESTPROG` to use
"stdbuf --output=0" and thus stop buffering. But the mechanism
is easily extensible, as proposed by Karel.

Old cover letter
================

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
  tests: libfdisk: remove reliance on buffer behaviour of standard
    streams
  tests: colcrt: fix reliance on EILSEQ in POSIX locale
  tests: column: use actually invalid multibytes to test encoding
  tests: col: avoid hardcoding of errno string
  tests: fdisk: avoid hardcoding of errno string

 tests/commands.sh                             |  1 +
 tests/expected/col/multibyte                  |  2 +-
 tests/expected/column/invalid-multibyte       |  2 +-
 tests/expected/fdisk/oddinput                 |  4 +-
 tests/expected/libfdisk/mkpart-full-gpt       | 14 +++---
 .../libfdisk/mkpart-full-gpt-err-overlap      |  8 ++--
 .../libfdisk/mkpart-full-gpt-nopartno         | 14 +++---
 .../libfdisk/mkpart-full-gpt-partno-gap       | 14 +++---
 .../libfdisk/mkpart-full-gpt-space-gap        | 10 ++--
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
 tests/functions.sh                            | 47 ++++++++++++++-----
 tests/helpers/Makemodule.am                   |  3 ++
 tests/helpers/test_strerror.c                 | 44 +++++++++++++++++
 tests/ts/col/multibyte                        |  5 +-
 tests/ts/colcrt/regressions                   |  2 +-
 tests/ts/column/invalid-multibyte             |  2 +-
 tests/ts/fdisk/oddinput                       |  6 ++-
 tests/ts/libfdisk/mkpart-full                 | 26 +++++-----
 tests/ts/misc/swaplabel                       |  4 +-
 tests/ts/rename/exit_codes                    |  2 +-
 29 files changed, 181 insertions(+), 109 deletions(-)
 create mode 100644 tests/helpers/test_strerror.c

-- 
2.23.0

