Return-Path: <SRS0=/ORA=7O=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD673C433DF
	for <util-linux@archiver.kernel.org>; Mon,  1 Jun 2020 19:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8810120734
	for <util-linux@archiver.kernel.org>; Mon,  1 Jun 2020 19:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="KAUiQpEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgFATVl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:21:41 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:58616 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726751AbgFATVl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 1 Jun 2020 15:21:41 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 5A5792E157C;
        Mon,  1 Jun 2020 22:21:37 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id Iz970RYwJe-LafmlK9f;
        Mon, 01 Jun 2020 22:21:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1591039297; bh=9qIipJ1NHMYN+PK3lJcRt0JyyNTfeEEpJCKeCYNYrEw=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=KAUiQpEYqvpp+dMvJQOaqsPFGXX18uZIFDUyDlMRl6vFRJVJCoYFxvBW4USj+wIKB
         dEe5FJhrScjJxlLybS/r6t4k2CCUjfMwAZ77lrgoE7Vxn5UIjVKQafieFHTDDppnaG
         sGhldjGhzZZoYEJwxrlljFnZUtq/GCxRFU1M0pdY=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:623::1:1])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id YVOhHoRaIy-LaW45fjp;
        Mon, 01 Jun 2020 22:21:36 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH util-linux] dmesg: adjust timestamps according to suspended
 time
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     util-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 01 Jun 2020 22:21:34 +0300
Message-ID: <159103929487.199093.15757669576783156290.stgit@buzz>
User-Agent: StGit/0.22-39-gd257
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Timestamps in kernel log comes from monotonic clocksource which does not
tick when system suspended. Suspended time easily sums into hours and days
rendering human readable timestamps in dmesg useless.

Adjusting timestamps accouring to current delta between boottime and
monotonic clocksources produces accurate timestamps for messages printed
since last resume. Which are supposed to be most interesting.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 include/monotonic.h |    2 ++
 lib/monotonic.c     |   12 ++++++++++++
 sys-utils/dmesg.1   |    2 ++
 sys-utils/dmesg.c   |   22 +++++++++++++++++-----
 4 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/include/monotonic.h b/include/monotonic.h
index 7a69d9e4b51e..380e59c3791e 100644
--- a/include/monotonic.h
+++ b/include/monotonic.h
@@ -15,6 +15,8 @@
 
 extern int get_boot_time(struct timeval *boot_time);
 
+extern time_t get_suspended_time(void);
+
 extern int gettime_monotonic(struct timeval *tv);
 
 #endif /* UTIL_LINUX_MONOTONIC_H */
diff --git a/lib/monotonic.c b/lib/monotonic.c
index b684d8dd650a..f0aeba6828e7 100644
--- a/lib/monotonic.c
+++ b/lib/monotonic.c
@@ -48,6 +48,18 @@ int get_boot_time(struct timeval *boot_time)
 #endif
 }
 
+time_t get_suspended_time(void)
+{
+#if defined(CLOCK_BOOTTIME) && defined(CLOCK_MONOTONIC)
+	struct timespec boot, mono;
+
+	if (clock_gettime(CLOCK_BOOTTIME, &boot) == 0 &&
+	    clock_gettime(CLOCK_MONOTONIC, &mono) == 0)
+		return boot.tv_sec - mono.tv_sec;
+#endif
+	return 0;
+}
+
 int gettime_monotonic(struct timeval *tv)
 {
 #ifdef CLOCK_MONOTONIC
diff --git a/sys-utils/dmesg.1 b/sys-utils/dmesg.1
index 61a6ce89465d..6c5773a6b211 100644
--- a/sys-utils/dmesg.1
+++ b/sys-utils/dmesg.1
@@ -161,6 +161,8 @@ source used for the logs is
 .B not updated after
 system
 .BR SUSPEND / RESUME .
+Timestamps are adjusted according to current delta between boottime and monotonic
+clocks, this works only for messages printed after last resume.
 .IP "\fB\-t\fR, \fB\-\-notime\fR"
 Do not print kernel's timestamps.
 .IP "\fB\-\-time\-format\fR \fIformat\fR"
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index ae1ebc74a2d9..c78f01ca8755 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -169,6 +169,7 @@ struct dmesg_control {
 	struct timeval	lasttime;	/* last printed timestamp */
 	struct tm	lasttm;		/* last localtime */
 	struct timeval	boot_time;	/* system boot time */
+	time_t		suspended_time;	/* time spent in suspeneded state */
 
 	int		action;		/* SYSLOG_ACTION_* */
 	int		method;		/* DMESG_METHOD_* */
@@ -824,7 +825,7 @@ static struct tm *record_localtime(struct dmesg_control *ctl,
 				   struct dmesg_record *rec,
 				   struct tm *tm)
 {
-	time_t t = ctl->boot_time.tv_sec + rec->tv.tv_sec;
+	time_t t = ctl->boot_time.tv_sec + ctl->suspended_time + rec->tv.tv_sec;
 	return localtime_r(&t, tm);
 }
 
@@ -852,7 +853,7 @@ static char *iso_8601_time(struct dmesg_control *ctl, struct dmesg_record *rec,
 			   char *buf, size_t bufsz)
 {
 	struct timeval tv = {
-		.tv_sec = ctl->boot_time.tv_sec + rec->tv.tv_sec,
+		.tv_sec = ctl->boot_time.tv_sec + ctl->suspended_time + rec->tv.tv_sec,
 		.tv_usec = rec->tv.tv_usec
 	};
 
@@ -1301,8 +1302,16 @@ static inline int dmesg_get_boot_time(struct timeval *tv)
 
 	return get_boot_time(tv);
 }
+
+static inline time_t dmesg_get_suspended_time(void)
+{
+	if (getenv("DMESG_TEST_BOOTIME"))
+		return 0;
+	return get_suspended_time();
+}
 #else
 # define dmesg_get_boot_time	get_boot_time
+# define dmesg_get_suspended_time	get_suspended_time
 #endif
 
 int main(int argc, char *argv[])
@@ -1499,9 +1508,12 @@ int main(int argc, char *argv[])
 
 	if ((is_timefmt(&ctl, RELTIME) ||
 	     is_timefmt(&ctl, CTIME)   ||
-	     is_timefmt(&ctl, ISO8601))
-	    && dmesg_get_boot_time(&ctl.boot_time) != 0)
-		ctl.time_fmt = DMESG_TIMEFTM_NONE;
+	     is_timefmt(&ctl, ISO8601))) {
+		if (dmesg_get_boot_time(&ctl.boot_time) != 0)
+			ctl.time_fmt = DMESG_TIMEFTM_NONE;
+		else
+			ctl.suspended_time = dmesg_get_suspended_time();
+	}
 
 	if (delta)
 		switch (ctl.time_fmt) {

