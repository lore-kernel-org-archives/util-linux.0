Return-Path: dave@gnu.org
Subject: Re: [PATCH] mount: use common libs
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20110914144539.GA1829@nb.net.home>
References: <1315926455.3703.2.camel@offbook>
	 <20110914144539.GA1829@nb.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 14 Sep 2011 15:07:06 -0300
Message-ID: <1316023626.2771.0.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Wed, 2011-09-14 at 16:45 +0200, Karel Zak wrote:
> On Tue, Sep 13, 2011 at 12:07:35PM -0300, Davidlohr Bueso wrote:
> > --- a/mount/devname.c
> > +++ b/mount/devname.c
> > @@ -2,6 +2,7 @@
> > =20
> >  #include "devname.h"
> >  #include "sundries.h"		/* for xstrdup */
> > +#include "xalloc.h"
>=20
>  It would be better to include xalloc.h in sunders.h only.
>=20
> > -static void
> > -die_if_null(void *t) {
> > -	if (t =3D=3D NULL)
> > -		die(EX_SYSERR, _("not enough memory"));
>             ^^^^^^^^
> > -}
>=20
>  it means that you have to use:
>=20
>  #define XALLOC_EXIT_CODE   EX_SYSERR
>  #include "xalloc.h"
>=20
>  to keep it backwardly compatible.
>=20

Ok, below is v2.

Thanks.


From: Davidlohr Bueso <dave@gnu.org>
Date: Wed, 14 Sep 2011 15:05:22 -0300
Subject: [PATCH] mount: use common libs

Get rid of the local xmalloc.[c/h] files by using the global xalloc and s=
trutils libraries.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 mount/Makefile.am |    2 +-
 mount/fstab.c     |    2 +-
 mount/lomount.c   |    1 -
 mount/mount.c     |    1 -
 mount/sundries.c  |    1 -
 mount/sundries.h  |    6 ++++--
 mount/umount.c    |    1 +
 mount/xmalloc.c   |   48 -----------------------------------------------=
-
 mount/xmalloc.h   |   14 --------------
 9 files changed, 7 insertions(+), 69 deletions(-)
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
diff --git a/mount/fstab.c b/mount/fstab.c
index 2331a7d..d0a0482 100644
--- a/mount/fstab.c
+++ b/mount/fstab.c
@@ -12,10 +12,10 @@
 #include <sys/time.h>
 #include <time.h>
 #include <mntent.h>
+
 #include "mount_mntent.h"
 #include "fstab.h"
 #include "sundries.h"
-#include "xmalloc.h"
 #include "fsprobe.h"
 #include "pathnames.h"
 #include "nls.h"
diff --git a/mount/lomount.c b/mount/lomount.c
index fad58d5..74a8749 100644
--- a/mount/lomount.c
+++ b/mount/lomount.c
@@ -21,7 +21,6 @@
 #include "strutils.h"
 #include "nls.h"
 #include "sundries.h"
-#include "xmalloc.h"
 #include "pathnames.h"
=20
 #ifdef LOOP_SET_FD
diff --git a/mount/mount.c b/mount/mount.c
index 5066abc..b64035e 100644
--- a/mount/mount.c
+++ b/mount/mount.c
@@ -32,7 +32,6 @@
 #include "devname.h"
 #include "mount_constants.h"
 #include "sundries.h"
-#include "xmalloc.h"
 #include "mount_mntent.h"
 #include "fstab.h"
 #include "lomount.h"
diff --git a/mount/sundries.c b/mount/sundries.c
index 2dec37f..58f7b5d 100644
--- a/mount/sundries.c
+++ b/mount/sundries.c
@@ -15,7 +15,6 @@
 #include "canonicalize.h"
=20
 #include "sundries.h"
-#include "xmalloc.h"
 #include "nls.h"
=20
 int mount_quiet;
diff --git a/mount/sundries.h b/mount/sundries.h
index 3b6a464..5e3ddc3 100644
--- a/mount/sundries.h
+++ b/mount/sundries.h
@@ -13,6 +13,9 @@
 #include <stdarg.h>
 #include <stdlib.h>
=20
+#define XALLOC_EXIT_CODE 2 /* same as EX_SYSERR, for backwards compatibi=
lity */
+#include "xalloc.h"
+
 /* global mount, umount, and losetup variables */
 extern int mount_quiet;
 extern int verbose;
@@ -20,6 +23,7 @@ extern int nocanonicalize;
 extern char *progname;
=20
 #define streq(s, t)	(strcmp ((s), (t)) =3D=3D 0)
+#define my_free(_p)  free((void *) _p)
=20
 void block_signals (int how);
=20
@@ -30,8 +34,6 @@ void die(int err, const char *fmt, ...)
=20
 int matching_type (const char *type, const char *types);
 int matching_opts (const char *options, const char *test_opts);
-void *xmalloc (size_t size);
-char *xstrdup (const char *s);
 char *xstrndup (const char *s, int n);
 char *xstrconcat3 (char *, const char *, const char *);
 char *xstrconcat4 (char *, const char *, const char *, const char *);
diff --git a/mount/umount.c b/mount/umount.c
index 64f320c..5000aa5 100644
--- a/mount/umount.c
+++ b/mount/umount.c
@@ -11,6 +11,7 @@
 #include <sys/stat.h>
 #include <sys/wait.h>
 #include <sys/mount.h>
+
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
