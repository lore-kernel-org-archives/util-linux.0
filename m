Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36627 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbcGLVmw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 12 Jul 2016 17:42:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id x83so3455595wma.3
        for <util-linux@vger.kernel.org>; Tue, 12 Jul 2016 14:42:46 -0700 (PDT)
Date: Tue, 12 Jul 2016 22:42:33 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: Ruediger Meier <sweet_f_a@gmx.de>
cc: kerolasa@gmail.com, J William Piggott <elseifthen@gmx.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] hwclock: remove UTC-0 localization hack
In-Reply-To: <201607122338.40458.sweet_f_a@gmx.de>
Message-ID: <alpine.LNX.2.20.1607122241300.11890@imuri>
References: <20160710200242.2706-1-kerolasa@iki.fi> <201607121623.04891.sweet_f_a@gmx.de> <CAG27Bk3po26Bsb=E0A1UXDrTrkwPH1pEvqEKXFZ_n4PVOcxt8A@mail.gmail.com> <201607122338.40458.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 12 Jul 2016, Ruediger Meier wrote:

> On Tuesday 12 July 2016, Sami Kerola wrote:
> > On 12 July 2016 at 15:23, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> > > On Tuesday 12 July 2016, Sami Kerola wrote:
> > >> On 11 July 2016 at 21:23, J William Piggott <elseifthen@gmx.com>
> > >
> > > wrote:
> > >> > We use mktime(3) for portability.
> > >> >
> > >> > http://www.gnu.org/software/libc/manual/html_mono/libc.html#inde
> > >> >x-t imegm
> > >> >
> > >> > Portability note: mktime is essentially universally available.
> > >> > timegm is rather rare. For the most portable conversion from a
> > >> > UTC broken-down time to a simple time, set the TZ environment
> > >> > variable to UTC, call mktime, then set TZ back.
> > >>
> > >> I don't think hwclock(8) is portable. It has ioctl(2) calls, and
> > >> such.
> > >
> > > But there are non-gnu libc's for Linux.
> >
> > Fair point, but can you name one that does not have timegm().
> >
> > https://github.com/cloudius-systems/musl/blob/master/src/time/timegm.
> >c https://github.com/ensc/dietlibc/blob/master/libugly/timegm.c
> > http://www.uclibc-ng.org/browser/uclibc-ng/libc/misc/time/timegm.c?or
> >der=name
> 
> 
> Yep, also musl has timegm. But at least it's good that William reminded 
> us to check that! :)

Oh well. I guess it does not hurt to support incomplete libraries even if 
we might not be able to name them.

https://github.com/kerolasa/lelux-utiliteetit/commit/5dff764bb38f0745a8bb128337d2534f109a37c8

and the same as email body so that review is possible.

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Tue, 12 Jul 2016 22:21:10 +0100
Subject: [PATCH] lib: add portability functions, start with timegm()

The lib/portability.c is a file where functions that may be missing from
libraries can be added.

CC: Ruediger Meier <ruediger.meier@ga-group.nl>
CC: J William Piggott <elseifthen@gmx.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac           |  1 +
 include/Makemodule.am  |  1 +
 include/portability.h  |  8 ++++++++
 lib/Makemodule.am      |  1 +
 lib/portability.c      | 28 ++++++++++++++++++++++++++++
 login-utils/utmpdump.c |  1 +
 sys-utils/hwclock.c    |  1 +
 7 files changed, 41 insertions(+)
 create mode 100644 include/portability.h
 create mode 100644 lib/portability.c

diff --git a/configure.ac b/configure.ac
index 39d9aca..0835838 100644
--- a/configure.ac
+++ b/configure.ac
@@ -413,6 +413,7 @@ AC_CHECK_FUNCS([ \
 	strnlen \
 	sysconf \
 	sysinfo \
+	timegm \
 	updwtmp \
 	usleep \
 	warn \
diff --git a/include/Makemodule.am b/include/Makemodule.am
index 5ceff0a..9eff5c8 100644
--- a/include/Makemodule.am
+++ b/include/Makemodule.am
@@ -35,6 +35,7 @@ dist_noinst_HEADERS += \
 	include/path.h \
 	include/pathnames.h \
 	include/plymouth-ctrl.h \
+	include/portability.h \
 	include/procutils.h \
 	include/pt-bsd.h \
 	include/pt-mbr.h \
diff --git a/include/portability.h b/include/portability.h
new file mode 100644
index 0000000..2a60ede
--- /dev/null
+++ b/include/portability.h
@@ -0,0 +1,8 @@
+#ifndef UTIL_LINUX_PORTABILITY_H
+#define UTIL_LINUX_PORTABILITY_H
+
+#ifndef HAVE_TIMEGM
+extern time_t timegm(struct tm *tm);
+#endif
+
+#endif /* UTIL_LINUX_PORTABILITY_H */
diff --git a/lib/Makemodule.am b/lib/Makemodule.am
index 704a16e..57b1d86 100644
--- a/lib/Makemodule.am
+++ b/lib/Makemodule.am
@@ -16,6 +16,7 @@ libcommon_la_SOURCES = \
 	lib/md5.c \
 	lib/pager.c \
 	lib/path.c \
+	lib/portability.c \
 	lib/randutils.c \
 	lib/setproctitle.c \
 	lib/strutils.c \
diff --git a/lib/portability.c b/lib/portability.c
new file mode 100644
index 0000000..cbc49a5
--- /dev/null
+++ b/lib/portability.c
@@ -0,0 +1,28 @@
+/*
+ * Functions in this file are replacements when library functions neither
+ * unimplemented or unavailable due old version.  In best case these
+ * functions are never needed.
+ */
+
+#include <time.h>
+#include <stdlib.h>
+
+#include "portability.h"
+
+#ifndef HAVE_TIMEGM
+time_t timegm(struct tm *tm)
+{
+	const char *zone = getenv("TZ");
+	time_t ret;
+
+	setenv("TZ", "", 1);
+	tzset();
+	ret = mktime(tm);
+	if (zone)
+		setenv("TZ", zone, 1);
+	else
+		unsetenv("TZ");
+	tzset();
+	return ret;
+}
+#endif /* HAVE_TIMEGM */
diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index 1849a4e..43fc842 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -45,6 +45,7 @@
 #include "timeutils.h"
 #include "xalloc.h"
 #include "closestream.h"
+#include "portability.h"
 
 static time_t strtotime(const char *s_time)
 {
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index bcaab8b..fb9d628 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -78,6 +78,7 @@
 #include "nls.h"
 #include "optutils.h"
 #include "pathnames.h"
+#include "portability.h"
 #include "strutils.h"
 #include "hwclock.h"
 #include "timeutils.h"
-- 
2.9.0

