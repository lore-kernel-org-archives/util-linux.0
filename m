Return-Path: <SRS0=YMMD=WT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC1BC3A5A4
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 13:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9642173E
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 13:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fkskCfMS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BfPJFcmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfHWNdL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:33:11 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:33835 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388040AbfHWNdK (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Aug 2019 09:33:10 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 5BA6B3BF;
        Fri, 23 Aug 2019 09:33:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 23 Aug 2019 09:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=thyYpzA7djeUh
        hXftId3Gk7yNP3naEoA0eoyJ6f6Em8=; b=fkskCfMSfvSBrZsFhQDlSV7dMBl4G
        gSkvkLs4YqMcbgK4BManGwTXmTJ+WYZBzR8ZoZ7YHQd5kQlVRz9icBY70i6nbw3o
        7I0vi8mVY4XZZMnL+AfQPSn7Z1skL82CJfm2wL4xc4aujgMDNupLmPbIEKUm9Yvb
        A9IvWAeK4EL3V1Kxj1w/XzBKAfxR4gJQcC54r/+0AfuTP110eXZklAsFFg5E1A0C
        EL872ZASDzmnAr3EG0mrHrEY4mVd27PKXatN7amQtPsWsbijDYS6qIehU9fA6keg
        tTDayCRAtYLpvvqlia++K8VXnFJ50VLoc/wvNv2ZntEOGo4dWkuoRDvQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=thyYpzA7djeUhhXftId3Gk7yNP3naEoA0eoyJ6f6Em8=; b=BfPJFcmf
        rENNy2O8rUhr4XLZ66e8NN9WCuY9h2V1EBcLqtyRLmBq0PtPqIcucgoY3YcLb65Z
        7cVe0O6uzfNBAQV9eMBnlGWgtRQtJRl61ekx4LpGusq+FM9sGtDcu8p6pmLmBU2h
        sqfq89Nm/anO6lhr9rsfXAmdMZd7Tm9RMBsMSGZHCZsyy8cXtwfXboMR/JMZ+a9a
        9/go84p/zn/ObihuqAHC5JPdJrK4QyyiwxOGl0qgAeFbXPG+DS1KoUhrQ8RrdV3y
        LPJE/inF5lSR09MCF5va36/+AQC/2cFjV+y7JXe8MnAgaFwqYSa8/u4QDRwvHrPA
        sJUF59DAQhw7xQ==
X-ME-Sender: <xms:FOtfXTzJkrvrFyIOCFHoZty2uGIxEKJmIfKBvTzJ0GITRIcwwiWWZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeejrddule
    durddvudefrddvtddtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:FOtfXfs6kZF3JI62nQhaXSgk8674W3GcZ2LmadnqC3UQNb7MXKcStQ>
    <xmx:FOtfXaHWGUUuBYiXUuGct88PFbOo16zZQ6XxNqRs_vOVSscUoGc_3Q>
    <xmx:FOtfXffbBK13SexnTUM_WGgplwThuTVCyRJhpgRmbWrOwiA34MFqyQ>
    <xmx:FOtfXYf6S6owTOQJHMn3jDxhWRJrQsWNM1_SHlILfIdJYYuqJIxieQ>
Received: from NSJAIL (x4dbfd5c8.dyn.telefonica.de [77.191.213.200])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3EF03D60062;
        Fri, 23 Aug 2019 09:33:08 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 58646930 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 23 Aug 2019 13:33:04 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Karel Zak <kzak@redhat.com>
Subject: [PATCH v2 1/6] tests: remove reliance on buffer behaviour of stderr/stdout streams
Date:   Fri, 23 Aug 2019 15:32:53 +0200
Message-Id: <d503b30d13c847040a8343f0e7299ae1bf7cb120.1566566906.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566566906.git.ps@pks.im>
References: <cover.1566555078.git.ps@pks.im> <cover.1566566906.git.ps@pks.im>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

In the test cases "rename::exit_codes" and "rename::exit_codes", we rely
on the flushing behaviour of stderr and stdout streams relative to each
other. Streams in glibc will not flush on newlines if stdout is pointing
to a non-TTY file descriptor, but relying on this is fragile and may
break on systems with a different behaviour like musl libc.

Fix this by introducing a new parameter "--unbuffered" to `ts_run`. If
this parameter is passed and stdbuf(1) from coreutils is available, then
it will use it to disable buffering of standard output completely. Like
this, we can selectively run tests with this if ordering of messages
from stdout and stderr is being checked.

Signed-off-by: Patrick Steinhardt <ps@pks.im>

x
---
 tests/expected/misc/swaplabel    |  2 +-
 tests/expected/rename/exit_codes |  2 +-
 tests/functions.sh               | 47 +++++++++++++++++++++++---------
 tests/ts/misc/swaplabel          |  4 +--
 tests/ts/rename/exit_codes       |  2 +-
 5 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/tests/expected/misc/swaplabel b/tests/expected/misc/swaplabel
index 172f876af..790a28c6c 100644
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
index c57781788..3d53010b2 100644
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
diff --git a/tests/functions.sh b/tests/functions.sh
index 0605a1320..3d7bb89bc 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -420,26 +420,48 @@ function ts_init_py {
 }
 
 function ts_run {
+	local UNBUFFERED=
+
+	while true; do
+		case "$1" in
+			--unbuffered)
+				UNBUFFERED=1
+				shift;;
+			--)
+				shift
+				break;;
+			*)
+				break;;
+		esac
+	done
+
+	declare -a args
+
 	#
