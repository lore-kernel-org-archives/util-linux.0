Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:64350 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbcBZDIt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Feb 2016 22:08:49 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 13/14] build-sys: remove duplicate cal sources
Date: Fri, 26 Feb 2016 04:08:37 +0100
Message-Id: <1456456118-19584-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456456118-19584-1-git-send-email-sweet_f_a@gmx.de>
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
 <1456456118-19584-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

These extra sources should have been removed since cal is
linked against libcommon (see 7b353df2).

CC: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 misc-utils/Makemodule.am | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index aa54919..120aadf 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -1,15 +1,7 @@
 if BUILD_CAL
 usrbin_exec_PROGRAMS += cal
 dist_man_MANS += misc-utils/cal.1
-cal_SOURCES = \
-	misc-utils/cal.c \
-	lib/mbsalign.c \
-	lib/strutils.c
-
-if !HAVE_LANGINFO
-cal_SOURCES += lib/langinfo.c
-endif
-
+cal_SOURCES = misc-utils/cal.c
 cal_CFLAGS = $(AM_CFLAGS) $(NCURSES_CFLAGS)
 cal_LDADD = $(LDADD) libcommon.la libtcolors.la $(NCURSES_LIBS)
 endif # BUILD_CAL
-- 
1.8.4.5

