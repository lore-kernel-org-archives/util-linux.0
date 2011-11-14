Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:64108 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab1KNBsJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Nov 2011 20:48:09 -0500
Message-ID: <4EC07357.1030002@bernhard-voelker.de>
Date: Mon, 14 Nov 2011 02:48:07 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 03/15] prlimit: fix diagnostic when setting current PIDs resources
 fails
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[PATCH 03/15] prlimit: fix diagnostic when setting current PIDs 
resources fails

Avoids wrong message:
$ prlimit --nofile=16000
prlimit: failed to get resource limits for PID 0: Operation not permitted

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
  sys-utils/prlimit.c |    8 ++++++--
  1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index 525351a..6943d11 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -320,8 +320,12 @@ static void do_prlimit(struct prlimit lims[], 
size_t n, int tt_flags)
  				printf(":%ju>\n", new->rlim_max);
  		}

-		if (prlimit(pid, lims[i].desc->resource, new, &lims[i].rlim) == -1)
-			err(EXIT_FAILURE, _("failed to get resource limits for PID %d"), pid);
+		if (prlimit(pid, lims[i].desc->resource, new, &lims[i].rlim) == -1) {
+			if (pid)
+				err(EXIT_FAILURE, _("failed to get resource limits for PID %d"), pid);
+			else
+				err(EXIT_FAILURE, _("failed to get resource limits of the current 
process"));
+		}
  	}

  	if (nshows)
