Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.8]:53582 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab1KNBsU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Nov 2011 20:48:20 -0500
Message-ID: <4EC07362.6000507@bernhard-voelker.de>
Date: Mon, 14 Nov 2011 02:48:18 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 06/15] prlimit: enhance diagnostic when changing a limit fails:
 add limit name
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[PATCH 06/15] prlimit: enhance diagnostic when changing a limit fails: 
add limit name

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
  sys-utils/prlimit.c |   12 ++++++++----
  1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index d668fba..611f3e8 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -326,14 +326,18 @@ static void do_prlimit(struct prlimit lims[], 
size_t n, int tt_flags)
  		if (prlimit(pid, lims[i].desc->resource, new, &lims[i].rlim) == -1) {
  			if (pid) {
  				if (lims[i].modify)
-					err(EXIT_FAILURE, _("failed to set resource limits for PID %d"), pid);
+					err(EXIT_FAILURE, _("failed to set the %s resource limit for PID %d"),
+						lims[i].desc->name, pid);
  				else
-					err(EXIT_FAILURE, _("failed to get resource limits for PID %d"), pid);
+					err(EXIT_FAILURE, _("failed to get the %s resource limit for PID %d"),
+						lims[i].desc->name, pid);
  			} else {
  				if (lims[i].modify)
-					err(EXIT_FAILURE, _("failed to set resource limits of the current 
process"));
+					err(EXIT_FAILURE, _("failed to set the %s resource limit of the 
current process"),
+						lims[i].desc->name);
  				else
-					err(EXIT_FAILURE, _("failed to get resource limits of the current 
process"));
+					err(EXIT_FAILURE, _("failed to get the %s resource limit of the 
current process"),
+						lims[i].desc->name);
  			}
  		}
  	}
