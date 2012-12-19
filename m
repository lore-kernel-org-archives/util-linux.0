Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:34468 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060Ab2LSO2s (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 19 Dec 2012 09:28:48 -0500
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 0EAAFA5213
	for <util-linux@vger.kernel.org>; Wed, 19 Dec 2012 15:28:47 +0100 (CET)
From: Werner Fink <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: Werner Fink <werner@suse.de>
Subject: [PATCH] Move struct chardata and init_chardata to ttyutils
Date: Wed, 19 Dec 2012 15:28:41 +0100
Message-Id: <1355927321-31673-1-git-send-email-werner@suse.de>
In-Reply-To: <20121219132917.GA26228@boole.suse.de>
References: <20121219132917.GA26228@boole.suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

this one moves the struct chardata and init_chardata to include/ttyutils.h
as well as to lib/include/ttyutils.c.  Also the macros CTL/CTRL are fixed
in agetty.c and sulogin.c to use the XOR variant CTL.

Signed-off-by: Werner Fink <werner@suse.de>
---
 include/consoles.h    |    9 ++-------
 include/ttyutils.h    |   50 +++++++++++++++++++++++++++++++++++++++++++++++--
 lib/consoles.c        |    8 +-------
 lib/ttyutils.c        |   28 +++++++++++++++++++++++++++
 login-utils/sulogin.c |    4 ----
 term-utils/agetty.c   |   34 ---------------------------------
 6 files changed, 79 insertions(+), 54 deletions(-)

diff --git include/consoles.h include/consoles.h
index 2544263..5d87156 100644
--- include/consoles.h
+++ include/consoles.h
@@ -26,14 +26,9 @@
 #include <stdint.h>
 #include <stdio.h>
 #include <termios.h>
-#include <list.h>
+#include "list.h"
+#include "ttyutils.h"
 
-struct chardata {
-	uint8_t	erase;
-	uint8_t kill;
-	uint8_t eol;
-	uint8_t parity;
-};
 struct console {
 	struct list_head entry;
 	char *tty;
diff --git include/ttyutils.h include/ttyutils.h
index 93e8934..75d48c7 100644
--- include/ttyutils.h
+++ include/ttyutils.h
@@ -1,3 +1,23 @@
+/*
+ * ttyutils.h       Header file for routines to detect and initialize
+ *                  terminal lines
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *  
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program (see the file COPYING); if not, write to the
+ * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ *
+ */
 #ifndef UTIL_LINUX_TTYUTILS_H
 #define UTIL_LINUX_TTYUTILS_H
 
@@ -8,6 +28,34 @@
 #include <sys/ioctl.h>
 #endif
 
+/* Some shorthands for control characters. */
+#define CTL(x)		((x) ^ 0100)	/* Assumes ASCII dialect */
+#define CR		CTL('M')	/* carriage return */
+#define NL		CTL('J')	/* line feed */
+#define BS		CTL('H')	/* back space */
+#define DEL		CTL('?')	/* delete */
+
+/* Defaults for line-editing etc. characters; you may want to change these. */
+#define DEF_ERASE	DEL		/* default erase character */
+#define DEF_INTR	CTL('C')	/* default interrupt character */
+#define DEF_QUIT	CTL('\\')	/* default quit char */
+#define DEF_KILL	CTL('U')	^/* default kill char */
+#define DEF_EOF		CTL('D')	/* default EOF char */
+#define DEF_EOL		0
+#define DEF_SWITCH	0		/* default switch char */
+
+/* Storage for things detected while the login name was read. */
+struct chardata {
+	int erase;		/* erase character */
+	int kill;		/* kill character */
+	int eol;		/* end-of-line character */
+	int parity;		/* what parity did we see */
+	int capslock;		/* upper case without lower case */
+};
+
+/* Initial values for the above. */
+extern const struct chardata init_chardata;
+
 extern int get_terminal_width(void);
 extern int get_terminal_name(const char **path, const char **name, const char **number);
 
@@ -82,6 +130,4 @@ static inline void reset_virtual_console(struct termios *tp, int flags)
 	tp->c_cc[VEOL2]    = _POSIX_VDISABLE;
 }
 
-
-
 #endif /* UTIL_LINUX_TTYUTILS_H */
diff --git lib/consoles.c lib/consoles.c
index 7175a08..75fb082 100644
--- lib/consoles.c
+++ lib/consoles.c
@@ -277,12 +277,6 @@ __attribute__((__nonnull__,__hot__))
 #endif
 int append_console(struct list_head *consoles, const char *name)
 {
-	static const struct chardata initcp = {
-		.erase	= CERASE,
-		.kill	= CKILL,
-		.eol	= CTRL('r'),
-		.parity = 0
-	};
 	struct console *restrict tail;
 	struct console *last = NULL;
 
@@ -307,7 +301,7 @@ int append_console(struct list_head *consoles, const char *name)
 	tail->id = last ? last->id + 1 : 0;
 	tail->pid = 0;
 	memset(&tail->tio, 0, sizeof(tail->tio));
-	memcpy(&tail->cp, &initcp, sizeof(struct chardata));
+	tail->cp = init_chardata;
 
 	return 0;
 }
diff --git lib/ttyutils.c lib/ttyutils.c
index 15d5389..b9236fa 100644
--- lib/ttyutils.c
+++ lib/ttyutils.c
@@ -1,9 +1,37 @@
+/*
+ * ttyutils.c       Common routines to detect/initialize terminal lines
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program (see the file COPYING); if not, write to the
+ * Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
+ * MA 02110-1301, USA.
+ *
+ */
 
 #include <ctype.h>
 
 #include "c.h"
 #include "ttyutils.h"
 
+/* Initial values for the above. */
+static const struct chardata init_chardata = {
+	DEF_ERASE,		/* default erase character */
+	DEF_KILL,		/* default kill character */
+	13,			/* default eol char */
+	0,			/* space parity */
+	0,			/* no capslock */
+};
+
 int get_terminal_width(void)
 {
 #ifdef TIOCGSIZE
diff --git login-utils/sulogin.c login-utils/sulogin.c
index 810168d..14a865c 100644
--- login-utils/sulogin.c
+++ login-utils/sulogin.c
@@ -58,10 +58,6 @@
 #include "consoles.h"
 #define CONMAX		16
 
-#define BS		CTRL('h')
-#define NL		CTRL('j')
-#define CR		CTRL('m')
-
 static unsigned int timeout;
 static int profile;
 static volatile uint32_t openfd;		/* Remember higher file descriptors */
diff --git term-utils/agetty.c term-utils/agetty.c
index 5df150a..cc1a9ab 100644
--- term-utils/agetty.c
+++ term-utils/agetty.c
@@ -106,22 +106,6 @@
 #define LOGIN		"login: "
 #define LOGIN_ARGV_MAX	16		/* Numbers of args for login */
 
-/* Some shorthands for control characters. */
-#define CTL(x)		(x ^ 0100)	/* Assumes ASCII dialect */
-#define	CR		CTL('M')	/* carriage return */
-#define	NL		CTL('J')	/* line feed */
-#define	BS		CTL('H')	/* back space */
-#define	DEL		CTL('?')	/* delete */
-
-/* Defaults for line-editing etc. characters; you may want to change these. */
-#define DEF_ERASE	DEL		/* default erase character */
-#define DEF_INTR	CTL('C')	/* default interrupt character */
-#define DEF_QUIT	CTL('\\')	/* default quit char */
-#define DEF_KILL	CTL('U')	/* default kill char */
-#define DEF_EOF		CTL('D')	/* default EOF char */
-#define DEF_EOL		0
-#define DEF_SWITCH	0		/* default switch char */
-
 /*
  * When multiple baud rates are specified on the command line, the first one
  * we will try is the first one specified.
@@ -178,24 +162,6 @@ struct options {
 #define serial_tty_option(opt, flag)	\
 	(((opt)->flags & (F_VCONSOLE|(flag))) == (flag))
 
-/* Storage for things detected while the login name was read. */
-struct chardata {
-	int erase;		/* erase character */
-	int kill;		/* kill character */
-	int eol;		/* end-of-line character */
-	int parity;		/* what parity did we see */
-	int capslock;		/* upper case without lower case */
-};
-
-/* Initial values for the above. */
-static const struct chardata init_chardata = {
-	DEF_ERASE,		/* default erase character */
-	DEF_KILL,		/* default kill character */
-	13,			/* default eol char */
-	0,			/* space parity */
-	0,			/* no capslock */
-};
-
 struct Speedtab {
 	long speed;
 	speed_t code;
-- 
1.7.9.2

