Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:57975 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbaI1TxN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:53:13 -0400
Received: by mail-wi0-f176.google.com with SMTP id n3so2021858wiv.9
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:53:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Adam Sampson <ats@offog.org>
Subject: [PATCH 23/23] tests: fix the ipcs test for shmall being too big to show
Date: Sun, 28 Sep 2014 20:51:56 +0100
Message-Id: <1411933916-30576-24-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Adam Sampson <ats@offog.org>

It was correct when originally introduced, but the shell overflow fix in
3a9ec12d6664527fad9c56347c88f3447d6c0856 accidentally reversed the sense
of the test.

Tested-by: Sami Kerola <kerolasa@iki.if>
Reviewed-by: Ruediger Meier <sweet_f_a@gmx.de>
Signed-off-by: Adam Sampson <ats@offog.org>
---
 tests/ts/ipcs/limits2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ts/ipcs/limits2 b/tests/ts/ipcs/limits2
index 1a49c46..4e96ce6 100755
--- a/tests/ts/ipcs/limits2
+++ b/tests/ts/ipcs/limits2
@@ -29,7 +29,7 @@ ts_check_prog "bc"
 
 # TODO https://github.com/karelzak/util-linux/issues/51
 SHMALL=$(</proc/sys/kernel/shmall)
-if [ $(bc <<<"2^64 / $PAGE_SIZE < $SHMALL") -ne 1 ]; then
+if [ $(bc <<<"(2^64 / $PAGE_SIZE) <= $SHMALL") -eq 1 ]; then
 	TS_KNOWN_FAIL="yes"
 fi
 
-- 
2.1.1

