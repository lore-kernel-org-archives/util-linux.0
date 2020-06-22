Return-Path: <SRS0=SdG/=AD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43632C433E0
	for <util-linux@archiver.kernel.org>; Mon, 22 Jun 2020 23:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ECBE20732
	for <util-linux@archiver.kernel.org>; Mon, 22 Jun 2020 23:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgFVXwN (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:52:13 -0400
Received: from vn01.namespace.at ([213.208.148.228]:34170 "EHLO
        nlay-fle-service01.in.namespace.at" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728636AbgFVXwN (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 22 Jun 2020 19:52:13 -0400
Received: from [10.100.0.62] (helo=debbuild.in.namespace.at)
        by nlay-fle-service01.in.namespace.at with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <zeha@debian.org>)
        id 1jnWET-009gqi-LG; Tue, 23 Jun 2020 01:52:09 +0200
Received: from ch by debbuild.in.namespace.at with local (Exim 4.94)
        (envelope-from <zeha@debian.org>)
        id 1jnWET-003QVe-CD; Mon, 22 Jun 2020 23:52:09 +0000
From:   Chris Hofstaedtler <zeha@debian.org>
To:     util-linux@vger.kernel.org
Cc:     Mark Hindley <mark@hindley.org.uk>
Subject: [PATCH] Fix mountpoint test failure in build chroots.
Date:   Mon, 22 Jun 2020 23:52:09 +0000
Message-Id: <20200622235209.816843-1-zeha@debian.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Mark Hindley <mark@hindley.org.uk>

The test assumed that / was a mountpoint. This is not always the case, for
example in pbuilder/cowbuilder chroots. So use / if findmnt verifies it is a
mountpoint, otherwise use the first mountpoint found. Skip the test if no
mountpoints are found.

Signed-off-by: Mark Hindley <mark@hindley.org.uk>
---
 tests/expected/misc/mountpoint-default  |  2 +-
 tests/expected/misc/mountpoint-nofollow |  2 +-
 tests/ts/misc/mountpoint                | 15 +++++++++++----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/tests/expected/misc/mountpoint-default b/tests/expected/misc/mountpoint-default
index 9a7ac6ab3..ca7505538 100644
--- a/tests/expected/misc/mountpoint-default
+++ b/tests/expected/misc/mountpoint-default
@@ -1,2 +1,2 @@
-./symlink-to-root is a mountpoint
+./symlink-to-mountpoint is a mountpoint
 0
diff --git a/tests/expected/misc/mountpoint-nofollow b/tests/expected/misc/mountpoint-nofollow
index 1ba174959..03d2b5da8 100644
--- a/tests/expected/misc/mountpoint-nofollow
+++ b/tests/expected/misc/mountpoint-nofollow
@@ -1,2 +1,2 @@
-./symlink-to-root is not a mountpoint
+./symlink-to-mountpoint is not a mountpoint
 1
diff --git a/tests/ts/misc/mountpoint b/tests/ts/misc/mountpoint
index 1b391c3bf..e52ccb28f 100755
--- a/tests/ts/misc/mountpoint
+++ b/tests/ts/misc/mountpoint
@@ -7,16 +7,23 @@ TS_DESC="mountpoint"
 ts_init "$*"
 
 ts_check_test_command "$TS_CMD_MOUNTPOINT"
+ts_check_test_command "$TS_CMD_FINDMNT"
 
-ln -s / ./symlink-to-root
+# / is not always a mountpoint (chroots etc.), so check if it is and otherwise
+# fallback to the first available mountpoint.
+FIRST_MOUNTPOINT=$($TS_CMD_FINDMNT -no TARGET / || $TS_CMD_FINDMNT -fno TARGET)
+
+[ -z "$FIRST_MOUNTPOINT" ] && ts_skip "no mountpoint found for symlink tests"
+
+ln -s $FIRST_MOUNTPOINT ./symlink-to-mountpoint
 
 ts_init_subtest "default"
-$TS_CMD_MOUNTPOINT ./symlink-to-root >> $TS_OUTPUT 2>> $TS_ERRLOG
+$TS_CMD_MOUNTPOINT ./symlink-to-mountpoint >> $TS_OUTPUT 2>> $TS_ERRLOG
 echo $? >> $TS_OUTPUT 2>> $TS_ERRLOG
 ts_finalize_subtest
 
 ts_init_subtest "nofollow"
-$TS_CMD_MOUNTPOINT --nofollow ./symlink-to-root >> $TS_OUTPUT 2>> $TS_ERRLOG
+$TS_CMD_MOUNTPOINT --nofollow ./symlink-to-mountpoint >> $TS_OUTPUT 2>> $TS_ERRLOG
 echo $? >> $TS_OUTPUT 2>> $TS_ERRLOG
 ts_finalize_subtest
 
@@ -25,5 +32,5 @@ $TS_CMD_MOUNTPOINT --devno --nofollow / >> $TS_OUTPUT 2>> $TS_ERRLOG
 echo $? >> $TS_OUTPUT 2>> $TS_ERRLOG
 ts_finalize_subtest
 
-rm -f ./symlink-to-root
+rm -f ./symlink-to-mountpoint
 ts_finalize
-- 
2.27.0

