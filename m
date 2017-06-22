Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:60564 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752098AbdFVChu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 22:37:50 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mcgur-1d640D0Dnl-00I033 for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 04:37:48 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 06/13] setarch: print usage error if no argument given
Date: Thu, 22 Jun 2017 04:37:39 +0200
Message-Id: <1498099066-24235-7-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
References: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This looks more likely as intended.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/setarch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index eb9cf21..6481eb2 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -301,7 +301,7 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	if (argc < 1)
+	if (argc < 2)
 		show_usage(_("Not enough arguments"));
 
 	archwrapper = strcmp(program_invocation_short_name, "setarch") != 0;
-- 
1.8.5.6

