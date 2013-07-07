Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f54.google.com ([74.125.83.54]:45838 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab3GGTzM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:55:12 -0400
Received: by mail-ee0-f54.google.com with SMTP id t10so2403109eei.27
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:10 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/34] text-utils: use unlocked io
Date: Sun,  7 Jul 2013 20:54:20 +0100
Message-Id: <1373226889-3451-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/col.c    | 1 +
 text-utils/colcrt.c | 1 +
 text-utils/colrm.c  | 1 +
 text-utils/column.c | 1 +
 text-utils/more.c   | 1 +
 text-utils/pg.c     | 1 +
 text-utils/rev.c    | 1 +
 text-utils/tailf.c  | 1 +
 text-utils/ul.c     | 1 +
 9 files changed, 9 insertions(+)

diff --git a/text-utils/col.c b/text-utils/col.c
index 9aa6a41..a18d45f 100644
--- a/text-utils/col.c
+++ b/text-utils/col.c
@@ -52,6 +52,7 @@
 #include <unistd.h>
 #include <getopt.h>
 
+#include "unlocked-io.h"
 #include "nls.h"
 #include "xalloc.h"
 #include "widechar.h"
diff --git a/text-utils/colcrt.c b/text-utils/colcrt.c
index 6c7f636..72115fb 100644
--- a/text-utils/colcrt.c
+++ b/text-utils/colcrt.c
@@ -45,6 +45,7 @@
 #include <getopt.h>
 #include "nls.h"
 
+#include "unlocked-io.h"
 #include "widechar.h"
 #include "c.h"
 #include "closestream.h"
diff --git a/text-utils/colrm.c b/text-utils/colrm.c
index 454085e..5bdc7f5 100644
--- a/text-utils/colrm.c
+++ b/text-utils/colrm.c
@@ -48,6 +48,7 @@
 #include "strutils.h"
 #include "c.h"
 #include "closestream.h"
+#include "unlocked-io.h"
 
 /*
 COLRM removes unwanted columns from a file
diff --git a/text-utils/column.c b/text-utils/column.c
index e29ea47..ee9fdd7 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -49,6 +49,7 @@
 #include <errno.h>
 #include <getopt.h>
 
+#include "unlocked-io.h"
 #include "nls.h"
 #include "widechar.h"
 #include "c.h"
diff --git a/text-utils/more.c b/text-utils/more.c
index 66de2bf..bdc5bf9 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -65,6 +65,7 @@
 #include "xalloc.h"
 #include "widechar.h"
 #include "closestream.h"
+#include "unlocked-io.h"
 
 #include <regex.h>
 
diff --git a/text-utils/pg.c b/text-utils/pg.c
index 7b61e6b..30a47c8 100644
--- a/text-utils/pg.c
+++ b/text-utils/pg.c
@@ -65,6 +65,7 @@
 #include "all-io.h"
 #include "closestream.h"
 #include "strutils.h"
+#include "unlocked-io.h"
 
 #define	READBUF		LINE_MAX	/* size of input buffer */
 #define CMDBUF		255		/* size of command buffer */
diff --git a/text-utils/rev.c b/text-utils/rev.c
index 1c44036..13249de 100644
--- a/text-utils/rev.c
+++ b/text-utils/rev.c
@@ -63,6 +63,7 @@
 #include "widechar.h"
 #include "c.h"
 #include "closestream.h"
+#include "unlocked-io.h"
 
 wchar_t *buf;
 
diff --git a/text-utils/tailf.c b/text-utils/tailf.c
index 2f611a4..c673bbf 100644
--- a/text-utils/tailf.c
+++ b/text-utils/tailf.c
@@ -45,6 +45,7 @@
 #include "strutils.h"
 #include "c.h"
 #include "closestream.h"
+#include "unlocked-io.h"
 
 #define DEFAULT_LINES  10
 
diff --git a/text-utils/ul.c b/text-utils/ul.c
index 7b50ede..c2c19f6 100644
--- a/text-utils/ul.c
+++ b/text-utils/ul.c
@@ -55,6 +55,7 @@
 #include "widechar.h"
 #include "c.h"
 #include "closestream.h"
+#include "unlocked-io.h"
 
 #ifdef HAVE_WIDECHAR
 /* Output an ASCII character as a wide character */
-- 
1.8.3.2

