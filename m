Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752100AbeAQN3H (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 17 Jan 2018 08:29:07 -0500
Date: Wed, 17 Jan 2018 14:29:02 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] hwclock: add --ul-debug implementing debug.h
Message-ID: <20180117132902.yjhpfchrjd2due3o@ws.net.home>
References: <27af199a-8ec2-634f-6e99-dd4047f9d5f4@gmx.com>
 <c0ee83b1-2736-313d-802b-4937c6f71d85@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c0ee83b1-2736-313d-802b-4937c6f71d85@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 24, 2017 at 03:38:58PM -0500, J William Piggott wrote:
> 
> Undocumented at this time, because it is a skeleton
> implementation.  More debugging points are to be added after
> refactoring is complete, or ad hoc in the mean time.
> 
> When fully implemented, enough time may have passed that the
> deprecated --debug could be used to replace --ul-debug.

I have updated your patch to use a new __UL_INIT_DEBUG_FROM_STRING(),
so the mask is initialized from --ul-debug in way compatible with 
rest of the util-linux, but without getenv().

        ./hwclock --ul-debug all
        25183: hwclock:     INIT: hwclock debug mask: 0xffff
        25183: hwclock:     INIT: hwclock version: util-linux 2.31.188-b0fee
        2018-01-17 14:22:24.311689+01:00

If you agree I'll apply the patch to the master branch. IMHO it's good
compromise.

    Karel


>From 3eac099c14339e0e934353d2f3f0917fcabb787c Mon Sep 17 00:00:00 2001
From: J William Piggott <elseifthen@gmx.com>
Date: Sun, 24 Dec 2017 15:38:58 -0500
Subject: [PATCH] hwclock: add --ul-debug implementing debug.h

Undocumented at this time, because it is a skeleton
implementation.  More debugging points are to be added after
refactoring is complete, or ad hoc in the mean time.

When fully implemented, enough time may have passed that the
deprecated --debug could be used to replace --ul-debug.

[kzak@redhat.com: - use __UL_INIT_DEBUG_FROM_STRING() to initialize the mask
                  - add hwclock_init_debug()]

Coauthored-by: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: J William Piggott <elseifthen@gmx.com>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 sys-utils/hwclock.c | 49 +++++++++++++++++++++++++++++++++----------------
 sys-utils/hwclock.h | 14 ++++++++++++--
 2 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 0dc1d2369..b83e71004 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -84,6 +84,9 @@
 static int hwaudit_fd = -1;
 #endif
 
+UL_DEBUG_DEFINE_MASK(hwclock);
+UL_DEBUG_DEFINE_MASKNAMES(hwclock) = UL_DEBUG_EMPTY_MASKNAMES;
+
 /* The struct that holds our hardware access routines */
 static struct clock_ops *ur;
 
@@ -120,6 +123,23 @@ struct adjtime {
 	 */
 };
 
+static void hwclock_init_debug(const char *str)
+{
+	__UL_INIT_DEBUG_FROM_STRING(hwclock, HWCLOCK_DEBUG_, 0, str);
+
+	DBG(INIT, ul_debug("hwclock debug mask: 0x%04x", hwclock_debug_mask));
+	DBG(INIT, ul_debug("hwclock version: %s", PACKAGE_STRING));
+}
+
+/* FOR TESTING ONLY: inject random delays of up to 1000ms */
+static void up_to_1000ms_sleep(void)
+{
+	int usec = random() % 1000000;
+
+	DBG(RANDOM_SLEEP, ul_debug("sleeping ~%d usec", usec));
+	xusleep(usec);
+}
+
 /*
  * time_t to timeval conversion.
  */
