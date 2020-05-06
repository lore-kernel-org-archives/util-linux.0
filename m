Return-Path: <SRS0=2oxY=6U=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8AEC28CBC
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 10:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9C82070B
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 10:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588761481;
	bh=8dxRdPvp06I/vfuMxdwsTovhTbQpRWwk6HrLRyCuvv0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=YA12/w5ArRtOIVqJV5ToEHdAUMQNE3/MuIBkSSuZ0rQ4fNthcG3seIw4TU5Jd6/N1
	 k49GNsaNU2w6D1GymbHBglHbKqWBIx6CVkFV2cx3EoNxKBgfzLFQx2lCz4KwtHLSIR
	 Wdo1SkFn3+R9qaSjbJus2i51lyniGbVrtimeDVkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgEFKiB (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 May 2020 06:38:01 -0400
Received: from sauhun.de ([88.99.104.3]:44572 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgEFKiB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 6 May 2020 06:38:01 -0400
Received: from localhost (p54B3333E.dip0.t-ipconnect.de [84.179.51.62])
        by pokefinder.org (Postfix) with ESMTPSA id E6BD52C0885;
        Wed,  6 May 2020 12:37:59 +0200 (CEST)
From:   Wolfram Sang <wsa@kernel.org>
To:     util-linux@vger.kernel.org
Cc:     Wolfram Sang <wsa@kernel.org>
Subject: [PATCH] fdisk: specify in '--help' that we can have multiple devices with '-l'
Date:   Wed,  6 May 2020 12:37:50 +0200
Message-Id: <20200506103750.2587-1-wsa@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Matches it with the man-page.

Adresses: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=756187
Signed-off-by: Wolfram Sang <wsa@kernel.org>
---
 disk-utils/fdisk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index 457509cd3..8a9b8cf2a 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -849,8 +849,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(USAGE_HEADER, out);
 
 	fprintf(out,
-	      _(" %1$s [options] <disk>      change partition table\n"
-	        " %1$s [options] -l [<disk>] list partition table(s)\n"),
+	      _(" %1$s [options] <disk>         change partition table\n"
+	        " %1$s [options] -l [<disk>...] list partition table(s)\n"),
 	       program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
-- 
2.26.2

