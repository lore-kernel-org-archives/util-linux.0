Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:61773 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174AbcBZNuI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 26 Feb 2016 08:50:08 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Subject: Re: [PATCH 12/14] lib: provide mkostemp fallback function
Date: Fri, 26 Feb 2016 14:50:03 +0100
Cc: util-linux@vger.kernel.org
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de> <1456456118-19584-3-git-send-email-sweet_f_a@gmx.de> <m337sfocs8.fsf@gmail.com>
In-Reply-To: <m337sfocs8.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201602261450.03471.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Friday 26 February 2016, Yuriy M. Kaminskiy wrote:
> Ruediger Meier <sweet_f_a@gmx.de> writes:
> > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> >
> > It's missing on OSX.
> >
> > Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> > ---
> >  configure.ac        |  1 +
> >  include/fileutils.h |  4 ++++
> >  lib/fileutils.c     | 27 +++++++++++++++++++++++++++
> >  libblkid/src/save.c |  1 +
> >  4 files changed, 33 insertions(+)
> >
> > diff --git a/configure.ac b/configure.ac
> > index 727a875..64a16ff 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -368,6 +368,7 @@ AC_CHECK_FUNCS([ \
> >  	llseek \
> >  	lseek64 \
> >  	mempcpy \
> > +	mkostemp \
> >  	nanosleep \
> >  	ntp_gettime \
> >  	personality \
> > diff --git a/include/fileutils.h b/include/fileutils.h
> > index ba8da7f..7c5594e 100644
> > --- a/include/fileutils.h
> > +++ b/include/fileutils.h
> > @@ -8,6 +8,10 @@
> >
> >  #include "c.h"
> >
> > +#ifndef HAVE_MKOSTEMP
> > +extern int mkostemp(char *template, int flags);
> > +#endif
> > +
> >  extern int xmkstemp(char **tmpname, const char *dir, const char
> > *prefix);
> >
> >  static inline FILE *xfmkstemp(char **tmpname, const char *dir,
> > const char *prefix) diff --git a/lib/fileutils.c b/lib/fileutils.c
> > index bf8e60a..05a8c02 100644
> > --- a/lib/fileutils.c
> > +++ b/lib/fileutils.c
> > @@ -13,6 +13,33 @@
> >  #include "fileutils.h"
> >  #include "pathnames.h"
> >
> > +#ifndef HAVE_MKOSTEMP
> > +int mkostemp(char *template, int flags)
> > +{
> > +	int fd, old_flags, errno_save;
> > +
> > +	fd = mkstemp(template);
> > +	if (fd < 0)
> > +		return fd;
> > +
> > +	old_flags = fcntl(fd, F_GETFD);
>
> This cannot be right. `flags` in `mkostemp` is **open** flags (such

Oops, this was really stupid.

> as `O_RDWR`, `O_CREAT`, etc; most notable, `O_CLOEXEC`; however, if
> `O_CLOEXEC` is missing on system, "c.h" defines it as 0, so it is
> silently ignored on those systems, instead of being emulated; so,
> whenever it matters, callers must call **both** `open(O_CLOEXEC)` and
> `fcntl(F_SETFD,FD_CLOEXEC)`]).

I see, but then defining O_CLOEXEC to 0 at all is the big mistake. We 
are using (ignoring) it in whole util-linux. To fix that we have to add 
fcntl(F_SETFD,FD_CLOEXEC) everywhere.

> fcntl(F_SETFD) sets only FD_CLOEXEC (bit 0), which certainly
> different.
>
> (Note that `F_SETFL` is not proper replacement either, as many `O_*`
> flags make sense in open(), but not in `fcntl(F_SETFL)` [e.g. O_CREAT
> or O_EXCL]; and it is *not* correct to `or` old flags and new ones;
> e.g. if old flags contains `O_RDWR`, and new flags is O_RDONLY,
> `old_flags | flags` may be nonsense).

Ok, to have it most simple I would now only implement a fallback for 
exactly this usage:
  mkostemp(localtmp, O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC);

like this

#if defined HAVE_MKOSTEMP && defined O_CLOEXEC
mkostemp(localtmp, O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC);
#else
fd = mkstemp(template);
old_flags = fcntl(fd, F_GETFD);
fcntl(fd, F_SETFD, old_flags | FD_CLOEXEC)
#endif


> > +	if (old_flags < 0)
> > +		goto unwind;
> > +	if (fcntl(fd, F_SETFD, old_flags | flags) < 0)
> > +		goto unwind;
> > +
> > +	return fd;
> > +
> > +unwind:
> > +	errno_save = errno;
> > +	unlink(template);
> > +	close(fd);
> > +	errno = errno_save;
> > +
> > +	return -1;
> > +}
> > +#endif
> > +
> >  /* Create open temporary file in safe way.  Please notice that the
> >   * file permissions are -rw------- by default. */
> >  int xmkstemp(char **tmpname, const char *dir, const char *prefix)
> > diff --git a/libblkid/src/save.c b/libblkid/src/save.c
> > index 5e8bbee..b9f447a 100644
> > --- a/libblkid/src/save.c
> > +++ b/libblkid/src/save.c
> > @@ -23,6 +23,7 @@
> >  #endif
> >
> >  #include "closestream.h"
> > +#include "fileutils.h"
> >
> >  #include "blkidP.h"
>
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
