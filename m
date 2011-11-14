Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:55724 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755090Ab1KNBs6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Nov 2011 20:48:58 -0500
Message-ID: <4EC07388.6030400@bernhard-voelker.de>
Date: Mon, 14 Nov 2011 02:48:56 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 15/15] prlimit: fix displaying of modified limits
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[PATCH 15/15] prlimit: fix displaying of modified limits

When a limit is to be modified and shown, e.g. in
   $ prlimit -p$$  -n1000 -n
then the prlimit syscall has overwritten lims[i].rlim with the old value.
For such cases, copy the new values afterwards again.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
  sys-utils/prlimit.c |   14 +++++++++++++-
  1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index 69440a5..bfe8005 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -333,6 +333,7 @@ static void do_prlimit(struct prlimit lims[], int 
tt_flags)

  	for (i = 0; i < MAX_RESOURCES; i++) {
  		struct rlimit *new = NULL;
+		struct rlimit new_rlim;

  		if (lims[i].modify) {
  			if (!pid)
@@ -348,7 +349,9 @@ static void do_prlimit(struct prlimit lims[], int 
tt_flags)
  				 lims[i].rlim.rlim_max != RLIM_INFINITY))
  				errx(EXIT_FAILURE, _("the soft limit cannot exceed the ceiling 
value"));

-			new = &lims[i].rlim;
+			new_rlim.rlim_cur = lims[i].rlim.rlim_cur;
+			new_rlim.rlim_max = lims[i].rlim.rlim_max;
+			new = &new_rlim;
  		} else if (!(lims[i].show)) {
  			continue;
  		}
@@ -383,6 +386,15 @@ static void do_prlimit(struct prlimit lims[], int 
tt_flags)
  						lims[i].desc->name);
  			}
  		}
+		if (lims[i].modify && new) {
+			/*
+			 * prlimit has overwritten lims[i].rlim with the old value.
+			 * In the case we have to display the new value, we have to
+			 * copy it from new_rlim again.
+			 */
+			 lims[i].rlim.rlim_cur = new_rlim.rlim_cur;
+			 lims[i].rlim.rlim_max = new_rlim.rlim_max;
+		}			
  	}
  }

