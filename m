Return-Path: <SRS0=yJR+=6T=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEF3C47254
	for <util-linux@archiver.kernel.org>; Tue,  5 May 2020 19:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F63620721
	for <util-linux@archiver.kernel.org>; Tue,  5 May 2020 19:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgEET56 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 5 May 2020 15:57:58 -0400
Received: from vn01.namespace.at ([213.208.148.228]:51190 "EHLO
        nlay-fle-service01.in.namespace.at" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729084AbgEET55 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 5 May 2020 15:57:57 -0400
X-Greylist: delayed 634 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 May 2020 15:57:56 EDT
Received: from [10.100.0.41] (helo=percival.namespace.at)
        by nlay-fle-service01.in.namespace.at with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ch@percival.namespace.at>)
        id 1jW3XD-005PHJ-EI; Tue, 05 May 2020 21:47:19 +0200
Received: from ch by percival.namespace.at with local (Exim 4.92)
        (envelope-from <ch@percival.namespace.at>)
        id 1jW3XD-009EAJ-BC; Tue, 05 May 2020 21:47:19 +0200
From:   Chris Hofstaedtler <zeha@debian.org>
To:     util-linux@vger.kernel.org
Cc:     Mark Hindley <mark@hindley.org.uk>
Subject: [PATCH] Fix for misc/fallocate test build failure.
Date:   Tue,  5 May 2020 21:28:55 +0200
Message-Id: <20200505192854.2194308-1-zeha@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Mark Hindley <mark@hindley.org.uk>

This was already a known possible failure case. However, in the migration to a
clearer separation of stdout and stderr in the testsuite, the logfile used to
detect the failure was not updated.

Signed-off-by: Mark Hindley <mark@hindley.org.uk>
---
 tests/ts/misc/fallocate | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ts/misc/fallocate b/tests/ts/misc/fallocate
index 2f77ee928..ec3d2d2f8 100755
--- a/tests/ts/misc/fallocate
+++ b/tests/ts/misc/fallocate
@@ -30,7 +30,7 @@ else
 	# fs type of $TS_OUTDIR, could be used to skip this test early
 	fs_type=$(${TS_CMD_FINDMNT} -n -o FSTYPE -T ${TS_OUTDIR})
 
-	grep -qi "fallocate: fallocate failed:.*not supported" $TS_OUTPUT \
+	grep -qi "fallocate: fallocate failed:.*not supported" $TS_ERRLOG \
 		&& ts_skip "'${fs_type}' not supported"
 fi
 
-- 
2.20.1

