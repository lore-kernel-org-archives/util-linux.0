Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64375 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbbBVOmD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:03 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so11683266wid.5
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:02 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 06/16] tunelp: remove unnecessary preprocessor directives
Date: Sun, 22 Feb 2015 14:41:36 +0000
Message-Id: <1424616106-580-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The lp.h included earlier in the tunelp.c has the definitions that were
checked, so these statements could have not been false and such
impossible conditions does not need to be checked.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/tunelp.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sys-utils/tunelp.c b/sys-utils/tunelp.c
index 197b093..8c70268 100644
--- a/sys-utils/tunelp.c
+++ b/sys-utils/tunelp.c
@@ -205,7 +205,6 @@ int main(int argc, char **argv)
 				show_irq = 0;
 			}
 			break;
-#ifdef LPGETSTATUS
 		case 'o':
 			cmds->op = LPABORTOPEN;
 			cmds->val = get_onoff(optarg);
@@ -228,8 +227,6 @@ int main(int argc, char **argv)
 			cmds = cmds->next;
 			cmds->next = 0;
 			break;
-#endif
-#ifdef LPRESET
 		case 'r':
 			cmds->op = LPRESET;
 			cmds->val = 0;
@@ -237,8 +234,6 @@ int main(int argc, char **argv)
 			cmds = cmds->next;
 			cmds->next = 0;
 			break;
-#endif
-#ifdef LPTRUSTIRQ
 		case 'T':
 			/* Note: this will do the wrong thing on
 			 * 2.0.36 when compiled under 2.2.x
@@ -249,7 +244,6 @@ int main(int argc, char **argv)
 			cmds = cmds->next;
 			cmds->next = 0;
 			break;
-#endif
 		case 'v':
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
@@ -290,7 +284,6 @@ int main(int argc, char **argv)
 
 	cmds = cmdst;
 	while (cmds->next) {
-#ifdef LPGETSTATUS
 		if (cmds->op == LPGETSTATUS) {
 			status = 0xdeadbeef;
 			retval = ioctl(fd, LPGETSTATUS - offset, &status);
@@ -314,7 +307,6 @@ int main(int argc, char **argv)
 				printf("\n");
 			}
 		} else
-#endif /* LPGETSTATUS */
 		if (ioctl(fd, cmds->op - offset, cmds->val) < 0)
 			warn(_("ioctl failed"));
 		cmdst = cmds;
-- 
2.3.0

