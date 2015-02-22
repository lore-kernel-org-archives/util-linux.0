Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f176.google.com ([74.125.82.176]:35089 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbbBVOmF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:05 -0500
Received: by wevl61 with SMTP id l61so9455186wev.2
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:04 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 08/16] tunelp: use parse_switch()
Date: Sun, 22 Feb 2015 14:41:38 +0000
Message-Id: <1424616106-580-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/tunelp.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/sys-utils/tunelp.c b/sys-utils/tunelp.c
index 8c70268..65c397a 100644
--- a/sys-utils/tunelp.c
+++ b/sys-utils/tunelp.c
@@ -116,13 +116,6 @@ static void __attribute__((__noreturn__)) print_usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-static long get_onoff(char *val)
-{
-	if (!strncasecmp("on", val, 2))
-		return 1;
-	return 0;
-}
-
 int main(int argc, char **argv)
 {
 	int c, fd, irq, status, show_irq, offset = 0, retval;
@@ -193,28 +186,24 @@ int main(int argc, char **argv)
 			break;
 		case 'a':
 			cmds->op = LPABORT;
-			cmds->val = get_onoff(optarg);
+			cmds->val = parse_switch(optarg, "on", "off");
 			cmds->next = xmalloc(sizeof(struct command));
 			cmds = cmds->next;
 			cmds->next = 0;
 			break;
 		case 'q':
-			if (get_onoff(optarg)) {
-				show_irq = 1;
-			} else {
-				show_irq = 0;
-			}
+			show_irq = parse_switch(optarg, "on", "off");
 			break;
 		case 'o':
 			cmds->op = LPABORTOPEN;
-			cmds->val = get_onoff(optarg);
+			cmds->val = parse_switch(optarg, "on", "off");
 			cmds->next = xmalloc(sizeof(struct command));
 			cmds = cmds->next;
 			cmds->next = 0;
 			break;
 		case 'C':
 			cmds->op = LPCAREFUL;
-			cmds->val = get_onoff(optarg);
+			cmds->val = parse_switch(optarg, "on", "off");
 			cmds->next = xmalloc(sizeof(struct command));
 			cmds = cmds->next;
 			cmds->next = 0;
@@ -239,7 +228,7 @@ int main(int argc, char **argv)
 			 * 2.0.36 when compiled under 2.2.x
 			 */
 			cmds->op = LPTRUSTIRQ;
-			cmds->val = get_onoff(optarg);
+			cmds->val = parse_switch(optarg, "on", "off");
 			cmds->next = xmalloc(sizeof(struct command));
 			cmds = cmds->next;
 			cmds->next = 0;
-- 
2.3.0

