Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.9]:59020 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981Ab2E2RKG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 29 May 2012 13:10:06 -0400
Message-ID: <4FC502EB.70301@bernhard-voelker.de>
Date: Tue, 29 May 2012 19:10:03 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] Fix typos in comments and wall's man page
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


>From 08fa804da02c17f4cdb9bd89ea23c02b63afbd77 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Tue, 29 May 2012 19:06:50 +0200
Subject: [PATCH] Fix typos in comments and wall's man page

Culprits identified again by (newer) misspellings:

  $ git ls-files | misspellings -f - | grep -v '^po/'

* wall: Fix typo in man page.
* Fix typos in source code comments.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 libmount/src/context_mount.c |    2 +-
 term-utils/setterm.c         |    2 +-
 term-utils/wall.1            |    2 +-
 text-utils/more.c            |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index 3f0001d..2642768 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -613,7 +613,7 @@ int mnt_context_prepare_mount(struct libmnt_context *cxt)
  * Note that this function could be called only once. If you want to mount
  * another source or target than you have to call mnt_reset_context().
  *
- * If you want to call mount(2) for the same source and target with a diffrent
+ * If you want to call mount(2) for the same source and target with a different
  * mount flags or fstype then call mnt_context_reset_status() and then try
  * again mnt_context_do_mount().
  *
diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 5a65293..3083ac8 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -68,7 +68,7 @@
  * Semantics:
  *
  * Setterm writes to standard output a character string that will
- * invoke the specified terminal capabilities.  Where possibile
+ * invoke the specified terminal capabilities.  Where possible
  * terminfo is consulted to find the string to use.  Some options
  * however do not correspond to a terminfo capability.  In this case if
  * the terminal type is "con*", or "linux*" the string that invokes
diff --git a/term-utils/wall.1 b/term-utils/wall.1
index 56fa413..88e816c 100644
--- a/term-utils/wall.1
+++ b/term-utils/wall.1
@@ -56,7 +56,7 @@ program is suid or sgid.
 .SH OPTIONS
 .TP
 \fB\-n\fR, \fB\-\-nobanner\fR
-Supress banner
+Suppress banner
 .TP
 \fB\-t\fR, \fB\-\-timeout\fR \fItimeout\fR
 Write
diff --git a/text-utils/more.c b/text-utils/more.c
index d7d9322..7f78cdd 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -846,7 +846,7 @@ int get_line(register FILE *f, int *length)
     mbstate_t state, state_bak;		/* Current status of the stream. */
     char mbc[MB_LEN_MAX];		/* Buffer for one multibyte char. */
     size_t mblength;			/* Byte length of multibyte char. */
-    size_t mbc_pos = 0;			/* Postion of the MBC. */
+    size_t mbc_pos = 0;			/* Position of the MBC. */
     int use_mbc_buffer_flag = 0;	/* If 1, mbc has data. */
     int break_flag = 0;			/* If 1, exit while(). */
     long file_pos_bak = Ftell (f);
-- 
1.7.7

