Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.187]:51341 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab1KNBsN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Nov 2011 20:48:13 -0500
Message-ID: <4EC0735B.2010504@bernhard-voelker.de>
Date: Mon, 14 Nov 2011 02:48:11 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 04/15] prlimit: add warning diagnostic when attempting to
 change prlimit's limits
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[PATCH 04/15] prlimit: add warning diagnostic when attempting to change 
prlimit's limits

Setting the limits of the prlimit process is useless because it will
exit shortly anyway. To help the user not to fall into this trap,
prlimit now displays a warning.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
  sys-utils/prlimit.c |    7 +++++--
  1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index 6943d11..9a52b81 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -302,10 +302,13 @@ static void do_prlimit(struct prlimit lims[], 
size_t n, int tt_flags)
  	for (i = 0; i < n; i++) {
  		struct rlimit *new = NULL;

-		if (lims[i].modify)
+		if (lims[i].modify) {
+			if (!pid)
+				warnx(_("setting limits of the prlimit process is pointless"));
  			new = &lims[i].rlim;
-		else
+		} else {
  			nshows++;
+		}

  		if (verbose && new) {
  			printf(_("New %s limit: "), lims[i].desc->name);
