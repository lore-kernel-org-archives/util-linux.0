Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:63600 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752087AbdFVCht (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 22:37:49 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MaE4a-1d48Bv3P8C-00JvzI for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 04:37:47 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 05/13] dmesg: do not accept any non-option arguments
Date: Thu, 22 Jun 2017 04:37:38 +0200
Message-Id: <1498099066-24235-6-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
References: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

'dmesg foo' is no valid syntax and gives an error now.
BTW we avoid the "dead increment of argc and argv.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/dmesg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index b83cfb1..5be4ff6 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -1486,10 +1486,8 @@ int main(int argc, char *argv[])
 			errtryhelp(EXIT_FAILURE);
 		}
 	}
-	argc -= optind;
-	argv += optind;
 
-	if (argc > 1)
+	if (argc != optind)
 		usage(stderr);
 
 	if ((is_timefmt(&ctl, RELTIME) ||
-- 
1.8.5.6

