Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62060 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757512Ab2CETjU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 14:39:20 -0500
Received: by mail-ey0-f174.google.com with SMTP id q12so1565217eaa.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 11:39:20 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/17] chfn: use pathnames.h for paths
Date: Mon,  5 Mar 2012 20:38:44 +0100
Message-Id: <1330976334-10751-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
References: <20120305123847.GD486@x2.net.home>
 <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chfn.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 21c6466..2d9a092 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -142,9 +142,9 @@ int main(int argc, char **argv)
 				     oldf.username);
 			}
 		}
-		if (setupDefaultContext("/etc/passwd"))
+		if (setupDefaultContext(_PATH_PASSWD))
 			errx(EXIT_FAILURE,
-			     _("can't set default context for /etc/passwd"));
+			     _("can't set default context for %s"), _PATH_PASSWD);
 	}
 #endif
 
-- 
1.7.9.2

