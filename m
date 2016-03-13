Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:56412 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754281AbcCMWbZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 18:31:25 -0400
Received: from tenfore.ga-group.nl ([2.247.85.77]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0M1zFf-1ZqhFo1p4F-00u3U6 for
 <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 23:31:23 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 04/12] tests: remove invalid argument in libmount/debug
Date: Sun, 13 Mar 2016 23:31:12 +0100
Message-Id: <1457908280-15588-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
References: <1457908280-15588-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This was usually no problem because of unsafe strtoul(3) usage in
test prog libmount/src/init.c. But musl's strtoul sets errno if
no digit was found in the argument.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/libmount/debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/ts/libmount/debug b/tests/ts/libmount/debug
index da9ecc3..d722b4e 100755
--- a/tests/ts/libmount/debug
+++ b/tests/ts/libmount/debug
@@ -19,12 +19,12 @@ ts_finalize_subtest
 
 # CACHE | LOCKS
 ts_init_subtest "set-from-env-str"
-LIBMOUNT_DEBUG=cache,locks ts_valgrind $TESTPROG 2>&1 $TS_OUTPUT | grep -o '0x.*' &> $TS_OUTPUT
+LIBMOUNT_DEBUG=cache,locks ts_valgrind $TESTPROG 2>&1 | grep -o '0x.*' &> $TS_OUTPUT
 ts_finalize_subtest
 
 # CACHE | LOCKS
 ts_init_subtest "set-from-env-int"
-LIBMOUNT_DEBUG=20 ts_valgrind $TESTPROG 2>&1 $TS_OUTPUT | grep -o '0x.*' &> $TS_OUTPUT
+LIBMOUNT_DEBUG=20 ts_valgrind $TESTPROG 2>&1 | grep -o '0x.*' &> $TS_OUTPUT
 ts_finalize_subtest
 
 ts_finalize
-- 
1.8.4.5

