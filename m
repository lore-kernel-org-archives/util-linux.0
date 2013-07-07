Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f50.google.com ([74.125.83.50]:41668 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab3GGTzE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:55:04 -0400
Received: by mail-ee0-f50.google.com with SMTP id d49so2365039eek.37
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:03 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/34] include: copy unlocked-io.h from gnulib
Date: Sun,  7 Jul 2013 20:54:18 +0100
Message-Id: <1373226889-3451-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

At the moment util-linux command are not threading, which means they can
safely use thread-unsafe IO system calls which should make printing
quicker.

References: http://marc.info/?l=util-linux-ng&m=137266928927642&w=3
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac          |  13 +++++
 include/Makemodule.am |   1 +
 include/unlocked-io.h | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)
 create mode 100644 include/unlocked-io.h

diff --git a/configure.ac b/configure.ac
index 398aaf0..4cb87f9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -308,10 +308,21 @@ AC_CHECK_FUNCS([ \
 	__fpending \
 	secure_getenv \
 	__secure_getenv \
+	clearerr_unlocked \
 	err \
 	errx \
+	feof_unlocked \
+	ferror_unlocked \
+	fflush_unlocked \
+	fgets_unlocked \
+	fputc_unlocked \
+	fputs_unlocked \
+	fread_unlocked \
 	fsync \
 	futimens \
+	fwrite_unlocked \
+	getc_unlocked \
+	getchar_unlocked \
 	getdomainname \
 	getdtablesize \
 	getexecname \
@@ -327,6 +338,8 @@ AC_CHECK_FUNCS([ \
 	personality \
 	posix_fadvise \
 	prctl \
+	putc_unlocked \
+	putchar_unlocked \
 	rpmatch \
 	scandirat \
 	setresgid \
diff --git a/include/Makemodule.am b/include/Makemodule.am
index 7ba4593..6d0fd8a 100644
--- a/include/Makemodule.am
+++ b/include/Makemodule.am
@@ -42,6 +42,7 @@ dist_noinst_HEADERS += \
 	include/timer.h \
 	include/tt.h \
 	include/ttyutils.h \
+	include/unlocked-io.h \
 	include/wholedisk.h \
 	include/widechar.h \
 	include/xalloc.h \
diff --git a/include/unlocked-io.h b/include/unlocked-io.h
new file mode 100644
index 0000000..90bc849
--- /dev/null
+++ b/include/unlocked-io.h
@@ -0,0 +1,136 @@
+/* Prefer faster, non-thread-safe stdio functions if available.
+
+   Copyright (C) 2001-2004, 2009-2013 Free Software Foundation, Inc.
+
+   This program is free software: you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 3 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
+
+/* Written by Jim Meyering.  */
+
+#ifndef UNLOCKED_IO_H
+# define UNLOCKED_IO_H 1
+
+/* These are wrappers for functions/macros from the GNU C library, and
+   from other C libraries supporting POSIX's optional thread-safe functions.
+
+   The standard I/O functions are thread-safe.  These *_unlocked ones are
+   more efficient but not thread-safe.  That they're not thread-safe is
+   fine since all of the applications in this package are single threaded.
+
+   Also, some code that is shared with the GNU C library may invoke
+   the *_unlocked functions directly.  On hosts that lack those
+   functions, invoke the non-thread-safe versions instead.  */
+
+# include <stdio.h>
+
+# if HAVE_CLEARERR_UNLOCKED
+#  undef clearerr
+#  define clearerr(x) clearerr_unlocked (x)
+# else
+#  define clearerr_unlocked(x) clearerr (x)
+# endif
+
+# if HAVE_FEOF_UNLOCKED
+#  undef feof
+#  define feof(x) feof_unlocked (x)
+# else
+#  define feof_unlocked(x) feof (x)
+# endif
+
+# if HAVE_FERROR_UNLOCKED
+#  undef ferror
+#  define ferror(x) ferror_unlocked (x)
+# else
+#  define ferror_unlocked(x) ferror (x)
+# endif
+
+# if HAVE_FFLUSH_UNLOCKED
+#  undef fflush
+#  define fflush(x) fflush_unlocked (x)
+# else
+#  define fflush_unlocked(x) fflush (x)
+# endif
+
+# if HAVE_FGETS_UNLOCKED
+#  undef fgets
+#  define fgets(x,y,z) fgets_unlocked (x,y,z)
+# else
+#  define fgets_unlocked(x,y,z) fgets (x,y,z)
+# endif
+
+# if HAVE_FPUTC_UNLOCKED
+#  undef fputc
+#  define fputc(x,y) fputc_unlocked (x,y)
+# else
+#  define fputc_unlocked(x,y) fputc (x,y)
+# endif
+
+# if HAVE_FPUTS_UNLOCKED
+#  undef fputs
+#  define fputs(x,y) fputs_unlocked (x,y)
+# else
+#  define fputs_unlocked(x,y) fputs (x,y)
+# endif
+
+# if HAVE_FREAD_UNLOCKED
+#  undef fread
+#  define fread(w,x,y,z) fread_unlocked (w,x,y,z)
+# else
+#  define fread_unlocked(w,x,y,z) fread (w,x,y,z)
+# endif
+
+# if HAVE_FWRITE_UNLOCKED
+#  undef fwrite
+#  define fwrite(w,x,y,z) fwrite_unlocked (w,x,y,z)
+# else
+#  define fwrite_unlocked(w,x,y,z) fwrite (w,x,y,z)
+# endif
+
+# if HAVE_GETC_UNLOCKED
+#  undef getc
+#  define getc(x) getc_unlocked (x)
+# else
+#  define getc_unlocked(x) getc (x)
+# endif
+
+# if HAVE_GETCHAR_UNLOCKED
+#  undef getchar
+#  define getchar() getchar_unlocked ()
+# else
+#  define getchar_unlocked() getchar ()
+# endif
+
+# if HAVE_PUTC_UNLOCKED
+#  undef putc
+#  define putc(x,y) putc_unlocked (x,y)
+# else
+#  define putc_unlocked(x,y) putc (x,y)
+# endif
+
+# if HAVE_PUTCHAR_UNLOCKED
+#  undef putchar
+#  define putchar(x) putchar_unlocked (x)
+# else
+#  define putchar_unlocked(x) putchar (x)
+# endif
+
+# undef flockfile
+# define flockfile(x) ((void) 0)
+
+# undef ftrylockfile
+# define ftrylockfile(x) 0
+
+# undef funlockfile
+# define funlockfile(x) ((void) 0)
+
+#endif /* UNLOCKED_IO_H */
-- 
1.8.3.2

