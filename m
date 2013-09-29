Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:38556 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111Ab3I2Eod (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 29 Sep 2013 00:44:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 57A9533EAE4
	for <util-linux@vger.kernel.org>; Sun, 29 Sep 2013 04:44:32 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] setterm: fix term.h/ncurses.h include ordering
Date: Sun, 29 Sep 2013 00:44:36 -0400
Message-Id: <1380429876-25146-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The ncurses term.h header has logic in it to detect if nucrses.h has
already been included and void defining things when it has.  But since
setterm includes term.h and the ncurses.h, it doesn't work and we can
get fun build-time warnings like:

  CC       term-utils/setterm-setterm.o
In file included from term-utils/setterm.c:109:0:
/usr/include/ncursesw/ncurses.h:827:12: warning: redundant redeclaration of 'tigetflag' [-Wredundant-decls]
 extern NCURSES_EXPORT(int) tigetflag (NCURSES_CONST char *);  /* implemented */
            ^
In file included from term-utils/setterm.c:106:0:
/usr/include/ncursesw/term.h:775:12: note: previous declaration of 'tigetflag' was here
 extern NCURSES_EXPORT(int) tigetflag (NCURSES_CONST char *);
            ^

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 term-utils/setterm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 310c3fa..d41e335 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -100,16 +100,17 @@
 #include <termios.h>
 #include <string.h>
 #include <fcntl.h>
+
 #ifndef NCURSES_CONST
 #define NCURSES_CONST const	/* define before including term.h */
 #endif
-#include <term.h>
-
 #ifdef HAVE_NCURSES_H
 #include <ncurses.h>
 #elif defined(HAVE_NCURSES_NCURSES_H)
 #include <ncurses/ncurses.h>
 #endif
+/* must include after ncurses.h */
+#include <term.h>
 
 #include <sys/param.h>		/* for MAXPATHLEN */
 #include <sys/ioctl.h>
-- 
1.8.3.2

