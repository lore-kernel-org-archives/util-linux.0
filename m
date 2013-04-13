Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:42557 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab3DMT4e (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:56:34 -0400
Received: by mail-wg0-f50.google.com with SMTP id k13so3668717wgh.29
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:56:33 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 31/33] setpriv: check writing to a file descriptor was successful
Date: Sat, 13 Apr 2013 20:54:59 +0100
Message-Id: <1365882901-11429-32-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/setpriv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 18810c5..4a44106 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -526,7 +526,9 @@ static void do_selinux_label(const char *label)
 		err(SETPRIV_EXIT_PRIVERR,
 		    _("write failed: %s"), _PATH_PROC_ATTR_EXEC);
 
-	close(fd);
+	if (close_fd(fd) != 0)
+		err(SETPRIV_EXIT_PRIVERR,
+		    _("write failed: %s"), _PATH_PROC_ATTR_EXEC);
 }
 
 static void do_apparmor_profile(const char *label)
-- 
1.8.2.1

