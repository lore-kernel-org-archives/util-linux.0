Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:50282 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbaKBU10 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Nov 2014 15:27:26 -0500
Received: by mail-wi0-f179.google.com with SMTP id h11so4888922wiw.12
        for <util-linux@vger.kernel.org>; Sun, 02 Nov 2014 12:27:25 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 7/8] mkswap: set variable only when it's value is known
Date: Sun,  2 Nov 2014 20:26:30 +0000
Message-Id: <1414959991-8369-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
References: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Avoid updating ctl->pagesize twice when user does specify page size.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkswap.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index 7f60013..280d890 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -90,23 +90,21 @@ struct mkswap_control {
 static void
 init_signature_page(struct mkswap_control *ctl)
 {
-
-	int kernel_pagesize = ctl->pagesize = getpagesize();
+	const int kernel_pagesize = getpagesize();
 
 	if (ctl->user_pagesize) {
 		if (ctl->user_pagesize < 0 || !is_power_of_2(ctl->user_pagesize) ||
 		    (size_t) ctl->user_pagesize < sizeof(struct swap_header_v1_2) + 10)
 			errx(EXIT_FAILURE,
-				_("Bad user-specified page size %u"),
-				ctl->user_pagesize);
-		ctl->pagesize = ctl->user_pagesize;
-	}
-
-	if (ctl->user_pagesize && ctl->user_pagesize != kernel_pagesize)
-		warnx(_("Using user-specified page size %d, "
+			     _("Bad user-specified page size %u"),
+			       ctl->user_pagesize);
+		if (ctl->user_pagesize != kernel_pagesize)
+			warnx(_("Using user-specified page size %d, "
 				"instead of the system value %d"),
 				ctl->pagesize, kernel_pagesize);
-
+		ctl->pagesize = ctl->user_pagesize;
+	} else
+		ctl->pagesize = kernel_pagesize;
 	ctl->signature_page = (unsigned long *) xcalloc(1, ctl->pagesize);
 }
 
-- 
2.1.3

