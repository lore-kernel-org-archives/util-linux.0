Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:50290 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763496AbdKRVUQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 18 Nov 2017 16:20:16 -0500
Subject: [PATCH 1/2] hwclock: use reentrant time conversion functions
To: Karel Zak <kzak@redhat.com>
References: <d91b971a-29f1-3403-342b-2b837c2abcb7@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <a4a83c57-7125-d9d3-fc28-5aeb3bc99d4f@gmx.com>
Date: Sat, 18 Nov 2017 16:20:14 -0500
MIME-Version: 1.0
In-Reply-To: <d91b971a-29f1-3403-342b-2b837c2abcb7@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index c93a5fd65..8ff33474e 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -375,9 +375,9 @@ set_hardware_clock(const struct hwclock_control *ctl, const time_t newtime)
 	 */
 
 	if (ctl->universal)
-		new_broken_time = *gmtime(&newtime);
+		gmtime_r(&newtime, &new_broken_time);
 	else
-		new_broken_time = *localtime(&newtime);
+		localtime_r(&newtime, &new_broken_time);
 
 	if (ctl->debug)
 		printf(_("Setting Hardware Clock to %.2d:%.2d:%.2d "
@@ -600,13 +600,13 @@ static int
 set_system_clock(const struct hwclock_control *ctl,
 		 const struct timeval newtime)
 {
-	struct tm *broken;
+	struct tm broken;
 	int minuteswest;
 	int rc = 0;
 	const struct timezone tz_utc = { 0 };
 
-	broken = localtime(&newtime.tv_sec);
-	minuteswest = -get_gmtoff(broken) / 60;
+	localtime_r(&newtime.tv_sec, &broken);
+	minuteswest = -get_gmtoff(&broken) / 60;
 
 	if (ctl->debug) {
 		if (ctl->hctosys && !ctl->universal)