-	# valgrind mode
+	# ASAN mode
 	#
-	if [ -n "$TS_VALGRIND_CMD" ]; then
-		libtool --mode=execute \
-		$TS_VALGRIND_CMD --tool=memcheck --leak-check=full \
-				 --leak-resolution=high --num-callers=20 \
-				 --log-file="$TS_VGDUMP" "$@"
+	if [ "$TS_ENABLE_ASAN" == "yes" ]; then
+		args+=(ASAN_OPTIONS='detect_leaks=1')
+	fi
+
 	#
-	# ASAN mode
+	# Disable buffering of stdout
 	#
-	elif [ "$TS_ENABLE_ASAN" == "yes" ]; then
-		ASAN_OPTIONS='detect_leaks=1' "$@"
+	if [ -n "$UNBUFFERED" ]; then
+		if type stdbuf >/dev/null 2>&1; then
+			args+=(stdbuf --output=0)
+		fi
+	fi
 
 	#
-	# Default mode
+	# valgrind mode
 	#
-	else
-		"$@"
+	if [ -n "$TS_VALGRIND_CMD" ]; then
+		args+=(libtool --mode=execute "$TS_VALGRIND_CMD" --tool=memcheck --leak-check=full)
+		args+=(--leak-resolution=high --num-callers=20 --log-file="$TS_VGDUMP")
 	fi
+
+	"${args[@]}" "$@"
 }
 
 function ts_gen_diff {
@@ -977,4 +999,3 @@ function ts_has_ncurses_support {
 		echo "no"
 	fi
 }
-
diff --git a/tests/ts/misc/swaplabel b/tests/ts/misc/swaplabel
index 22858b0ac..106cb7d21 100755
--- a/tests/ts/misc/swaplabel
+++ b/tests/ts/misc/swaplabel
@@ -39,7 +39,7 @@ MIN_SWAP_SIZE_KB=$(( MIN_SWAP_SIZE / 1024 ))
 
 rm -f $IMAGE
 fallocate_or_skip $(( $MIN_SWAP_SIZE - 1 )) $IMAGE
-$TS_CMD_MKSWAP \
+ts_run --unbuffered $TS_CMD_MKSWAP \
 	--label 1234567890abcdef \
 	--uuid 12345678-abcd-abcd-abcd-1234567890ab \
 	$IMAGE 2>&1 |\
@@ -50,7 +50,7 @@ $TS_CMD_MKSWAP \
 
 rm -f $IMAGE
 fallocate_or_skip $MIN_SWAP_SIZE $IMAGE
-$TS_CMD_MKSWAP \
+ts_run --unbuffered $TS_CMD_MKSWAP \
 	--label 1234567890abcdef \
 	--uuid 12345678-abcd-abcd-abcd-1234567890ab \
 	$IMAGE 2>&1 |\
diff --git a/tests/ts/rename/exit_codes b/tests/ts/rename/exit_codes
index 37028162b..d3012ae59 100755
--- a/tests/ts/rename/exit_codes
+++ b/tests/ts/rename/exit_codes
@@ -32,7 +32,7 @@ $TS_CMD_RENAME -v codes values rename_exit_codes.? >> $TS_OUTPUT 2>&1
 echo "EXIT_SUCCESS: $?" >> $TS_OUTPUT
 
 mkdir rename_exit_codes.2
-$TS_CMD_RENAME -v values codes rename_exit_values.? >> $TS_OUTPUT 2>&1
+ts_run --unbuffered $TS_CMD_RENAME -v values codes rename_exit_values.? >> $TS_OUTPUT 2>&1
 echo "RENAME_EXIT_SOMEOK: $?" >> $TS_OUTPUT
 
 rmdir rename_exit_codes.2
-- 
2.23.0

