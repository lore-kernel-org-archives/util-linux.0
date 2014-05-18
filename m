Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:62673 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbaEROG2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 May 2014 10:06:28 -0400
Received: by mail-wg0-f51.google.com with SMTP id x13so6869222wgg.22
        for <util-linux@vger.kernel.org>; Sun, 18 May 2014 07:06:27 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 16/17] setterm: mark some options to be exclusive with each other
Date: Sun, 18 May 2014 15:05:40 +0100
Message-Id: <1400421941-14244-17-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 10ca021..ba175f9 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -78,6 +78,7 @@
 #include "c.h"
 #include "closestream.h"
 #include "nls.h"
+#include "optutils.h"
 #include "strutils.h"
 #include "xalloc.h"
 
@@ -541,8 +542,16 @@ static void parse_option(struct setterm_control *ctl, int argc, char **argv)
 		{"help", no_argument, NULL, OPT_HELP},
 		{NULL, 0, NULL, 0}
 	};
+	static const ul_excl_t excl[] = {
+		{ OPT_DEFAULT, OPT_STORE },
+		{ OPT_TABS, OPT_CLRTABS, OPT_REGTABS },
+		{ OPT_MSG, OPT_MSGLEVEL },
+		{ 0 }
+	};
+	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
 
 	while ((c = getopt_long_only(argc, argv, "", longopts, NULL)) != -1) {
+		err_exclusive_options(c, longopts, excl, excl_st);
 		switch (c) {
 		case OPT_TERM:
 			ctl->opt_term = set_opt_flag(ctl->opt_term);
-- 
1.9.2

