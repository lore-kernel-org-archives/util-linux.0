Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60722 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933322Ab1IJPHC convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 10 Sep 2011 11:07:02 -0400
Received: by qyk30 with SMTP id 30so829324qyk.19
        for <util-linux@vger.kernel.org>; Sat, 10 Sep 2011 08:07:01 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Sat, 10 Sep 2011 17:07:00 +0200
Message-ID: <CAG27Bk1tGhRf5yJaZfn7bR7ZQASmpomisUt-oATvBt223Hgn7A@mail.gmail.com>
Subject: [pull] build all and check with smatch
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

The first patch is about me being tired to write lots of --enable-* if
I want to try to compile all programs. The smatch(1) seems to give
valuable output where there might be problems in code. I went though
every warning and came to conclusion few of them are important enough
to fix. Would it make sense to add this tool to
Documentation/howto-compilation.txt which possibly should have
separated debugging section.

(1) http://smatch.sourceforge.net/

The following changes since commit 4e9b3bfda20ebbaf5d925dedad6ce8e2b678b563:

  lib,cpuset: fix compiler warning [-Wuninitialized] (2011-09-10 00:02:00 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit smatch

Sami Kerola (6):
      build-sys: add --enable-most-builds
      build-sys: ddate typo fixed
      column: fix error reported by smatch
      libblkid: fix smatch warning
      last: fix smatch warning
      kill: fix issue warned by smatch

 configure.ac         |   21 ++++++++++++++++++++-
 libblkid/src/probe.c |    2 +-
 login-utils/last.c   |    2 +-
 misc-utils/procs.c   |    3 ++-
 text-utils/column.c  |    3 ++-
 5 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index 94cced3..fb0b0eb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -347,6 +347,25 @@ AC_DEFUN([UTIL_RESTORE_FLAGS], [

 AX_CHECK_TLS

+AC_ARG_ENABLE([most-builds],
+  AS_HELP_STRING([--enable-most-builds], [build everthing other than
experimental code]),
+  [], enable_most_builds=no
+)
+if test "x$enable_most_builds" = xyes; then
+  enable_arch=yes
+  enable_ddate=yes
+  enable_elvtune=yes
+  enable_kill=yes
+  enable_last=yes
+  enable_line=yes
+  enable_mesg=yes
+  enable_raw=yes
+  enable_rename=yes
+  enable_reset=yes
+  enable_login_utils=yes
+  enable_write=yes
+fi
+
 AC_ARG_ENABLE([mount],
   AS_HELP_STRING([--disable-mount], [do not build mount utilities]),
   [], enable_mount=check
@@ -849,7 +868,7 @@ AM_CONDITIONAL(BUILD_ARCH, test "x$enable_arch" = xyes)

 AC_ARG_ENABLE([ddate],
   AS_HELP_STRING([--enable-ddate], [do build ddate]),
-  [], enable_date=no
+  [], enable_ddate=no
 )
 AM_CONDITIONAL(BUILD_DDATE, test "x$enable_ddate" = xyes)

diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 7d0c9f9..2902de9 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -795,7 +795,7 @@ int blkid_probe_get_idmag(blkid_probe pr, const
struct blkid_idinfo *id,
 		mag++;
 	}

-	if (id->magics && id->magics[0].magic)
+	if (id && id->magics && id->magics[0].magic)
 		/* magic string(s) defined, but not found */
 		return 1;

diff --git a/login-utils/last.c b/login-utils/last.c
index 23a2d28..5980780 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -448,7 +448,7 @@ ttyconv(char *arg) {
 			(void)strcpy(mval, "console");
 		else {
 			(void)strcpy(mval, "tty");
-			(void)strcpy(mval + 3, arg);
+			(void)strncpy(mval + 3, arg, 4);
 		}
 		return mval;
 	}
diff --git a/misc-utils/procs.c b/misc-utils/procs.c
index 3f52387..7bbe02f 100644
--- a/misc-utils/procs.c
+++ b/misc-utils/procs.c
@@ -23,6 +23,7 @@
 #include <ctype.h>
 #include <unistd.h>
 #include "kill.h"
+#include "xalloc.h"

 extern char *mybasename (char *);
 static char *parse_parens (char *buf);
@@ -77,7 +78,7 @@ get_pids (char *process_name, int get_all) {
 	if (strcmp (process_name, mybasename (cp))) continue;
 	while (pids_size < num_pids + 2) {
 	    pids_size += 5;
-	    pids = (int *) realloc (pids, sizeof (int) * pids_size);
+	    pids = (int *) xrealloc (pids, sizeof (int) * pids_size);
 	}
 	pids[num_pids++] = pid;
 	pids[num_pids] = -1;
diff --git a/text-utils/column.c b/text-utils/column.c
index 1e7a577..f8fd350 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -106,6 +106,7 @@ int main(int argc, char **argv)
 {
 	struct winsize win;
 	int ch, tflag = 0, xflag = 0;
+	int i;
 	long termwidth = 80;
 	int entries = 0;		/* number of records */
 	unsigned int eval = 0;		/* exit value */
@@ -198,7 +199,7 @@ int main(int argc, char **argv)
 	else
 		r_columnate(maxlength, termwidth, list, entries);

-	for (int i = 0; i < entries; i++)
+	for (i = 0; i < entries; i++)
 		free(list[i]);
 	free(list);

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
