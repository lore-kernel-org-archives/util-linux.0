Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBC51E48A
	for <util-linux@vger.kernel.org>; Mon,  9 Dec 2024 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743027; cv=none; b=jBHD+zmXokUQMPXIm5fg/tYINpGzbfTgEWDz03I48wc/SqPCl1ABdjAUK8yKdHI/iRb8J/i4vWJctRB6/kl0mxFP+QJTzPciy4uD2ekEyn39Zol+UnXx+KMKRfjtG4xTvVQu0mtz3jpGx0NDMK481Dy4Q5PgWwt3oRhQZWzMCfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743027; c=relaxed/simple;
	bh=ezSvliyisu417rdydbHr60m8hLfCkxLv5kURAdTZI/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vkmb21UhiFb1ipTR4pEbhcUdLIF3dSXhPpDWe6aGHm/MGCSwp8w4dJxWtpPrUXAvFunqIa854LfvQ/u9+UADhfzfIqaBJ30QGadXmY4olCRLkFbd7gw1sSpgIG5OsnYfENV48Foj7TPViMzXSZc8SYDUbr6z8czp5NYBLnmhvNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OBvFOfyI; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OBvFOfyI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=SrP8N
	iE7RGg1uvgETebHTVPG4PwaR6fDzSVQ0pDaGqE=; b=OBvFOfyIFtnHS1rakTuqy
	eBXzmvTddQE9CYq0HVFnL8g5Z7n0wGZzxqArcJ7cw+rUCT2XCtv6yXi36a2ibpdM
	w/3eDVd2ETw4GjXCDmDNjBU6CS1zVNNi1Y6TL82Bl03v4AnWnbpxG1l9OkZncVVe
	9TFRsR+EJ+LaQPuaj+caW4=
Received: from chenw.lan (unknown [121.12.217.185])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXved70VZnvs01FA--.21898S2;
	Mon, 09 Dec 2024 19:16:30 +0800 (CST)
From: Zhaoming Luo <zhmingluo@163.com>
To: util-linux@vger.kernel.org
Cc: bug-hurd@gnu.org,
	kzak@redhat.com,
	Zhaoming Luo <zhmingluo@163.com>
Subject: [PATCH v2] hwclock: Support GNU Hurd
Date: Mon,  9 Dec 2024 19:16:11 +0800
Message-ID: <20241209111611.370398-1-zhmingluo@163.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXved70VZnvs01FA--.21898S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFyxZF4Duw18CrWfCFWkCrg_yoWrZr1UpF
	4UCF4YyFW8Kr1agF97KF1kGFnrX348GrW3CFy7Cr9rtFy7Xr18XF4kJF9ayryYqrZ3Za98
	Cr17Gry5CF4DCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUb18gUUUUU=
X-CM-SenderInfo: p2kpx0pjox0qqrwthudrp/1tbiRRqwLGdWzg92xQAAsA

* configure.ac: add HURD so it can be used in conditional in am files
* sys-utils/Makemodule.am: compile hwclock for GNU Hurd
* sys-utils/hwclock-rtc.c: compile for GNU Hurd
* sys-utils/hwclock.c: compile for GNU Hurd
* sys-utils/hwclock.h: compile for GNU Hurd

Signed-off-by: Zhaoming Luo <zhmingluo@163.com>
---
 configure.ac            |  6 +++++-
 sys-utils/Makemodule.am |  5 +++++
 sys-utils/hwclock-rtc.c | 19 ++++++++++++++++++-
 sys-utils/hwclock.c     |  2 +-
 sys-utils/hwclock.h     |  4 +++-
 5 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 698da36c6..8de6af616 100644
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
index 209b656b0..8cc69be60 100644
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
index 2796f2e8a..7acf09d43 100644
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
@@ -99,12 +106,20 @@ static int open_rtc(const struct hwclock_control *ctl)
 	/* --rtc option has been given */
 	if (ctl->rtc_dev_name) {
 		rtc_dev_name = ctl->rtc_dev_name;
+#ifdef __GNU__
+		rtc_dev_fd = open(rtc_dev_name, O_RDWR);
+#else
 		rtc_dev_fd = open(rtc_dev_name, O_RDONLY);
+#endif
 	} else {
 		for (i = 0; i < ARRAY_SIZE(fls); i++) {
 			if (ctl->verbose)
 				printf(_("Trying to open: %s\n"), fls[i]);
+#ifdef __GNU__
+			rtc_dev_fd = open(fls[i], O_RDWR);
+#else
 			rtc_dev_fd = open(fls[i], O_RDONLY);
+#endif
 
 			if (rtc_dev_fd < 0) {
 				if (errno == ENOENT || errno == ENODEV)
@@ -411,6 +426,7 @@ int set_epoch_rtc(const struct hwclock_control *ctl)
 
 
 
+#ifndef __GNU__
 static int resolve_rtc_param_alias(const char *alias, __u64 *value)
 {
 	const struct hwclock_param *param = &hwclock_params[0];
@@ -609,3 +625,4 @@ int rtc_vl_clear(const struct hwclock_control *ctl)
 
 	return 0;
 }
+#endif /* __GNU__ */
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 2b33dfbce..2714775f9 100644
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
index 2522d6c7d..4cbbff957 100644
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
2.47.1

