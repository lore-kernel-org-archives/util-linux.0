Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33615 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbcDPSeY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Apr 2016 14:34:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id y144so13930522wmd.0
        for <util-linux@vger.kernel.org>; Sat, 16 Apr 2016 11:34:18 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 7/7] mount: try to tell what mount was doing when it failed
Date: Sat, 16 Apr 2016 19:34:09 +0100
Message-Id: <1460831649-11484-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1460831649-11484-1-git-send-email-kerolasa@iki.fi>
References: <1460831649-11484-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier output did not give enough information to system admin to fix an
issue in /etc/fstab effectively.

$ sudo mount -a
mount: mount(2) failed: No such file or directory

Addresses: https://bugs.launchpad.net/bugs/1557145
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/mount.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 9c4729e..64ec0a7 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -520,7 +520,12 @@ try_readonly:
 			warnx(_("special device %s does not exist"), src);
 		} else {
 			errno = syserr;
-			warn(_("mount(2) failed"));	/* print errno */
+			if (tgt)
+				warn("%s: %s", _("mount(2) failed"), tgt);
+			else if (src)
+				warn("%s: %s", _("mount(2) failed"), src);
+			else
+				warn(_("mount(2) failed"));
 		}
 		break;
 
@@ -535,7 +540,7 @@ try_readonly:
 				 "(a path prefix is not a directory)"), src);
 		} else {
 			errno = syserr;
-			warn(_("mount(2) failed"));     /* print errno */
+			warn("%s: %s", _("mount(2) failed"), tgt);
 		}
 		break;
 
-- 
2.8.0

