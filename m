Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8684C91
	for <util-linux@vger.kernel.org>; Mon,  9 Dec 2024 02:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733713126; cv=none; b=RTm2tgN7YzVyL4OwLphVlP+sOV1qUPUlBkDeTUHtUqZz9eD1U5Eph6WzMf5J6nluQKRp4N/VDD5jSOzZU5PTcPGVxBFZCkjcECrm6wPo8utcH6uF/y8ilO1q3jnn+REYfsuMLmgHOnnwdTwhDHeyb32GgulI1J/6Ooy0ZJL0ntM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733713126; c=relaxed/simple;
	bh=DHUptKZYFXYYLlpBSD7vMfShpdUZjZleAjie2cN4aW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z5WrYZ+61K7DQvPwZ0Gtd84jCjvDb9D/8Sk1hpzZx6KvUsNUH3rneEWAgCnVl5TFutylIDYmCQbtJHJWFEoGXTPQ4rNSY/+NrV2iM+AYrG8L2alHIokYolIsMxcLOXAx5eXlJ1GuzI2m+NwfdhCJQlgLfvg7PEHxTp4q9/plkCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g40IYEuk; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g40IYEuk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=E5pA4
	phgSOUls6UKvxltZBFGq8oIsFuNzUINq38mowA=; b=g40IYEuk+xVGPekMaNUjy
	ngGEB8StVjQUSS570Oc1rMXE1OIGTvP+5NDuNzjOqA7R0L9cxXwhPQMrvX5tbKts
	QhbBLdOuV6nv3hq2/3n9MrnrMghlUi1Q3EKQAmiJS1DqbP6XhjGqvio0Ht1WG+pI
	J57X7OMH53EFlHhV5k7oWk=
Received: from localhost.localdomain (unknown [121.12.217.185])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wA3XxPGXFZnhgl+Dw--.822S2;
	Mon, 09 Dec 2024 10:58:26 +0800 (CST)
From: Zhaoming Luo <zhmingluo@163.com>
To: util-linux@vger.kernel.org
Cc: bug-hurd@gnu.org,
	Zhaoming Luo <zhmingluo@163.com>
Subject: [PATCH] hwclock: Support GNU Hurd
Date: Mon,  9 Dec 2024 10:58:15 +0800
Message-ID: <20241209025815.7299-1-zhmingluo@163.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3XxPGXFZnhgl+Dw--.822S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF18Krykuw4rAF47Ww45Wrg_yoWrCry7pF
	4UCF4YyFW8Kr1agF97tFykKFn7G34UGrW3CFy7ur17tFy7Xr18XF4kJF9ayryYqrZ3ZayD
	ArnrGry5CF4DC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUFPfQUUUUU=
X-CM-SenderInfo: p2kpx0pjox0qqrwthudrp/1tbiEQewLGdWWz83OwAAsT

* configure.ac: add HURD so it can be used in conditional in am files
* sys-utils/Makemodule.am: compile hwclock for GNU Hurd
* sys-utils/hwclock-rtc.c: compile for GNU Hurd
* sys-utils/hwclock.c: compile for GNU Hurd
* sys-utils/hwclock.h: compile for GNU Hurd

Signed-off-by: Zhaoming Luo <zhmingluo@163.com>
---
 configure.ac            |  6 +++++-
 sys-utils/Makemodule.am |  5 +++++
 sys-utils/hwclock-rtc.c | 15 ++++++++++++---
 sys-utils/hwclock.c     |  2 +-
 sys-utils/hwclock.h     |  4 +++-
 5 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 698da36..8de6af6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -263,16 +263,20 @@ AC_PATH_PROG([XSLTPROC], [xsltproc])
 
 linux_os=no
 bsd_os=no
+gnu_os=no
 AS_CASE([${host_os}],
   [*linux*],
      [linux_os=yes],
   [*darwin*],
      [darwin_os=yes],
   [*bsd*],
-     [bsd_os=yes])
+     [bsd_os=yes],
+  [gnu*],
+     [gnu_os=yes])
 AM_CONDITIONAL([LINUX], [test "x$linux_os" = xyes])
 AM_CONDITIONAL([DARWIN], [test "x$darwin_os" = xyes])
 AM_CONDITIONAL([BSD], [test "x$bsd_os" = xyes])
