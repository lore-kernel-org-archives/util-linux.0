Return-Path: elseifthen@gmx.com
Message-ID: <55398616.5020004@gmx.com>
Date: Thu, 23 Apr 2015 19:53:58 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>, Isaac Dunham <ibid.ag@gmail.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 1/1] hwclock: Remove TZUTC
References: <1429764592-15947-1-git-send-email-ibid.ag@gmail.com> <55398435.4090504@gmx.com>
In-Reply-To: <55398435.4090504@gmx.com>
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>


commit d53f8ecfbf036eddb2aef737dc0973a613d80ced
introduced the TZUTC environment variable to
facilitate use of the zoneinfo 'right' database.
This was incorrect. Either the TZDIR environment
variable should be used or a system-wide
configuration for the 'right' database should be
used.

See hwclock(8) POSIX vs 'RIGHT' for more details.

TZUTC was undocumented and should be safe to remove.

The commit also caused a regression when using
musl libc, because when TZUTC is unset getenv()
returns a NULL pointer.
Reported-by: Isaac Dunham <ibid.ag@gmail.com>

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index e1e5816..f4784a1 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -400,15 +400,8 @@ mktime_tz(struct tm tm, const bool universal,
 	 */
 	zone = getenv("TZ");	/* remember original time zone */
 	if (universal) {
-		/* Set timezone to UTC as defined by the environment
-		 * variable TZUTC.  TZUTC undefined gives the default UTC
-		 * zonefile which usually does not take into account leap
-		 * seconds.  Define TZUTC to select your UTC zonefile which
-		 * does include leap seconds.  For example, with recent GNU
-		 * libc's:
-		 *    TZUTC=:/usr/share/zoneinfo/right/UTC
-		 */
-		setenv("TZ", getenv("TZUTC"), TRUE);
+		/* Set timezone to UTC */
+		setenv("TZ", "", TRUE);
 		/*
 		 * Note: tzset() gets called implicitly by the time code,
 		 * but only the first time. When changing the environment
