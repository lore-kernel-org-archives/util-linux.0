Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EACC4167E
	for <util-linux@archiver.kernel.org>; Mon, 18 Oct 2021 17:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BF1860F02
	for <util-linux@archiver.kernel.org>; Mon, 18 Oct 2021 17:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhJRRzZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbhJRRzX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 18 Oct 2021 13:55:23 -0400
Received: from nlay-fle-service01.in.namespace.at (nlay-fle-service01.in.namespace.at [IPv6:2a01:190:1801:100::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1460EC06161C
        for <util-linux@vger.kernel.org>; Mon, 18 Oct 2021 10:53:12 -0700 (PDT)
Received: from [10.100.0.62] (helo=debbuild.in.namespace.at)
        by nlay-fle-service01.in.namespace.at with smtp (Exim 4.92)
        (envelope-from <zeha@debian.org>)
        id 1mcWov-006H7Z-DT; Mon, 18 Oct 2021 19:53:09 +0200
Received: (nullmailer pid 23647 invoked by uid 1000);
        Mon, 18 Oct 2021 17:53:09 -0000
From:   Chris Hofstaedtler <zeha@debian.org>
To:     util-linux@vger.kernel.org
Cc:     Mark Hindley <mark@hindley.org.uk>
Subject: [PATCH] Fix test/misc/swaplabel failure due to change in mkswap behaviour.
Date:   Mon, 18 Oct 2021 17:53:01 +0000
Message-Id: <20211018175301.23636-1-zeha@debian.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Mark Hindley <mark@hindley.org.uk>

mkswap now warns if the image file has holes. If fallocate is used to create the
file, use POSIX semantics to ensure the file has no holes.

This fixes the test failure

misc: swaplabel                      ... FAILED (misc/swaplabel)
========= script: /build/util-linux-2.37.2/tests/ts/misc/swaplabel =================
================= OUTPUT =====================
     1  Setting up swapspace version 1, size = 9 pages (9xPGSZ bytes)
     2  LABEL=1234567890abcde, UUID=12345678-abcd-abcd-abcd-1234567890ab
     3  LABEL: 1234567890abcde
     4  UUID:  12345678-abcd-abcd-abcd-1234567890ab
================= EXPECTED ===================
     1  Setting up swapspace version 1, size = 9 pages (9xPGSZ bytes)
     2  LABEL=1234567890abcde, UUID=12345678-abcd-abcd-abcd-1234567890ab
     3  LABEL: 1234567890abcde
     4  UUID:  12345678-abcd-abcd-abcd-1234567890ab
================= O/E diff ===================
==============================================

The additional error appears in swaplabel.err:

 mkswap: <swapfile> contains holes or other unsupported extents.
         This swap file can be rejected by kernel on swap activation!
         Use --verbose for more details.

[zeha@debian.org: this appears to be important/required when building
inside cowbuilder, on an ext3 filesystem.]

Signed-off-by: Mark Hindley <mark@hindley.org.uk>
---
 tests/ts/misc/swaplabel | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ts/misc/swaplabel b/tests/ts/misc/swaplabel
index 0801cb213..8b1abb5c3 100755
--- a/tests/ts/misc/swaplabel
+++ b/tests/ts/misc/swaplabel
@@ -25,7 +25,7 @@ ts_check_test_command "$TS_HELPER_SYSINFO"
 # fallocate does not work on most file systems
 function fallocate_or_skip()
 {
-	$TS_CMD_FALLOCATE -l $1 $2 2>/dev/null || \
+	$TS_CMD_FALLOCATE -x -l $1 $2 2>/dev/null || \
 	truncate -s $1 $2 || \
 	ts_skip "no way to create test image"
 }
-- 
2.20.1

