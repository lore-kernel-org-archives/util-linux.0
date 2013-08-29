Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f44.google.com ([74.125.83.44]:34600 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838Ab3H2SLB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 29 Aug 2013 14:11:01 -0400
Received: by mail-ee0-f44.google.com with SMTP id b47so424308eek.3
        for <util-linux@vger.kernel.org>; Thu, 29 Aug 2013 11:11:00 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 24/26] last, utmpdump, agetty, wall, write: avoid compatibility hacks
Date: Thu, 29 Aug 2013 19:10:50 +0100
Message-Id: <1377799852-28461-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In include/bits/utmp.h the ut_user and ut_time macros are marked with
comment they are backwards compatibility hacks.  It is probably best to
avoid use of these macros where ever possible.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c     | 50 ++++++++++++++++++++++++++++----------------------
 login-utils/utmpdump.c | 11 +++++++++--
 term-utils/agetty.c    |  4 ++++
 term-utils/wall.c      |  2 +-
 term-utils/write.c     |  4 ++--
 5 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 419162e..2e392d9 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -49,6 +49,12 @@
 #include "strutils.h"
 #include "time-util.h"
 
+#if defined(_HAVE_UT_TV)
+# define UL_UT_TIME ut_tv.tv_sec
+#else
+# define UL_UT_TIME ut_time
+#endif
+
 #ifndef SHUTDOWN_TIME
 # define SHUTDOWN_TIME 254
 #endif
