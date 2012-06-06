Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.8]:51680 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026Ab2FFOgc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Jun 2012 10:36:32 -0400
Message-ID: <4FCF6AEE.5040004@bernhard-voelker.de>
Date: Wed, 06 Jun 2012 16:36:30 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] setsid: fix off-by-one error in execvp call
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

E.g. run "ps -j" to see that the SID changed:
  setsid ps -j
The -j option is swallowed due to the +1.

Have a nice day,
Berny

>From 6a3baff2aa7ea3bf387d7805660f668737fe6854 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Wed, 6 Jun 2012 16:34:55 +0200
Subject: [PATCH] setsid: fix off-by-one error in execvp call

Bug introduced during --ctty implementation by v2.21-112-g8a2f04d.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 sys-utils/setsid.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/setsid.c b/sys-utils/setsid.c
index 52ad38f..071ccc4 100644
--- a/sys-utils/setsid.c
+++ b/sys-utils/setsid.c
@@ -93,6 +93,6 @@ int main(int argc, char **argv)
 		if (ioctl(STDIN_FILENO, TIOCSCTTY, 1))
 			warn(_("failed to set the controlling terminal"));
 	}
-	execvp(argv[optind], argv + optind + 1);
+	execvp(argv[optind], argv + optind);
 	err(EXIT_FAILURE, _("execvp failed"));
 }
-- 
1.7.7