+AM_CONDITIONAL([HURD], [test "x$gnu_os" = xyes])
 
 AS_IF([test  "x$darwin_os" = xyes], [
   AC_DEFINE([_DARWIN_C_SOURCE], [1], [Enable MAP_ANON in sys/mman.h on Mac OS X])
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 209b656..8cc69be 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -570,6 +570,11 @@ hwclock_SOURCES += \
 	lib/monotonic.c
 hwclock_LDADD += $(REALTIME_LIBS)
 endif
+if HURD
+hwclock_SOURCES += \
+	sys-utils/hwclock-rtc.c \
+	lib/monotonic.c
+endif
 if HAVE_AUDIT
 hwclock_LDADD += -laudit
 endif
diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index 2796f2e..7162ae9 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -8,10 +8,15 @@
  *
  * rtc.c - Use /dev/rtc for clock access
  */
+#ifdef __GNU__
+#include <sys/ioctl.h>
+#include <hurd/rtc.h>
+#else
 #include <asm/ioctl.h>
-#include <errno.h>
 #include <linux/rtc.h>
 #include <linux/types.h>
+#endif /* __GNU__ */
+#include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -28,6 +33,7 @@
 
 #include "hwclock.h"
 
+#ifndef __GNU__
 #ifndef RTC_PARAM_GET
 struct rtc_param {
 	__u64 param;
@@ -60,6 +66,7 @@ const struct hwclock_param *get_hwclock_params(void)
 {
 	return hwclock_params;
 }
+#endif /* __GNU__ */
 
 /*
  * /dev/rtc is conventionally chardev 10/135
@@ -99,12 +106,12 @@ static int open_rtc(const struct hwclock_control *ctl)
 	/* --rtc option has been given */
 	if (ctl->rtc_dev_name) {
 		rtc_dev_name = ctl->rtc_dev_name;
-		rtc_dev_fd = open(rtc_dev_name, O_RDONLY);
+		rtc_dev_fd = open(rtc_dev_name, O_RDWR);
 	} else {
 		for (i = 0; i < ARRAY_SIZE(fls); i++) {
 			if (ctl->verbose)
 				printf(_("Trying to open: %s\n"), fls[i]);
-			rtc_dev_fd = open(fls[i], O_RDONLY);
+			rtc_dev_fd = open(fls[i], O_RDWR);
 
 			if (rtc_dev_fd < 0) {
 				if (errno == ENOENT || errno == ENODEV)
@@ -411,6 +418,7 @@ int set_epoch_rtc(const struct hwclock_control *ctl)
 
 
 
+#ifndef __GNU__
 static int resolve_rtc_param_alias(const char *alias, __u64 *value)
 {
 	const struct hwclock_param *param = &hwclock_params[0];
@@ -609,3 +617,4 @@ int rtc_vl_clear(const struct hwclock_control *ctl)
 
 	return 0;
 }
+#endif /* __GNU__ */
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 2b33dfb..2714775 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -989,7 +989,7 @@ static void determine_clock_access_method(const struct hwclock_control *ctl)
 	if (ctl->directisa)
 		ur = probe_for_cmos_clock();
 #endif
-#ifdef __linux__
+#if defined(__linux__) || defined(__GNU__)
 	if (!ur)
 		ur = probe_for_rtc_clock(ctl);
 #endif
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index 2522d6c..4cbbff9 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -36,8 +36,10 @@ struct hwclock_control {
 #if defined(__linux__) && defined(__alpha__)
 	char *epoch_option;
 #endif
-#ifdef __linux__
+#if defined(__linux__) || defined(__GNU__)
 	char *rtc_dev_name;
+#endif
+#ifdef __linux__
 	uint32_t param_idx;	/* --param-index <n> */
 #endif
 	char *param_get_option;
-- 
2.45.2

