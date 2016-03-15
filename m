Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48954 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753783AbcCOLYO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Mar 2016 07:24:14 -0400
Date: Tue, 15 Mar 2016 12:24:12 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Isaac Dunham <ibid.ag@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 00/12] another BSD/OSX related patch-set
Message-ID: <20160315112412.tbb7sakncar5r4vl@ws.net.home>
References: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
 <20160308012836.GA26455@newbook>
 <201603140243.40546.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201603140243.40546.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 14, 2016 at 02:43:40AM +0100, Ruediger Meier wrote:
> On Tuesday 08 March 2016, Isaac Dunham wrote:
> > On Tue, Mar 08, 2016 at 12:11:50AM +0100, Ruediger Meier wrote:
> > > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> > >
> > > This is github pull request #299
> > > https://github.com/karelzak/util-linux/pull/299
> > >
> > > Again some arbitrary BSD, OSX and musl related fixes and clean-up
> >
> > <snip>
> >
> > > For OSX one should additionally disable all utmp.h related
> > > programs.
> >
> > FYI:
> > With musl, utmpx is stubbed out and utmp is wrappers for utmpx, so
> > users should disable utmp(x)-related programs and code.
> 
> > (The point is to let things build, but not use utmp because the
> > maintainer considers it a fundamentally flawed idea.)
> >
> > Additionally, systemd is working on allowing disabling of utmp(x).
> 
> Will there be another interface to be used by last(1)?
> 
> > This seems to imply that --disable-utmp/--disable-utmpx options would
> > be helpful.
> 
> Do you mean --without-utmp to build our progs without utmp or really 
> disabling the build of all progs which are using utmp right now?
> 
> Actually I thought the next step could be to remove utmp and use utmpx 
> only because it's POSIX and more portable. See commit d00c10ed. 
> 
> There are still two files to be fixed
>   login-utils/last.c
>   login-utils/su-common.c

 Well, programs like login(1) and su(1) use btmp to log failed login
 attempts, it should be enough to check if _PATH_BTMP exists,
 otherwise ignore the file.

 If we want to use --without-utmp then only for portability (libc
 does not provide relevant headers).

 I guess we want to support work with (archived) utmp files, so
 programs like utmpdump makes sense everywhere (if possible).

 The last(1) or lslogins(1) have to be smart enough to ignore missing
 files by default. So again, --without-utmp should be about
 portability only.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
