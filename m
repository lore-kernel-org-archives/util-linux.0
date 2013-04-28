Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34607 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab3D1RLP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Apr 2013 13:11:15 -0400
Received: by mail-wi0-f171.google.com with SMTP id l13so2052701wie.10
        for <util-linux@vger.kernel.org>; Sun, 28 Apr 2013 10:11:14 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/11] cal: fix preprocessor directive indendation
Date: Sun, 28 Apr 2013 18:10:57 +0100
Message-Id: <1367169067-23705-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And code within the blocks selected by preprocessor to be live code.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 81 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 39 insertions(+), 42 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 276148d..13830de 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -73,69 +73,66 @@
 #include "strutils.h"
 
 #if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW)
-
-#ifdef HAVE_NCURSES_H
-#include <ncurses.h>
-#elif defined(HAVE_NCURSES_NCURSES_H)
-#include <ncurses/ncurses.h>
-#endif
-
-#include <term.h>                       /* include after <curses.h> */
-
-static void
-my_setupterm(const char *term, int fildes, int *errret) {
-    setupterm((char*)term, fildes, errret);
+# ifdef HAVE_NCURSES_H
+#  include <ncurses.h>
+# elif defined(HAVE_NCURSES_NCURSES_H)
+#  include <ncurses/ncurses.h>
+# endif
+# include <term.h>
+
+static void my_setupterm(const char *term, int fildes, int *errret)
+{
+	setupterm((char *)term, fildes, errret);
 }
 
-static void
-my_putstring(char *s) {
-     putp(s);
+static void my_putstring(char *s)
+{
+	putp(s);
 }
 
-static const char *
-my_tgetstr(char *s __attribute__ ((__unused__)), char *ss) {
-    const char* ret = tigetstr(ss);
-    if (!ret || ret==(char*)-1)
-	return "";
-    else
-	return ret;
+static const char *my_tgetstr(char *s __attribute__((__unused__)), char *ss)
+{
+	const char *ret = tigetstr(ss);
+	if (!ret || ret == (char *)-1)
+		return "";
+	else
+		return ret;
 }
 
 #elif defined(HAVE_LIBTERMCAP)
-
-#include <termcap.h>
+# include <termcap.h>
 
 char termbuffer[4096];
 char tcbuffer[4096];
 char *strbuf = termbuffer;
 
-static void
-my_setupterm(const char *term, int fildes, int *errret) {
-    *errret = tgetent(tcbuffer, term);
+static void my_setupterm(const char *term, int fildes, int *errret)
+{
+	*errret = tgetent(tcbuffer, term);
 }
 
-static void
-my_putstring(char *s) {
-     tputs (s, 1, putchar);
+static void my_putstring(char *s)
+{
+	tputs(s, 1, putchar);
 }
 
-static const char *
-my_tgetstr(char *s, char *ss __attribute__ ((__unused__))) {
-    const char* ret = tgetstr(s, &strbuf);
-    if (!ret)
-	return "";
-    else
-	return ret;
+static const char *my_tgetstr(char *s, char *ss __attribute__((__unused__)))
+{
+	const char *ret = tgetstr(s, &strbuf);
+	if (!ret)
+		return "";
+	else
+		return ret;
 }
 
-#else /* ! (HAVE_LIBTERMCAP || HAVE_LIBNCURSES || HAVE_LIBNCURSESW) */
+#else	/* ! (HAVE_LIBTERMCAP || HAVE_LIBNCURSES || HAVE_LIBNCURSESW) */
 
-static void
-my_putstring(char *s) {
-     fputs(s, stdout);
+static void my_putstring(char *s)
+{
+	fputs(s, stdout);
 }
 
-#endif
+#endif	/* end of LIBTERMCAP / NCURSES */
 
 
 const char	*term="";
-- 
1.8.2.2

