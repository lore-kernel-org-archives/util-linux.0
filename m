Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34674 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbcEORbE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 May 2016 13:31:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so13474525wmn.1
        for <util-linux@vger.kernel.org>; Sun, 15 May 2016 10:31:03 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 01/11] lib: add timestamp helpers to libcommon.la
Date: Sun, 15 May 2016 18:30:47 +0100
Message-Id: <1463333457-1011-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1463333457-1011-1-git-send-email-kerolasa@iki.fi>
References: <1463333457-1011-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The following programs have local timestamp creation facilities.  Aim is to
retire local implementations and share functions that will work for all
cases below.

login-utils/last.c
login-utils/lslogins.c
sys-utils/dmesg.c
sys-utils/lsipc.c

Notably misc-utils/logger.c is not in the list.  The logger(1) has pretty
special timestamp requirements, so it is best to keep it as-is.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/Makemodule.am |   1 +
 include/timestamps.h  |  20 ++++++++
 lib/Makemodule.am     |   1 +
 lib/timestamps.c      | 125 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 include/timestamps.h
 create mode 100644 lib/timestamps.c

diff --git a/include/Makemodule.am b/include/Makemodule.am
index d4ae10c..5c9a216 100644
--- a/include/Makemodule.am
+++ b/include/Makemodule.am
@@ -50,6 +50,7 @@ dist_noinst_HEADERS += \
 	include/swapprober.h \
 	include/sysfs.h \
 	include/timer.h \
+	include/timestamps.h \
 	include/timeutils.h \
 	include/ttyutils.h \
 	include/widechar.h \
diff --git a/include/timestamps.h b/include/timestamps.h
new file mode 100644
index 0000000..8fd006f
--- /dev/null
+++ b/include/timestamps.h
@@ -0,0 +1,20 @@
+#ifndef UTIL_LINUX_TIMESTAMPS
+#define UTIL_LINUX_TIMESTAMPS
+
+struct ul_time {
+	struct tm *tm;
+	long microseconds;
+	char *buf;
+	size_t bufsz;
+};
+
+int ul_timestamp_hours_minutes(const struct ul_time *t);
+int ul_timestamp_iso_full(const struct ul_time *t);
+int ul_timestamp_iso_ms(const struct ul_time *t);
+int ul_timestamp_iso_short(const struct ul_time *t);
+int ul_timestamp_ctime_full(const struct ul_time *t);
+int ul_timestamp_ctime_short_date(const struct ul_time *t, const char date,
+				  const char divider);
+int ul_timestamp_ctime_short(const struct ul_time *t);
+
+#endif /* UTIL_LINUX_TIMESTAMPS */
diff --git a/lib/Makemodule.am b/lib/Makemodule.am
index 092d54e..672c169 100644
--- a/lib/Makemodule.am
+++ b/lib/Makemodule.am
@@ -19,6 +19,7 @@ libcommon_la_SOURCES = \
 	lib/randutils.c \
 	lib/setproctitle.c \
 	lib/strutils.c \
+	lib/timestamps.c \
 	lib/timeutils.c \
 	lib/ttyutils.c \
 	lib/exec_shell.c \
diff --git a/lib/timestamps.c b/lib/timestamps.c
new file mode 100644
index 0000000..b8a59be
--- /dev/null
+++ b/lib/timestamps.c
@@ -0,0 +1,125 @@
+/*
+ * Copyright (C) 2016 Sami Kerola <kerolasa@iki.fi>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/time.h>
+#include <time.h>
+
+#include "timestamps.h"
+
+int ul_timestamp_hours_minutes(const struct ul_time *t)
+{
+	if (!strftime(t->buf, t->bufsz, "%H:%M", t->tm))
+		return -1;
+	return 0;
+}
+
+static int ul_timestamp_iso_internal(const struct ul_time *t,
+				     int add_microseconds)
+{
+	size_t len;
+
+	if (!strftime(t->buf, t->bufsz, "%Y-%m-%dT%H:%M:%S", t->tm))
+		return -1;
+	len = strlen(t->buf);
+	if (add_microseconds) {
+		snprintf(t->buf + len, t->bufsz - len, ",%06ld",
+			 t->microseconds);
+		len = strlen(t->buf);
+	}
+	if (!strftime(t->buf + len, t->bufsz - len, "%z", t->tm))
+		return -1;
+	return 0;
+}
+
+int ul_timestamp_iso_full(const struct ul_time *t)
+{
+	return ul_timestamp_iso_internal(t, 0);
+}
+
+int ul_timestamp_iso_ms(const struct ul_time *t)
+{
+	return ul_timestamp_iso_internal(t, 1);
+}
+
+int ul_timestamp_iso_short(const struct ul_time *t)
+{
+	if (!strftime(t->buf, t->bufsz, "%Y-%m-%d", t->tm))
+		return -1;
+	return 0;
+}
+
+int ul_timestamp_ctime_full(const struct ul_time *t)
+{
+	/* same format as asctime() without trailing \n */
+	static const char wday_name[7][4] = {
+		"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
+	};
+	static const char mon_name[12][4] = {
+		"Jan", "Feb", "Mar", "Apr", "May", "Jun",
+		"Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
+	};
+	size_t len;
+
+	len = snprintf(t->buf, t->bufsz, "%s %s ", wday_name[t->tm->tm_wday],
+		       mon_name[t->tm->tm_mon]);
+	if (!len)
+		return -1;
+	if (!strftime(t->buf + len, t->bufsz - len, "%e %T %Y", t->tm))
+		return -1;
+	return 0;
+}
+
+typedef enum {
+	DATE_IS_TODAY,
+	DATE_IS_THIS_YEAR,
+	DATE_IS_OLDER
+} ul_time_whence;
+
+static ul_time_whence date_is(const struct tm *tm)
+{
+	const time_t time = timelocal((struct tm *)tm);
+	struct timeval now;
+
+	gettimeofday(&now, NULL);
+	if ((time / (3600 * 24)) == (now.tv_sec / (3600 * 24)))
+		return DATE_IS_TODAY;
+	if ((time / (3600 * 24 * 365)) == (now.tv_sec / (3600 * 24 * 365)))
+		return DATE_IS_THIS_YEAR;
+	return DATE_IS_OLDER;
+}
+
+int ul_timestamp_ctime_short_date(const struct ul_time *t, const char date,
+				  const char divider)
+{
+	char fmt[11];
+
+	sprintf(fmt, "%%b%%%c%c%%H:%%M", date, divider);
+	if (!strftime(t->buf, t->bufsz, fmt, t->tm))
+		return -1;
+	return 0;
+}
+
+int ul_timestamp_ctime_short(const struct ul_time *t)
+{
+	switch (date_is(t->tm)) {
+	case DATE_IS_TODAY:
+		if (!strftime(t->buf, t->bufsz, "%T", t->tm))
+			return -1;
+		break;
+	case DATE_IS_THIS_YEAR:
+		ul_timestamp_ctime_short_date(t, 'd', '/');
+		break;
+	case DATE_IS_OLDER:
+		if (!strftime(t->buf, t->bufsz, "%Y-%b%d", t->tm))
+			return -1;
+		break;
+	default:
+		/* drop core when impossible happens */
+		abort();
+	}
+	return 0;
+}
-- 
2.8.2

