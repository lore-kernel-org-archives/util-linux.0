Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62666 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab3ATSFP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 20 Jan 2013 13:05:15 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr12so3194166wgb.11
        for <util-linux@vger.kernel.org>; Sun, 20 Jan 2013 10:05:13 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 5/6] nsenter: drop core when impossible happens
Date: Sun, 20 Jan 2013 18:04:55 +0000
Message-Id: <1358705096-21092-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358705096-21092-1-git-send-email-kerolasa@iki.fi>
References: <1358705096-21092-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Message to user is less informative, but impossible events should be
rare so core files are much appriciated for these cases.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/nsenter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index b83f457..0e1c8f4 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -26,6 +26,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <assert.h>
 
 #include "strutils.h"
 #include "nls.h"
@@ -117,7 +118,7 @@ static void open_namespace_fd(int nstype, const char *path)
 		return;
 	}
 	/* This should never happen */
-	err(EXIT_FAILURE, "Unrecognized namespace type");
+	assert(nsfile->nstype);
 }
 
 static void continue_as_child(void)
-- 
1.8.1.1

