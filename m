Return-Path: dave@gnu.org
Subject: [PATCH] mount: use common libs
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Sep 2011 12:07:35 -0300
Message-ID: <1315926455.3703.2.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Get rid of the local xmalloc.[c/h] files by using the global xalloc and s=
trutils libraries.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
This is applies to the latest commit in kernel.org's repo, since I have n=
ot cloned the new github repository.
 mount/Makefile.am    |    2 +-
 mount/devname.c      |    1 +
 mount/fstab.c        |    3 ++-
 mount/lomount.c      |    2 +-
 mount/mount.c        |    2 +-
 mount/mount_mntent.c |    1 +
 mount/sundries.c     |    2 +-
 mount/sundries.h     |    3 +--
 mount/umount.c       |    2 ++
 mount/xmalloc.c      |   48 --------------------------------------------=
----
 mount/xmalloc.h      |   14 --------------
 11 files changed, 11 insertions(+), 69 deletions(-)
 delete mode 100644 mount/xmalloc.c
 delete mode 100644 mount/xmalloc.h

diff --git a/mount/Makefile.am b/mount/Makefile.am
index b82464f..d64cd72 100644
--- a/mount/Makefile.am
+++ b/mount/Makefile.am
@@ -7,7 +7,7 @@ sbin_PROGRAMS =3D losetup swapon
 dist_man_MANS =3D fstab.5 mount.8 swapoff.8 swapon.8 umount.8 losetup.8
=20
 # generic sources for all programs (mount, umount, losetup)
-srcs_common =3D sundries.c xmalloc.c $(top_srcdir)/lib/canonicalize.c su=
ndries.h xmalloc.h
+srcs_common =3D sundries.c $(top_srcdir)/lib/canonicalize.c sundries.h
=20
 # generic header for mount and umount
 hdrs_mount =3D fstab.h mount_mntent.h mount_constants.h \
diff --git a/mount/devname.c b/mount/devname.c
index 05da092..308bad1 100644
--- a/mount/devname.c
+++ b/mount/devname.c
@@ -2,6 +2,7 @@
=20
 #include "devname.h"
 #include "sundries.h"		/* for xstrdup */
+#include "xalloc.h"
=20
 const char *
 spec_to_devname(const char *spec)
diff --git a/mount/fstab.c b/mount/fstab.c
index 2331a7d..e0ca0d8 100644
--- a/mount/fstab.c
+++ b/mount/fstab.c
@@ -12,10 +12,11 @@
 #include <sys/time.h>
 #include <time.h>
 #include <mntent.h>
+
 #include "mount_mntent.h"
 #include "fstab.h"
 #include "sundries.h"
-#include "xmalloc.h"
+#include "xalloc.h"
 #include "fsprobe.h"
 #include "pathnames.h"
 #include "nls.h"
diff --git a/mount/lomount.c b/mount/lomount.c
index fad58d5..b8f9735 100644
--- a/mount/lomount.c
+++ b/mount/lomount.c
@@ -21,7 +21,7 @@
 #include "strutils.h"
 #include "nls.h"
 #include "sundries.h"
-#include "xmalloc.h"
+#include "xalloc.h"
 #include "pathnames.h"
=20
 #ifdef LOOP_SET_FD
diff --git a/mount/mount.c b/mount/mount.c
index 5066abc..f7aa1ed 100644
--- a/mount/mount.c
+++ b/mount/mount.c
@@ -32,7 +32,7 @@
 #include "devname.h"
 #include "mount_constants.h"
 #include "sundries.h"
-#include "xmalloc.h"
+#include "xalloc.h"
 #include "mount_mntent.h"
 #include "fstab.h"
 #include "lomount.h"
diff --git a/mount/mount_mntent.c b/mount/mount_mntent.c
index f42c0ad..f29baf9 100644
--- a/mount/mount_mntent.c
+++ b/mount/mount_mntent.c
@@ -10,6 +10,7 @@
 #include <ctype.h>		/* for isdigit */
 #include <sys/stat.h>		/* for umask */
