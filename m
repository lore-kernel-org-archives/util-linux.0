Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:60860 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757102AbcLAIwY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Dec 2016 03:52:24 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 02/11] login-utils: remove _HAVE_UT_TV fallback
Date: Thu,  1 Dec 2016 09:52:05 +0100
Message-Id: <1480582332-17407-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
References: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

_HAVE_UT_TV is glibc only. Moreover we want to move to utmpx where
timeval is standard.

Now utmp/subsecond (1173d0a6) should work on all supported systems.

CC: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 login-utils/last.c      | 32 +++++++++++++-------------------
 login-utils/login.c     | 19 -------------------
 login-utils/su-common.c |  8 --------
 login-utils/utmpdump.c  |  8 ++------
 term-utils/agetty.c     |  4 ----
 5 files changed, 15 insertions(+), 56 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 90eee68..42fb914 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -53,12 +53,6 @@
 #include "timeutils.h"
 #include "monotonic.h"
 
-#if defined(_HAVE_UT_TV)
-# define UL_UT_TIME ut_tv.tv_sec
-#else
-# define UL_UT_TIME ut_time
-#endif
-
 #ifndef SHUTDOWN_TIME
 # define SHUTDOWN_TIME 254
 #endif
@@ -425,7 +419,7 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t logout_ti
 	 */
 	fmt = &timefmts[ctl->time_fmt];
 
