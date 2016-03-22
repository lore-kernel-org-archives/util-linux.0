Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:57550 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759158AbcCVLEx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 Mar 2016 07:04:53 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] tests: fix fdisk/bsd for alpha
Date: Tue, 22 Mar 2016 12:04:43 +0100
Cc: util-linux@vger.kernel.org
References: <1458088844-23523-1-git-send-email-sweet_f_a@gmx.de> <201603172252.49517.sweet_f_a@gmx.de> <20160318143600.mmpkpnxaujhwans3@ws.net.home>
In-Reply-To: <20160318143600.mmpkpnxaujhwans3@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201603221204.43377.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Friday 18 March 2016, Karel Zak wrote:
> On Thu, Mar 17, 2016 at 10:52:49PM +0100, Ruediger Meier wrote:
> > On Thursday 17 March 2016, Karel Zak wrote:
> > > On Wed, Mar 16, 2016 at 04:27:10PM +0100, Ruediger Meier wrote:
> > > > And we could disable setarch's uname26 test because
> > > > # glibc requires kernel >= 3.0, thus setarch --uname-2.6 fails
> > > > # on platforms without VDSO
> > >
> > > OK, added exception for sparc.
> >
> > I don't fully understand the real problem. See also this Debian
> > package comment:
> >  "Apparently glibc does not support 2.6 personality on some
> >   architectures when built to require newer kernels (e.g. >= 3.2).
> >   See https://bugs.debian.org/806911"
> >
> > Couldn't we tell setarch at build time that uname26 will not work
> > with the used glibc?
>
> Is there any way how to detect it? Do we really want it?
>
> I don't like if userspace utils want to be more smart than kernel or
> any abstraction layers in libc -- in many case is better to
> strerror() + exit() than #ifdef or if() in code based on kernel or
> libc version.
>
> The code is possible to compile, the rest is about the real
> environment where the util is executed. I guess you can update kernel
> or libc without ABI break.
>
> The another story is that downstream kernel version says nothing due
> to massive backports and number of patches in distributions.

I understand. BTW I guess any personality option may have the capability 
to let an arbitrary executed binary fail. The user should know what he 
is doing. We should not stop him from "running" kernel 2.6 with a libc 
which does not support it. Maybe he even wants to use setarch to find 
out what exactly happens in this case.

Moreover the executed binary even does not need to be linked against the 
same libc like our setarch. Actually we would only need to have a 
2.6-compatible test binary rather than /bin/echo.

> > On openSUSE 13.2,arm7vl and on that debian,sparc machine we see
> > this diff:
> >
> >  Switching on STICKY_TIMEOUTS.
> >  Switching on ADDR_LIMIT_3GB.
> >  Switching on UNAME26.
> > -success
> > +FATAL: kernel too old
> >
> > Where does the "FATAL" message come from? Is it printed directly by
> > glibc? If yes then we could use it to skip the test. (Allthough the
> > kernel is not really too old but probably something is too new or
> > just different.)
> >
> > But on openSUSE 13.2 arm6vl and aarch64 I don't get this last
> > "FATAL" message but a segfault instead! Is there something we could
> > do in setarch to avoid this segfault? (These arm6vl and aarch64
> > machines seem to run differently as "qemu_user_space_build").
> >
> > BTW the test works fine on openSUSE 13.1 and 42.1. (newer and older
> > than 13.2).
>
> I think use "FATAL: ..." to skip the test would be good enough. Not
> sure about segfault :-)

I will add some more tests without --uname-2.6 and also handle 
that "kernel too old" message.

Regarding segfault I think it's a good idea to add another verbose 
message to setarch, like "exec command" right before  execvp(). Then we 
will see whether at least our own code survives until this point 
without crashing.

> Maybe for arms and sparc use TS_KNOWN_FAIL="yes", it does not have
> to be perfect (especially if we know about the issue and it's
> relevant for "old" kernels only).

It looks like "setarch $(uname -m) ..." should work on any arch.The 
failed logs we see are only because of --uname-2.6 incompatibility plus 
other problems on "qemu user space" where also many other things do not 
work as expected,


cu,
Rudi

