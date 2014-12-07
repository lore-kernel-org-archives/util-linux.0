Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f53.google.com ([74.125.82.53]:54929 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbaLGKOO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Dec 2014 05:14:14 -0500
Received: by mail-wg0-f53.google.com with SMTP id l18so4082839wgh.40
        for <util-linux@vger.kernel.org>; Sun, 07 Dec 2014 02:14:13 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>,
        Frodo Looijaard <frodo@frodo.looijaard.name>
Subject: [PATCH 11/11] getopt: avoid re-terminating long_option list at every update
Date: Sun,  7 Dec 2014 10:13:55 +0000
Message-Id: <1417947235-24229-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
References: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Terminating the ctl->long_options list once when adding options is
completed is enough.  This also allows moving ctl->long_options_nr
increment to more appropriate location.

CC: Frodo Looijaard <frodo@frodo.looijaard.name>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/getopt.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index 2940a7d..c484ee6 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -248,20 +248,13 @@ static void add_longopt(struct getopt_control *ctl, const char *name, int has_ar
 					     sizeof(struct option) *
 					     ctl->long_options_length);
 	}
-
-	ctl->long_options[ctl->long_options_nr].name = NULL;
-	ctl->long_options[ctl->long_options_nr].has_arg = 0;
-	ctl->long_options[ctl->long_options_nr].flag = NULL;
-	ctl->long_options[ctl->long_options_nr].val = 0;
-
 	if (name) {
 		/* Not for init! */
-		ctl->long_options[ctl->long_options_nr - 1].has_arg = has_arg;
-		ctl->long_options[ctl->long_options_nr - 1].flag = &flag;
-		ctl->long_options[ctl->long_options_nr - 1].val = ctl->long_options_nr;
-		ctl->long_options[ctl->long_options_nr - 1].name = xstrdup(name);
+		ctl->long_options[ctl->long_options_nr].has_arg = has_arg;
+		ctl->long_options[ctl->long_options_nr].flag = &flag;
+		ctl->long_options[ctl->long_options_nr].val = ctl->long_options_nr;
+		ctl->long_options[ctl->long_options_nr].name = xstrdup(name);
 	}
-	ctl->long_options_nr++;
 }
 
 
@@ -290,9 +283,14 @@ static void add_long_options(struct getopt_control *ctl, char *options)
 						     "-l or --long argument"));
 			}
 			add_longopt(ctl, tokptr, arg_opt);
+			ctl->long_options_nr++;
 		}
 		tokptr = strtok(NULL, ", \t\n");
 	}
+	ctl->long_options[ctl->long_options_nr].name = NULL;
+	ctl->long_options[ctl->long_options_nr].has_arg = 0;
+	ctl->long_options[ctl->long_options_nr].flag = NULL;
+	ctl->long_options[ctl->long_options_nr].val = 0;
 }
 
 static shell_t shell_type(const char *new_shell)
-- 
2.1.3

