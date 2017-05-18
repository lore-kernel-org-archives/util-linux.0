Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: kerolasa@gmail.com
Subject: Re: versioning
Date: Thu, 18 May 2017 12:43:31 +0200
Cc: Karel Zak <kzak@redhat.com>,
 Bruce Dubbs <bruce.dubbs@gmail.com>,
 "util-linux" <util-linux@vger.kernel.org>
References: <20170517074741.ltxnoawwvj56gc3m@ws.net.home> <20170517210953.dskdxcr3rdmbtvgs@ws.net.home> <CAG27Bk17xasjeZQP6YpzUvchZJ5mtG2K4w0dirRybxu98-pAcQ@mail.gmail.com>
In-Reply-To: <CAG27Bk17xasjeZQP6YpzUvchZJ5mtG2K4w0dirRybxu98-pAcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201705181243.31801.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Thursday 18 May 2017, Sami Kerola wrote:
> On 17 May 2017 at 22:09, Karel Zak <kzak@redhat.com> wrote:
> > On Wed, May 17, 2017 at 09:07:49PM +0200, Ruediger Meier wrote:
> >> I'm not talking about making things incompatible just to be
> >> incompatible but about ugly, outdated ifdefs which probably nobody
> >> needs anymore but also nobody would touch unless we actively
> >> review this.
> >
> > This would be better to discuss per patch. I don't think the
> > current code is affected by many obscure #ifdef and if we have
> > #ifdef then it's usually to be compatible with some libc, non-linux
> > systems, old gcc, etc.
> >
> > Anyway, it seems the conclusion is to continue with vX.Y.Z :-)
>
> So will we get 3.0.0 next and stick with 3.y.z for couple years until
> numbers grow large?  Then v4.y.z and so on.  My initial thinking was
> really as simple as 2.30.0 is a bit large number, and the 2 has not
> changed for 10 years so maybe it's time to update that.
>
> Seeing v31 proposal was interesting, but no.  Two number system could
> also work fine, but there does not seem to be apetite to that.  Lets
> go with concencus and stick with X.Y.Z format.
>
> Now when we are talking about versioning - do we get much benefit
> from rcN series?

I think some distro maintainers use and test it to report bugs before 
final release. Maybe even translaters use it.  The benfit for them is 
that they need less dependencies for the build. Also the rcN tag makes 
them able to get informed automatically a few times per year rather 
then continuously following our master branch or mailing list.

Only for cosmetics I would remove the old rcN tarballs from the server. 
Nobody needs them nor should still use them after release.

> As far I can tell the project is good shape to 
> release after every single commit.  What I don't see is distros using
> rc series for any users so currently they primarily tell to
> contributors 'stop sending intrusive crazy stuff for couple weeks, a
> release is about to happen'.  And if that's all these releases do the
> same could be achieved by sending a maintainer note to maillist
> informing when is the expected day of next release.
>
> In short dropping the -rc's in favour of releasing for real more
> often is something I would like to see.

IMO we are releasing often enough. Personally I find the stable bug fix 
releases most interesting. If I want a more recent UL I would build 
from git anyways.

cu,
Rudi