@@ -397,7 +403,7 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t t, int wh
 	if (ctl->show) {
 		char **walk;
 		for (walk = ctl->show; *walk; walk++) {
-			if (strncmp(p->ut_name, *walk, UT_NAMESIZE) == 0 ||
+			if (strncmp(p->ut_user, *walk, UT_NAMESIZE) == 0 ||
 			    strcmp(utline, *walk) == 0 ||
 			    (strncmp(utline, "tty", 3) == 0 &&
 			     strcmp(utline + 3, *walk) == 0)) break;
@@ -408,7 +414,7 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t t, int wh
 	/*
 	 *	Calculate times
 	 */
-	tmp = (time_t)p->ut_time;
+	tmp = p->UL_UT_TIME;
 
 	if (ctl->present && (ctl->present < tmp || (0 < t && t < ctl->present)))
 		return 0;
@@ -417,7 +423,7 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t t, int wh
 	    time_formatter(ctl, &logouttime[0], sizeof(logouttime), &t, 1) < 0)
 		errx(EXIT_FAILURE, _("preallocation size exceeded"));
 
-	secs = t - p->ut_time;
+	secs = t - p->UL_UT_TIME;
 	mins  = (secs / 60) % 60;
 	hours = (secs / 3600) % 24;
 	days  = secs / 86400;
@@ -489,7 +495,7 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t t, int wh
 		if (!ctl->altlist) {
 			len = snprintf(final, sizeof(final),
 				"%-8.*s %-12.12s %-16.*s %-*.*s %-*.*s %s\n",
-				ctl->name_len, p->ut_name, utline,
+				ctl->name_len, p->ut_user, utline,
 				ctl->domain_len, domain,
 				tftl[ctl->time_fmt].in, tftl[ctl->time_fmt].in, logintime,
 				tftl[ctl->time_fmt].out, tftl[ctl->time_fmt].out, logouttime,
@@ -497,7 +503,7 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t t, int wh
 		} else {
 			len = snprintf(final, sizeof(final),
 				"%-8.*s %-12.12s %-*.*s %-*.*s %-12.12s %s\n",
-				ctl->name_len, p->ut_name, utline,
+				ctl->name_len, p->ut_user, utline,
 				tftl[ctl->time_fmt].in, tftl[ctl->time_fmt].in, logintime,
 				tftl[ctl->time_fmt].out, tftl[ctl->time_fmt].out, logouttime,
 				length, domain);
@@ -505,7 +511,7 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t t, int wh
 	} else
 		len = snprintf(final, sizeof(final),
 			"%-8.*s %-12.12s %-*.*s %-*.*s %s\n",
-			ctl->name_len, p->ut_name, utline,
+			ctl->name_len, p->ut_user, utline,
 			tftl[ctl->time_fmt].in, tftl[ctl->time_fmt].in, logintime,
 			tftl[ctl->time_fmt].out, tftl[ctl->time_fmt].out, logouttime,
 			length);
@@ -615,7 +621,7 @@ static void process_wtmp_file(const struct last_control *ctl)
 	 * Read first structure to capture the time field
 	 */
 	if (uread(ctl, fp, &ut, NULL) == 1)
-		begintime = ut.ut_time;
+		begintime = ut.UL_UT_TIME;
 	else {
 		fstat(fileno(fp), &st);
 		begintime = st.st_ctime;
@@ -636,16 +642,16 @@ static void process_wtmp_file(const struct last_control *ctl)
 		if (uread(ctl, fp, &ut, &quit) != 1)
 			break;
 
-		if (ctl->since && ut.ut_time < ctl->since)
+		if (ctl->since && ut.UL_UT_TIME < ctl->since)
 			continue;
 
-		if (ctl->until && ctl->until < ut.ut_time)
+		if (ctl->until && ctl->until < ut.UL_UT_TIME)
 			continue;
 
-		lastdate = ut.ut_time;
+		lastdate = ut.UL_UT_TIME;
 
 		if (ctl->lastb) {
-			quit = list(ctl, &ut, ut.ut_time, R_NORMAL);
+			quit = list(ctl, &ut, ut.UL_UT_TIME, R_NORMAL);
 			continue;
 		}
 
@@ -667,21 +673,21 @@ static void process_wtmp_file(const struct last_control *ctl)
 		 */
 		else {
 			if (ut.ut_type != DEAD_PROCESS &&
-			    ut.ut_name[0] && ut.ut_line[0] &&
-			    strcmp(ut.ut_name, "LOGIN") != 0)
+			    ut.ut_user[0] && ut.ut_line[0] &&
+			    strcmp(ut.ut_user, "LOGIN") != 0)
 				ut.ut_type = USER_PROCESS;
 			/*
 			 * Even worse, applications that write ghost
 			 * entries: ut_type set to USER_PROCESS but
-			 * empty ut_name...
+			 * empty ut_user...
 			 */
-			if (ut.ut_name[0] == 0)
+			if (ut.ut_user[0] == 0)
 				ut.ut_type = DEAD_PROCESS;
 
 			/*
 			 * Clock changes.
 			 */
-			if (strcmp(ut.ut_name, "date") == 0) {
+			if (strcmp(ut.ut_user, "date") == 0) {
 				if (ut.ut_line[0] == '|')
 					ut.ut_type = OLD_TIME;
 				if (ut.ut_line[0] == '{')
@@ -695,7 +701,7 @@ static void process_wtmp_file(const struct last_control *ctl)
 				strcpy(ut.ut_line, "system down");
 				quit = list(ctl, &ut, lastboot, R_NORMAL);
 			}
-			lastdown = lastrch = ut.ut_time;
+			lastdown = lastrch = ut.UL_UT_TIME;
 			down = 1;
 			break;
 		case OLD_TIME:
@@ -710,7 +716,7 @@ static void process_wtmp_file(const struct last_control *ctl)
 		case BOOT_TIME:
 			strcpy(ut.ut_line, "system boot");
 			quit = list(ctl, &ut, lastdown, R_REBOOT);
-			lastboot = ut.ut_time;
+			lastboot = ut.UL_UT_TIME;
 			down = 1;
 			break;
 		case RUN_LVL:
@@ -720,11 +726,11 @@ static void process_wtmp_file(const struct last_control *ctl)
 				quit = list(ctl, &ut, lastrch, R_NORMAL);
 			}
 			if (x == '0' || x == '6') {
-				lastdown = ut.ut_time;
+				lastdown = ut.UL_UT_TIME;
 				down = 1;
 				ut.ut_type = SHUTDOWN_TIME;
 			}
-			lastrch = ut.ut_time;
+			lastrch = ut.UL_UT_TIME;
 			break;
 
 		case USER_PROCESS:
@@ -740,7 +746,7 @@ static void process_wtmp_file(const struct last_control *ctl)
 				    UT_LINESIZE) == 0) {
 					/* Show it */
 					if (c == 0) {
-						quit = list(ctl, &ut, p->ut.ut_time, R_NORMAL);
+						quit = list(ctl, &ut, p->ut.UL_UT_TIME, R_NORMAL);
 						c = 1;
 					}
 					if (p->next) p->next->prev = p->prev;
@@ -800,7 +806,7 @@ static void process_wtmp_file(const struct last_control *ctl)
 		 * the entire current utmplist.
 		 */
 		if (down) {
-			lastboot = ut.ut_time;
+			lastboot = ut.UL_UT_TIME;
 			whydown = (ut.ut_type == SHUTDOWN_TIME) ? R_DOWN : R_CRASH;
 			for (p = utmplist; p; p = next) {
 				next = p->next;
diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index baf9f5c..acc10db 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -90,7 +90,11 @@ static void print_utline(struct utmp ut, FILE *out)
 
 	in.s_addr = ut.ut_addr;
 	addr_string = inet_ntoa(in);
-	time_string = timetostr(ut.ut_time);
+#if defined(_HAVE_UT_TV)
+	time_string = timetostr(ut.ut_tv.tv_sec);
+#else
+	time_string = timetostr((time_t)ut.ut_time);	/* ut_time is not always a time_t */
+#endif
 	cleanse(ut.ut_id);
 	cleanse(ut.ut_user);
 	cleanse(ut.ut_line);
@@ -268,8 +272,11 @@ static void undump(FILE *in, FILE *out)
 		gettok(line, s_time, sizeof(s_time) - 1, 0);
 
 		ut.ut_addr = inet_addr(s_addr);
+#if defined(_HAVE_UT_TV)
+		ut.ut_tv.tv_sec = strtotime(s_time);
+#else
 		ut.ut_time = strtotime(s_time);
-
+#endif
 		ignore_result( fwrite(&ut, sizeof(ut), 1, out) );
 
 		++count;
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 4cd8675..af1e520 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -849,7 +849,11 @@ static void update_utmp(struct options *op)
 	if (fakehost)
 		strncpy(ut.ut_host, fakehost, sizeof(ut.ut_host));
 	time(&t);
+#if defined(_HAVE_UT_TV)
+	ut.ut_tv.tv_sec = t;
+#else
 	ut.ut_time = t;
+#endif
 	ut.ut_type = LOGIN_PROCESS;
 	ut.ut_pid = pid;
 	ut.ut_session = sid;
diff --git a/term-utils/wall.c b/term-utils/wall.c
index fbea7e4..20a2891 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -155,7 +155,7 @@ int main(int argc, char **argv)
 	iov.iov_base = mbuf;
 	iov.iov_len = mbufsize;
 	while((utmpptr = getutent())) {
-		if (!utmpptr->ut_name[0])
+		if (!utmpptr->ut_user[0])
 			continue;
 #ifdef USER_PROCESS
 		if (utmpptr->ut_type != USER_PROCESS)
diff --git a/term-utils/write.c b/term-utils/write.c
index 1738694..f5ca341 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -201,7 +201,7 @@ int utmp_chk(char *user, char *tty)
 
 	while ((uptr = getutent())) {
 		memcpy(&u, uptr, sizeof(u));
-		if (strncmp(user, u.ut_name, sizeof(u.ut_name)) == 0 &&
+		if (strncmp(user, u.ut_user, sizeof(u.ut_user)) == 0 &&
 		    strncmp(tty, u.ut_line, sizeof(u.ut_line)) == 0) {
 			res = 0;
 			break;
@@ -239,7 +239,7 @@ void search_utmp(char *user, char *tty, char *mytty, uid_t myuid)
 	user_is_me = 0;
 	while ((uptr = getutent())) {
 		memcpy(&u, uptr, sizeof(u));
-		if (strncmp(user, u.ut_name, sizeof(u.ut_name)) == 0) {
+		if (strncmp(user, u.ut_user, sizeof(u.ut_user)) == 0) {
 			++nloggedttys;
 			strncpy(atty, u.ut_line, sizeof(u.ut_line));
 			atty[sizeof(u.ut_line)] = '\0';
-- 
1.8.4

