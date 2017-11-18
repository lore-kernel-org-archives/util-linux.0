Return-Path: elseifthen@gmx.com
Subject: [PATCH 2/2] hwclock: fix debug regression
To: Karel Zak <kzak@redhat.com>
References: <d91b971a-29f1-3403-342b-2b837c2abcb7@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <975e1e00-fab6-e539-8b92-5388e33d7f16@gmx.com>
Date: Sat, 18 Nov 2017 16:21:17 -0500
MIME-Version: 1.0
In-Reply-To: <d91b971a-29f1-3403-342b-2b837c2abcb7@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


commit f0a0ce7 makes debug mode implicit for the --test option.

Using the previous command syntax of --test and --debug
together invokes the undocumented Level 2 debugging when
setting the RTC. This can cause many thousands of lines of
output like:
1510967983.499968 < 1510967983.500000 (-0.000032)

Fix: bump Level 2 debugging to Level 9, just before the
other undocumented Level 10. This makes it improbable for
the development debug levels to be accessed unintentionally.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 8ff33474e..e5f90a44e 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -494,7 +494,7 @@ set_hardware_clock_exact(const struct hwclock_control *ctl,
 			/* The retarget is handled at the end of the loop. */
 		} else if (deltavstarget < 0) {
 			/* deltavstarget < 0 if current time < target time */
-			if (ctl->debug >= 2)
+			if (ctl->debug >= 9)
 				printf(_("%ld.%06ld < %ld.%06ld (%.6f)\n"),
 				       nowsystime.tv_sec,
 				       nowsystime.tv_usec,
