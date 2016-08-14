Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33222 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbcHNJdG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Aug 2016 05:33:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so5790644wme.0
        for <util-linux@vger.kernel.org>; Sun, 14 Aug 2016 02:33:05 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/3] pg: stop building the command by default
Date: Sun, 14 Aug 2016 08:24:06 +0100
Message-Id: <20160814072406.2991-3-kerolasa@iki.fi>
In-Reply-To: <20160814072406.2991-1-kerolasa@iki.fi>
References: <20160814072406.2991-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The pg command is marked deprecated in POSIX since 1997, and this project
has thought the same since Feb 2013.  Time has come to stop shipping this
binary by default.

Reference: 956e582874d3a28434018bf12057c745f74821de
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index f4d99f8..028ce90 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1804,8 +1804,8 @@ AM_CONDITIONAL([BUILD_MORE], [test "x$build_more" = xyes])
 
 
 AC_ARG_ENABLE([pg],
-  AS_HELP_STRING([--disable-pg], [do not build pg]),
-  [], [UL_DEFAULT_ENABLE([pg], [check])]
+  AS_HELP_STRING([--enable-pg], [build pg]),
+  [], [UL_DEFAULT_ENABLE([pg], [no])]
 )
 UL_BUILD_INIT([pg])
 UL_REQUIRES_HAVE([pg], [ncursesw, ncurses], [ncurses or ncursesw library])
-- 
2.9.3

