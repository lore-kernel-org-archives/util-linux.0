Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:58133 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab3DMTzl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:41 -0400
Received: by mail-wg0-f46.google.com with SMTP id e11so1402536wgh.1
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:40 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/33] setpriv: check writing to a file was successful
Date: Sat, 13 Apr 2013 20:54:39 +0100
Message-Id: <1365882901-11429-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/setpriv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 7fa5f82..18810c5 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -541,8 +541,9 @@ static void do_apparmor_profile(const char *label)
 		err(SETPRIV_EXIT_PRIVERR,
 		    _("cannot open %s"), _PATH_PROC_ATTR_EXEC);
 
-	if (fprintf(f, "changeprofile %s", label) < 0 || fflush(f) != 0
-	    || fclose(f) != 0)
+	fprintf(f, "changeprofile %s", label);
+
+	if (close_stream(f) != 0)
 		err(SETPRIV_EXIT_PRIVERR,
 		    _("write failed: %s"), _PATH_PROC_ATTR_EXEC);
 }
-- 
1.8.2.1

