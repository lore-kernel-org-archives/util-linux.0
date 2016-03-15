Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35204 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933229AbcCOCKy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Mar 2016 22:10:54 -0400
Received: by mail-pf0-f196.google.com with SMTP id u190so561830pfb.2
        for <util-linux@vger.kernel.org>; Mon, 14 Mar 2016 19:10:53 -0700 (PDT)
Date: Mon, 14 Mar 2016 19:10:50 -0700
From: Isaac Dunham <ibid.ag@gmail.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/12] another BSD/OSX related patch-set
Message-ID: <20160315021049.GA17614@newbook>
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

As far as I know, the only option for that on no-utmp(x) systems would be
PAM.

> > This seems to imply that --disable-utmp/--disable-utmpx options would
> > be helpful.
> 
> Do you mean --without-utmp to build our progs without utmp or really 
> disabling the build of all progs which are using utmp right now?

Ideally, it would be build progs without utmp(x), and disable build of
anything that's a stub after that.

For example:
uptime would either drop the '<n> users' field, or change it to 
'?? users' (the latter would keep the right number of fields).
wall would disappear, since it enumerates active ttys based on utmp.
last would disappear, since it gets login records from utmp(x).

> Actually I thought the next step could be to remove utmp and use utmpx 
> only because it's POSIX and more portable. See commit d00c10ed. 

That doesn't address what I'm concerned about, though it's a nice thought.
(In fact, OpenBSD is utmp only.)
I'm saying that it would be *nice* to be able to turn off *everything* that
relies on utmp or utmpx, all at once.
Is that, at least in theory, acceptable?

Thanks,
Isaac Dunham
