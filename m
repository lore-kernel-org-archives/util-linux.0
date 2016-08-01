Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33950 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808AbcHAL0L (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Aug 2016 07:26:11 -0400
Date: Mon, 1 Aug 2016 13:26:09 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: J William Piggott <elseifthen@gmx.com>, Ruediger Meier <sweet_f_a@gmx.de>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] hwclock: remove UTC-0 localization hack
Message-ID: <20160801112609.2uj3xfyz7wn4v2xx@ws.net.home>
References: <20160710200242.2706-1-kerolasa@iki.fi>
 <201607121623.04891.sweet_f_a@gmx.de>
 <CAG27Bk3po26Bsb=E0A1UXDrTrkwPH1pEvqEKXFZ_n4PVOcxt8A@mail.gmail.com>
 <201607122338.40458.sweet_f_a@gmx.de>
 <alpine.LNX.2.20.1607122241300.11890@imuri>
 <20160714100143.gc4ozcmah5i5stgz@ws.net.home>
 <55e0d593-85e7-accc-84bd-c853a9d2951c@gmx.com>
 <CAG27Bk1DOOpwa-T=R0Hxxna+3Cap-6gC+KCcn8C4i_5AD5jd0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1DOOpwa-T=R0Hxxna+3Cap-6gC+KCcn8C4i_5AD5jd0g@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 27, 2016 at 05:07:38PM +0100, Sami Kerola wrote:
> On 15 July 2016 at 19:46, J William Piggott <elseifthen@gmx.com> wrote:
> > On 07/14/2016 06:01 AM, Karel Zak wrote:
> >> On Tue, Jul 12, 2016 at 10:42:33PM +0100, Sami Kerola wrote:
> >>>  lib/portability.c      | 28 ++++++++++++++++++++++++++++
> >>
> >> We already care about portability and we have many fallbacks, so why
> >> we need lib/portability.c now? It would better to use timeutils.c (or
> >> inline function in c.h).
> >
> > What is this projects position on POSIX compatibility? A few comments in
> > the *-ReleaseNotes is all I found in /Documentation. Just curious, because
> > mktime() is and timegm() is not POSIX.
> 
> That is a question to maintainer, but Karel seems to be busy so let me try
> to phrase how I see the things.

I had vacation last 2 weeks.
 
> As mentioned in this thread the util-linux is one of the core packages, and
> it is assumed to be found from all sorts of systems.  That in mind the
> portability question has got more to do whether the project works without
> problems with alternative libc implementations.  Ideally the util-linux
> should compile fine on any linux no matter what libc is used.  But please
> notice that some utilities might not get compiled if/when autotools notice
> requirements are not fulfilled.
> 
> In short.  While portability is not a main goal of the project neither it is
> completely neglected either.  Keeping ulibc going is important, making the
> util-linux work with mingw is less important.
 
Yes.

The primary goal is Linux with all usable libc, the another operation systems 
and exotic libraries are supported only if the support has no negative impact 
to the Linux use-cases and code maintenance. 

As in another cases we assume common sense rather than any strict rules ;-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
