Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:62143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751090AbdHSAVD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 18 Aug 2017 20:21:03 -0400
Subject: [PATCH 3/6] hwclock: update set_system_clock debugging
To: Karel Zak <kzak@redhat.com>
References: <7059c516-6d5f-0579-81be-60b4519f0ce7@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <44227f4c-9c7b-eaf0-7901-e9eed54993ca@gmx.com>
Date: Fri, 18 Aug 2017 20:20:57 -0400
MIME-Version: 1.0
In-Reply-To: <7059c516-6d5f-0579-81be-60b4519f0ce7@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Update debug messages for a combined --systz and --hctosys in
the set_system_clock function.

New debug messages:

hwclock --test -D --systz --localtime
Calling settimeofday(NULL, 240) to warp System time.
Test mode: clock was not changed

hwclock --test -D --systz --utc
Calling settimeofday(NULL, 0) to lock the warp function.
Calling settimeofday(NULL, 240) to set the kernel timezone.
Test mode: clock was not changed

hwclock --test -D --hctosys --utc
Calling settimeofday(1502239269.733639, 240)
Test mode: clock was not changed

hwclock --test -D --hctosys --localtime
Calling settimeofday(NULL, 240) to set persistent_clock_is_local.
Calling settimeofday(1502253708.200200, 240)
Test mode: clock was not changed

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index ddd6413..0be9c2a 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -606,11 +606,24 @@ set_system_clock(const struct hwclock_control *ctl,
 #endif
 
 	if (ctl->debug) {
-		printf(_("Calling settimeofday:\n"));
-		printf(_("\ttv.tv_sec = %ld, tv.tv_usec = %ld\n"),
-		       newtime.tv_sec, newtime.tv_usec);
-		printf(_("\ttz.tz_minuteswest = %d\n"), minuteswest);
+		if (ctl->hctosys && !ctl->universal)
+			printf(_("Calling settimeofday(NULL, %d) to set "
+				 "persistent_clock_is_local.\n"), minuteswest);
+		if (ctl->systz && ctl->universal)
+			puts(_("Calling settimeofday(NULL, 0) "
+				"to lock the warp function."));
+		if (ctl->hctosys)
+			printf(_("Calling settimeofday(%ld.%06ld, %d)\n"),
+			       newtime.tv_sec, newtime.tv_usec, minuteswest);
+		else {
+			printf(_("Calling settimeofday(NULL, %d) "), minuteswest);
+			if (ctl->universal)
+				 puts(_("to set the kernel timezone."));
+			else
+				 puts(_("to warp System time."));
+		}
 	}
+
 	if (ctl->testing) {
 		printf(_
 		       ("Test mode: clock was not changed\n"));
