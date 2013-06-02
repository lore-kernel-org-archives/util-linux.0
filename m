Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:64630 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755045Ab3FBRwg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Jun 2013 13:52:36 -0400
Received: by mail-wi0-f176.google.com with SMTP id hr14so2028291wib.9
        for <util-linux@vger.kernel.org>; Sun, 02 Jun 2013 10:52:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 18/19] dmesg: more deterministic boot time detection
Date: Sun,  2 Jun 2013 18:51:24 +0100
Message-Id: <1370195485-27907-19-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This fixes an issue which made second in human readable time formats to
wiggle.  One would expect the two dmesg runs below would be identical,
but the half second sleep should almost always make some timestamps to
differ.

diff -q <(dmesg --ctime) <(sleep 0.5 ; dmesg --ctime)

Unfortunately this patch is not perfect.  The use of pid 1 directory
ctime is a bit off what kernel thinks is the start up time, which makes
the dmesg, journald, and kernel all to mutually disagree when system
started.  On my laptop the /proc/uptime consider start time to be
18:22:33, the old dmesg claimed 18:22:35, the new dmesg 18:22:42, and
journald 18:22:44.

In the heart of the problem is linux kernel that does not tell, in high
resolution accurancy, when start up happen.  I am almost sure the kernel
should log a message telling at boot, and at any time clock is skewed,
what time the kernel thinks it is.  A klog message such as 'kernel time
announcement: <epoc>.<milliseconds>' might solve most if not all
problems.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/pathnames.h |  3 ++-
 sys-utils/dmesg.c   | 27 ++++++++++++++-------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/pathnames.h b/include/pathnames.h
index cc8a20b..84eabd4 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -48,7 +48,8 @@
 #define _PATH_SECURE		"/etc/securesingle"
 #define _PATH_USERTTY           "/etc/usertty"
 
-/* used in login-utils/shutdown.c */
+/* used in sys-utils/dmesg.c */
+#define _PATH_PROC_PID1		"/proc/1"
 
 /* used in login-utils/setpwnam.h and login-utils/islocal.c */
 #define _PATH_PASSWD		"/etc/passwd"
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index d80b3e9..da58c42 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -34,6 +34,7 @@
 #include "optutils.h"
 #include "mangle.h"
 #include "pager.h"
+#include "pathnames.h"
 
 /* Close the log.  Currently a NOP. */
 #define SYSLOG_ACTION_CLOSE          0
@@ -141,7 +142,7 @@ struct dmesg_control {
 
 	struct timeval	lasttime;	/* last printed timestamp */
 	struct tm	lasttm;		/* last localtime */
-	time_t		boot_time;	/* system boot time */
+	struct timeval	boot_time;	/* system boot time */
 
 	int		action;		/* SYSLOG_ACTION_* */
 	int		method;		/* DMESG_METHOD_* */
@@ -464,18 +465,17 @@ static int get_syslog_buffer_size(void)
 	return n > 0 ? n : 0;
 }
 
-static time_t get_boot_time(void)
+static struct timeval get_boot_time(void)
 {
-	struct sysinfo info;
-	struct timeval tv;
+	struct stat st;
+	struct timeval ret;
+	memset(&ret, 0, sizeof(struct timeval));
 
-	if (sysinfo(&info) != 0)
-		warn(_("sysinfo failed"));
-	else if (gettimeofday(&tv, NULL) != 0)
-		warn(_("gettimeofday failed"));
+	if (stat(_PATH_PROC_PID1, &st))
+		warn(_("stat failed %s"), _PATH_PROC_PID1);
 	else
-		return tv.tv_sec -= info.uptime;
-	return 0;
+		ret.tv_sec = st.st_ctime;
+	return ret;
 }
 
 /*
@@ -763,8 +763,9 @@ static struct tm *record_localtime(struct dmesg_control *ctl,
 				   struct dmesg_record *rec,
 				   struct tm *tm)
 {
-	time_t t = ctl->boot_time + rec->tv.tv_sec;
-	return localtime_r(&t, tm);
+	struct timeval res;
+	timeradd(&(ctl->boot_time), &(rec->tv), &res);
+	return localtime_r(&(res.tv_sec), tm);
 }
 
 static char *record_ctime(struct dmesg_control *ctl,
@@ -1371,7 +1372,7 @@ int main(int argc, char *argv[])
 
 	if (ctl.time_fmt & (TIMEFTM_RELTIME | TIMEFTM_CTIME | TIMEFTM_ISO8601)) {
 		ctl.boot_time = get_boot_time();
-		if (!ctl.boot_time)
+		if (!ctl.boot_time.tv_sec)
 			ctl.time_fmt &= TIMEFTM_RELTIME | TIMEFTM_CTIME;
 	}
 
-- 
1.8.3

