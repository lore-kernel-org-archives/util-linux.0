Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33189 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964951Ab2B1Qpq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Feb 2012 11:45:46 -0500
Received: by mail-vw0-f46.google.com with SMTP id ff1so1997660vbb.19
        for <util-linux@vger.kernel.org>; Tue, 28 Feb 2012 08:45:45 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 11/13] sulogin: header/include cleanup
Date: Tue, 28 Feb 2012 11:45:19 -0500
Message-Id: <1330447521-886-12-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

- use our own crypt.h compile time check
- remove ttydefaults.h include -- get this via termios.h, the same as
  agetty

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 login-utils/sulogin.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 17ad044..f276a3e 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -39,10 +39,9 @@
 #include <pwd.h>
 #include <shadow.h>
 #include <termios.h>
-#include <sys/ttydefaults.h>
 #include <errno.h>
 #include <sys/ioctl.h>
-#if defined(__GLIBC__)
+#ifdef HAVE_CRYPT_H
 #  include <crypt.h>
 #endif
 
-- 
1.7.9.2

