Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qg0-f50.google.com ([209.85.192.50]:48742 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbaLHUaS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Dec 2014 15:30:18 -0500
Received: by mail-qg0-f50.google.com with SMTP id i50so4011119qgf.23
        for <util-linux@vger.kernel.org>; Mon, 08 Dec 2014 12:30:17 -0800 (PST)
From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Subject: [PATCH] buildsys: hwclock requires -lm
Date: Mon,  8 Dec 2014 17:30:10 -0300
Message-Id: <1418070610-265347-1-git-send-email-crrodriguez@opensuse.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

hwclock uses fabs and therefore needs libm, otherwise a linking
error ocurrs when building with -fno-builtin.
---
 sys-utils/Makemodule.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 25e1ad7..ef793c1 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -370,7 +370,7 @@ hwclock_SOURCES = \
 if LINUX
 hwclock_SOURCES += sys-utils/hwclock-rtc.c
 endif
-hwclock_LDADD = $(LDADD) libcommon.la
+hwclock_LDADD = $(LDADD) libcommon.la -lm
 if HAVE_AUDIT
 hwclock_LDADD += -laudit
 endif
-- 
2.2.0

