Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:45589 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099AbaHXQFe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 24 Aug 2014 12:05:34 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 7C36C140EA
	for <util-linux@vger.kernel.org>; Sun, 24 Aug 2014 18:05:02 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Aurelien Jarno <aurel32@debian.org>, LaMont Jones <lamont@debian.org>
Subject: [PATCH 2/4] remaining kFreeBSD hackery for building.
Date: Sun, 24 Aug 2014 18:04:42 +0200
Message-Id: <1408896284-14467-3-git-send-email-andreas@fatal.se>
In-Reply-To: <1408896284-14467-1-git-send-email-andreas@fatal.se>
References: <1408896284-14467-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Aurelien Jarno <aurel32@debian.org>

Addresses-Debian-Bug: #527384
Signed-off-by: LaMont Jones <lamont@debian.org>
---
 sys-utils/ipcs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 8ed5698..9ce5366 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -461,8 +461,10 @@ static void do_msg (char format, int unit)
 			return;
 		}
 		printf (_("------ Messages Status --------\n"));
+#ifndef __FreeBSD_kernel__
 		printf (_("allocated queues = %d\n"), msginfo.msgpool);
 		printf (_("used headers = %d\n"), msginfo.msgmap);
+#endif
 		ipc_print_size(unit, _("used space"), msginfo.msgtql,
 			       unit == IPC_UNIT_DEFAULT ? _(" bytes\n") : "\n", 0);
 		return;
-- 
2.1.0.rc1

