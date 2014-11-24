Return-Path: elseifthen@gmx.com
Message-ID: <54728FF3.2020600@gmx.com>
Date: Sun, 23 Nov 2014 20:54:59 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: kerolasa@gmail.com
CC: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Subject: Re: RFC hwclock: refactoring
References: <5470FE32.9030805@gmx.com>	<CAG27Bk3zu-8Qar_k44uM3_8_kOddJkqvb1be1_KmjkBGfBGcYA@mail.gmail.com> <CAG27Bk1cCo_S0txKeFtAb3+oEQn9k24h9Ty7+E++Oxg93pVeQA@mail.gmail.com>
In-Reply-To: <CAG27Bk1cCo_S0txKeFtAb3+oEQn9k24h9Ty7+E++Oxg93pVeQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

On 11/23/2014 10:32 AM, Sami Kerola wrote:
>> On 23 November 2014 at 13:31, Sami Kerola <kerolasa@iki.fi> wrote:
>>> On 22 November 2014 at 21:20, JWP <elseifthen@gmx.com> wrote:
>>> So, I noticed when *fdisk were rewritten that some antiquated
>>> code was dropped.  I would like some opinions on whether this
>>> should be done when refactoring hwclock.
>>>
>>> For example, do we need a workaround for the 1994 Award BIOS
>>> bug?
>>
>> I agree with Benno, it is time to say goodbye to that code.
>>
>>> Do we need Alpha code?  Is there a Linux distro that
>>> still officially supports Alpha machines?
>>
>> I'm not sure if there is any up to date distribution for Alpha. Kernel
>> crew seems to still care alpha, so it is not completely dead.
>>
>> http://marc.info/?t=140518903000002&r=1&w=2
>>
>> Maybe the question should be rephrased. How about dropping the Alpha
>> cmos support? It looks like Alpha has rtc support.


I intentionally did not include --directisa and hwclock-cmos.c in my
RFC, because my current position is that I2C access should remain in
hwclock for troubleshooting and testing purposes.

Your marc.info link seems to be broken.

>>
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/alpha/kernel/rtc.c
>>
>>> Any other ideas regarding this topic are welcome.
>>
>> Removal of i386 references should be safe.
>>
>> http://news.softpedia.com/news/Linux-Kernel-3-8-Says-Goodbye-to-i386-314293.shtml
>>
>> Since there is no other than Alpha & i386 references to cmos code, all
>> of it is subject for removal.

The __i386__ macro is set for all x86 platforms. They all support the ISA
architecture and therefore can use direct access methods to the persistent
clock.  That includes x86_64, even though the current iteration of hwclock
does not allow it, which is one of many hwclock bugs I will be fixing.


> 
> JWP,
> 
> It's a rainy day here, so I decided to make initial attempt to remove
> cmos & --badyear. Maybe something like these are what you are thinking
> of.
> 
> https://github.com/kerolasa/lelux-utiliteetit/commit/fa8825f77996dfad39bd09240729287706f6e72f
> https://github.com/kerolasa/lelux-utiliteetit/commit/74edf1aa9c16d351e9fdb25a961ec1932c60c674
> 
> After a clean up like that there is still tons to do. For example this
> snippet here
> 
> /*
>  * struct rtc_time is present since 1.3.99.
>  * Earlier (since 1.3.89), a struct tm was used.
>  */
> 
> is screaming obsolete.
> 

All of the code will be changing, Karel ask me to refactor it outside
of the main development channel.  I wanted to see if the Alpha and 
Award code was somehow important to someone.  My opinion is to remove
it, but maybe there is something I am unaware of.

Even the source for the aboot Alpha boot-loader, and the previous center
of all things Linux-Alpha, alphalinux.org is gone.

I do wonder why the kernel hasn't dropped it yet though.

I'm curious as to what Mr. Z's thoughts are going to be.

Thanks for your time and input Sami!
