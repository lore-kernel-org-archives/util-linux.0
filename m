Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-it0-f66.google.com ([209.85.214.66]:34484 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753548AbeAFQq0 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 6 Jan 2018 11:46:26 -0500
Received: by mail-it0-f66.google.com with SMTP id m11so7355459iti.1
        for <util-linux@vger.kernel.org>; Sat, 06 Jan 2018 08:46:25 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <3b97fbb3-d191-1aa1-2d6e-ee8e17174cea@gmx.com>
References: <27af199a-8ec2-634f-6e99-dd4047f9d5f4@gmx.com> <c0ee83b1-2736-313d-802b-4937c6f71d85@gmx.com>
 <20171229113824.72y6cgyqta42mt2y@ws.net.home> <3b97fbb3-d191-1aa1-2d6e-ee8e17174cea@gmx.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 6 Jan 2018 16:46:25 +0000
Message-ID: <CAG27Bk2g_whRsFO1X0Mies6sQp34sWDocQv3zyfgp4fUMt+4Vw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hwclock: add --ul-debug implementing debug.h
To: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 6 January 2018 at 16:11, J William Piggott <elseifthen@gmx.com> wrote:
>
>
> On 12/29/2017 06:38 AM, Karel Zak wrote:
>> On Sun, Dec 24, 2017 at 03:38:58PM -0500, J William Piggott wrote:
>>>
>>> Undocumented at this time, because it is a skeleton
>>> implementation.  More debugging points are to be added after
>>> refactoring is complete, or ad hoc in the mean time.
>>>
>>> When fully implemented, enough time may have passed that the
>>> deprecated --debug could be used to replace --ul-debug.
>>
>> We use everywhere env.variables (e.g. HWCLOCK_DEBUG=). The macro
>> __UL_INIT_DEBUG() already provides all necessary functionality for
>> this purpose.
>>
>> It also allows to use human readable names for the masks or hex
>> numbers. See for example  sys-utils/lsns.c or libsmartcols/src/init.c
>> for more complex usage. The human readable masks are optional and now
>> used by shared libs only, see for example "LIBSMARTCOLS_DEBUG=help
>> lsns".
>>
>> I'd like to keep things consistent and with no exceptions...
>>
>> IMHO "hwclock --verbose" is good idea for ordinary users and
>> "HWCLOCK_DEBUG=all hwclock" for developers.
>>
>>     Karel
>>
>
> Karel,
>
> Sami sent me a patch doing exactly that. So I made time to digest debug.h; then
> I replied that I had reversed my position; I don't like debug.h for hwclock.
>
> I slept on it, and thought perhaps using an option instead of an env might be
> an acceptable compromise. So I figured out how to make debug.h use an option.
>
> Would it not be 'consistent' to say that commands use a debug option, and libs
> use a debug env?
>
> Consistent in this case isn't about the code, but the UI; correct? So doesn't
> consistent really translate to convenient for developers. That does not seem
> like a strong argument to me. A proportionate counter point could be that it is
> more convenient to enter 'hwclock -d all' then 'HWCLOCK_DEBUG=all hwclock'.
>
> I'm more interested in asking: how does using an env over an option benefit the
> code? I think it does not. Commands already have the code to parse options;
> adding more code to parse an env which serves no benefit to the application,
> IMO, is code bloat (and possibly a security risk).
>
> What I dislike the most is that debugging is very seldom used, yet debugging is
> initialized unconditionally whether it is wanted or not. This is completely
> unnecessary; an option does the job just as well without the added overhead.
> For time sensitive commands like hwclock this is just one more place for
> preemption to slip in. The one thing left that I really want to fix on hwclock
> it its precision.  At least some of that problem is preemption. Using an option
> over an env eliminates that.
>
> My approach to debug.h adds a single line to hwclock.c. It eliminates the
> unconditional debugging initialization and the other unnecessary code.
>
> Regarding debug.h in general, is this an elegant solution?
>   disk-utils/cfdisk.c:2691
>         fdisk_init_debug(0);
>         scols_init_debug(0);
>         cfdisk_init_debug();
>
> CFDISK_DEBUG=all LIBFDISK_DEBUG=all LIBBLKID_DEBUG=all \
> LIBSMARTCOLS_DEBUG=all LIBSMARTCOLS_DEBUG_PADDING=on cfdisk
>
> Is anyone else (other than e2fsprogs) using this approach?
>
> I also wonder if the way debug.h is using the env argument is a potential security
> whole? I didn't note any input sanitizing being done?
>
> In the end I just do not like the debug.h solution. It's a solution in search
> of a problem; a problem that commands do not have. I understand the concept for
> libraries, but I'm not convinced that it is the best solution for them either.
>
> Anyway, Sami has a patch queued that uses the env, if that is what you want.
> Please remove my name from his commit messages, as I object to using debug.h in
> hwclock.

Demonstrative debug.h work that is referred in previous message can ben found
from here:

git://github.com/kerolasa/lelux-utiliteetit.git hwclock-debug

The last commit 'hwclock: add cmos debug support' should not be merged. It is
does too much messaging in sections where delays are not welcome. That commit
was supposed to show how to get debug.h to work across source files. IMHO this
branch is not quite good enough to be merged. What is needed is messaging at
lines that make sense and is useful, and hwclock-rtc.c messaging.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
