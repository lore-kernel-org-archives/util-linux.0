Return-Path: <SRS0=vWqr=7J=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16695C433DF
	for <util-linux@archiver.kernel.org>; Wed, 27 May 2020 23:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C082078C
	for <util-linux@archiver.kernel.org>; Wed, 27 May 2020 23:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgE0XVB (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 27 May 2020 19:21:01 -0400
Received: from vn01.namespace.at ([213.208.148.228]:56252 "EHLO
        nlay-fle-service01.in.namespace.at" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725267AbgE0XVB (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 27 May 2020 19:21:01 -0400
Received: from [10.100.0.62] (helo=debbuild.in.namespace.at)
        by nlay-fle-service01.in.namespace.at with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <zeha@debian.org>)
        id 1je5M2-00FTMi-Jy; Thu, 28 May 2020 01:20:58 +0200
Received: from ch by debbuild.in.namespace.at with local (Exim 4.93)
        (envelope-from <zeha@debian.org>)
        id 1je5M2-0025yH-8t; Wed, 27 May 2020 23:20:58 +0000
From:   Chris Hofstaedtler <zeha@debian.org>
To:     util-linux@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>
Subject: [PATCH] setarch: fix stderr handling in uname26 tests
Date:   Wed, 27 May 2020 23:20:58 +0000
Message-Id: <20200527232058.499568-1-zeha@debian.org>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Helge Deller <deller@gmx.de>

A while ago stdout and stderr have been split in these testcases, but
"FATAL: kernel too old" is actually treated as an "okay" output. However
this FATAL ends up on stderr, so when it happens, it is not seen in
the captured stdout.

Fix this by merging stdout/stderr in these cases once again.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Chris Hofstaedtler <zeha@debian.org>
Bug: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=961639
Fixes: cbf858aa085e25aa5afd1d06decaea6e14a8963f
---
 tests/ts/misc/setarch | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/ts/misc/setarch b/tests/ts/misc/setarch
index 7c99ccad2..6c872bf70 100755
--- a/tests/ts/misc/setarch
+++ b/tests/ts/misc/setarch
@@ -45,22 +45,22 @@ ts_init_subtest uname26
 finmsg="" # for debugging 2.6 issues
 
 echo "###### --uname-2.6 echo" >>$TS_OUTPUT
-$TS_CMD_SETARCH $ARCH -v --uname-2.6 echo "2.6 worked" >> $TS_OUTPUT 2>> $TS_ERRLOG
+$TS_CMD_SETARCH $ARCH -v --uname-2.6 echo "2.6 worked" >> $TS_OUTPUT 2>&1
 if [ $? -eq 0 ]; then
 	expected='^2.6 worked$'
 else
-	# this may happen after execvp
+	# this may happen after execvp - gets written to stderr
 	expected="^FATAL: kernel too old$"
 	finmsg+=" echo"
 fi
 sed -i "$ s/$expected/2.6 works or kernel too old/" $TS_OUTPUT
 
 echo "###### --uname-2.6 true, non-verbose" >>$TS_OUTPUT
-$TS_CMD_SETARCH $ARCH --uname-2.6 true >> $TS_OUTPUT 2>> $TS_ERRLOG
+$TS_CMD_SETARCH $ARCH --uname-2.6 true >> $TS_OUTPUT 2>&1
 if [ $? -eq 0 ]; then
 	echo "2.6 works or kernel too old" >> $TS_OUTPUT
 else
-	# this may happen after execvp
+	# this may happen after execvp - gets written to stderr
 	expected="^FATAL: kernel too old$"
 	sed -i "$ s/$expected/2.6 works or kernel too old/" $TS_OUTPUT
 	finmsg+=" true"
-- 
2.27.0.rc2

