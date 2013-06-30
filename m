Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f175.google.com ([74.125.82.175]:38576 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab3F3SLz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 30 Jun 2013 14:11:55 -0400
Received: by mail-we0-f175.google.com with SMTP id t59so2593044wes.6
        for <util-linux@vger.kernel.org>; Sun, 30 Jun 2013 11:11:53 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Kay Sievers <kay@vrfy.org>
Subject: [PATCH 16/15] dmesg: make time stamps to be printed consistently
Date: Sun, 30 Jun 2013 19:11:22 +0100
Message-Id: <1372615882-11589-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1372615882-11589-1-git-send-email-kerolasa@iki.fi>
References: <1372615882-11589-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier uptime determination, which was done with sysinfo(2), had one
second resolution, which made time stamps to be rounded unstable way
depending on when a dmesg command was executed.  In practical terms; the
command below was supposed not to differ but it did.

$ diff -q <(dmesg --ctime) <(sleep 0.5 ; dmesg --ctime)

CC: Kay Sievers <kay@vrfy.org>
References: https://lkml.org/lkml/2013/6/30/37
Buglink: https://github.com/karelzak/util-linux/issues/24
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 480c897..c429a82 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -145,7 +145,7 @@ struct dmesg_control {
 
 	struct timeval	lasttime;	/* last printed timestamp */
 	struct tm	lasttm;		/* last localtime */
-	time_t		boot_time;	/* system boot time */
+	struct timeval	boot_time;	/* system boot time */
 
 	int		action;		/* SYSLOG_ACTION_* */
 	int		method;		/* DMESG_METHOD_* */
@@ -472,18 +472,19 @@ static int get_syslog_buffer_size(void)
 	return n > 0 ? n : 0;
 }
 
-static time_t get_boot_time(void)
+static void get_boot_time(struct timeval *boot_time)
 {
-	struct sysinfo info;
-	struct timeval tv;
+	struct timespec hires_uptime;
+	struct timeval lores_uptime, now;
 
-	if (sysinfo(&info) != 0)
-		warn(_("sysinfo failed"));
-	else if (gettimeofday(&tv, NULL) != 0)
+	if (clock_gettime(CLOCK_BOOTTIME, &hires_uptime) != 0)
+		warn(_("clock_gettime failed"));
+	else if (gettimeofday(&now, NULL) != 0)
 		warn(_("gettimeofday failed"));
-	else
-		return tv.tv_sec -= info.uptime;
-	return 0;
+	else {
+		TIMESPEC_TO_TIMEVAL(&lores_uptime, &hires_uptime);
+		timersub(&now, &lores_uptime, boot_time);
+	}
 }
 
 /*
@@ -771,7 +772,7 @@ static struct tm *record_localtime(struct dmesg_control *ctl,
 				   struct dmesg_record *rec,
 				   struct tm *tm)
 {
-	time_t t = ctl->boot_time + rec->tv.tv_sec;
+	time_t t = ctl->boot_time.tv_sec + rec->tv.tv_sec;
 	return localtime_r(&t, tm);
 }
 
@@ -1338,8 +1339,8 @@ int main(int argc, char *argv[])
 		usage(stderr);
 
 	if (is_timefmt(ctl, RELTIME) || is_timefmt(ctl, CTIME) || is_timefmt(ctl, ISO8601)) {
-		ctl.boot_time = get_boot_time();
-		if (!ctl.boot_time)
+		get_boot_time(&(ctl.boot_time));
+		if (ctl.boot_time.tv_sec == 0 && ctl.boot_time.tv_usec == 0)
 			ctl.time_fmt = DMESG_TIMEFTM_NONE;
 	}
 
-- 
1.8.3.2

