Return-Path: <SRS0=B5TI=SZ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86693C10F03
	for <util-linux@archiver.kernel.org>; Tue, 23 Apr 2019 14:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5370120674
	for <util-linux@archiver.kernel.org>; Tue, 23 Apr 2019 14:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5Bu9a5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfDWO6h (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:58:37 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:35588 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWO6g (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 23 Apr 2019 10:58:36 -0400
Received: by mail-pl1-f173.google.com with SMTP id w24so7668459plp.2
        for <util-linux@vger.kernel.org>; Tue, 23 Apr 2019 07:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1Ws3TpeVTgUxk5sffFbPYLDpkn5eJeOZdhqmnTpVtOQ=;
        b=r5Bu9a5ZytUgqhm8K7J840K4/qZPv1S2ZYPHEE6xVJGIszhPCcHR1Kgjhvq/+U/82M
         afl7QrhKS7tcmpBvPNK7QsO9wCGHlYzgawIHZplWJ6KpOk/rBKaNGJ684p5dCmPt0V7B
         yjvCCYjks+tsScvJbHVSGgi2RNWX6Ooe67kXUBJy6iBPZ9g3Qhvn3bACVMxtAZwxhR7T
         amE39XPfK3HOHCv2Egb5wVD+igevzkCVnH3sK5ZcQCn4/ekSlLs3jXkDcbIh0rABpC0G
         j2rcxsMBDzVZWIwRLe3oR2RoqNOxIYPnBpifp3NObQpy+JsZOCdgTEK3v5ldh0+K29/K
         jjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1Ws3TpeVTgUxk5sffFbPYLDpkn5eJeOZdhqmnTpVtOQ=;
        b=XyjUUjDbyNT8ByiCMB05Ya2GfPHOvD5ckGhq8kb+QJq7vZJCg0cBiGWsGV65k2qH7k
         pZ3JNTO5hUPVocs0h+b976hPEUfib1HsRGZGhH5hklT8SXWhw2Ftk+DtBuUjbg6xlGz6
         ryFJS9beN5pa3a8MQcsPTNJm+OWdsiu60mdbQcolkudT9JIhOY90fWFJTob9ovJwcoEI
         Lw4+DHTAVyX5y+GOsH0VAR9RK1rAzeEFvor1rvJ4w2saZcVCY9X1UXPcOhUkdE/tPOcN
         r4HKdvZwTYMllKzIyAiqE0lPrhDIMB8lXBMks3itenNpQJlSICYE7ElYXzZZk9g13APH
         sFVw==
X-Gm-Message-State: APjAAAWTnRpR89N55II4MMCDpWgiQdKNykDX0CchWeY3oN/5KiKqn3aT
        2YvRojBqWZ4GcYllrgAfz9EDsbFC
X-Google-Smtp-Source: APXvYqzxHRW3lWCmm/tu00hW70zYHR+nrWn0CCWnjywJNNTssbIisLN9m1MHPO/UqnSN03ffXZNfTw==
X-Received: by 2002:a17:902:2c01:: with SMTP id m1mr27440713plb.22.1556031515630;
        Tue, 23 Apr 2019 07:58:35 -0700 (PDT)
Received: from localhost.localdomain (fs276ec80e.tkyc203.ap.nuro.jp. [39.110.200.14])
        by smtp.gmail.com with ESMTPSA id o81sm28269641pfa.156.2019.04.23.07.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 07:58:34 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
X-Google-Original-From: Wang Shilong <wshilong1991@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Wang Shilong <wshilong@ddn.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH v2] fstrim: document kernel return minlen explicitly
Date:   Tue, 23 Apr 2019 23:58:28 +0900
Message-Id: <1556031508-18850-1-git-send-email-wshilong1991@gmail.com>
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
v1->v2:
better explain as darrick suggestion..
---
 sys-utils/fstrim.8 | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sys-utils/fstrim.8 b/sys-utils/fstrim.8
index f7e7aa9ef..c6ecca706 100644
--- a/sys-utils/fstrim.8
+++ b/sys-utils/fstrim.8
@@ -76,10 +76,11 @@ the end of the filesystem.
 .IP "\fB\-m, \-\-minimum\fP \fIminimum-size\fP"
 Minimum contiguous free range to discard, in bytes. (This value is internally
 rounded up to a multiple of the filesystem block size.)  Free ranges smaller
-than this will be ignored.  By increasing this value, the fstrim operation
-will complete more quickly for filesystems with badly fragmented freespace,
-although not all blocks will be discarded.  The default value is zero,
-discarding every free block.
+than this will be ignored and fstrim will adjust the minimum if it's smaller than
+the device's minimum, and report that (fstrim_range.minlen) back to userspace.
+By increasing this value, the fstrim operation will complete more quickly for
+filesystems with badly fragmented freespace, although not all blocks will be
+discarded.  The default value is zero, discarding every free block.
 .IP "\fB\-v, \-\-verbose\fP"
 Verbose execution.  With this option
 .B fstrim
-- 
2.21.0

