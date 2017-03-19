Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36795 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbdCSKTU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 19 Mar 2017 06:19:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id x124so9791049wmf.3
        for <util-linux@vger.kernel.org>; Sun, 19 Mar 2017 03:19:19 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/5] libsmartcols: fix test variable shadowing
Date: Sun, 19 Mar 2017 10:10:41 +0000
Message-Id: <20170319101045.3018-2-kerolasa@iki.fi>
In-Reply-To: <20170319101045.3018-1-kerolasa@iki.fi>
References: <20170319101045.3018-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

libsmartcols/samples/fromfile.c:57:16: warning: declaration of 'flags'
shadows a global declaration [-Wshadow]
libsmartcols/samples/fromfile.c:29:33: note: shadowed declaration is here
libsmartcols/samples/fromfile.c:101:8: warning: declaration of 'flags'
shadows a global declaration [-Wshadow]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libsmartcols/samples/fromfile.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/libsmartcols/samples/fromfile.c b/libsmartcols/samples/fromfile.c
index 4c9fca468..1a90e2d4b 100644
--- a/libsmartcols/samples/fromfile.c
+++ b/libsmartcols/samples/fromfile.c
@@ -54,12 +54,12 @@ static long name_to_flag(const char *name, size_t namesz)
 
 static int parse_column_flags(char *str)
 {
-	unsigned long flags = 0;
+	unsigned long num_flags = 0;
 
-	if (string_to_bitmask(str, &flags, name_to_flag))
+	if (string_to_bitmask(str, &num_flags, name_to_flag))
 		err(EXIT_FAILURE, "failed to parse column flags");
 
-	return flags;
+	return num_flags;
 }
 
 static struct libscols_column *parse_column(FILE *f)
@@ -98,8 +98,8 @@ static struct libscols_column *parse_column(FILE *f)
 		}
 		case 2: /* FLAGS */
 		{
-			int flags = parse_column_flags(line);
-			if (scols_column_set_flags(cl, flags))
+			int num_flags = parse_column_flags(line);
+			if (scols_column_set_flags(cl, num_flags))
 				goto fail;
 			if (strcmp(line, "wrapnl") == 0) {
 				scols_column_set_wrapfunc(cl,
-- 
2.12.0

