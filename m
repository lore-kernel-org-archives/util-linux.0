Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f173.google.com ([209.85.192.173]:51812 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbaEAFKS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 1 May 2014 01:10:18 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so2693853pdj.32
        for <util-linux@vger.kernel.org>; Wed, 30 Apr 2014 22:10:17 -0700 (PDT)
From: Andy Lutomirski <luto@amacapital.net>
To: util-linux@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH] setpriv: Fix --selinux-label
Date: Wed, 30 Apr 2014 22:10:13 -0700
Message-Id: <a14933a93032e16adfce8ba1fe8b5b8aead3d838.1398920968.git.luto@amacapital.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This commit:

    commit 05cef8eafbf169a8da1d2831f5ed3d5b1b81aaad
    Author: Sami Kerola <kerolasa@iki.fi>
    Date:   Sat Apr 13 20:54:59 2013 +0100

        setpriv: check writing to a file descriptor was successful

broke --selinux-label.  It checks whether fsyncing /proc/self/attr/exec
succeeds, and it doesn't, because fsync isn't supported on that file.

I have stealthily improved the error message as part of this fix.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 sys-utils/setpriv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 7bea626..65921be 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -526,9 +526,9 @@ static void do_selinux_label(const char *label)
 		err(SETPRIV_EXIT_PRIVERR,
 		    _("write failed: %s"), _PATH_PROC_ATTR_EXEC);
 
-	if (close_fd(fd) != 0)
+	if (close(fd) != 0)
 		err(SETPRIV_EXIT_PRIVERR,
-		    _("write failed: %s"), _PATH_PROC_ATTR_EXEC);
+		    _("close failed: %s"), _PATH_PROC_ATTR_EXEC);
 }
 
 static void do_apparmor_profile(const char *label)
-- 
1.9.0

