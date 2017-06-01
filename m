Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:59158 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751361AbdFABIo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 31 May 2017 21:08:44 -0400
Received: from tenfore.ga-group.nl ([77.12.147.210]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MY86C-1dTLdy0YWe-00UsFn for
 <util-linux@vger.kernel.org>; Thu, 01 Jun 2017 03:08:42 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/6] tests: use stdbuf when stderr and stdout is randomly ordered
Date: Thu,  1 Jun 2017 03:08:38 +0200
Message-Id: <1496279320-14541-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
References: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Linux User <rudi@zappa.l.ga-group.nl>

glibc seems to flush stdout before stderr.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/misc/swaplabel    | 2 +-
 tests/expected/rename/exit_codes | 2 +-
 tests/ts/misc/swaplabel          | 3 ++-
 tests/ts/rename/exit_codes       | 3 ++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/expected/misc/swaplabel b/tests/expected/misc/swaplabel
index 172f876..790a28c 100644
--- a/tests/expected/misc/swaplabel
+++ b/tests/expected/misc/swaplabel
@@ -1,7 +1,7 @@
 mkswap: error: swap area needs to be at least 10 pages
 mkswap: <swapfile>: insecure permissions <perm>, 0600 suggested.
-mkswap: Label was truncated.
 Setting up swapspace version 1, size = 9 pages (9xPGSZ bytes)
+mkswap: Label was truncated.
 LABEL=1234567890abcde, UUID=12345678-abcd-abcd-abcd-1234567890ab
 LABEL: 1234567890abcde
 UUID:  12345678-abcd-abcd-abcd-1234567890ab
diff --git a/tests/expected/rename/exit_codes b/tests/expected/rename/exit_codes
index c577817..3d53010 100644
--- a/tests/expected/rename/exit_codes
+++ b/tests/expected/rename/exit_codes
@@ -2,6 +2,6 @@ RENAME_EXIT_NOTHING: 4
 `rename_exit_codes.1' -> `rename_exit_values.1'
 `rename_exit_codes.2' -> `rename_exit_values.2'
 EXIT_SUCCESS: 0
-rename: rename_exit_values.2: rename to rename_exit_codes.2 failed: Is a directory
 `rename_exit_values.1' -> `rename_exit_codes.1'
+rename: rename_exit_values.2: rename to rename_exit_codes.2 failed: Is a directory
 RENAME_EXIT_SOMEOK: 2
diff --git a/tests/ts/misc/swaplabel b/tests/ts/misc/swaplabel
index 6463045..f934b21 100755
--- a/tests/ts/misc/swaplabel
+++ b/tests/ts/misc/swaplabel
@@ -20,6 +20,7 @@ ts_init "$*"
 
 ts_check_test_command "$TS_CMD_MKSWAP"
 ts_check_test_command "$TS_CMD_SWAPLABEL"
+ts_check_prog "stdbuf"
 
 # fallocate does not work on most file systems
 function fallocate_or_skip()
@@ -49,7 +50,7 @@ $TS_CMD_MKSWAP \
 
 rm -f $IMAGE
 fallocate_or_skip $MIN_SWAP_SIZE $IMAGE
-$TS_CMD_MKSWAP \
+stdbuf -oL -eL $TS_CMD_MKSWAP \
 	--label 1234567890abcdef \
 	--uuid 12345678-abcd-abcd-abcd-1234567890ab \
 	$IMAGE 2>&1 |\
diff --git a/tests/ts/rename/exit_codes b/tests/ts/rename/exit_codes
index 3702816..3d46120 100755
--- a/tests/ts/rename/exit_codes
+++ b/tests/ts/rename/exit_codes
@@ -22,6 +22,7 @@ TS_DESC="exit codes"
 ts_init "$*"
 
 ts_check_test_command "$TS_CMD_RENAME"
+ts_check_prog "stdbuf"
 ts_cd "$TS_OUTDIR"
 
 touch rename_exit_codes.{1..2}
@@ -32,7 +33,7 @@ $TS_CMD_RENAME -v codes values rename_exit_codes.? >> $TS_OUTPUT 2>&1
 echo "EXIT_SUCCESS: $?" >> $TS_OUTPUT
 
 mkdir rename_exit_codes.2
-$TS_CMD_RENAME -v values codes rename_exit_values.? >> $TS_OUTPUT 2>&1
+stdbuf -oL -eL $TS_CMD_RENAME -v values codes rename_exit_values.? >> $TS_OUTPUT 2>&1
 echo "RENAME_EXIT_SOMEOK: $?" >> $TS_OUTPUT
 
 rmdir rename_exit_codes.2
-- 
1.8.5.6

