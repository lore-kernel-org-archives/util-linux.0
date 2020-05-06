Return-Path: <SRS0=2oxY=6U=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A1FC28CBC
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 10:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968AE20663
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 10:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588761490;
	bh=gRUmCjLX4/CP5vljNo3SB5BDntoN4aGZDA8t1dLG2CA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=aojgZiWgxDjP6/CZQWqZQMThUlfOCxjrFW15YKS4Hxof3fTG5l+Askrave4lZm1u5
	 FPATYd9sUMYbI5OXN9g/5QAO21WA5F3c4k7N7i7yKGcIhyVEkCTjfl9z0CnrUJYVt0
	 Adj8tD50z9Y3YJijqhb8O2AzAT7hmDwy0ghaG6i0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgEFKiK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 May 2020 06:38:10 -0400
Received: from sauhun.de ([88.99.104.3]:44586 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgEFKiK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 6 May 2020 06:38:10 -0400
Received: from localhost (p54B3333E.dip0.t-ipconnect.de [84.179.51.62])
        by pokefinder.org (Postfix) with ESMTPSA id EB1BD2C0885;
        Wed,  6 May 2020 12:38:08 +0200 (CEST)
From:   Wolfram Sang <wsa@kernel.org>
To:     util-linux@vger.kernel.org
Cc:     Wolfram Sang <wsa@kernel.org>
Subject: [PATCH] fdisk: better wording for '-B' in the man page
Date:   Wed,  6 May 2020 12:38:04 +0200
Message-Id: <20200506103804.2638-1-wsa@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Addresses: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=814184 (second part)
Signed-off-by: Wolfram Sang <wsa@kernel.org>
---
 disk-utils/fdisk.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/fdisk.8 b/disk-utils/fdisk.8
index 0e0d96324..6a92ba5db 100644
--- a/disk-utils/fdisk.8
+++ b/disk-utils/fdisk.8
@@ -58,7 +58,7 @@ between logical and physical sector size.  This option changes both sector sizes
 .IB sectorsize .
 .TP
 \fB\-B\fR, \fB\-\-protect\-boot\fP
-Don't erase the begin of the first disk sector when create a new disk label.  This
+Don't erase the beginning of the first disk sector when creating a new disk label.  This
 feature is supported for GPT and MBR.
 .TP
 \fB\-c\fR, \fB\-\-compatibility\fR[=\fImode\fR]
-- 
2.26.2

