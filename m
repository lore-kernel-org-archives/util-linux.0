Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59333 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345Ab2JVIG2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Oct 2012 04:06:28 -0400
Date: Mon, 22 Oct 2012 10:06:24 +0200
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: kerolasa@gmail.com, util-linux@vger.kernel.org
Subject: Re: [PATCH 03/19] write: stop using MAXHOSTNAMELEN
Message-ID: <20121022080624.GA21724@x2.net.home>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
 <20121015152558.GK18377@x2.net.home>
 <CAG27Bk3bRTppXcBpqEZeRSMhqK1+BTrQqje9E0NYPSgfqcm4fQ@mail.gmail.com>
 <201210220201.02516.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201210220201.02516.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 22, 2012 at 02:01:01AM -0400, Mike Frysinger wrote:
> On Thursday 18 October 2012 16:06:28 Sami Kerola wrote:
> > On Mon, Oct 15, 2012 at 3:14 AM, Mike Frysinger wrote:
> > > On Sunday 14 October 2012 16:20:59 Sami Kerola wrote:
> > >> POSIX.1-2001 declares usleep is obsolete.
> > > 
> > > this is true, but it seems like a better answer would be to add a
> > > usleep test to configure and provide a local fallback using nanosleep
> > > if it doesn't exist.
> > 
> > Is that necessary?  There has been for example in old mount since March
> > 2007[1] nanosleep() call, and I cannot remember anyone complaining it
> > causing problems.
> > 
> > [1] commit dc8fdc57cd3ba0658cf4ab05031695c2d2965f93
> 
> i think you misinterpreted my objection.  i don't have a problem with calling 
> nanosleep() -- when it makes sense.  replacing a simple call to a function 
> that, while no longer part of the latest standard, was mandated for many many 
> years, and will most likely never be removed from C libraries that have 
> already been providing it (since it'd be an ABI break), with a more 
> complicated call for no real reason is pointless imo.  further, you'd be 
> fighting a losing battle: developers will most likely be working & testing on a 
> glibc system where usleep does exist and works fine, so they won't notice if it 
> were added again.
> 
> hence i suggested a trivial middle ground that is future proof and doesn't 
> penalize systems that do include usleep (i.e. glibc i.e. what the majority of 
> people run): if you actually have a system that lacks usleep, then add usleep 
> to the AC_CHECK_FUNCS tests in configure.ac, and then add the simple 
> replacement to include/c.h:
> #ifndef HAVE_USLEEP
> static inline int usleep(useconds_t usec)
> {
> 	struct timespec waittime;
> 	waittime.tv_sec = usec / 1000000L;
> 	waittime.tv_nsec =  (usec % 1000000L) * 1000;
> 	return nanosleep(&waittime, NULL);
> }
> #endif
> 
> now everything should "just work".

Exactly this solution we use for now (since 2009):

$ cat include/usleep.h

#ifndef UTIL_LINUX_USLEEP_H
#define UTIL_LINUX_USLEEP_H

#ifndef HAVE_USLEEP
/*
 * This function is marked obsolete in POSIX.1-2001 and removed in
 * POSIX.1-2008. It is replaced with nanosleep().
 */
# define usleep(x) \
	do { \
		struct timespec xsleep; \
		xsleep.tv_sec = x / 1000 / 1000; \
		xsleep.tv_nsec = (x - xsleep.tv_sec * 1000 * 1000) * 1000; \
		nanosleep(&xsleep, NULL); \
	} while (0)
#endif

#endif /* UTIL_LINUX_USLEEP_H */


... so I don't think we have to check change anything.

> > On Mon, Oct 15, 2012 at 6:39 PM, Mike Frysinger wrote:
> > > On Monday 15 October 2012 04:36:43 Sami Kerola wrote:
> > >> On Mon, Oct 15, 2012 at 3:17 AM, Mike Frysinger wrote:
> > >> > On Sunday 14 October 2012 16:21:10 Sami Kerola wrote:
> > >> >> +     if (utimensat(path, &epoch, 0) < 0)
> > >> > 
> > >> > err, did you test this at all ?  utimensat() takes 4 args one of
> > >> > which is
> > >> > a reference file descriptor.
> > >> 
> > >> I thought I did, but what ever I did where partly unsuccessful.
> > > 
> > > cramfs isn't built by default, so you'll need to pass the right
> > > configure flag
> > 
> > *sigh* I see.  And I dropped the patch.
> > 
> > I wonder if anyone is ever reaching code that requires INCLUDE_FS_TESTS
> > defined.  Should there be a configure --enable-fs-crams-tests switch?  If
> > that sort of switch is added it should perhaps be included when
> > --enable-most-builds is set.  Comments, opinions?
> 
> i would add a new check target to disk-utils/Makemodule.am
> 
> check_PROGRAMS += test_mkfs.cramfs
> test_mkfs_cramfs_SOURCES = $(mkfs_cramfs_SOURCES)
> test_mkfs_cramfs_LDADD = $(mkfs_cramfs_LDADD)
> test_mkfs_cramfs_CFLAGS = -DINCLUDE_FS_TESTS

 Good point. Fixed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
