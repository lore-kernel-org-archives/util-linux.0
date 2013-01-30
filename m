Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:47429 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755407Ab3A3Udg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 30 Jan 2013 15:33:36 -0500
Received: by mail-wi0-f171.google.com with SMTP id hn14so4093542wib.16
        for <util-linux@vger.kernel.org>; Wed, 30 Jan 2013 12:33:34 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/3] eject: remove a duplicate command name from error message
Date: Wed, 30 Jan 2013 20:33:25 +0000
Message-Id: <1359578005-13427-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1359578005-13427-1-git-send-email-kerolasa@iki.fi>
References: <1359578005-13427-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Let the err() print the command name.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/eject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index e288371..a5b5656 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -655,7 +655,7 @@ static void umount_one(const char *name)
 			err(EXIT_FAILURE, _("cannot set group id"));
 
 		if (setuid(getuid()) < 0)
-			err(EXIT_FAILURE, _("eject: cannot set user id"));
+			err(EXIT_FAILURE, _("cannot set user id"));
 
 		if (p_option)
 			execl("/bin/umount", "/bin/umount", name, "-n", NULL);
-- 
1.8.1.2

