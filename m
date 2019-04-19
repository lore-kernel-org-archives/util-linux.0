Return-Path: <SRS0=YmP7=SV=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4399AC282DA
	for <util-linux@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B2B222AF
	for <util-linux@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSmXF271"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfDSS3H (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:29:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43252 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfDSS3H (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 19 Apr 2019 14:29:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so2975867pgu.10
        for <util-linux@vger.kernel.org>; Fri, 19 Apr 2019 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=z9pZ36v5OV99XgKMqGoNR28qx2i7FleoL9uym3hYEnY=;
        b=lSmXF2712Kf2uuaLLPSNoxy6kbySXISYjuvsl62EbXtwJbs/cQ6In/uOk/K0Ae6Rnm
         iI0BHTE14Te5XeaLTbgs4NlYk0vy+CFbv0FDOVBhdAOuSs8/b6uEcpmiNiU3hIl+Iwcv
         4ptT88fj6/sHUUPzoBnVrX4PncYcJRKEM15Bg9Smul6aoXF1oG6M80641owi97UxuwpH
         kF2/A6udp/nkYSIym9EBcT6ygNRh7w7MDWBj+fXjFLyFPq6Nx4VEc6mxCUFhDQoJvFLK
         wcMBDtUE3G7gaNDdlh2VEBrz7VybdiFLuejESWr22N5Jn1sJ79VcRgNsewNV3LbC3SWS
         9ZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z9pZ36v5OV99XgKMqGoNR28qx2i7FleoL9uym3hYEnY=;
        b=YX15KKteBQV/ZQ+aL/sBAJ66jQdCiXSiXgO/1H5qXEBrVYq0AuG6d5GPhFsQ+ohg8P
         8JSvluwQbobvLIfSTRUJezxanrs5OliKI3+81WE5MBZ8OVS0jBlXdNAnYdp47GqrhI55
         NrV6zQc5ANYm2hAlGmODvClfAxbnOdVe2MZBtqbcHrfftAwGpTvPIBw4SuwIMHsy3tne
         PoBisYFgxF0/yW7vBVGqIKtIEU72KoMnQwe8cMUpfGK4Q2NdiBiH5ZuwUE6pObM/xmsw
         e3LS515QaXhDhnFgemT7dgIQxy/vG6a66umhY2IVsA4AGeWyQRZuLfg8frDNiavarckj
         3sPg==
X-Gm-Message-State: APjAAAWrQvt1/WHvaVRvREF4rdTbRmpN2eaH8adAVLwRmb+JDvZrdrXL
        6v8Q4hCMtHvoddQeutPNC3FLSCP5
X-Google-Smtp-Source: APXvYqxHKJkTSfVosUsg2mJ7jyqrRJmLVw3GOpeASj4TCnwAWUqP7QpUArfbv5KawILabQfs9gGgZg==
X-Received: by 2002:a62:6e05:: with SMTP id j5mr4324598pfc.5.1555684647140;
        Fri, 19 Apr 2019 07:37:27 -0700 (PDT)
Received: from localhost.localdomain (fs276ec80e.tkyc203.ap.nuro.jp. [39.110.200.14])
        by smtp.gmail.com with ESMTPSA id g2sm8669748pfd.134.2019.04.19.07.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 07:37:26 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
X-Google-Original-From: Wang Shilong <wshilong1991@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Wang Shilong <wshilong@ddn.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] fstrim: document kernel return minlen explictly
Date:   Fri, 19 Apr 2019 23:37:20 +0900
Message-Id: <1555684640-23615-1-git-send-email-wshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Filesystem will modify @minlen according to its
block size etc, and will return actual unit
to userspace, document it into manpage.

Cc: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 sys-utils/fstrim.8 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/fstrim.8 b/sys-utils/fstrim.8
index f7e7aa9ef..10ef8bc23 100644
--- a/sys-utils/fstrim.8
+++ b/sys-utils/fstrim.8
@@ -76,10 +76,10 @@ the end of the filesystem.
 .IP "\fB\-m, \-\-minimum\fP \fIminimum-size\fP"
 Minimum contiguous free range to discard, in bytes. (This value is internally
 rounded up to a multiple of the filesystem block size.)  Free ranges smaller
-than this will be ignored.  By increasing this value, the fstrim operation
-will complete more quickly for filesystems with badly fragmented freespace,
-although not all blocks will be discarded.  The default value is zero,
-discarding every free block.
+than this will be ignored and kernel shall return modified value(fstrim_range.minlen)
+to userspace. By increasing this value, the fstrim operation will complete
+more quickly for filesystems with badly fragmented freespace, although not
+all blocks will be discarded.  The default value is zero, discarding every free block.
 .IP "\fB\-v, \-\-verbose\fP"
 Verbose execution.  With this option
 .B fstrim
-- 
2.21.0

