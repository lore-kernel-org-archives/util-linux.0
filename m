Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:62353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751007AbdKLPXk (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 12 Nov 2017 10:23:40 -0500
Subject: [v2 PATCH 1/5] hwclock: add iso-8601 overflow check
To: Karel Zak <kzak@redhat.com>
References: <1a28a73d-2e05-7071-479a-af5a18fade3b@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <86f22fe1-3af8-e510-4d85-7791376f0922@gmx.com>
Date: Sun, 12 Nov 2017 10:23:38 -0500
MIME-Version: 1.0
In-Reply-To: <1a28a73d-2e05-7071-479a-af5a18fade3b@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


hwclock wasn't testing for strtimeval_iso() truncation:

/sbin/hwclock --utc --noadjfile --predict --date '7982 years'; echo $?
9999-09-25 19:33:01.000000-0400
0

/sbin/hwclock --utc --noadjfile --predict --date '7983 years'; echo $?
10000-09-25 19:33:10.000000-
0

Patched:
./hwclock --utc --noadjfile --predict --date '7982 years'; echo $?
9999-09-25 19:22:15.000000-0400
0

./hwclock --utc --noadjfile --predict --date '7983 years'; echo $?
hwclock: iso-8601 format truncated
1

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 36b6204b0..c2c20812c 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -551,15 +551,19 @@ set_hardware_clock_exact(const struct hwclock_control *ctl,
 	set_hardware_clock(ctl, newhwtime);
 }
 
-static void
+static int
 display_time(struct timeval hwctime)
 {
 	char buf[ISO_8601_BUFSIZ];
 
-	strtimeval_iso(&hwctime, ISO_8601_DATE|ISO_8601_TIME|ISO_8601_DOTUSEC|
+	if (strtimeval_iso(&hwctime, ISO_8601_DATE|ISO_8601_TIME|ISO_8601_DOTUSEC|
 				 ISO_8601_TIMEZONE|ISO_8601_SPACE,
-				 buf, sizeof(buf));
+				 buf, sizeof(buf))) {
+		warnx(_("iso-8601 format overflow"));
+		return EXIT_FAILURE;
+	}
 	printf("%s\n", buf);
+	return EXIT_SUCCESS;
 }
 
 /*
@@ -931,8 +935,7 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 			printf(_ ("Target date:   %ld\n"), set_time);
 			printf(_ ("Predicted RTC: %ld\n"), hclocktime.tv_sec);
 		}
-		display_time(hclocktime);
-		return EXIT_SUCCESS;
+		return display_time(hclocktime);
 	}
 
 	if (ctl->systz)
@@ -978,7 +981,7 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 		 time_inc(hclocktime, time_diff(startup_time, read_time));
 	}
 	if (ctl->show || ctl->get) {
-		display_time(startup_hclocktime);
+		return display_time(startup_hclocktime);
 	} else if (ctl->set) {
 		set_hardware_clock_exact(ctl, set_time, startup_time);
 		if (!ctl->noadjfile)
