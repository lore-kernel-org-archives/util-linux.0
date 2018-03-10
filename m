Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33440 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeCJVU2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 10 Mar 2018 16:20:28 -0500
Received: by mail-wr0-f194.google.com with SMTP id v18so12102196wrv.0
        for <util-linux@vger.kernel.org>; Sat, 10 Mar 2018 13:20:28 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] closestream: remove dummy function __fpending()
Date: Sat, 10 Mar 2018 21:20:24 +0000
Message-Id: <20180310212024.5126-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Exclude __fpending() from build when function is not available.  This is
more obvious than adding a dummy function and expecting compiler to
eliminate it as dead code.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/closestream.h | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/closestream.h b/include/closestream.h
index 2dfe11360..b3b257c94 100644
--- a/include/closestream.h
+++ b/include/closestream.h
@@ -14,22 +14,20 @@
 # define CLOSE_EXIT_CODE EXIT_FAILURE
 #endif
 
-#ifndef HAVE___FPENDING
-static inline int
-__fpending(FILE *stream __attribute__((__unused__)))
-{
-	return 0;
-}
-#endif
-
 static inline int
 close_stream(FILE * stream)
 {
+#ifdef HAVE___FPENDING
 	const int some_pending = (__fpending(stream) != 0);
+#endif
 	const int prev_fail = (ferror(stream) != 0);
 	const int fclose_fail = (fclose(stream) != 0);
 
-	if (prev_fail || (fclose_fail && (some_pending || errno != EBADF))) {
+	if (prev_fail || (fclose_fail && (
+#ifdef HAVE___FPENDING
+					  some_pending ||
+#endif
+					  errno != EBADF))) {
 		if (!fclose_fail && !(errno == EPIPE))
 			errno = 0;
 		return EOF;
-- 
2.16.2

