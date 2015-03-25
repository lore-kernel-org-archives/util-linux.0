Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:59965 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055AbbCYJkO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 25 Mar 2015 05:40:14 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0LsgvV-1ZckfC3QIz-012G2e for
 <util-linux@vger.kernel.org>; Wed, 25 Mar 2015 10:40:12 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] last, fix race when comparing time stamps
Date: Wed, 25 Mar 2015 10:40:10 +0100
Message-Id: <1427276410-25271-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1427276410-25271-1-git-send-email-sweet_f_a@gmx.de>
References: <1427276410-25271-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

It is just luck if two time() calls happen within the same
second. Introduced in 31d28e09.

Actually I don't like adding another global variable but this
way we avoid bigger refactoring. IMO it's questionable why
lastdate, lastdown, etc. are initialized with current time() at
all. It looks unsafe to print "still running" always when
logout_time = now.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 login-utils/last.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 4a165c2..8d82c10 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -138,6 +138,7 @@ static struct last_timefmt timefmts[] = {
 /* Global variables */
 static unsigned int recsdone;	/* Number of records listed */
 static time_t lastdate;		/* Last date we've seen */
+static time_t currentdate;	/* date when we started processing the file */
 
 /* --time-format=option parser */
 static int which_time_format(const char *optarg)
@@ -372,7 +373,7 @@ static void trim_trailing_spaces(char *s)
  */
 static int list(const struct last_control *ctl, struct utmp *p, time_t logout_time, int what)
 {
-	time_t		secs, utmp_time, now;
+	time_t		secs, utmp_time;
 	char		logintime[LAST_TIMESTAMP_LEN];
 	char		logouttime[LAST_TIMESTAMP_LEN];
 	char		length[LAST_TIMESTAMP_LEN];
@@ -428,8 +429,7 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t logout_ti
 	hours = (secs / 3600) % 24;
 	days  = secs / 86400;
 
-	now = time(NULL);
-	if (logout_time == now) {
+	if (logout_time == currentdate) {
 		if (ctl->time_fmt > LAST_TIMEFTM_SHORT_CTIME) {
 			sprintf(logouttime, "  still running");
 			length[0] = 0;
@@ -638,7 +638,7 @@ static void process_wtmp_file(const struct last_control *ctl,
 	/*
 	 * Fill in 'lastdate'
 	 */
-	lastdate = lastrch = lastdown;
+	lastdate = currentdate = lastrch = lastdown;
 
 	/*
 	 * Install signal handlers
-- 
1.8.4.5

