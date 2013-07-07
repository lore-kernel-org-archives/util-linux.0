Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f174.google.com ([209.85.215.174]:40839 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab3GGTzO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:55:14 -0400
Received: by mail-ea0-f174.google.com with SMTP id o10so2486536eaj.5
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:13 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/34] misc-utils: use unlocked io
Date: Sun,  7 Jul 2013 20:54:21 +0100
Message-Id: <1373226889-3451-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c     | 1 +
 misc-utils/findfs.c  | 1 +
 misc-utils/findmnt.c | 1 +
 misc-utils/getopt.c  | 1 +
 misc-utils/look.c    | 1 +
 misc-utils/lsblk.c   | 1 +
 misc-utils/lslocks.c | 1 +
 misc-utils/mcookie.c | 1 +
 misc-utils/namei.c   | 1 +
 misc-utils/uuidgen.c | 1 +
 misc-utils/whereis.c | 1 +
 11 files changed, 11 insertions(+)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index c4ed1d1..b46af3a 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -72,6 +72,7 @@
 #include "nls.h"
 #include "mbsalign.h"
 #include "strutils.h"
+#include "unlocked-io.h"
 
 #if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW)
 # ifdef HAVE_NCURSES_H
diff --git a/misc-utils/findfs.c b/misc-utils/findfs.c
index bc4a843..e3e6e68 100644
--- a/misc-utils/findfs.c
+++ b/misc-utils/findfs.c
@@ -14,6 +14,7 @@
 #include "nls.h"
 #include "closestream.h"
 #include "c.h"
+#include "unlocked-io.h"
 
 static void __attribute__((__noreturn__)) usage(int rc)
 {
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 8ccceda..1febde0 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -46,6 +46,7 @@
 #include "xalloc.h"
 #include "optutils.h"
 #include "mangle.h"
+#include "unlocked-io.h"
 
 /* flags */
 enum {
diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index 7630173..9ef7c79 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -60,6 +60,7 @@
 
 #include "closestream.h"
 #include "nls.h"
+#include "unlocked-io.h"
 #include "xalloc.h"
 
 /* NON_OPT is the code that is returned when a non-option is found in '+'
diff --git a/misc-utils/look.c b/misc-utils/look.c
index 502168b..22b1381 100644
--- a/misc-utils/look.c
+++ b/misc-utils/look.c
@@ -61,6 +61,7 @@
 #include "xalloc.h"
 #include "pathnames.h"
 #include "closestream.h"
+#include "unlocked-io.h"
 
 #define	EQUAL		0
 #define	GREATER		1
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 494bc73..3eaaa40 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -61,6 +61,7 @@
 #include "closestream.h"
 #include "mangle.h"
 #include "optutils.h"
+#include "unlocked-io.h"
 
 /* column IDs */
 enum {
diff --git a/misc-utils/lslocks.c b/misc-utils/lslocks.c
index de3094a..b30a56c 100644
--- a/misc-utils/lslocks.c
+++ b/misc-utils/lslocks.c
@@ -43,6 +43,7 @@
 #include "strutils.h"
 #include "c.h"
 #include "closestream.h"
+#include "unlocked-io.h"
 
 /* column IDs */
 enum {
diff --git a/misc-utils/mcookie.c b/misc-utils/mcookie.c
index da641a1..a505fd2 100644
--- a/misc-utils/mcookie.c
+++ b/misc-utils/mcookie.c
@@ -22,6 +22,7 @@
 #include "md5.h"
 #include "nls.h"
 #include "closestream.h"
+#include "unlocked-io.h"
 
 #include <fcntl.h>
 #include <getopt.h>
diff --git a/misc-utils/namei.c b/misc-utils/namei.c
index a9c8301..6ce0d6e 100644
--- a/misc-utils/namei.c
+++ b/misc-utils/namei.c
@@ -38,6 +38,7 @@
 #include "widechar.h"
 #include "strutils.h"
 #include "closestream.h"
+#include "unlocked-io.h"
 
 #ifndef MAXSYMLINKS
 #define MAXSYMLINKS 256
diff --git a/misc-utils/uuidgen.c b/misc-utils/uuidgen.c
index 450e26a..2dd829d 100644
--- a/misc-utils/uuidgen.c
+++ b/misc-utils/uuidgen.c
@@ -25,6 +25,7 @@ extern int optind;
 #include "nls.h"
 #include "c.h"
 #include "closestream.h"
+#include "unlocked-io.h"
 
 #define DO_TYPE_TIME	1
 #define DO_TYPE_RANDOM	2
diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index ba83b15..8f0fa9e 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -54,6 +54,7 @@
 #include "c.h"
 #include "closestream.h"
 #include "canonicalize.h"
+#include "unlocked-io.h"
 
 /*#define DEBUG*/
 
-- 
1.8.3.2

