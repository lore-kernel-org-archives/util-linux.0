Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:56029 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751216AbdGPRxu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 16 Jul 2017 13:53:50 -0400
Subject: [PATCH 4/4] hwclock: improve RTC epoch messages
To: Karel Zak <kzak@redhat.com>
References: <4a0f9283-7a08-a2c3-acc3-fb35ab51ec59@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <660825e1-8887-731b-e8b0-29fa2b92cd5c@gmx.com>
Date: Sun, 16 Jul 2017 13:53:34 -0400
MIME-Version: 1.0
In-Reply-To: <4a0f9283-7a08-a2c3-acc3-fb35ab51ec59@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 445d736..423ebcd 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1172,23 +1172,17 @@ manipulate_epoch(const struct hwclock_control *ctl)
 		unsigned long epoch;
 
 		if (get_epoch_rtc(ctl, &epoch))
-			warnx(_
-			      ("Unable to get the epoch value from the kernel."));
+			warnx(_("unable to read the RTC epoch."));
 		else
-			printf(_("Kernel is assuming an epoch value of %lu\n"),
-			       epoch);
+			printf(_("The RTC epoch is set to %lu.\n"), epoch);
 	} else if (ctl->setepoch) {
 		if (!ctl->epoch_option)
-			warnx(_
-			      ("To set the epoch value, you must use the 'epoch' "
-			       "option to tell to what value to set it."));
+			warnx(_("--epoch is required for --setepoch."));
 		else if (ctl->testing)
-			printf(_
-			       ("Not setting the epoch to %s - testing only.\n"),
+			printf(_("Test mode: epoch was not set to %s.\n"),
 			       ctl->epoch_option);
 		else if (set_epoch_rtc(ctl))
-			printf(_
-			       ("Unable to set the epoch value in the kernel.\n"));
+			warnx(_("unable to set the RTC epoch."));
 	}
 }
 #endif		/* __linux__ __alpha__ */
