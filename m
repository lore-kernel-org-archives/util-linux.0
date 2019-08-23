Return-Path: <SRS0=YMMD=WT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEFBC3A5A4
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 10:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA192233A0
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 10:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="z7lBwylH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MOQPSwhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfHWKRK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:17:10 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46233 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731077AbfHWKRJ (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Aug 2019 06:17:09 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 7D993466
        for <util-linux@vger.kernel.org>; Fri, 23 Aug 2019 06:17:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 23 Aug 2019 06:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=OpLOvYOGFzwID
        YO9MxSZEuMBgl0VVWeXzfl/YXzf0y8=; b=z7lBwylH4M6X0Va3irqjkZ2iWSxsp
        LOmf3mkUVa6wt7xx7TOq21FeKG0Yi3oluIUxLgpE7aq20zkZs7RFGb+D5GYVBZR8
        aIoaFT8FETpH0uK8L7a0KQwnPMga+xfU5mo6ZW9+yqYA2Ssh9zqEvaRDRD4k0sjU
        8HErOKqT7O+VMgTWWIqWIS+ieFPsOcY6GlenLPUJmEfb0ob3O5c1QKV7qQKGgjtc
        TQM1pTu5Uf+1z5dzCdzb+lHO25ywHlbBFaQ/xOqKU3hL8kocHDe8BdzdHgD4i/TP
        k2neuDjkopl42+5yWB1ZsGlf60Eu6HCsS95bqTivXTRdxYGA1187bY0+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=OpLOvYOGFzwIDYO9MxSZEuMBgl0VVWeXzfl/YXzf0y8=; b=MOQPSwhI
        qeBigz63BgbA4rUOSzsjzVCiuKASuPQ63nP8P6I1PLrRwaPd47/E1b1V9P3ZgILA
        jvEcz0HT4yX2v41mwmg0K1LQvvT4tp7Ul5IQnHdTnvwTGS5Re3ntytTx+UEXD7nS
        cr3j/S0CtQThhBLBc/W71oESfM83SjCXnNvcge+sUoAuXnw+GgcGR6j+OAIahRCt
        WIy2naKtU3QrdaM5XZL1nKdfxn6vAGdzeqRgZlubS+NRHxGRQA0tePld4zpC082e
        fvkRc0Uv9mahiK+FYlVylcuwR10XZ97frNC5RfstxGoAoP5iL1juOOIZE67W1AaX
        jgq4tOK6W7tc5w==
X-ME-Sender: <xms:I71fXQfV_YtvZQic0rwrhqNmSI9hv87UFwUzqSVeBOJpJoGYW8ceeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecukfhppeejjedrudeluddrvddufedrvddttdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:I71fXeUWW4C1ebR7hVFFF65EM21NS-iwvuMm2nsxthery1xbzBB6ag>
    <xmx:I71fXW9civ8uj8D-pQhhHvrdtuYgbEeDN_OHkSSi7RZLjZdWHwZrcQ>
    <xmx:I71fXVMCM9VIbOd7z2bcqeZcqv1TvcJSeLApvcWOU64Rt5XCYZ-XQA>
    <xmx:JL1fXRfsWseZNlySefhuR9JpIYX9DNNCprO23Fy0PTxdwRD6ylaFBw>
Received: from NSJAIL (x4dbfd5c8.dyn.telefonica.de [77.191.213.200])
        by mail.messagingengine.com (Postfix) with ESMTPA id 72A7DD60062
        for <util-linux@vger.kernel.org>; Fri, 23 Aug 2019 06:17:07 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 0c663b15 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 23 Aug 2019 10:17:04 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/6] tests: remove reliance on buffer behaviour of stderr/stdout streams
Date:   Fri, 23 Aug 2019 12:16:58 +0200
Message-Id: <c41c946772ccad75661dfcd14e7c03c05fd35e83.1566555078.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566555078.git.ps@pks.im>
References: <cover.1566555078.git.ps@pks.im>
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

Fix this by introducing a new function `ts_unbuffered`. If available on
the local system, then it will execute stdbuf(1) from coreutils to
disable buffering of standard output completely. Like this, we can
selectively run tests with this if ordering of messages from stdout and
stderr is being checked.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 tests/expected/misc/swaplabel    | 2 +-
 tests/expected/rename/exit_codes | 2 +-
 tests/functions.sh               | 7 +++++++
 tests/ts/misc/swaplabel          | 4 ++--
 tests/ts/rename/exit_codes       | 2 +-
 5 files changed, 12 insertions(+), 5 deletions(-)

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
index 0605a1320..95d37bd5f 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -978,3 +978,10 @@ function ts_has_ncurses_support {
 	fi
 }
 
+function ts_unbuffered() {
+    if type stdbuf >/dev/null 2>&1; then
+        stdbuf -o0 "$@"
+    else
+        "$@"
+    fi
+}
diff --git a/tests/ts/misc/swaplabel b/tests/ts/misc/swaplabel
index 22858b0ac..681b39a64 100755
--- a/tests/ts/misc/swaplabel
+++ b/tests/ts/misc/swaplabel
@@ -39,7 +39,7 @@ MIN_SWAP_SIZE_KB=$(( MIN_SWAP_SIZE / 1024 ))
 
 rm -f $IMAGE
 fallocate_or_skip $(( $MIN_SWAP_SIZE - 1 )) $IMAGE
-$TS_CMD_MKSWAP \
+ts_unbuffered $TS_CMD_MKSWAP \
 	--label 1234567890abcdef \
 	--uuid 12345678-abcd-abcd-abcd-1234567890ab \
 	$IMAGE 2>&1 |\
@@ -50,7 +50,7 @@ $TS_CMD_MKSWAP \
 
 rm -f $IMAGE
 fallocate_or_skip $MIN_SWAP_SIZE $IMAGE
-$TS_CMD_MKSWAP \
+ts_unbuffered $TS_CMD_MKSWAP \
 	--label 1234567890abcdef \
 	--uuid 12345678-abcd-abcd-abcd-1234567890ab \
 	$IMAGE 2>&1 |\
diff --git a/tests/ts/rename/exit_codes b/tests/ts/rename/exit_codes
index 37028162b..739a8738c 100755
--- a/tests/ts/rename/exit_codes
+++ b/tests/ts/rename/exit_codes
@@ -32,7 +32,7 @@ $TS_CMD_RENAME -v codes values rename_exit_codes.? >> $TS_OUTPUT 2>&1
 echo "EXIT_SUCCESS: $?" >> $TS_OUTPUT
 
 mkdir rename_exit_codes.2
-$TS_CMD_RENAME -v values codes rename_exit_values.? >> $TS_OUTPUT 2>&1
+ts_unbuffered $TS_CMD_RENAME -v values codes rename_exit_values.? >> $TS_OUTPUT 2>&1
 echo "RENAME_EXIT_SOMEOK: $?" >> $TS_OUTPUT
 
 rmdir rename_exit_codes.2
-- 
2.23.0