=20
+#include "xalloc.h"
 #include "mount_mntent.h"
 #include "sundries.h"		/* for xmalloc */
 #include "nls.h"
diff --git a/mount/sundries.c b/mount/sundries.c
index 2dec37f..9227497 100644
--- a/mount/sundries.c
+++ b/mount/sundries.c
@@ -15,7 +15,7 @@
 #include "canonicalize.h"
=20
 #include "sundries.h"
-#include "xmalloc.h"
+#include "xalloc.h"
 #include "nls.h"
=20
 int mount_quiet;
diff --git a/mount/sundries.h b/mount/sundries.h
index 3b6a464..faea235 100644
--- a/mount/sundries.h
+++ b/mount/sundries.h
@@ -20,6 +20,7 @@ extern int nocanonicalize;
 extern char *progname;
=20
 #define streq(s, t)	(strcmp ((s), (t)) =3D=3D 0)
+#define my_free(_p)  free((void *) _p)
=20
 void block_signals (int how);
=20
@@ -30,8 +31,6 @@ void die(int err, const char *fmt, ...)
=20
 int matching_type (const char *type, const char *types);
 int matching_opts (const char *options, const char *test_opts);
-void *xmalloc (size_t size);
-char *xstrdup (const char *s);
 char *xstrndup (const char *s, int n);
 char *xstrconcat3 (char *, const char *, const char *);
 char *xstrconcat4 (char *, const char *, const char *, const char *);
diff --git a/mount/umount.c b/mount/umount.c
index 64f320c..192b9ec 100644
--- a/mount/umount.c
+++ b/mount/umount.c
@@ -11,6 +11,8 @@
 #include <sys/stat.h>
 #include <sys/wait.h>
 #include <sys/mount.h>
+
+#include "xalloc.h"
 #include "mount_constants.h"
 #include "sundries.h"
 #include "getusername.h"
diff --git a/mount/xmalloc.c b/mount/xmalloc.c
deleted file mode 100644
index 3fd09fd..0000000
--- a/mount/xmalloc.c
+++ /dev/null
@@ -1,48 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>	/* strdup() */
-#include "xmalloc.h"
-#include "nls.h"	/* _() */
-#include "sundries.h"	/* EX_SYSERR */
-
-static void
-die_if_null(void *t) {
-	if (t =3D=3D NULL)
-		die(EX_SYSERR, _("not enough memory"));
-}
-
-void *
-xmalloc (size_t size) {
-	void *t;
-
-	if (size =3D=3D 0)
-		return NULL;
-
-	t =3D malloc(size);
-	die_if_null(t);
-
-	return t;
-}
-
-void *
-xrealloc (void *p, size_t size) {
-	void *t;
-
-	t =3D realloc(p, size);
-	die_if_null(t);
-
-	return t;
-}
-
-char *
-xstrdup (const char *s) {
-	char *t;
-
-	if (s =3D=3D NULL)
-		return NULL;
-
-	t =3D strdup(s);
-	die_if_null(t);
-
-	return t;
-}
diff --git a/mount/xmalloc.h b/mount/xmalloc.h
deleted file mode 100644
index 2fc0a7e..0000000
--- a/mount/xmalloc.h
+++ /dev/null
@@ -1,14 +0,0 @@
-#ifndef MOUNT_XMALLOC_H
-#define MOUNT_XMALLOC_H
-
-extern void *xmalloc(size_t size);
-extern void *xrealloc(void *p, size_t size);
-extern char *xstrdup(const char *s);
-
-/*
- * free(p); when 'p' is 'const char *' makes gcc unhappy:
- *    warning: passing argument 1 of =E2=80=98free=E2=80=99 discards qua=
lifiers from pointer target type
- */
-#define my_free(_p)	free((void *) _p)
-
-#endif  /* MOUNT_XMALLOC_H */
--=20
1.7.4.1
