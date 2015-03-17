Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:52281 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932151AbbCQQY6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Mar 2015 12:24:58 -0400
Message-ID: <55085554.5040409@gmx.com>
Date: Tue, 17 Mar 2015 12:24:52 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 1/2] hwclock: increase debug output precision
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Increased the precision in debug output showing
the clock drift and the time lapsed.

Showing a clock drift of 0.0 while giving a value that the
drift factor was adjusted by makes no sense.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 52a7874..e8732b8 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1062,8 +1062,8 @@ adjust_drift_factor(struct adjtime *adjtime_p,
 			drift_factor = 0;
 		} else {
 			if (debug)
-				printf(_("Clock drifted %.1f seconds in the past "
-					 "%.1f seconds\nin spite of a drift factor of "
+				printf(_("Clock drifted %f seconds in the past "
+					 "%f seconds\nin spite of a drift factor of "
 					 "%f seconds/day.\n"
 					 "Adjusting drift factor by %f seconds/day\n"),
 				       time_diff(nowtime, hclocktime),
