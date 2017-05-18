Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20170517210953.dskdxcr3rdmbtvgs@ws.net.home>
References: <20170517074741.ltxnoawwvj56gc3m@ws.net.home> <591C8A09.6070100@gmail.com>
 <201705172107.49456.sweet_f_a@gmx.de> <20170517210953.dskdxcr3rdmbtvgs@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 18 May 2017 10:29:30 +0100
Message-ID: <CAG27Bk17xasjeZQP6YpzUvchZJ5mtG2K4w0dirRybxu98-pAcQ@mail.gmail.com>
Subject: Re: versioning
To: Karel Zak <kzak@redhat.com>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, Bruce Dubbs <bruce.dubbs@gmail.com>,
	util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

On 17 May 2017 at 22:09, Karel Zak <kzak@redhat.com> wrote:
> On Wed, May 17, 2017 at 09:07:49PM +0200, Ruediger Meier wrote:
>> I'm not talking about making things incompatible just to be incompatible
>> but about ugly, outdated ifdefs which probably nobody needs anymore but
>> also nobody would touch unless we actively review this.
>
> This would be better to discuss per patch. I don't think the current
> code is affected by many obscure #ifdef and if we have #ifdef then
> it's usually to be compatible with some libc, non-linux systems, old
> gcc, etc.
>
> Anyway, it seems the conclusion is to continue with vX.Y.Z :-)

So will we get 3.0.0 next and stick with 3.y.z for couple years until
numbers grow large?  Then v4.y.z and so on.  My initial thinking was really
as simple as 2.30.0 is a bit large number, and the 2 has not changed for 10
years so maybe it's time to update that.

Seeing v31 proposal was interesting, but no.  Two number system could also
work fine, but there does not seem to be apetite to that.  Lets go with
concencus and stick with X.Y.Z format.

Now when we are talking about versioning - do we get much benefit from rcN
series?  As far I can tell the project is good shape to release after every
single commit.  What I don't see is distros using rc series for any users so
currently they primarily tell to contributors 'stop sending intrusive crazy
stuff for couple weeks, a release is about to happen'.  And if that's all
these releases do the same could be achieved by sending a maintainer note to
maillist informing when is the expected day of next release.

In short dropping the -rc's in favour of releasing for real more often is
something I would like to see.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
