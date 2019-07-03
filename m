Return-Path: <SRS0=+2nm=VA=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76891C0650E
	for <util-linux@archiver.kernel.org>; Wed,  3 Jul 2019 16:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5D02187F
	for <util-linux@archiver.kernel.org>; Wed,  3 Jul 2019 16:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsJbTTBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfGCQbv (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:31:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37598 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCQbv (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 3 Jul 2019 12:31:51 -0400
Received: by mail-qt1-f194.google.com with SMTP id y57so2067669qtk.4
        for <util-linux@vger.kernel.org>; Wed, 03 Jul 2019 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QYIdgjwnXltlpeWM4NJVBeaZ6B4bkl4STe/5MLJGMfc=;
        b=hsJbTTBXZF6kdKemRLwY41ZK1A8yait5cJowncihzt+0wPBNRwTmG84g1a8RdkT90o
         49K+CP9AoDcVvsodi5O5uBty3DZp+3haRJ/IL48xeCJ/dPqM/fE1OJAg6u4BURW3UmNe
         7qdSOQ1ueZo6x+KSGaQVKFtSYBQ8mq/sbVC0Y/n4Aa+j0LVVkrpXgXOaZKiNstVqZiHY
         bnewqcc2mc4v/Yo3W+lCtoGe+lxfy3u12gjTuu/hl7UA4+ToGRnG1p5XoPAMnnlSPA72
         aBzrRuvtVIHPpkGQKQqVe3XqtvPLuYqlr8HTFGJghAzZWKXf79AUD6W8z+nQWflDoJpt
         G5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QYIdgjwnXltlpeWM4NJVBeaZ6B4bkl4STe/5MLJGMfc=;
        b=JVvHOgIubNZtUSalH9E8DqVweGVeY5v0AaQg2GlZ+0+9lV18P/Jl8SER7uv12Fqh04
         RxykDpH+7DCsK5irLQlgfR7isUSRIC/6eBiEN5qfs61Yo70keAfjdY9RvkXV1OYO8AVT
         vRWuDrL2fd2jHh6SMOb7Da9q2w3u0l0s+7o4SkjcEI5wgYd362dpteVhmxxdSqEo6miB
         DtsG2+S2oLF71pES7Ck3cImW21gwD8Xg/g0jU9ZbjCGthJLLns9PPdZT/zeb8M4SUc2P
         UP2sb4N5G2k9VTxRDfhwnOctQ0wlHuXvovyxICSFMqCUAEXYdw74hmtn9JGBa0njljOg
         yznw==
X-Gm-Message-State: APjAAAXzhKfNGpTVfJeLbJctWlzydAc14UVB97EV7rWwp+w4RHSO6O/k
        MuHTiEMCTW6iYO8EDW1Vodw78FFyRMo=
X-Google-Smtp-Source: APXvYqy+fBV8G5f2wX5zbyEXtbG0hzUY5B4d3aJryfPF9fGLAjWjQln4nvWIuS4YeVpD7MRs1kbsjg==
X-Received: by 2002:ac8:4a10:: with SMTP id x16mr31374798qtq.282.1562171509843;
        Wed, 03 Jul 2019 09:31:49 -0700 (PDT)
Received: from casantos.remote.csb (201.86.240.146.dynamic.adsl.gvt.net.br. [201.86.240.146])
        by smtp.gmail.com with ESMTPSA id h18sm1033081qkj.134.2019.07.03.09.31.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 09:31:49 -0700 (PDT)
From:   unixmania@gmail.com
To:     util-linux@vger.kernel.org
Cc:     Carlos Santos <unixmania@gmail.com>
Subject: [PATCH v2] hwclock: use CMOS clock only if available
Date:   Wed,  3 Jul 2019 13:31:34 -0300
Message-Id: <20190703163134.26083-1-unixmania@gmail.com>
X-Mailer: git-send-email 2.18.1
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Carlos Santos <unixmania@gmail.com>

- Add --disable-hwclock-cmos configuration argument
- Add USE_HWCLOCK_CMOS (enabled by default for i386/x86_64)
- Add define(USE_HWCLOCK_CMOS)
- Compile hwclock-cmos.c only if USE_HWCLOCK_CMOS is true
- Remove all unnecessary #ifdefs from hwclock-cmos.c
- Add #ifdef USE_HWCLOCK_CMOS around the determine_clock_access_method()
  call in hwclock.c

Signed-off-by: Carlos Santos <unixmania@gmail.com>
---
TODO: find a way to check the architecture in configure.ac and set
USE_HWCLOCK_CMOS to true inly if it's i386/x86_64.
---
 configure.ac             | 13 +++++++++++
 sys-utils/Makemodule.am  |  7 ++++--
 sys-utils/hwclock-cmos.c | 47 +++++-----------------------------------
 sys-utils/hwclock.c      |  2 ++
 4 files changed, 26 insertions(+), 43 deletions(-)

diff --git a/configure.ac b/configure.ac
index a840e20ee..f5b9d4a4e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1516,6 +1516,19 @@ UL_REQUIRES_HAVE([hwclock], [io, linuxdummy], [ioperm iopl function or Linux])
 AM_CONDITIONAL([BUILD_HWCLOCK], [test "x$build_hwclock" = xyes])
 
 
+AC_ARG_ENABLE([hwclock-cmos],
+  AS_HELP_STRING([--disable-hwclock-cmos], [do not use CMOS clock]),
+  [], [use_hwclock_cmos="$build_hwclock"]
+)
+
+AS_IF([test "x$use_hwclock_cmos" = xyes], [
+  AM_CONDITIONAL([USE_HWCLOCK_CMOS], [true])
+  AC_DEFINE([USE_HWCLOCK_CMOS], [1], [Define to 1 if want to use CMOS clock.])
+],[
+  AM_CONDITIONAL([USE_HWCLOCK_CMOS], [false])
+])
+
+
 UL_BUILD_INIT([mkfs], [yes])
 AM_CONDITIONAL([BUILD_MKFS], [test "x$build_mkfs" = xyes])
 
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 7c118a6de..98e2cc29b 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -451,9 +451,12 @@ dist_man_MANS += \
 PATHFILES += sys-utils/hwclock.8
 hwclock_SOURCES = \
 	sys-utils/hwclock.c \
-	sys-utils/hwclock.h \
-	sys-utils/hwclock-cmos.c
+	sys-utils/hwclock.h
 hwclock_LDADD = $(LDADD) libcommon.la -lm
+if USE_HWCLOCK_CMOS
+hwclock_SOURCES += \
+	sys-utils/hwclock-cmos.c
+endif
 if LINUX
 hwclock_SOURCES += \
 	sys-utils/hwclock-rtc.c \
diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
index a11f676b8..4d3e023d9 100644
--- a/sys-utils/hwclock-cmos.c
+++ b/sys-utils/hwclock-cmos.c
@@ -56,37 +56,13 @@
 #include "pathnames.h"
 
 /* for inb, outb */
-#if defined(__i386__) || defined(__x86_64__)
-# ifdef HAVE_SYS_IO_H
-#  include <sys/io.h>
-# elif defined(HAVE_ASM_IO_H)
-#  include <asm/io.h>
-# else
-#  undef __i386__
-#  undef __x86_64__
-#  warning "disable cmos access - no sys/io.h or asm/io.h"
-static void outb(int a __attribute__((__unused__)),
-		 int b __attribute__((__unused__)))
-{
-}
-
-static int inb(int c __attribute__((__unused__)))
-{
-	return 0;
-}
-# endif				/* __i386__ __x86_64__ */
+#ifdef HAVE_SYS_IO_H
+# include <sys/io.h>
+#elif defined(HAVE_ASM_IO_H)
+# include <asm/io.h>
 #else
-# warning "disable cmos access - not i386 or x86_64"
-static void outb(int a __attribute__((__unused__)),
-		 int b __attribute__((__unused__)))
-{
-}
-
-static int inb(int c __attribute__((__unused__)))
-{
-	return 0;
-}
-#endif				/* for inb, outb */
+# error "no sys/io.h or asm/io.h"
+#endif	/* HAVE_SYS_IO_H, HAVE_ASM_IO_H */
 
 #include "hwclock.h"
 
@@ -360,7 +336,6 @@ static int set_hardware_clock_cmos(const struct hwclock_control *ctl
 	return 0;
 }
 
-#if defined(__i386__) || defined(__x86_64__)
 # if defined(HAVE_IOPL)
 static int i386_iopl(const int level)
 {
@@ -373,12 +348,6 @@ static int i386_iopl(const int level __attribute__ ((__unused__)))
 	return ioperm(clock_ctl_addr, 2, 1);
 }
 # endif
-#else
-static int i386_iopl(const int level __attribute__ ((__unused__)))
-{
-	return IOPL_NOT_IMPLEMENTED;
-}
-#endif
 
 static int get_permissions_cmos(void)
 {
@@ -412,9 +381,5 @@ static struct clock_ops cmos_interface = {
  */
 struct clock_ops *probe_for_cmos_clock(void)
 {
-#if defined(__i386__) || defined(__x86_64__)
 	return &cmos_interface;
-#else
-	return NULL;
-#endif
 }
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index a2c5cc2a4..c01a86826 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -925,8 +925,10 @@ static void determine_clock_access_method(const struct hwclock_control *ctl)
 {
 	ur = NULL;
 
+#ifdef USE_HWCLOCK_CMOS
 	if (ctl->directisa)
 		ur = probe_for_cmos_clock();
+#endif
 #ifdef __linux__
 	if (!ur)
 		ur = probe_for_rtc_clock(ctl);
-- 
2.18.1

