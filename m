Return-Path: <SRS0=LABb=AE=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05278C433DF
	for <util-linux@archiver.kernel.org>; Tue, 23 Jun 2020 00:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2AC62082F
	for <util-linux@archiver.kernel.org>; Tue, 23 Jun 2020 00:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgFWAOc (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:14:32 -0400
Received: from vn01.namespace.at ([213.208.148.228]:34176 "EHLO
        nlay-fle-service01.in.namespace.at" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731000AbgFWAOc (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 22 Jun 2020 20:14:32 -0400
Received: from [10.100.0.62] (helo=debbuild.in.namespace.at)
        by nlay-fle-service01.in.namespace.at with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <zeha@debian.org>)
        id 1jnWa6-009hFY-MF
        for util-linux@vger.kernel.org; Tue, 23 Jun 2020 02:14:30 +0200
Received: from ch by debbuild.in.namespace.at with local (Exim 4.94)
        (envelope-from <zeha@debian.org>)
        id 1jnWa6-003jl1-DM
        for util-linux@vger.kernel.org; Tue, 23 Jun 2020 00:14:30 +0000
From:   Chris Hofstaedtler <zeha@debian.org>
To:     util-linux@vger.kernel.org
Subject: [PATCH] hexdump: automatically use -C when called as hd
Date:   Tue, 23 Jun 2020 00:14:30 +0000
Message-Id: <20200623001430.890832-1-zeha@debian.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

When invoking hexdump as hd enable the "Canonical" format to by
default, implying the -C option.

This is historic behaviour on Debian and apparently also on FreeBSD.
Some Debian users have asked for this to be restored, after Debian
switched to util-linux' hexdump and hd.

Signed-off-by: Chris Hofstaedtler <zeha@debian.org>
---
 text-utils/hexdump.1 | 3 +++
 text-utils/hexdump.c | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
index eb508f6d4..80a7c0f0d 100644
--- a/text-utils/hexdump.1
+++ b/text-utils/hexdump.1
@@ -67,6 +67,9 @@ by the same sixteen bytes in
 format enclosed in
 .RB ' | '
 characters.
+Invoking the program as
+.B hd
+implies this option.
 .TP
 \fB\-d\fR, \fB\-\-two\-bytes\-decimal\fR
 \fITwo-byte decimal display\fR.  Display the input offset in hexadecimal,
diff --git a/text-utils/hexdump.c b/text-utils/hexdump.c
index cbd593e5f..ce83c9d83 100644
--- a/text-utils/hexdump.c
+++ b/text-utils/hexdump.c
@@ -82,6 +82,13 @@ parse_args(int argc, char **argv, struct hexdump *hex)
 		{NULL, no_argument, NULL, 0}
 	};
 
+	if (!strcmp(program_invocation_short_name, "hd")) {
+		/* Canonical format */
+		add_fmt("\"%08.8_Ax\n\"", hex);
+		add_fmt("\"%08.8_ax  \" 8/1 \"%02x \" \"  \" 8/1 \"%02x \" ", hex);
+		add_fmt("\"  |\" 16/1 \"%_p\" \"|\\n\"", hex);
+	}
+
 	while ((ch = getopt_long(argc, argv, "bcCde:f:L::n:os:vxhV", longopts, NULL)) != -1) {
 		switch (ch) {
 		case 'b':
-- 
2.27.0

