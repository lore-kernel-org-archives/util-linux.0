Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755809AbeAHKzb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 8 Jan 2018 05:55:31 -0500
Date: Mon, 8 Jan 2018 11:55:27 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] hwclock: add --ul-debug implementing debug.h
Message-ID: <20180108105527.kj62amdwlgoj3f7l@ws.net.home>
References: <27af199a-8ec2-634f-6e99-dd4047f9d5f4@gmx.com>
 <c0ee83b1-2736-313d-802b-4937c6f71d85@gmx.com>
 <20171229113824.72y6cgyqta42mt2y@ws.net.home>
 <3b97fbb3-d191-1aa1-2d6e-ee8e17174cea@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3b97fbb3-d191-1aa1-2d6e-ee8e17174cea@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jan 06, 2018 at 11:11:31AM -0500, J William Piggott wrote:
> Sami sent me a patch doing exactly that. So I made time to digest debug.h; then
> I replied that I had reversed my position; I don't like debug.h for hwclock.

The debugging is mostly about messages in the code and I think debug.h
provides good infrastructure for this purpose. I don't think that the
trigger (env.var or --any-option) should be the reason to ignore
debug.h. Right? :-)

> I slept on it, and thought perhaps using an option instead of an env might be
> an acceptable compromise. So I figured out how to make debug.h use an option.
> 
> Would it not be 'consistent' to say that commands use a debug option, and libs
> use a debug env?

For libs it's definitely better to use env. vars, for command I have
no so strong opinion about it; and yes, I can probably accept --debug, 
but not sure how you want to do that for hwclock, --ul-debug is ugly.

> Consistent in this case isn't about the code, but the UI; correct? So doesn't
> consistent really translate to convenient for developers. That does not seem
> like a strong argument to me. A proportionate counter point could be that it is
> more convenient to enter 'hwclock -d all' then 'HWCLOCK_DEBUG=all hwclock'.

For me env.variable is something more hidden, less visible for end users :-)

> I'm more interested in asking: how does using an env over an option benefit the
> code? I think it does not. Commands already have the code to parse options;
> adding more code to parse an env which serves no benefit to the application,
> IMO, is code bloat (and possibly a security risk).

This is all in debug.h macros, you don't have to add any extra code to
your command. For --debug you have to add getopt stuff.

> What I dislike the most is that debugging is very seldom used, yet debugging is
> initialized unconditionally whether it is wanted or not. This is completely
> unnecessary; an option does the job just as well without the added overhead.

It's one getenv() call, nothing else. See libc for how many env.vars
it's sensitive.

> For time sensitive commands like hwclock this is just one more place for
> preemption to slip in. The one thing left that I really want to fix on hwclock
> it its precision.  At least some of that problem is preemption. Using an option
> over an env eliminates that.
> 
> My approach to debug.h adds a single line to hwclock.c. It eliminates the
> unconditional debugging initialization and the other unnecessary code.

If we want to support an option to trigger debug output than it would
be nice to extend debug.h and add __UL_INIT_DEBUG_FROM_STRING() and
keep it compatible (same) as the original __UL_INIT_DEBUG().
It would be better than atoi().

I'll accept a patch with this extension.

> Regarding debug.h in general, is this an elegant solution?
>   disk-utils/cfdisk.c:2691
> 	fdisk_init_debug(0);
> 	scols_init_debug(0);
> 	cfdisk_init_debug();
> 
> CFDISK_DEBUG=all LIBFDISK_DEBUG=all LIBBLKID_DEBUG=all \
> LIBSMARTCOLS_DEBUG=all LIBSMARTCOLS_DEBUG_PADDING=on cfdisk

I cannot imagine situation when you want to debug all this stuff
together. 

> Is anyone else (other than e2fsprogs) using this approach?

libs has tons of env.variables

> I also wonder if the way debug.h is using the env argument is a potential security
> whole? I didn't note any input sanitizing being done?

The debug messages should not contain any security sensitive stuff
(like passwords or so), enabled debugging should not enable any
functionality, etc. It's just fprintf(stderr, "Hello world I'm doing
this now...")  and everything else is bug.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
