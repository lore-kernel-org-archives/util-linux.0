Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:52494 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbaI1Twb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:52:31 -0400
Received: by mail-wi0-f180.google.com with SMTP id q5so2053888wiv.13
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:52:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/23] libuuid: remove _SVID_SOURCE pre-processor definition
Date: Sun, 28 Sep 2014 20:51:42 +0100
Message-Id: <1411933916-30576-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The _SVID_SOURCE is deprecated.

In file included from /usr/include/stdio.h:27:0,
                 from libuuid/src/gen_uuid.c:46: /usr/include/features.h:148:3:
		      warning: #warning "_BSD_SOURCE and _SVID_SOURCE are
		      deprecated, use _DEFAULT_SOURCE" [-Wcpp]

Notice that the Makefile.am has

AM_CPPFLAGS = \
        -include config.h \

that enforces the config.h is included before any other hearer.  In the
configure.ac there is AC_USE_SYSTEM_EXTENSIONS that makes all possible
features that can be supported in a system are turned on.  With these two
there is absolutely no need for any legacy _SOURCE definitions.

Reference: https://sourceware.org/git/gitweb.cgi?p=glibc.git;a=commit;h=c941736c92fa3a319221f65f6755659b2a5e0a20
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libuuid/src/gen_uuid.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 387518a..eb79339 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -32,12 +32,6 @@
  * %End-Header%
  */
 
-/*
- * Force inclusion of SVID stuff since we need it if we're compiling in
- * gcc-wall wall mode
- */
-#define _SVID_SOURCE
-
 #ifdef _WIN32
 #define _WIN32_WINNT 0x0500
 #include <windows.h>
-- 
2.1.1

