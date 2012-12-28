Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:56274 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192Ab2L1Vaj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 28 Dec 2012 16:30:39 -0500
Received: by mail-wg0-f42.google.com with SMTP id dr1so4380491wgb.3
        for <util-linux@vger.kernel.org>; Fri, 28 Dec 2012 13:30:38 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/4] ipcs: fix spacing in summary output
Date: Fri, 28 Dec 2012 21:23:41 +0000
Message-Id: <1356729823-729-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1356729823-729-1-git-send-email-kerolasa@iki.fi>
References: <1356729823-729-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Change 56692a6 introduced spacing error to --summary printing.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 4422162..1e1b022 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -465,7 +465,7 @@ static void do_msg (char format, int unit)
 		printf (_("------ Messages Status --------\n"));
 		printf (_("allocated queues = %d\n"), msginfo.msgpool);
 		printf (_("used headers = %d\n"), msginfo.msgmap);
-		ipc_print_size(unit, _("used space ="), msginfo.msgtql,
+		ipc_print_size(unit, _("used space"), msginfo.msgtql,
 			       unit == IPC_UNIT_DEFAULT ? _(" bytes\n") : "\n", 0);
 		return;
 	}
-- 
1.8.0.3

