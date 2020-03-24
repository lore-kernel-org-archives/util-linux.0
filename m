Return-Path: <SRS0=M7Df=5J=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21160C10DCE
	for <util-linux@archiver.kernel.org>; Tue, 24 Mar 2020 21:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F421A206F6
	for <util-linux@archiver.kernel.org>; Tue, 24 Mar 2020 21:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgCXVfW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:35:22 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:46671 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgCXVfW (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 24 Mar 2020 17:35:22 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Mar 2020 17:35:21 EDT
Received: from localhost.localdomain (i19-les04-th2-31-36-16-7.sfr.lns.abo.bbox.fr [31.36.16.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 47FA25613BD;
        Tue, 24 Mar 2020 22:27:09 +0100 (CET)
From:   Aurelien LAJOIE <orel@melix.net>
To:     util-linux@vger.kernel.org
Cc:     Aurelien LAJOIE <orel@melix.net>
Subject: [PATCH] libuuid: improve uuid_unparse() performance
Date:   Tue, 24 Mar 2020 22:26:25 +0100
Message-Id: <20200324212625.6934-1-orel@melix.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Mar 24 22:27:09 2020 +0100 (CET))
X-Org-Mail: aurelien.lajoie.2000@polytechnique.org
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

There is 2 improvements:

 * remove useless uuid_unpack,
 * directly print the hexa format from memory without using printf
   we can do this as the bytes order is the network byte order

The improvement is important, some results for 1000000 uuid_unparse calls:

Little Endian Ubuntu:
before took 382623 us
after  took  36740 us

Big Endian OpenBSD:
before took 3138172 us
after  took  180116 us

Signed-off-by: Aurelien LAJOIE <orel@melix.net>
---
 libuuid/src/unparse.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/libuuid/src/unparse.c b/libuuid/src/unparse.c
index a95bbb042..62bb3ef26 100644
--- a/libuuid/src/unparse.c
+++ b/libuuid/src/unparse.c
@@ -36,41 +36,40 @@
 
 #include "uuidP.h"
 
-static const char *fmt_lower =
-	"%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x";
-
-static const char *fmt_upper =
-	"%08X-%04X-%04X-%02X%02X-%02X%02X%02X%02X%02X%02X";
+char const __str_digits_lower[36] = "0123456789abcdefghijklmnopqrstuvwxyz";
+char const __str_digits_upper[36] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
 
 #ifdef UUID_UNPARSE_DEFAULT_UPPER
-#define FMT_DEFAULT fmt_upper
+#define STR_DIGIT_DEFAULT __str_digits_upper
 #else
-#define FMT_DEFAULT fmt_lower
+#define STR_DIGIT_DEFAULT __str_digits_lower
 #endif
 
-static void uuid_unparse_x(const uuid_t uu, char *out, const char *fmt)
+static void uuid_fmt(char *buf, const uuid_t uuid, char const fmt[36])
 {
-	struct uuid uuid;
+	char *p = buf;
 
-	uuid_unpack(uu, &uuid);
-	sprintf(out, fmt,
-		uuid.time_low, uuid.time_mid, uuid.time_hi_and_version,
-		uuid.clock_seq >> 8, uuid.clock_seq & 0xFF,
-		uuid.node[0], uuid.node[1], uuid.node[2],
-		uuid.node[3], uuid.node[4], uuid.node[5]);
+	for (int i = 0; i < 16; i++) {
+		if (i == 4 || i == 6 || i == 8 || i == 10) {
+			*p++ = '-';
+		}
+		*p++ = fmt[uuid[i] >> 4];
+		*p++ = fmt[uuid[i] & 15];
+	}
+	*p = '\0';
 }
 
 void uuid_unparse_lower(const uuid_t uu, char *out)
 {
-	uuid_unparse_x(uu, out,	fmt_lower);
+	uuid_fmt(out, uu, __str_digits_lower);
 }
 
 void uuid_unparse_upper(const uuid_t uu, char *out)
 {
-	uuid_unparse_x(uu, out,	fmt_upper);
+	uuid_fmt(out, uu, __str_digits_upper);
 }
 
 void uuid_unparse(const uuid_t uu, char *out)
 {
-	uuid_unparse_x(uu, out, FMT_DEFAULT);
+	uuid_fmt(out, uu, STR_DIGIT_DEFAULT);
 }
-- 
2.20.1