@@ -473,12 +493,7 @@ set_hardware_clock_exact(const struct hwclock_control *ctl,
 	while (1) {
 		double ticksize;
 
-		/* FOR TESTING ONLY: inject random delays of up to 1000ms */
-		if (ctl->verbose >= 10) {
-			int usec = random() % 1000000;
-			printf(_("sleeping ~%d usec\n"), usec);
-			xusleep(usec);
-		}
+		ON_DBG(RANDOM_SLEEP, up_to_1000ms_sleep());
 
 		gettimeofday(&nowsystime, NULL);
 		deltavstarget = time_diff(nowsystime, targetsystime);
@@ -494,13 +509,11 @@ set_hardware_clock_exact(const struct hwclock_control *ctl,
 			/* The retarget is handled at the end of the loop. */
 		} else if (deltavstarget < 0) {
 			/* deltavstarget < 0 if current time < target time */
-			if (ctl->verbose >= 9)
-				printf(_("%ld.%06ld < %ld.%06ld (%.6f)\n"),
-				       nowsystime.tv_sec,
-				       nowsystime.tv_usec,
-				       targetsystime.tv_sec,
-				       targetsystime.tv_usec,
-				       deltavstarget);
+			DBG(DELTA_VS_TARGET,
+			    ul_debug("%ld.%06ld < %ld.%06ld (%.6f)",
+				     nowsystime.tv_sec, nowsystime.tv_usec,
+				     targetsystime.tv_sec,
+				     targetsystime.tv_usec, deltavstarget));
 			continue;  /* not there yet - keep spinning */
 		} else if (deltavstarget <= target_time_tolerance_secs) {
 			/* Close enough to the target time; done waiting. */
@@ -1125,6 +1138,7 @@ int main(int argc, char **argv)
 		{ "version",      no_argument,       NULL, 'V'            },
 		{ "systohc",      no_argument,       NULL, 'w'            },
 		{ "debug",        no_argument,       NULL, 'D'            },
+		{ "ul-debug",     required_argument, NULL, 'd'            },
 		{ "verbose",      no_argument,       NULL, 'v'            },
 		{ "set",          no_argument,       NULL, OPT_SET        },
 #if defined(__linux__) && defined(__alpha__)
@@ -1187,7 +1201,7 @@ int main(int argc, char **argv)
 	atexit(close_stdout);
 
 	while ((c = getopt_long(argc, argv,
-				"hvVDalrsuwf:", longopts, NULL)) != -1) {
+				"hvVDd:alrsuwf:", longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
 
@@ -1196,7 +1210,10 @@ int main(int argc, char **argv)
 			warnx(_("use --verbose, --debug has been deprecated."));
 			break;
 		case 'v':
-			ctl.verbose++;
+			ctl.verbose = 1;
+			break;
+		case 'd':
+			hwclock_init_debug(optarg);
 			break;
 		case 'a':
 			ctl.adjust = 1;
@@ -1249,7 +1266,7 @@ int main(int argc, char **argv)
 			break;
 		case OPT_TEST:
 			ctl.testing = 1;	/* --test */
-			ctl.verbose++;
+			ctl.verbose = 1;
 			break;
 		case OPT_DATE:
 			ctl.date_opt = optarg;	/* --date */
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index 570bfe439..7bb6ec8bd 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -8,6 +8,16 @@
 #include <time.h>
 
 #include "c.h"
+#include "debug.h"
+
+#define HWCLOCK_DEBUG_INIT		(1 << 0)
+#define HWCLOCK_DEBUG_RANDOM_SLEEP	(1 << 1)
+#define HWCLOCK_DEBUG_DELTA_VS_TARGET	(1 << 2)
+#define HWCLOCK_DEBUG_ALL		0xFFFF
+
+UL_DEBUG_DECLARE_MASK(hwclock);
+#define DBG(m, x)	__UL_DBG(hwclock, HWCLOCK_DEBUG_, m, x)
+#define ON_DBG(m, x)	__UL_DBG_CALL(hwclock, HWCLOCK_DEBUG_, m, x)
 
 struct hwclock_control {
 	char *date_opt;
@@ -18,7 +28,6 @@ struct hwclock_control {
 #ifdef __linux__
 	char *rtc_dev_name;
 #endif
-	unsigned int verbose;
 	unsigned int
 		hwaudit_on:1,
 		adjust:1,
@@ -39,7 +48,8 @@ struct hwclock_control {
 		get:1,
 		set:1,
 		update:1,
-		universal:1;	/* will store hw_clock_is_utc() return value */
+		universal:1,	/* will store hw_clock_is_utc() return value */
+		verbose:1;
 };
 
 struct clock_ops {
-- 
2.13.6

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