-	utmp_time = p->UL_UT_TIME;
+	utmp_time = p->ut_tv.tv_sec;
 
 	if (ctl->present) {
 		if (ctl->present < utmp_time)
@@ -604,7 +598,7 @@ static int is_phantom(const struct last_control *ctl, struct utmp *ut)
 	char path[32];
 	int ret = 0;
 
-	if (ut->UL_UT_TIME < ctl->boot_time.tv_sec)
+	if (ut->ut_tv.tv_sec < ctl->boot_time.tv_sec)
 		return 1;
 	pw = getpwnam(ut->ut_user);
 	if (!pw)
@@ -681,7 +675,7 @@ static void process_wtmp_file(const struct last_control *ctl,
 	 * Read first structure to capture the time field
 	 */
 	if (uread(fp, &ut, NULL, filename) == 1)
-		begintime = ut.UL_UT_TIME;
+		begintime = ut.ut_tv.tv_sec;
 	else {
 		if (fstat(fileno(fp), &st) != 0)
 			err(EXIT_FAILURE, _("stat of %s failed"), filename);
@@ -703,16 +697,16 @@ static void process_wtmp_file(const struct last_control *ctl,
 		if (uread(fp, &ut, &quit, filename) != 1)
 			break;
 
-		if (ctl->since && ut.UL_UT_TIME < ctl->since)
+		if (ctl->since && ut.ut_tv.tv_sec < ctl->since)
 			continue;
 
-		if (ctl->until && ctl->until < ut.UL_UT_TIME)
+		if (ctl->until && ctl->until < ut.ut_tv.tv_sec)
 			continue;
 
-		lastdate = ut.UL_UT_TIME;
+		lastdate = ut.ut_tv.tv_sec;
 
 		if (ctl->lastb) {
-			quit = list(ctl, &ut, ut.UL_UT_TIME, R_NORMAL);
+			quit = list(ctl, &ut, ut.ut_tv.tv_sec, R_NORMAL);
 			continue;
 		}
 
@@ -762,7 +756,7 @@ static void process_wtmp_file(const struct last_control *ctl,
 				strcpy(ut.ut_line, "system down");
 				quit = list(ctl, &ut, lastboot, R_NORMAL);
 			}
-			lastdown = lastrch = ut.UL_UT_TIME;
+			lastdown = lastrch = ut.ut_tv.tv_sec;
 			down = 1;
 			break;
 		case OLD_TIME:
@@ -777,7 +771,7 @@ static void process_wtmp_file(const struct last_control *ctl,
 		case BOOT_TIME:
 			strcpy(ut.ut_line, "system boot");
 			quit = list(ctl, &ut, lastdown, R_REBOOT);
-			lastboot = ut.UL_UT_TIME;
+			lastboot = ut.ut_tv.tv_sec;
 			down = 1;
 			break;
 		case RUN_LVL:
@@ -787,11 +781,11 @@ static void process_wtmp_file(const struct last_control *ctl,
 				quit = list(ctl, &ut, lastrch, R_NORMAL);
 			}
 			if (x == '0' || x == '6') {
-				lastdown = ut.UL_UT_TIME;
+				lastdown = ut.ut_tv.tv_sec;
 				down = 1;
 				ut.ut_type = SHUTDOWN_TIME;
 			}
-			lastrch = ut.UL_UT_TIME;
+			lastrch = ut.ut_tv.tv_sec;
 			break;
 
 		case USER_PROCESS:
@@ -807,7 +801,7 @@ static void process_wtmp_file(const struct last_control *ctl,
 				    UT_LINESIZE) == 0) {
 					/* Show it */
 					if (c == 0) {
-						quit = list(ctl, &ut, p->ut.UL_UT_TIME, R_NORMAL);
+						quit = list(ctl, &ut, p->ut.ut_tv.tv_sec, R_NORMAL);
 						c = 1;
 					}
 					if (p->next)
@@ -867,7 +861,7 @@ static void process_wtmp_file(const struct last_control *ctl,
 		 * the entire current ulist.
 		 */
 		if (down) {
-			lastboot = ut.UL_UT_TIME;
+			lastboot = ut.ut_tv.tv_sec;
 			whydown = (ut.ut_type == SHUTDOWN_TIME) ? R_DOWN : R_CRASH;
 			for (p = ulist; p; p = next) {
 				next = p->next;
diff --git a/login-utils/login.c b/login-utils/login.c
index 2350fc3..043fce1 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -426,9 +426,7 @@ static void init_tty(struct login_context *cxt)
 static void log_btmp(struct login_context *cxt)
 {
 	struct utmp ut;
-#if defined(_HAVE_UT_TV)        /* in <utmpbits.h> included by <utmp.h> */
 	struct timeval tv;
-#endif
 
 	memset(&ut, 0, sizeof(ut));
 
@@ -441,17 +439,9 @@ static void log_btmp(struct login_context *cxt)
 	if (cxt->tty_name)
 		xstrncpy(ut.ut_line, cxt->tty_name, sizeof(ut.ut_line));
 
-#if defined(_HAVE_UT_TV)	/* in <utmpbits.h> included by <utmp.h> */
 	gettimeofday(&tv, NULL);
 	ut.ut_tv.tv_sec = tv.tv_sec;
 	ut.ut_tv.tv_usec = tv.tv_usec;
-#else
-	{
-		time_t t;
-		time(&t);
-		ut.ut_time = t;	/* ut_time is not always a time_t */
-	}
-#endif
 
 	ut.ut_type = LOGIN_PROCESS;	/* XXX doesn't matter */
 	ut.ut_pid = cxt->pid;
@@ -614,18 +604,9 @@ static void log_utmp(struct login_context *cxt)
 	if (cxt->tty_name)
 		xstrncpy(ut.ut_line, cxt->tty_name, sizeof(ut.ut_line));
 
-#ifdef _HAVE_UT_TV		/* in <utmpbits.h> included by <utmp.h> */
 	gettimeofday(&tv, NULL);
 	ut.ut_tv.tv_sec = tv.tv_sec;
 	ut.ut_tv.tv_usec = tv.tv_usec;
-#else
-	{
-		time_t t;
-		time(&t);
-		ut.ut_time = t;	/* ut_time is not always a time_t */
-				/* glibc2 #defines it as ut_tv.tv_sec */
-	}
-#endif
 	ut.ut_type = USER_PROCESS;
 	ut.ut_pid = cxt->pid;
 	if (cxt->hostname) {
diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index ff20a2f..c48d951 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -198,17 +198,9 @@ static void log_btmp(struct passwd const *pw)
 	if (tty_name)
 		xstrncpy(ut.ut_line, tty_name, sizeof(ut.ut_line));
 
-#if defined(_HAVE_UT_TV)	/* in <utmpbits.h> included by <utmp.h> */
 	gettimeofday(&tv, NULL);
 	ut.ut_tv.tv_sec = tv.tv_sec;
 	ut.ut_tv.tv_usec = tv.tv_usec;
-#else
-	{
-		time_t t;
-		time(&t);
-		ut.ut_time = t;	/* ut_time is not always a time_t */
-	}
-#endif
 	ut.ut_type = LOGIN_PROCESS;	/* XXX doesn't matter */
 	ut.ut_pid = getpid();
 
diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index cf8a50d..8f438b0 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -71,7 +71,6 @@ static time_t strtotime(const char *s_time)
 	return timegm(&tm);
 }
 
-#if defined(_HAVE_UT_TV)
 static suseconds_t strtousec(const char *s_time)
 {
 	const char *s = strchr(s_time, ',');
@@ -79,7 +78,6 @@ static suseconds_t strtousec(const char *s_time)
 		return (suseconds_t) atoi(s + 1);
 	return 0;
 }
-#endif
 
 #define cleanse(x) xcleanse(x, sizeof(x))
 static void xcleanse(char *s, int len)
@@ -287,12 +285,10 @@ static void undump(FILE *in, FILE *out)
 			inet_pton(AF_INET, s_addr, &(ut.ut_addr_v6));
 		else
 			inet_pton(AF_INET6, s_addr, &(ut.ut_addr_v6));
-#if defined(_HAVE_UT_TV)
+
 		ut.ut_tv.tv_sec = strtotime(s_time);
 		ut.ut_tv.tv_usec = strtousec(s_time);
-#else
-		ut.ut_time = strtotime(s_time);
-#endif
+
 		ignore_result( fwrite(&ut, sizeof(ut), 1, out) );
 
 		++count;
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index d6cec8f..dbf499e 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -943,11 +943,7 @@ static void update_utmp(struct options *op)
 	if (fakehost)
 		strncpy(ut.ut_host, fakehost, sizeof(ut.ut_host));
 	time(&t);
-#if defined(_HAVE_UT_TV)
 	ut.ut_tv.tv_sec = t;
-#else
-	ut.ut_time = t;
-#endif
 	ut.ut_type = LOGIN_PROCESS;
 	ut.ut_pid = pid;
 	ut.ut_session = sid;
-- 
1.8.5.6

