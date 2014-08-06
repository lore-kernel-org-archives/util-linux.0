Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f170.google.com ([74.125.82.170]:58858 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbaHFWEh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Aug 2014 18:04:37 -0400
Received: by mail-we0-f170.google.com with SMTP id w62so3295007wes.1
        for <util-linux@vger.kernel.org>; Wed, 06 Aug 2014 15:04:36 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] tests: make ipcs limit calculations work when numbers are large
Date: Wed,  6 Aug 2014 23:04:31 +0100
Message-Id: <1407362671-18446-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Test suite  failed when I ran it with kernel 3.16.  Error is the
following.

tests/ts/ipcs/limits2: line 31: [: 18446744073692774399: integer expression expected

Reference: http://lkml.iu.edu/hypermail/linux/kernel/1406.0/01869.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/ts/ipcs/limits2 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/ts/ipcs/limits2 b/tests/ts/ipcs/limits2
index 2333198..1a49c46 100755
--- a/tests/ts/ipcs/limits2
+++ b/tests/ts/ipcs/limits2
@@ -28,7 +28,8 @@ ts_check_prog "bc"
 . $TS_SELF/functions.sh
 
 # TODO https://github.com/karelzak/util-linux/issues/51
-if [ $(</proc/sys/kernel/shmall) -ge $(bc <<<"2^64 / $PAGE_SIZE") ]; then
+SHMALL=$(</proc/sys/kernel/shmall)
+if [ $(bc <<<"2^64 / $PAGE_SIZE < $SHMALL") -ne 1 ]; then
 	TS_KNOWN_FAIL="yes"
 fi
 
-- 
2.0.4

