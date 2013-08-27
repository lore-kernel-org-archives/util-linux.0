Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f176.google.com ([209.85.215.176]:41604 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab3H0SHH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Aug 2013 14:07:07 -0400
Received: by mail-ea0-f176.google.com with SMTP id q16so2450764ead.35
        for <util-linux@vger.kernel.org>; Tue, 27 Aug 2013 11:07:06 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Lennart Poettering <lennart@poettering.net>
Subject: [PATCH 10/17] lib/time-util: copy time parsing functions from systemd
Date: Tue, 27 Aug 2013 19:06:12 +0100
Message-Id: <1377626779-26030-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The functions are copied nearly as-is.  Coding style has been modified to
match with util-linux project, while the functionality remains untouched.

CC: Lennart Poettering <lennart@poettering.net>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/Makemodule.am |   1 +
 include/time-util.h   |  55 +++++++
 lib/Makemodule.am     |   1 +
 lib/time-util.c       | 388 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 445 insertions(+)
 create mode 100644 include/time-util.h
 create mode 100644 lib/time-util.c

diff --git a/include/Makemodule.am b/include/Makemodule.am
index 7ba4593..33276e1 100644
--- a/include/Makemodule.am
+++ b/include/Makemodule.am
@@ -40,6 +40,7 @@ dist_noinst_HEADERS += \
 	include/swapheader.h \
 	include/sysfs.h \
 	include/timer.h \
+	include/time-util.h
 	include/tt.h \
 	include/ttyutils.h \
 	include/wholedisk.h \
diff --git a/include/time-util.h b/include/time-util.h
new file mode 100644
index 0000000..bcae613
--- /dev/null
+++ b/include/time-util.h
@@ -0,0 +1,55 @@
+/***
+  First set of functions in this file are part of systemd, and were
+  copied to util-linux at August 2013.
+
+  Copyright 2010 Lennart Poettering
+
+  systemd is free software; you can redistribute it and/or modify it
+  under the terms of the GNU Lesser General Public License as published by
+  the Free Software Foundation; either version 2.1 of the License, or
+  (at your option) any later version.
+
+  systemd is distributed in the hope that it will be useful, but
+  WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+  Lesser General Public License for more details.
+
+  You should have received a copy of the GNU Lesser General Public License
+  along with systemd; If not, see <http://www.gnu.org/licenses/>.
+***/
+#ifndef UTIL_LINUX_TIME_UTIL_H
+#define UTIL_LINUX_TIME_UTIL_H
+
+#include <stdio.h>
+#include <inttypes.h>
+
+typedef uint64_t usec_t;
+typedef uint64_t nsec_t;
+
+#define MSEC_PER_SEC  1000ULL
+#define USEC_PER_SEC  1000000ULL
+#define USEC_PER_MSEC 1000ULL
+#define NSEC_PER_SEC  1000000000ULL
+#define NSEC_PER_MSEC 1000000ULL
+#define NSEC_PER_USEC 1000ULL
+
+#define USEC_PER_MINUTE	(60ULL*USEC_PER_SEC)
+#define NSEC_PER_MINUTE	(60ULL*NSEC_PER_SEC)
+#define USEC_PER_HOUR	(60ULL*USEC_PER_MINUTE)
+#define NSEC_PER_HOUR	(60ULL*NSEC_PER_MINUTE)
+#define USEC_PER_DAY	(24ULL*USEC_PER_HOUR)
+#define NSEC_PER_DAY	(24ULL*NSEC_PER_HOUR)
+#define USEC_PER_WEEK	(7ULL*USEC_PER_DAY)
+#define NSEC_PER_WEEK	(7ULL*NSEC_PER_DAY)
+#define USEC_PER_MONTH	(2629800ULL*USEC_PER_SEC)
+#define NSEC_PER_MONTH	(2629800ULL*NSEC_PER_SEC)
+#define USEC_PER_YEAR	(31557600ULL*USEC_PER_SEC)
+#define NSEC_PER_YEAR	(31557600ULL*NSEC_PER_SEC)
+
+#define FORMAT_TIMESTAMP_MAX ((4*4+1)+11+9+4+1)	/* weekdays can be unicode */
+#define FORMAT_TIMESTAMP_RELATIVE_MAX 256
+#define FORMAT_TIMESPAN_MAX 64
+
+int parse_timestamp(const char *t, usec_t *usec);
+
+#endif /* UTIL_LINUX_TIME_UTIL_H */
diff --git a/lib/Makemodule.am b/lib/Makemodule.am
index 6c3a1b0..32d46ba 100644
--- a/lib/Makemodule.am
+++ b/lib/Makemodule.am
@@ -23,6 +23,7 @@ libcommon_la_SOURCES = \
 	lib/sysfs.c \
 	lib/tt.c \
 	lib/wholedisk.c \
+	lib/time-util.c \
 	lib/ttyutils.c \
 	lib/xgetpass.c \
 	lib/exec_shell.c
diff --git a/lib/time-util.c b/lib/time-util.c
new file mode 100644
index 0000000..c8fcc2a
--- /dev/null
+++ b/lib/time-util.c
@@ -0,0 +1,388 @@
+/***
+  First set of functions in this file are part of systemd, and were
+  copied to util-linux at August 2013.
+
+  Copyright 2010 Lennart Poettering
+
+  systemd is free software; you can redistribute it and/or modify it
+  under the terms of the GNU Lesser General Public License as published by
+  the Free Software Foundation; either version 2.1 of the License, or
+  (at your option) any later version.
+
+  systemd is distributed in the hope that it will be useful, but
+  WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+  Lesser General Public License for more details.
+
+  You should have received a copy of the GNU Lesser General Public License
+  along with util-linux; If not, see <http://www.gnu.org/licenses/>.
+***/
+
+#include <assert.h>
+#include <ctype.h>
+#include <string.h>
+#include <time.h>
+
+#include "c.h"
+#include "time-util.h"
+
+#define WHITESPACE " \t\n\r"
+
+#define streq(a,b) (strcmp((a),(b)) == 0)
+
+static char *startswith(const char *s, const char *prefix)
+{
+	const char *a, *b;
+
+	assert(s);
+	assert(prefix);
+
+	a = s, b = prefix;
+	for (;;) {
+		if (*b == 0)
+			return (char *)a;
+		if (*a != *b)
+			return NULL;
+
+		a++, b++;
+	}
+}
+
+static char *startswith_no_case(const char *s, const char *prefix)
+{
+	const char *a, *b;
+
+	assert(s);
+	assert(prefix);
+
+	a = s, b = prefix;
+	for (;;) {
+		if (*b == 0)
+			return (char *)a;
+		if (tolower(*a) != tolower(*b))
+			return NULL;
+
+		a++, b++;
+	}
+}
+
+static char *endswith(const char *s, const char *postfix)
+{
+	size_t sl, pl;
+
+	assert(s);
+	assert(postfix);
+
+	sl = strlen(s);
+	pl = strlen(postfix);
+
+	if (pl == 0)
+		return (char *)s + sl;
+
+	if (sl < pl)
+		return NULL;
+
+	if (memcmp(s + sl - pl, postfix, pl) != 0)
+		return NULL;
+
+	return (char *)s + sl - pl;
+}
+
+static int parse_sec(const char *t, usec_t *usec)
+{
+	 static const struct {
+		const char *suffix;
+		usec_t usec;
+	 } table[] = {
+		{ "seconds",	USEC_PER_SEC },
+		{ "second",	USEC_PER_SEC },
+		{ "sec",	USEC_PER_SEC },
+		{ "s",		USEC_PER_SEC },
+		{ "minutes",	USEC_PER_MINUTE },
+		{ "minute",	USEC_PER_MINUTE },
+		{ "min",	USEC_PER_MINUTE },
+		{ "months",	USEC_PER_MONTH },
+		{ "month",	USEC_PER_MONTH },
+		{ "msec",	USEC_PER_MSEC },
+		{ "ms",		USEC_PER_MSEC },
+		{ "m",		USEC_PER_MINUTE },
+		{ "hours",	USEC_PER_HOUR },
+		{ "hour",	USEC_PER_HOUR },
+		{ "hr",		USEC_PER_HOUR },
+		{ "h",		USEC_PER_HOUR },
+		{ "days",	USEC_PER_DAY },
+		{ "day",	USEC_PER_DAY },
+		{ "d",		USEC_PER_DAY },
+		{ "weeks",	USEC_PER_WEEK },
+		{ "week",	USEC_PER_WEEK },
+		{ "w",		USEC_PER_WEEK },
+		{ "years",	USEC_PER_YEAR },
+		{ "year",	USEC_PER_YEAR },
+		{ "y",		USEC_PER_YEAR },
+		{ "usec",	1ULL },
+		{ "us",		1ULL },
+		{ "",		USEC_PER_SEC },	/* default is sec */
+	 };
+
+	const char *p;
+	usec_t r = 0;
+	int something = FALSE;
+
+	assert(t);
+	assert(usec);
+
+	p = t;
+	for (;;) {
+		long long l, z = 0;
+		char *e;
+		unsigned i, n = 0;
+
+		p += strspn(p, WHITESPACE);
+
+		if (*p == 0) {
+			if (!something)
+				return -EINVAL;
+
+			break;
+		}
+
+		errno = 0;
+		l = strtoll(p, &e, 10);
+
+		if (errno > 0)
+			return -errno;
+
+		if (l < 0)
+			return -ERANGE;
+
+		if (*e == '.') {
+			char *b = e + 1;
+
+			errno = 0;
+			z = strtoll(b, &e, 10);
+			if (errno > 0)
+				return -errno;
+
+			if (z < 0)
+				return -ERANGE;
+
+			if (e == b)
+				return -EINVAL;
+
+			n = e - b;
+
+		} else if (e == p)
+			return -EINVAL;
+
+		e += strspn(e, WHITESPACE);
+
+		for (i = 0; i < ARRAY_SIZE(table); i++)
+			if (startswith(e, table[i].suffix)) {
+				usec_t k = (usec_t) z * table[i].usec;
+
+				for (; n > 0; n--)
+					k /= 10;
+
+				r += (usec_t) l *table[i].usec + k;
+				p = e + strlen(table[i].suffix);
+
+				something = TRUE;
+				break;
+			}
+
+		if (i >= ARRAY_SIZE(table))
+			return -EINVAL;
+
+	}
+
+	*usec = r;
+
+	return 0;
+}
+
+int parse_timestamp(const char *t, usec_t *usec)
+{
+	 static const struct {
+		const char *name;
+		const int nr;
+	 } day_nr[] = {
+		{ "Sunday",	0 },
+		{ "Sun",	0 },
+		{ "Monday",	1 },
+		{ "Mon",	1 },
+		{ "Tuesday",	2 },
+		{ "Tue",	2 },
+		{ "Wednesday",	3 },
+		{ "Wed",	3 },
+		{ "Thursday",	4 },
+		{ "Thu",	4 },
+		{ "Friday",	5 },
+		{ "Fri",	5 },
+		{ "Saturday",	6 },
+		{ "Sat",	6 },
+	 };
+
+	const char *k;
+	struct tm tm, copy;
+	time_t x;
+	usec_t plus = 0, minus = 0, ret;
+	int r, weekday = -1;
+	unsigned i;
+
+	/*
+	 * Allowed syntaxes:
+	 *
+	 *   2012-09-22 16:34:22
+	 *   2012-09-22 16:34	  (seconds will be set to 0)
+	 *   2012-09-22		  (time will be set to 00:00:00)
+	 *   16:34:22		  (date will be set to today)
+	 *   16:34		  (date will be set to today, seconds to 0)
+	 *   now
+	 *   yesterday		  (time is set to 00:00:00)
+	 *   today		  (time is set to 00:00:00)
+	 *   tomorrow		  (time is set to 00:00:00)
+	 *   +5min
+	 *   -5days
+	 *
+	 */
+
+	assert(t);
+	assert(usec);
+
+	x = time(NULL);
+	localtime_r(&x, &tm);
+	tm.tm_isdst = -1;
+
+	if (streq(t, "now"))
+		goto finish;
+
+	else if (streq(t, "today")) {
+		tm.tm_sec = tm.tm_min = tm.tm_hour = 0;
+		goto finish;
+
+	} else if (streq(t, "yesterday")) {
+		tm.tm_mday--;
+		tm.tm_sec = tm.tm_min = tm.tm_hour = 0;
+		goto finish;
+
+	} else if (streq(t, "tomorrow")) {
+		tm.tm_mday++;
+		tm.tm_sec = tm.tm_min = tm.tm_hour = 0;
+		goto finish;
+
+	} else if (t[0] == '+') {
+
+		r = parse_sec(t + 1, &plus);
+		if (r < 0)
+			return r;
+
+		goto finish;
+	} else if (t[0] == '-') {
+
+		r = parse_sec(t + 1, &minus);
+		if (r < 0)
+			return r;
+
+		goto finish;
+
+	} else if (endswith(t, " ago")) {
+		char *z;
+
+		z = strndup(t, strlen(t) - 4);
+		if (!z)
+			return -ENOMEM;
+
+		r = parse_sec(z, &minus);
+		if (r < 0)
+			return r;
+
+		goto finish;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(day_nr); i++) {
+		size_t skip;
+
+		if (!startswith_no_case(t, day_nr[i].name))
+			continue;
+
+		skip = strlen(day_nr[i].name);
+		if (t[skip] != ' ')
+			continue;
+
+		weekday = day_nr[i].nr;
+		t += skip + 1;
+		break;
+	}
+
+	copy = tm;
+	k = strptime(t, "%y-%m-%d %H:%M:%S", &tm);
+	if (k && *k == 0)
+		goto finish;
+
+	tm = copy;
+	k = strptime(t, "%Y-%m-%d %H:%M:%S", &tm);
+	if (k && *k == 0)
+		goto finish;
+
+	tm = copy;
+	k = strptime(t, "%y-%m-%d %H:%M", &tm);
+	if (k && *k == 0) {
+		tm.tm_sec = 0;
+		goto finish;
+	}
+
+	tm = copy;
+	k = strptime(t, "%Y-%m-%d %H:%M", &tm);
+	if (k && *k == 0) {
+		tm.tm_sec = 0;
+		goto finish;
+	}
+
+	tm = copy;
+	k = strptime(t, "%y-%m-%d", &tm);
+	if (k && *k == 0) {
+		tm.tm_sec = tm.tm_min = tm.tm_hour = 0;
+		goto finish;
+	}
+
+	tm = copy;
+	k = strptime(t, "%Y-%m-%d", &tm);
+	if (k && *k == 0) {
+		tm.tm_sec = tm.tm_min = tm.tm_hour = 0;
+		goto finish;
+	}
+
+	tm = copy;
+	k = strptime(t, "%H:%M:%S", &tm);
+	if (k && *k == 0)
+		goto finish;
+
+	tm = copy;
+	k = strptime(t, "%H:%M", &tm);
+	if (k && *k == 0) {
+		tm.tm_sec = 0;
+		goto finish;
+	}
+
+	return -EINVAL;
+
+ finish:
+	x = mktime(&tm);
+	if (x == (time_t)-1)
+		return -EINVAL;
+
+	if (weekday >= 0 && tm.tm_wday != weekday)
+		return -EINVAL;
+
+	ret = (usec_t) x *USEC_PER_SEC;
+
+	ret += plus;
+	if (ret > minus)
+		ret -= minus;
+	else
+		ret = 0;
+
+	*usec = ret;
+
+	return 0;
+}
-- 
1.8.4

