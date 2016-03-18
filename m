Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48666 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752564AbcCROgC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Mar 2016 10:36:02 -0400
Date: Fri, 18 Mar 2016 15:36:00 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: fix fdisk/bsd for alpha
Message-ID: <20160318143600.mmpkpnxaujhwans3@ws.net.home>
References: <1458088844-23523-1-git-send-email-sweet_f_a@gmx.de>
 <201603161627.10907.sweet_f_a@gmx.de>
 <20160317133341.fwjakpzsdln3oivg@ws.net.home>
 <201603172252.49517.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201603172252.49517.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 17, 2016 at 10:52:49PM +0100, Ruediger Meier wrote:
> On Thursday 17 March 2016, Karel Zak wrote:
> > On Wed, Mar 16, 2016 at 04:27:10PM +0100, Ruediger Meier wrote:
> > > And we could disable setarch's uname26 test because
> > > # glibc requires kernel >= 3.0, thus setarch --uname-2.6 fails
> > > # on platforms without VDSO
> >
> > OK, added exception for sparc.
> 
> I don't fully understand the real problem. See also this Debian package 
> comment:
>  "Apparently glibc does not support 2.6 personality on some
>   architectures when built to require newer kernels (e.g. >= 3.2).
>   See https://bugs.debian.org/806911"
> 
> Couldn't we tell setarch at build time that uname26 will not work with 
> the used glibc?

Is there any way how to detect it? Do we really want it?

I don't like if userspace utils want to be more smart than kernel or 
any abstraction layers in libc -- in many case is better to strerror() 
+ exit() than #ifdef or if() in code based on kernel or libc version. 

The code is possible to compile, the rest is about the real environment 
where the util is executed. I guess you can update kernel or libc without
ABI break.

The another story is that downstream kernel version says nothing due
to massive backports and number of patches in distributions.

> On openSUSE 13.2,arm7vl and on that debian,sparc machine we see this 
> diff:
> 
>  Switching on STICKY_TIMEOUTS.
>  Switching on ADDR_LIMIT_3GB.
>  Switching on UNAME26.
> -success
> +FATAL: kernel too old
> 
> Where does the "FATAL" message come from? Is it printed directly by 
> glibc? If yes then we could use it to skip the test. (Allthough the 
> kernel is not really too old but probably something is too new or just 
> different.)
> 
> But on openSUSE 13.2 arm6vl and aarch64 I don't get this last "FATAL" 
> message but a segfault instead! Is there something we could do in 
> setarch to avoid this segfault? (These arm6vl and aarch64 machines seem 
> to run differently as "qemu_user_space_build").
> 
> BTW the test works fine on openSUSE 13.1 and 42.1. (newer and older than 
> 13.2).

I think use "FATAL: ..." to skip the test would be good enough. Not
sure about segfault :-) 

Maybe for arms and sparc use TS_KNOWN_FAIL="yes", it does not have 
to be perfect (especially if we know about the issue and it's 
relevant for "old" kernels only).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
