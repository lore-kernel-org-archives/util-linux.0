Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:60196 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756734AbdDFH4R (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 6 Apr 2017 03:56:17 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Masatake YAMATO <yamato@redhat.com>
Subject: [PATCH 1/5] tests: remove fincore SMALLER_THAN_PAGESIZE tests
Date: Thu,  6 Apr 2017 09:56:01 +0200
Message-Id: <1491465365-7515-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1491465365-7515-1-git-send-email-sweet_f_a@gmx.de>
References: <1491465365-7515-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

These tests failed for example on ext4 with a non-default
blocksize 1024. In this case it seems that the kernel only
caches a full page if we read at least PAGE_SIZE -BLOCK_SIZE +1.

Both tests also failed on NFS allthough block size seems to be
1M there.

We still keep the test for PAGE_SIZE-1 which seems to work more
reliable.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/fincore/count | 6 ------
 tests/ts/fincore/count       | 8 --------
 2 files changed, 14 deletions(-)

diff --git a/tests/expected/fincore/count b/tests/expected/fincore/count
index d5ce062..4665136 100644
--- a/tests/expected/fincore/count
+++ b/tests/expected/fincore/count
@@ -3,16 +3,12 @@ fincore: failed to open: no_such_file: No such file or directory
 return value: 1
     0    0 i_EMPTY_FILE
 return value: 0
-    1  2048 i_SMALLER_THAN_PAGESIZE__incore_
-return value: 0
     1  4095 i_PAGESIZE_-1__incore_
 return value: 0
     1  4096 i_JUST_PAGESIZE_incore_
 return value: 0
     0  4096 i_JUST_PAGESIZE_directio_
 return value: 0
-    2  4097 i_PAGESIZE_+_1__incore_
-return value: 0
     2  8192 i_TWO_PAGES_incore_
 return value: 0
     0  8192 i_TWO_PAGES_directio_
@@ -41,11 +37,9 @@ return value: 0
 fincore: failed to open: no_such_file: No such file or directory
 PAGES      SIZE FILE
     0         0 i_EMPTY_FILE
-    1      2048 i_SMALLER_THAN_PAGESIZE__incore_
     1      4095 i_PAGESIZE_-1__incore_
     1      4096 i_JUST_PAGESIZE_incore_
     0      4096 i_JUST_PAGESIZE_directio_
-    2      4097 i_PAGESIZE_+_1__incore_
     2      8192 i_TWO_PAGES_incore_
     0      8192 i_TWO_PAGES_directio_
     1      8192 i_TWO_PAGES_mixed_directio_incore_
diff --git a/tests/ts/fincore/count b/tests/ts/fincore/count
index 87e25a8..8f23fec 100755
--- a/tests/ts/fincore/count
+++ b/tests/ts/fincore/count
@@ -92,10 +92,6 @@ input=
 } >> $TS_OUTPUT 2>&1
 
 {
-    run_dd_test "SMALLER THAN PAGESIZE (incore)" $(( PAGE_SIZE / 2 ))
-} >> $TS_OUTPUT 2>&1
-
-{
     run_dd_test "PAGESIZE -1 (incore)" $(( PAGE_SIZE - 1 ))
 } >> $TS_OUTPUT 2>&1
 
@@ -108,10 +104,6 @@ input=
 } >> $TS_OUTPUT 2>&1
 
 {
-    run_dd_test "PAGESIZE + 1 (incore)" $(( PAGE_SIZE + 1 ))
-} >> $TS_OUTPUT 2>&1
-
-{
     run_dd_test "TWO PAGES(incore)" $(( 2 * PAGE_SIZE ))
 } >> $TS_OUTPUT 2>&1
 
-- 
1.8.5.6

