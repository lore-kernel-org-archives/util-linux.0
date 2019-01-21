Return-Path: <SRS0=DJtv=P5=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02642C282DE
	for <util-linux@archiver.kernel.org>; Mon, 21 Jan 2019 07:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6AB2084A
	for <util-linux@archiver.kernel.org>; Mon, 21 Jan 2019 07:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfAUHrD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:47:03 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:53612 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfAUHrD (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 21 Jan 2019 02:47:03 -0500
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 0ABC43A1B67
        for <util-linux@vger.kernel.org>; Mon, 21 Jan 2019 03:45:21 +0100 (CET)
X-Originating-IP: 71.238.64.75
Received: from localhost (c-71-238-64-75.hsd1.or.comcast.net [71.238.64.75])
        (Authenticated sender: josh@joshtriplett.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 2DCB81BF20A;
        Mon, 21 Jan 2019 02:45:19 +0000 (UTC)
Date:   Sun, 20 Jan 2019 18:45:16 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     util-linux@vger.kernel.org
Cc:     Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH] libuuid: Make the uuid_unparse functions inline
Message-ID: <20190121024510.GA22370@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Various libraries, including libblkid, depend on libuuid solely to call
uuid_unparse, which just prints a UUID. Move the uuid_unparse functions
to uuid.h and make them static inline, so that applications depending
solely on the uuid_unparse functions don't need to pull in libuuid. Keep
the out-of-line symbols for compatibility with existing applications.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 libuuid/src/unparse.c | 40 +---------------------------------------
 libuuid/src/uuid.h    | 39 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 42 deletions(-)

diff --git a/libuuid/src/unparse.c b/libuuid/src/unparse.c
index a95bbb042..808c41869 100644
--- a/libuuid/src/unparse.c
+++ b/libuuid/src/unparse.c
@@ -34,43 +34,5 @@
 
 #include <stdio.h>
 
+#define UUID_DEFINE_UNPARSE_SYMBOLS
 #include "uuidP.h"
-
-static const char *fmt_lower =
-	"%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x";
-
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
-{
-	struct uuid uuid;
-
-	uuid_unpack(uu, &uuid);
-	sprintf(out, fmt,
-		uuid.time_low, uuid.time_mid, uuid.time_hi_and_version,
-		uuid.clock_seq >> 8, uuid.clock_seq & 0xFF,
-		uuid.node[0], uuid.node[1], uuid.node[2],
-		uuid.node[3], uuid.node[4], uuid.node[5]);
-}
-
-void uuid_unparse_lower(const uuid_t uu, char *out)
-{
-	uuid_unparse_x(uu, out,	fmt_lower);
-}
-
-void uuid_unparse_upper(const uuid_t uu, char *out)
-{
-	uuid_unparse_x(uu, out,	fmt_upper);
-}
-
-void uuid_unparse(const uuid_t uu, char *out)
-{
-	uuid_unparse_x(uu, out, FMT_DEFAULT);
-}
diff --git a/libuuid/src/uuid.h b/libuuid/src/uuid.h
index 03c232caa..0c207f5b9 100644
--- a/libuuid/src/uuid.h
+++ b/libuuid/src/uuid.h
@@ -35,6 +35,7 @@
 #ifndef _UUID_UUID_H
 #define _UUID_UUID_H
 
+#include <stdio.h>
 #include <sys/types.h>
 #ifndef _WIN32
 #include <sys/time.h>
@@ -102,9 +103,41 @@ extern int uuid_is_null(const uuid_t uu);
 extern int uuid_parse(const char *in, uuid_t uu);
 
 /* unparse.c */
-extern void uuid_unparse(const uuid_t uu, char *out);
-extern void uuid_unparse_lower(const uuid_t uu, char *out);
-extern void uuid_unparse_upper(const uuid_t uu, char *out);
+#ifdef UUID_DEFINE_UNPARSE_SYMBOLS
+#define UNPARSE_FUNC
+void uuid_unparse_lower(const uuid_t uu, char *out);
+void uuid_unparse_upper(const uuid_t uu, char *out);
+void uuid_unparse(const uuid_t uu, char *out);
+#else
+#define UNPARSE_FUNC static inline
+#endif
+UNPARSE_FUNC void uuid_unparse_lower(const uuid_t uu, char *out)
+{
+	sprintf(out,
+		"%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x",
+		uu[0], uu[1], uu[2], uu[3],
+		uu[4], uu[5],
+		uu[6], uu[7],
+		uu[8], uu[9],
+		uu[10], uu[11], uu[12], uu[13], uu[14],uu[15]);
+}
+
+UNPARSE_FUNC void uuid_unparse_upper(const uuid_t uu, char *out)
+{
+	sprintf(out,
+		"%02X%02X%02X%02X-%02X%02X-%02X%02X-%02X%02X-%02X%02X%02X%02X%02X%02X",
+		uu[0], uu[1], uu[2], uu[3],
+		uu[4], uu[5],
+		uu[6], uu[7],
+		uu[8], uu[9],
+		uu[10], uu[11], uu[12], uu[13], uu[14],uu[15]);
+}
+
+UNPARSE_FUNC void uuid_unparse(const uuid_t uu, char *out)
+{
+	uuid_unparse_lower(uu, out);
+}
+#undef UNPARSE_FUNC
 
 /* uuid_time.c */
 extern time_t uuid_time(const uuid_t uu, struct timeval *ret_tv);
-- 
2.20.1

