Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754157AbdERKgp (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 18 May 2017 06:36:45 -0400
Date: Thu, 18 May 2017 12:36:40 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Ruediger Meier <sweet_f_a@gmx.de>,
        Bruce Dubbs <bruce.dubbs@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: versioning
Message-ID: <20170518103640.3dedmk7lat74biev@ws.net.home>
References: <20170517074741.ltxnoawwvj56gc3m@ws.net.home>
 <591C8A09.6070100@gmail.com>
 <201705172107.49456.sweet_f_a@gmx.de>
 <20170517210953.dskdxcr3rdmbtvgs@ws.net.home>
 <CAG27Bk17xasjeZQP6YpzUvchZJ5mtG2K4w0dirRybxu98-pAcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk17xasjeZQP6YpzUvchZJ5mtG2K4w0dirRybxu98-pAcQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 18, 2017 at 10:29:30AM +0100, Sami Kerola wrote:
> On 17 May 2017 at 22:09, Karel Zak <kzak@redhat.com> wrote:
> > On Wed, May 17, 2017 at 09:07:49PM +0200, Ruediger Meier wrote:
> >> I'm not talking about making things incompatible just to be incompatible
> >> but about ugly, outdated ifdefs which probably nobody needs anymore but
> >> also nobody would touch unless we actively review this.
> >
> > This would be better to discuss per patch. I don't think the current
> > code is affected by many obscure #ifdef and if we have #ifdef then
> > it's usually to be compatible with some libc, non-linux systems, old
> > gcc, etc.
> >
> > Anyway, it seems the conclusion is to continue with vX.Y.Z :-)
> 
> So will we get 3.0.0 next and stick with 3.y.z for couple years until

Seems like misunderstanding, I've thought that the current v2.nn is
good enough and we will continue with it (and maybe one day after some
significant changes we will switch to v3.nn, and so on).

> numbers grow large?  Then v4.y.z and so on.  My initial thinking was really
> as simple as 2.30.0 is a bit large number, and the 2 has not changed for 10
> years so maybe it's time to update that.

...

> Now when we are talking about versioning - do we get much benefit from rcN
> series? 

Well, it would be nice to somehow force people to use -rcN release to
test things :-)

The important thing on rcN is that we have official tarball, so you
can use it independently on git, add to distros etc.

I usually push all rc releases to unstable Fedora, sometimes I get feedback.

-rc1 is also time when I work on reports from coverity and another
static analyzers. So, for me it makes sense, but it's nothing critical.

> As far I can tell the project is good shape to release after every
> single commit.  What I don't see is distros using rc series for any users so
> currently they primarily tell to contributors 'stop sending intrusive crazy
> stuff for couple weeks, a release is about to happen'.  And if that's all
> these releases do the same could be achieved by sending a maintainer note to
> maillist informing when is the expected day of next release.

We need time to freeze the code (at least for one week) for
translators (usually -rc2). This is the minimal requirement.

> In short dropping the -rc's in favour of releasing for real more often is
> something I would like to see.

My wish is to release more often (~4 month), but not sure why it's 
always more months :-))

For v2.30 my schedule is:

   - Thu May 23 -rc2
   - Thu May 30 release

For the next releases it would be probably nice to prepare schedule
for all year and always publish schedule for the next release
immediately after the previous release

   - Sep 16 -- feature freeze, no invasive changes allowed (aka rc1)
   - Sep 19 -- strings freeze, translations (aka rc2)
   - Sep 26 -- v2.31

   - Jan 16 -- feature freeze, no invasive changes allowed (aka rc1)
   - Jan 23 -- strings freeze, translations (aka rc2)
   - Jan 30 -- v2.32

   ... etc.

It means release every 4 month, last Tuesday in the month; one week
between -rcN (so... 14 days freeze every 4 month, IMHO not so bad).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
