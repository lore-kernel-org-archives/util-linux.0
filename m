Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.186]:53820 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab1KNBsR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Nov 2011 20:48:17 -0500
Message-ID: <4EC0735F.1000602@bernhard-voelker.de>
Date: Mon, 14 Nov 2011 02:48:15 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 05/15] prlimit: fix diagnostic when setting a limit fails
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[PATCH 05/15] prlimit: fix diagnostic when setting a limit fails

As the prlimit() combines setting and getting the limit of a process,
prlimit must care about issueing the correct error message. This
fixes this wrong diagnostic:
$./prlimit --nofile=10000000
prlimit: failed to get resource limits of the current process: Operation 
not permitted

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
  sys-utils/prlimit.c |   15 +++++++++++----
  1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index 9a52b81..d668fba 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -324,10 +324,17 @@ static void do_prlimit(struct prlimit lims[], 
size_t n, int tt_flags)
  		}

  		if (prlimit(pid, lims[i].desc->resource, new, &lims[i].rlim) == -1) {
-			if (pid)
-				err(EXIT_FAILURE, _("failed to get resource limits for PID %d"), pid);
-			else
-				err(EXIT_FAILURE, _("failed to get resource limits of the current 
process"));
+			if (pid) {
+				if (lims[i].modify)
+					err(EXIT_FAILURE, _("failed to set resource limits for PID %d"), pid);
+				else
+					err(EXIT_FAILURE, _("failed to get resource limits for PID %d"), pid);
+			} else {
+				if (lims[i].modify)
+					err(EXIT_FAILURE, _("failed to set resource limits of the current 
process"));
+				else
+					err(EXIT_FAILURE, _("failed to get resource limits of the current 
process"));
+			}
  		}
  	}

