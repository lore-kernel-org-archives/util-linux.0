Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62060 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757512Ab2CETjP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 14:39:15 -0500
Received: by mail-ey0-f174.google.com with SMTP id q12so1565217eaa.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 11:39:15 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/17] vipw: use rpmatch to yes/no question
Date: Mon,  5 Mar 2012 20:38:42 +0100
Message-Id: <1330976334-10751-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
References: <20120305123847.GD486@x2.net.home>
 <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/vipw.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index c0ed0b3..992a3a3 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -347,11 +347,12 @@ int main(int argc, char *argv[])
 		printf((program == VIGR)
 		       ? _("You are using shadow groups on this system.\n")
 		       : _("You are using shadow passwords on this system.\n"));
+		/* TRANSLATORS: this program uses for y and n rpmatch(3),
+		 * which means they can be translated. */
 		printf(_("Would you like to edit %s now [y/n]? "), orig_file);
 
-		/* EOF means no */
 		if (fgets(response, sizeof(response), stdin)) {
-			if (response[0] == 'y' || response[0] == 'Y')
+			if (rpmatch(response) == 1)
 				edit_file(1);
 		}
 	}
-- 
1.7.9.2

