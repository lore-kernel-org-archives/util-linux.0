Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:52470 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751997AbdF1QlB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Jun 2017 12:41:01 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MbaS9-1d9Paw3aWD-00J6qr for <util-linux@vger.kernel.org>; Wed, 28 Jun 2017
 18:41:00 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 7/8] setpriv: align --help
Date: Wed, 28 Jun 2017 18:40:56 +0200
Message-Id: <1498668057-8256-8-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498668057-8256-1-git-send-email-sweet_f_a@gmx.de>
References: <1498668057-8256-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This was forgotton during my last cleanup because the build was
auto-disabled on my system.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/setpriv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 41a865f..1e5c0b4 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -139,7 +139,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" --apparmor-profile <pr>     set AppArmor profile\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
-	print_usage_help_options(16);
+	print_usage_help_options(29);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_(" This tool can be dangerous.  Read the manpage, and be careful.\n"), out);
 	fprintf(out, USAGE_MAN_TAIL("setpriv(1)"));
-- 
1.8.5.6

