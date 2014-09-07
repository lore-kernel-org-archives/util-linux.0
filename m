Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f178.google.com ([74.125.82.178]:38495 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbaIGMnN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 08:43:13 -0400
Received: by mail-we0-f178.google.com with SMTP id q58so1979179wes.37
        for <util-linux@vger.kernel.org>; Sun, 07 Sep 2014 05:43:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/17] libuuid: add extern qualifiers to uuid/uuid.h system header
Date: Sun,  7 Sep 2014 13:42:49 +0100
Message-Id: <1410093785-17537-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libuuid/src/uuid.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/libuuid/src/uuid.h b/libuuid/src/uuid.h
index 874d65a..30bd4c0 100644
--- a/libuuid/src/uuid.h
+++ b/libuuid/src/uuid.h
@@ -67,35 +67,35 @@ extern "C" {
 #endif
 
 /* clear.c */
-void uuid_clear(uuid_t uu);
+extern void uuid_clear(uuid_t uu);
 
 /* compare.c */
-int uuid_compare(const uuid_t uu1, const uuid_t uu2);
+extern int uuid_compare(const uuid_t uu1, const uuid_t uu2);
 
 /* copy.c */
-void uuid_copy(uuid_t dst, const uuid_t src);
+extern void uuid_copy(uuid_t dst, const uuid_t src);
 
 /* gen_uuid.c */
-void uuid_generate(uuid_t out);
-void uuid_generate_random(uuid_t out);
-void uuid_generate_time(uuid_t out);
-int uuid_generate_time_safe(uuid_t out);
+extern void uuid_generate(uuid_t out);
+extern void uuid_generate_random(uuid_t out);
+extern void uuid_generate_time(uuid_t out);
+extern int uuid_generate_time_safe(uuid_t out);
 
 /* isnull.c */
-int uuid_is_null(const uuid_t uu);
+extern int uuid_is_null(const uuid_t uu);
 
 /* parse.c */
-int uuid_parse(const char *in, uuid_t uu);
+extern int uuid_parse(const char *in, uuid_t uu);
 
 /* unparse.c */
-void uuid_unparse(const uuid_t uu, char *out);
-void uuid_unparse_lower(const uuid_t uu, char *out);
-void uuid_unparse_upper(const uuid_t uu, char *out);
+extern void uuid_unparse(const uuid_t uu, char *out);
+extern void uuid_unparse_lower(const uuid_t uu, char *out);
+extern void uuid_unparse_upper(const uuid_t uu, char *out);
 
 /* uuid_time.c */
-time_t uuid_time(const uuid_t uu, struct timeval *ret_tv);
-int uuid_type(const uuid_t uu);
-int uuid_variant(const uuid_t uu);
+extern time_t uuid_time(const uuid_t uu, struct timeval *ret_tv);
+extern int uuid_type(const uuid_t uu);
+extern int uuid_variant(const uuid_t uu);
 
 #ifdef __cplusplus
 }
-- 
2.1.0

