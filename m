Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:55261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751009AbdLXUjA (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 24 Dec 2017 15:39:00 -0500
Subject: [PATCH 2/2] hwclock: add --ul-debug implementing debug.h
To: Karel Zak <kzak@redhat.com>
References: <27af199a-8ec2-634f-6e99-dd4047f9d5f4@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <c0ee83b1-2736-313d-802b-4937c6f71d85@gmx.com>
Date: Sun, 24 Dec 2017 15:38:58 -0500
MIME-Version: 1.0
In-Reply-To: <27af199a-8ec2-634f-6e99-dd4047f9d5f4@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Undocumented at this time, because it is a skeleton
implementation.  More debugging points are to be added after
refactoring is complete, or ad hoc in the mean time.

When fully implemented, enough time may have passed that the
deprecated --debug could be used to replace --ul-debug.

Coauthored-by: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 40 ++++++++++++++++++++++++----------------
 sys-utils/hwclock.h | 13 +++++++++++--
 2 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 0dc1d2369..90eab9f89 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -84,6 +84,8 @@
 static int hwaudit_fd = -1;
 #endif
 
+UL_DEBUG_DEFINE_MASK(hwclock);
+
 /* The struct that holds our hardware access routines */
 static struct clock_ops *ur;
 
@@ -120,6 +122,15 @@ struct adjtime {
 	 */
 };
 
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
@@ -473,12 +484,7 @@ set_hardware_clock_exact(const struct hwclock_control *ctl,
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
@@ -494,13 +500,11 @@ set_hardware_clock_exact(const struct hwclock_control *ctl,
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
@@ -1125,6 +1129,7 @@ int main(int argc, char **argv)
 		{ "version",      no_argument,       NULL, 'V'            },
 		{ "systohc",      no_argument,       NULL, 'w'            },
 		{ "debug",        no_argument,       NULL, 'D'            },
+		{ "ul-debug",     required_argument, NULL, 'd'            },
 		{ "verbose",      no_argument,       NULL, 'v'            },
 		{ "set",          no_argument,       NULL, OPT_SET        },
 #if defined(__linux__) && defined(__alpha__)
@@ -1187,7 +1192,7 @@ int main(int argc, char **argv)
 	atexit(close_stdout);
 
 	while ((c = getopt_long(argc, argv,
-				"hvVDalrsuwf:", longopts, NULL)) != -1) {
+				"hvVDd:alrsuwf:", longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
 
@@ -1196,7 +1201,10 @@ int main(int argc, char **argv)
 			warnx(_("use --verbose, --debug has been deprecated."));
 			break;
 		case 'v':
-			ctl.verbose++;
+			ctl.verbose = 1;
+			break;
+		case 'd':
+			hwclock_debug_mask = atoi(optarg);
 			break;
 		case 'a':
 			ctl.adjust = 1;
@@ -1249,7 +1257,7 @@ int main(int argc, char **argv)
 			break;
 		case OPT_TEST:
 			ctl.testing = 1;	/* --test */
-			ctl.verbose++;
+			ctl.verbose = 1;
 			break;
 		case OPT_DATE:
 			ctl.date_opt = optarg;	/* --date */
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index 570bfe439..f60fce7bd 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -8,6 +8,15 @@
 #include <time.h>
 
 #include "c.h"
+#include "debug.h"
+
+#define HWCLOCK_DEBUG_RANDOM_SLEEP	(1 << 0)
+#define HWCLOCK_DEBUG_DELTA_VS_TARGET	(1 << 1)
+#define HWCLOCK_DEBUG_ALL		0xFFFF
+
+UL_DEBUG_DECLARE_MASK(hwclock);
+#define DBG(m, x)	__UL_DBG(hwclock, HWCLOCK_DEBUG_, m, x)
+#define ON_DBG(m, x)	__UL_DBG_CALL(hwclock, HWCLOCK_DEBUG_, m, x)
 
 struct hwclock_control {
 	char *date_opt;
@@ -18,7 +27,6 @@ struct hwclock_control {
 #ifdef __linux__
 	char *rtc_dev_name;
 #endif
-	unsigned int verbose;
 	unsigned int
 		hwaudit_on:1,
 		adjust:1,
@@ -39,7 +47,8 @@ struct hwclock_control {
 		get:1,
 		set:1,
 		update:1,
-		universal:1;	/* will store hw_clock_is_utc() return value */
+		universal:1,	/* will store hw_clock_is_utc() return value */
+		verbose:1;
 };
 
 struct clock_ops {
