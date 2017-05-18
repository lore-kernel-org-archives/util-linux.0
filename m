Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33031 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756046AbdERVTz (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 18 May 2017 17:19:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id y10so14089957wmh.0
        for <util-linux@vger.kernel.org>; Thu, 18 May 2017 14:19:55 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/3] chfn: disable tab completion
Date: Thu, 18 May 2017 22:19:35 +0100
Message-Id: <20170518211936.28153-3-kerolasa@iki.fi>
In-Reply-To: <20170518211936.28153-1-kerolasa@iki.fi>
References: <20170518211936.28153-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The default readline tab completion that offers file listing from current
directory does not make any sense in this context.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chfn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index d79a192cf..3a951a193 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -237,6 +237,7 @@ static char *ask_new_field(struct chfn_control *ctl, const char *question,
 		printf("%s [%s]: ", question, def_val);
 		__fpurge(stdin);
 #ifdef HAVE_LIBREADLINE
+		rl_bind_key('\t', rl_insert);
 		if ((buf = readline(NULL)) == NULL)
 #else
 		if (getline(&buf, &dummy, stdin) < 0)
-- 
2.13.0

