Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33285 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbcDTVR6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 20 Apr 2016 17:17:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id r12so5916678wme.0
        for <util-linux@vger.kernel.org>; Wed, 20 Apr 2016 14:17:57 -0700 (PDT)
Received: from teapot (120.112.208.46.dyn.plus.net. [46.208.112.120])
        by smtp.gmail.com with ESMTPSA id u3sm11463207wmg.15.2016.04.20.14.17.55
        for <util-linux@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Apr 2016 14:17:56 -0700 (PDT)
From: Earnestly <zibeon@googlemail.com>
Date: Wed, 20 Apr 2016 22:17:55 +0100
To: util-linux@vger.kernel.org
Subject: [PATCH] Remove AC_CONFIG_AUX_DIR
Message-ID: <20160420211755.GD17469@teapot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Likewise in cloog[0] and check[1], using autoreconf -i (or autogen.sh) results
in ./configure failing with:

    configure.ac:137: error: required file 'config/ltmain.sh' not found

This commit simply removes this AUX_DIR which lets the ./configure phase
complete successfully.

0: https://groups.google.com/forum/?hl=en#!topic/cloog-development/28_M3Qk87-Q
1: https://github.com/libcheck/check/pull/36

Signed-off-by: Earnestly <zibeon@gmail.com>
---
 configure.ac | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 5a00403..9325691 100644
--- a/configure.ac
+++ b/configure.ac
@@ -6,7 +6,6 @@ AC_INIT([util-linux],
 
 AC_PREREQ([2.60])
 
-AC_CONFIG_AUX_DIR([config])
 AC_CONFIG_MACRO_DIR([m4])
 dnl AC_USE_SYSTEM_EXTENSIONS must be called before any macros that run
 dnl the compiler (like AC_PROG_LIBTOOL) to avoid autoconf errors.
-- 
2.8.0

