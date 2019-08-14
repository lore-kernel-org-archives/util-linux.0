Return-Path: <SRS0=UJgV=WK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01F8C32753
	for <util-linux@archiver.kernel.org>; Wed, 14 Aug 2019 16:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861AF20665
	for <util-linux@archiver.kernel.org>; Wed, 14 Aug 2019 16:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TGlYRpA5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WwZv/l4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfHNQpK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:45:10 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:53165 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727799AbfHNQpJ (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 14 Aug 2019 12:45:09 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 96598536
        for <util-linux@vger.kernel.org>; Wed, 14 Aug 2019 12:45:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 14 Aug 2019 12:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm1; bh=lhW08Dp3wdHwjEdNt9Oh7c5Os4
        wzzMMVUU4vJlVxncY=; b=TGlYRpA5sSL0buqIJr9tfSNiiLnAovaFoXPcO6T6kB
        DgK59BaoArZkkqZgwACVIXLUdolZRw5zR/e/cO8vMoCeOh5mn1CKU0oYZSLc03I1
        knhDBKeFJJKsmJ7rlraY7IruIf7xPP13xMU09FK4i6D4evcEg82dOKXnRHZcINNq
        Ii8rQC89xMrc8mqU0+wkj27xDNTTYX5DP+oOKa+sLArAxzby47Xm62TiLbAYHaOH
        QMRVts7871g80y8WFI9v6amFTKjGFt0gtb3FCK15QdzzOsFAy7J16MsJG1DI6CDR
        0X7KtlCw/oKdPzsC0r2BGwwO8MEjYhlbAMRfu5N4zHhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=lhW08D
        p3wdHwjEdNt9Oh7c5Os4wzzMMVUU4vJlVxncY=; b=WwZv/l4QFzibZA+o4VWuyg
        nQSCryGmIa/Hcew6KBiH+jNe/3Ja5KCuTCHepG5jTBV02844IVUqaWB8nZqnNLQ0
        /AFWNDrsuhX1hapzAS1owC2Wt1rjHoRYUE5/c+6pJMpBDYWLHs1GVd1iOP/NUKbo
        hg93aSnMjaAC0v8+ozjS85gz4lhD97QI+SJj1XWPNVzZEY+xmeYsghIoqwb2NZw9
        hZBRLn8dJGsWYivoYnaBITFJmOv+QsmlUSbfCXsqPVa5HTSsXvKqTkMLfAJrDa1Y
        ioLnXjohnBK4HoT6SPNHL/PrGEqow4mlLD6KaswYyrdYg+NlRfedD2cOIL6XKq+g
        ==
X-ME-Sender: <xms:kDpUXXthbEPJfWVQOJCBFY8mMVnue_72Ll-L5QJUSAZa7fYW-eswOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddvledggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofggtgfgsehtkeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucfkphepjeekrdehgedrudejvddrvdduheenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:kTpUXdWSkE-SULMIp8i-Qo4m3TziHiyXijp16Yet8qKV3Y1hNDDReQ>
    <xmx:kTpUXQp5f1bb8iTXyAKjzO98KhWuCirqg8dnwfDE-qxTdifNLxV-wA>
    <xmx:kTpUXYpL2l_QbKfQBkR-RUWwfgPfKdISCV31jFZwpI92az2zeFyt-w>
    <xmx:kTpUXV68mF1y3zsyOohT6aNDdraeDtI0uWDqNjnTc7dbBk7xikdlwg>
Received: from NSJAIL (x4e36acd7.dyn.telefonica.de [78.54.172.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 767A680063
        for <util-linux@vger.kernel.org>; Wed, 14 Aug 2019 12:45:04 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id d6195f75 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 14 Aug 2019 16:45:00 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] Fix closing of standard text streams for non-glibc system
Date:   Wed, 14 Aug 2019 18:45:03 +0200
Message-Id: <cover.1565800625.git.ps@pks.im>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

since commit 52aa1a661 (include/closestream: avoid close more
than once, 2019-06-13), util-linux fails to build on musl libc
based systems. The culprit here is that it introduced assignments
to stderr and stdout, while the C89 standard explicitly notes
that treating stderr and stdout as valid lvalues is not a
requirement for any conforming C implementation. musl libc
implemented these streams as `extern FILE *const`, and as a
result assigning to these variables causes compiler errors.

Attached is a fix for this. Instead of assigning `NULL` to the
streams, util-linux now uses a static variable `streams_closed`.
Unfortunately, this fix necessitated some shifting around as
closestream was previously implemented as header, only, and
implementing static variables inside of a header is not going to
work due to them being static to the single compilation unit,
only. Thus I converted the code to move the implementation into
"lib/closestream.c".

Regards
Patrick

Patrick Steinhardt (4):
  term-utils/ttymsg: fix missing header for ARRAY_SIZE macro
  login-utils/islocal: fix missing header for err macro
  lib/closestream: move implementation into its own compilation unit
  lib/closestream: fix assignment to read-only standard streams

 disk-utils/Makemodule.am                   |  2 +
 include/closestream.h                      | 90 +++-------------------
 lib/Makemodule.am                          |  1 +
 include/closestream.h => lib/closestream.c | 27 ++++---
 login-utils/Makemodule.am                  |  4 +-
 login-utils/islocal.c                      |  1 +
 misc-utils/Makemodule.am                   | 10 ++-
 sys-utils/Makemodule.am                    |  9 ++-
 term-utils/ttymsg.c                        |  1 +
 text-utils/Makemodule.am                   |  6 +-
 10 files changed, 52 insertions(+), 99 deletions(-)
 copy include/closestream.h => lib/closestream.c (75%)

-- 
2.22.1

