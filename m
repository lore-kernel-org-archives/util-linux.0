Return-Path: <SRS0=YMMD=WT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03108C3A5A2
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 13:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9F82166E
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 13:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sjruGPUm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dFrC/wng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392854AbfHWNdQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:33:16 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:37289 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389164AbfHWNdP (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Aug 2019 09:33:15 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 99E163B3;
        Fri, 23 Aug 2019 09:33:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 23 Aug 2019 09:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=upoBhfvWGy6Qs
        B1pWjaRnf0UObuQVFPm4OIOEFIZcpM=; b=sjruGPUmMtVP64sj634AVu3WAyiRm
        2yz7b74/Q3fPLbOtoEOWP5x1ZyHZ66ITjPzGztf8xr74yQMpwfVD4/fSxeh+H4WE
        qoHxqvTBScbaQ6sJtZZ+BppPxa93OrGQmmYgMDa/+pQb3KcYywu2NosrxjnWuwtU
        6NpPTnG2KPrHVtIP7qfldfLTKQWAChd7DVpDt3a9SewQH3XqUydLHeQo8ONej/mz
        zhA/K1NPxD6GH7se31a4osVtE3yj5pdRAsFRnQV9W63H59JwU1EFv4z/O7Ope0YB
        truObWUll9sO6gHplfkUmkzPOzuP7hi7GJHTfQQ22olSNEgrCKrK7HNpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=upoBhfvWGy6QsB1pWjaRnf0UObuQVFPm4OIOEFIZcpM=; b=dFrC/wng
        C/Qd7082pswL7uP4J4EckjyRyK53rYFjklt/S9XfZwkDB1V2DOaj5zNqJM4H+QxD
        K00xd0zvS8cy3Pz2IyUnn+HTz8ql8n50Les8xDWcS8f/b2zjina/Dsz9hOhBOGMx
        1KFejNPDd4ImN+fg0GvYct7sY1kZTZ3cA3SsZ7FK41YX9oTe6ducHhbGJbEKSbN/
        nT9j6lDKPvjbjaQfFBbEAu7AUJ3ZT0WZdpdIt7M27FhfLdxbov1KlT7zoNLR2nq1
        Myyhem3kQjDV9M6mxk0CnnJZEyiswqAXkDAm0vUef+tg5Vr+Eb/5zjkBQTcRe1Pg
        cJqctjcFG8XMOw==
X-ME-Sender: <xms:GutfXacobyheFFw4tXcHTFpfehtxJuG4KBboIr95QEAGc8tsLJWjOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeejrddule
    durddvudefrddvtddtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    necuvehluhhsthgvrhfuihiivgepfe
X-ME-Proxy: <xmx:GutfXQZHyVAaouHM6MJrSy4q7jmN054aP6qvY9U5nBOEMpZjQE2CIw>
    <xmx:GutfXeZXqWOkFZyioZ6kNAzOxD-m9CYXOQTHKjv5PEU48IqzczcpNQ>
    <xmx:GutfXWkTH-wIF8Pn7RGGzFXUKabZQrpdDee7mwF6LowWMrApvQ2k-g>
    <xmx:GutfXR6qwjwICh_vU0Yxnhlr8hG0oZbZUsLew8qzy27Ik7gCACcjhQ>
Received: from NSJAIL (x4dbfd5c8.dyn.telefonica.de [77.191.213.200])
        by mail.messagingengine.com (Postfix) with ESMTPA id 625AB80066;
        Fri, 23 Aug 2019 09:33:13 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id c9ca5881 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 23 Aug 2019 13:33:12 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Karel Zak <kzak@redhat.com>
Subject: [PATCH v2 5/6] tests: col: avoid hardcoding of errno string
Date:   Fri, 23 Aug 2019 15:32:57 +0200
Message-Id: <987de1dbed24cda4d23ff3bc5c7d0ff8bf48f87d.1566566906.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566566906.git.ps@pks.im>
References: <cover.1566555078.git.ps@pks.im> <cover.1566566906.git.ps@pks.im>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The col/multibyte test has a hardcoded error string as part of its
expected output that is returned by glibc's strerror(3P) function. Even
though many of these strings are the same across libc implementations,
they are not standardiced and some are certainly different. One example
is the string for EILSEQ on musl libc.

To fix this, we introduce a new test helper "test_strerror". The helper
can be invoked with an error code like "EILSEQ", which will cause it to
print out the the respective error message for that code. Note that
"test_strerror" cannot act on the error's value (e.g. 84 for EILSEQ), as
these aren't standardized either. Instead, we thus need to have an array
of the error's string representation ("EILSEQ") to its respective error
code (the define EILSEQ). The array can trivially be extended as
required, thus it is only sparsely populated with EILSEQ right now.

To fix the col/multibyte test, we introduce a call to sed(1) to replace
the strerror(3P) message from EILSEQ with "EILSEQ". Furthermore, as
we're running tests with the POSIX locale by default which treats all
bytes as valid multibyte sequences, we have to change to the C.UTF-8
locale instead to actually get an error.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 tests/commands.sh             |  1 +
 tests/expected/col/multibyte  |  2 +-
 tests/helpers/Makemodule.am   |  3 +++
 tests/helpers/test_strerror.c | 42 +++++++++++++++++++++++++++++++++++
 tests/ts/col/multibyte        |  5 +++--
 5 files changed, 50 insertions(+), 3 deletions(-)
 create mode 100644 tests/helpers/test_strerror.c

diff --git a/tests/commands.sh b/tests/commands.sh
index 5cc34f6b3..9fcd488ce 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -33,6 +33,7 @@ TS_HELPER_PARTITIONS="${ts_helpersdir}sample-partitions"
 TS_HELPER_PATHS="${ts_helpersdir}test_pathnames"
 TS_HELPER_SCRIPT="${ts_helpersdir}test_script"
 TS_HELPER_SIGRECEIVE="${ts_helpersdir}test_sigreceive"
+TS_HELPER_STRERROR="${ts_helpersdir}test_strerror"
 TS_HELPER_STRUTILS="${ts_helpersdir}test_strutils"
 TS_HELPER_SYSINFO="${ts_helpersdir}test_sysinfo"
 TS_HELPER_TIOCSTI="${ts_helpersdir}test_tiocsti"
diff --git a/tests/expected/col/multibyte b/tests/expected/col/multibyte
index 4e299adc1..abf607249 100644
--- a/tests/expected/col/multibyte
+++ b/tests/expected/col/multibyte
@@ -1 +1 @@
-col: failed on line 1: Invalid or incomplete multibyte or wide character
+col: failed on line 1: EILSEQ
diff --git a/tests/helpers/Makemodule.am b/tests/helpers/Makemodule.am
index ab0b3cea9..a34cd8d2a 100644
--- a/tests/helpers/Makemodule.am
+++ b/tests/helpers/Makemodule.am
@@ -14,6 +14,9 @@ test_sha1_SOURCES = tests/helpers/test_sha1.c lib/sha1.c
 check_PROGRAMS += test_pathnames
 test_pathnames_SOURCES = tests/helpers/test_pathnames.c
 
+check_PROGRAMS += test_strerror
+test_strerror_SOURCES = tests/helpers/test_strerror.c
+
 check_PROGRAMS += test_sysinfo
 test_sysinfo_SOURCES = tests/helpers/test_sysinfo.c
 
diff --git a/tests/helpers/test_strerror.c b/tests/helpers/test_strerror.c
new file mode 100644
index 000000000..1919698eb
--- /dev/null
+++ b/tests/helpers/test_strerror.c
@@ -0,0 +1,42 @@
+/*
+ * This test program prints errno messages to allow for portable
+ * verification of error messages.
+ *
+ * Copyright (C) 2019 Patrick Steinhardt <ps@pks.im
+ *
+ * This file may be redistributed under the terms of the GNU Public
+ * License.
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#define E(x) { #x, x }
+static struct {
+	const char *str;
+	int error;
+} errors[] = {
+	E(EILSEQ)
+};
+
+int main(int argc, const char *argv[])
+{
+	size_t i;
+
+	if (argc != 2) {
+		fprintf(stderr, "USAGE: %s <errno>\n", argv[0]);
+		return -1;
+	}
+
+	for (i = 0; i < sizeof(errors)/sizeof(*errors); i++) {
+		if (strcmp(errors[i].str, argv[1]))
+			continue;
+		puts(strerror(errors[i].error));
+		return 0;
+	}
+
+	fprintf(stderr, "Invalid errno: %s\n", argv[1]);
+	return -1;
+}
diff --git a/tests/ts/col/multibyte b/tests/ts/col/multibyte
index e9c02922e..1ed4b5ff8 100755
--- a/tests/ts/col/multibyte
+++ b/tests/ts/col/multibyte
@@ -22,8 +22,9 @@ TS_DESC="multibyte input"
 ts_init "$*"
 
 ts_check_test_command "$TS_CMD_COL"
+ts_check_test_command "$TS_HELPER_STRERROR"
 
-cat $TS_SELF/multibyte.data | $TS_CMD_COL > /dev/null  2> $TS_OUTPUT
+cat $TS_SELF/multibyte.data | LC_ALL=C.UTF-8 $TS_CMD_COL 2>&1 > /dev/null |
+    sed -e "s@$($TS_HELPER_STRERROR EILSEQ)@EILSEQ@" > $TS_OUTPUT
 
 ts_finalize
-
-- 
2.23.0

