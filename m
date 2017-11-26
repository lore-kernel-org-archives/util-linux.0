Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35796 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbdKZRrz (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 26 Nov 2017 12:47:55 -0500
Received: by mail-wr0-f196.google.com with SMTP id w95so24356671wrc.2
        for <util-linux@vger.kernel.org>; Sun, 26 Nov 2017 09:47:55 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/3] lib/signames: remove unused function
Date: Sun, 26 Nov 2017 17:47:49 +0000
Message-Id: <20171126174751.10500-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/signames.h | 1 -
 lib/signames.c     | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/signames.h b/include/signames.h
index 2096ad845..a4fd1bc59 100644
--- a/include/signames.h
+++ b/include/signames.h
@@ -3,7 +3,6 @@
 
 int signame_to_signum(const char *sig);
 const char *signum_to_signame(int signum);
-size_t get_numof_signames(void);
 int get_signame_by_idx(size_t idx, const char **signame, int *signum);
 
 #endif /* SIGNAMES_H */
diff --git a/lib/signames.c b/lib/signames.c
index a654e88b1..316eec527 100644
--- a/lib/signames.c
+++ b/lib/signames.c
@@ -189,11 +189,6 @@ const char *signum_to_signame(int signum)
 	return NULL;
 }
 
-size_t get_numof_signames(void)
-{
-	return ARRAY_SIZE(ul_signames);
-}
-
 int get_signame_by_idx(size_t idx, const char **signame, int *signum)
 {
 	if (idx >= ARRAY_SIZE(ul_signames))
-- 
2.15.0

