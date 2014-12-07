Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:47586 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbaLGKOK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Dec 2014 05:14:10 -0500
Received: by mail-wg0-f42.google.com with SMTP id z12so4099396wgg.1
        for <util-linux@vger.kernel.org>; Sun, 07 Dec 2014 02:14:09 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>,
        Frodo Looijaard <frodo@frodo.looijaard.name>
Subject: [PATCH 08/11] getopt: remove unnecessary code
Date: Sun,  7 Dec 2014 10:13:52 +0000
Message-Id: <1417947235-24229-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
References: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The control structure is initialized in main().

CC: Frodo Looijaard <frodo@frodo.looijaard.name>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/getopt.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index 696e87a..67603b5 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -232,14 +232,6 @@ static void add_longopt(struct getopt_control *ctl, const char *name, int has_ar
 {
 	static int flag;
 
-	if (!name) {
-		/* init */
-		free(ctl->long_options);
-		ctl->long_options = NULL;
-		ctl->long_options_length = 0;
-		ctl->long_options_nr = 0;
-	}
-
 	if (ctl->long_options_nr == ctl->long_options_length) {
 		ctl->long_options_length += REALLOC_INCREMENT;
 		ctl->long_options = xrealloc(ctl->long_options,
@@ -252,7 +244,7 @@ static void add_longopt(struct getopt_control *ctl, const char *name, int has_ar
 	ctl->long_options[ctl->long_options_nr].flag = NULL;
 	ctl->long_options[ctl->long_options_nr].val = 0;
 
-	if (ctl->long_options_nr && name) {
+	if (name) {
 		/* Not for init! */
 		ctl->long_options[ctl->long_options_nr - 1].has_arg = has_arg;
 		ctl->long_options[ctl->long_options_nr - 1].flag = &flag;
-- 
2.1.3

