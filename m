Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:56594
	"EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbbHUOWO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 21 Aug 2015 10:22:14 -0400
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH 1/3] hwclock: fix signed/unsigned comparison warning on alpha
Date: Fri, 21 Aug 2015 16:13:27 +0200
Message-Id: <1440166409-32215-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fixes the following warning:
sys-utils/hwclock.c: In function 'manipulate_epoch':
sys-utils/hwclock.c:1465:17: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
   if (epoch_opt == -1)

Full build log available on:
https://buildd.debian.org/status/fetch.php?pkg=util-linux&arch=alpha&ver=2.26.2-9&stamp=1440078034

Detected by/via:
https://qa.debian.org/bls/packages/u/util-linux.html

Please note that this has never actually been (build-)tested on alpha,
but should hopefully resolve the warning. Note also that limits.h is
already included.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 sys-utils/hwclock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index f04cf2b..bdb98e2 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -137,7 +137,7 @@ int debug;
 bool badyear;
 
 /* User-specified epoch, used when rtc fails to return epoch. */
-unsigned long epoch_option = -1;
+unsigned long epoch_option = ULONG_MAX;
 
 /*
  * Almost all Award BIOS's made between 04/26/94 and 05/31/95 have a nasty
@@ -1452,7 +1452,7 @@ manipulate_epoch(const bool getepoch,
 			printf(_("Kernel is assuming an epoch value of %lu\n"),
 			       epoch);
 	} else if (setepoch) {
-		if (epoch_opt == -1)
+		if (epoch_opt == ULONG_MAX)
 			warnx(_
 			      ("To set the epoch value, you must use the 'epoch' "
 			       "option to tell to what value to set it."));
-- 
2.1.4

