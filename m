Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33614 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdEPI0B (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 16 May 2017 04:26:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id y10so36097712wmh.0
        for <util-linux@vger.kernel.org>; Tue, 16 May 2017 01:26:00 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] sulogin: remove duplicate const declaration
Date: Tue, 16 May 2017 09:25:57 +0100
Message-Id: <20170516082557.18918-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

login-utils/su-common.c:619:14: warning: duplicate 'const' declaration
specifier [-Wduplicate-decl-specifier]
   const char const **args = xcalloc (n_args, sizeof *args);

Regression-from: 71f207a5f598623a539ba825b97a503072c4a1b4
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/su-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index 32f3641ba..0999795c8 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -616,7 +616,7 @@ run_shell (char const * const shell, char const * const command, char ** const a
 	   const size_t n_additional_args)
 {
   const size_t n_args = 1 + fast_startup + 2 * !!command + n_additional_args + 1;
-  const char const **args = xcalloc (n_args, sizeof *args);
+  const char **args = xcalloc (n_args, sizeof *args);
   size_t argno = 1;
 
   if (simulate_login)
-- 
2.13.0

