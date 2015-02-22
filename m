Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f182.google.com ([209.85.212.182]:55314 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbbBVOmG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:06 -0500
Received: by mail-wi0-f182.google.com with SMTP id l15so11674991wiw.3
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:05 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 09/16] eject: use parse_switch()
Date: Sun, 22 Feb 2015 14:41:39 +0000
Message-Id: <1424616106-580-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/eject.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 4f7d6e6..4e1d65f 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -202,12 +202,7 @@ static void parse_args(struct eject_control *ctl, int argc, char **argv)
 		switch (c) {
 		case 'a':
 			ctl->a_option = 1;
-			if (!strcmp(optarg, "0") || !strcmp(optarg, "off"))
-				ctl->a_arg = 0;
-			else if (!strcmp(optarg, "1") || !strcmp(optarg, "on"))
-				ctl->a_arg = 1;
-			else
-				errx(EXIT_FAILURE, _("invalid argument to --auto/-a option"));
+			ctl->a_arg = parse_switch(optarg, "on", "off");
 			break;
 		case 'c':
 			ctl->c_option = 1;
@@ -231,12 +226,7 @@ static void parse_args(struct eject_control *ctl, int argc, char **argv)
 			break;
 		case 'i':
 			ctl->i_option = 1;
-			if (!strcmp(optarg, "0") || !strcmp(optarg, "off"))
-				ctl->i_arg = 0;
-			else if (!strcmp(optarg, "1") || !strcmp(optarg, "on"))
-				ctl->i_arg = 1;
-			else
-				errx(EXIT_FAILURE, _("invalid argument to --manualeject/-i option"));
+			ctl->i_arg = parse_switch(optarg, "on", "off");
 			break;
 		case 'm':
 			ctl->m_option = 1;
-- 
2.3.0

