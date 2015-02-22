Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:64194 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbBVOmA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:00 -0500
Received: by mail-wg0-f51.google.com with SMTP id y19so21178700wgg.10
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:41:59 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 04/16] prlimit: tell in --verbose output which pid got the new limit
Date: Sun, 22 Feb 2015 14:41:34 +0000
Message-Id: <1424616106-580-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/prlimit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index ddab76e..0fa5d57 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -360,7 +360,8 @@ static void do_prlimit(struct list_head *lims)
 			old = &lim->rlim;
 
 		if (verbose && new) {
-			printf(_("New %s limit: "), lim->desc->name);
+			printf(_("New %s limit for pid %d: "), lim->desc->name,
+				pid ? pid : getpid());
 			if (new->rlim_cur == RLIM_INFINITY)
 				printf("<%s", _("unlimited"));
 			else
-- 
2.3.0

