Return-Path: <SRS0=Ofmp=5L=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D514C43331
	for <util-linux@archiver.kernel.org>; Thu, 26 Mar 2020 14:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC039206F8
	for <util-linux@archiver.kernel.org>; Thu, 26 Mar 2020 14:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgCZOi7 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:38:59 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:49698 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZOi7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 26 Mar 2020 10:38:59 -0400
Received: from localhost.localdomain (i19-les04-th2-31-36-16-7.sfr.lns.abo.bbox.fr [31.36.16.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 2CD5C5648AD;
        Thu, 26 Mar 2020 15:38:52 +0100 (CET)
From:   Aurelien LAJOIE <orel@melix.net>
To:     util-linux@vger.kernel.org
Cc:     Aurelien LAJOIE <orel@melix.net>
Subject: [PATCH v2] libuuid: improve uuid_unparse() performance
Date:   Thu, 26 Mar 2020 15:38:27 +0100
Message-Id: <20200326143827.25879-1-orel@melix.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Mar 26 15:38:52 2020 +0100 (CET))
X-Org-Mail: aurelien.lajoie.2000@polytechnique.org
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

There is 2 improvements:

 * remove useless uuid_unpack,
 * directly print the hexa format from memory without using printf
   we can do this as the bytes order is the network byte order
   https://tools.ietf.org/html/rfc4122#section-4.1.2
   even the spatially unique node identifier(the last 6 bytes)

The improvement is important, some results for 1000000 uuid_unparse calls:

Little Endian Ubuntu:
before took 382623 us
after  took  36740 us

Big Endian OpenBSD:
before took 3138172 us
after  took  180116 us

Signed-off-by: Aurelien LAJOIE <orel@melix.net>
---
 libuuid/src/unparse.c | 45 ++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/libuuid/src/unparse.c b/libuuid/src/unparse.c
index a95bbb042..0e7e8eae4 100644
--- a/libuuid/src/unparse.c
+++ b/libuuid/src/unparse.c
@@ -36,41 +36,38 @@
 
 #include "uuidP.h"
 
-static const char *fmt_lower =
-	"%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x";
+static char const hexdigits_lower[16] = "0123456789abcdef";
+static char const hexdigits_upper[16] = "0123456789ABCDEF";
 
-static const char *fmt_upper =
-	"%08X-%04X-%04X-%02X%02X-%02X%02X%02X%02X%02X%02X";
-
-#ifdef UUID_UNPARSE_DEFAULT_UPPER
-#define FMT_DEFAULT fmt_upper
-#else
-#define FMT_DEFAULT fmt_lower
-#endif
-
-static void uuid_unparse_x(const uuid_t uu, char *out, const char *fmt)
+static void uuid_fmt(const uuid_t uuid, char *buf, char const fmt[restrict])
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
+		size_t tmp = uuid[i];
+		*p++ = fmt[tmp >> 4];
+		*p++ = fmt[tmp & 15];
+	}
+	*p = '\0';
 }
 
 void uuid_unparse_lower(const uuid_t uu, char *out)
 {
-	uuid_unparse_x(uu, out,	fmt_lower);
+	uuid_fmt(uu, out, hexdigits_lower);
 }
 
 void uuid_unparse_upper(const uuid_t uu, char *out)
 {
-	uuid_unparse_x(uu, out,	fmt_upper);
+	uuid_fmt(uu, out, hexdigits_upper);
 }
 
+#ifdef UUID_UNPARSE_DEFAULT_UPPER
 void uuid_unparse(const uuid_t uu, char *out)
-{
-	uuid_unparse_x(uu, out, FMT_DEFAULT);
-}
+	__attribute__((alias("uuid_unparse_upper")));
+#else
+void uuid_unparse(const uuid_t uu, char *out)
+	__attribute__((alias("uuid_unparse_lower")));
+#endif
-- 
2.20.1

