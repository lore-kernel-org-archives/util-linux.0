Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <CAG27Bk3zu-8Qar_k44uM3_8_kOddJkqvb1be1_KmjkBGfBGcYA@mail.gmail.com>
References: <5470FE32.9030805@gmx.com>
	<CAG27Bk3zu-8Qar_k44uM3_8_kOddJkqvb1be1_KmjkBGfBGcYA@mail.gmail.com>
Date: Sun, 23 Nov 2014 15:32:19 +0000
Message-ID: <CAG27Bk1cCo_S0txKeFtAb3+oEQn9k24h9Ty7+E++Oxg93pVeQA@mail.gmail.com>
Subject: Re: RFC hwclock: refactoring
From: Sami Kerola <kerolasa@iki.fi>
To: JWP <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 23 November 2014 at 13:31, Sami Kerola <kerolasa@iki.fi> wrote:
> On 22 November 2014 at 21:20, JWP <elseifthen@gmx.com> wrote:
>> So, I noticed when *fdisk were rewritten that some antiquated
>> code was dropped.  I would like some opinions on whether this
>> should be done when refactoring hwclock.
>>
>> For example, do we need a workaround for the 1994 Award BIOS
>> bug?
>
> I agree with Benno, it is time to say goodbye to that code.
>
>> Do we need Alpha code?  Is there a Linux distro that
>> still officially supports Alpha machines?
>
> I'm not sure if there is any up to date distribution for Alpha. Kernel
> crew seems to still care alpha, so it is not completely dead.
>
> http://marc.info/?t=140518903000002&r=1&w=2
>
> Maybe the question should be rephrased. How about dropping the Alpha
> cmos support? It looks like Alpha has rtc support.
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/alpha/kernel/rtc.c
>
>> Any other ideas regarding this topic are welcome.
>
> Removal of i386 references should be safe.
>
> http://news.softpedia.com/news/Linux-Kernel-3-8-Says-Goodbye-to-i386-314293.shtml
>
> Since there is no other than Alpha & i386 references to cmos code, all
> of it is subject for removal.

JWP,

It's a rainy day here, so I decided to make initial attempt to remove
cmos & --badyear. Maybe something like these are what you are thinking
of.

https://github.com/kerolasa/lelux-utiliteetit/commit/fa8825f77996dfad39bd09240729287706f6e72f
https://github.com/kerolasa/lelux-utiliteetit/commit/74edf1aa9c16d351e9fdb25a961ec1932c60c674

After a clean up like that there is still tons to do. For example this
snippet here

/*
 * struct rtc_time is present since 1.3.99.
 * Earlier (since 1.3.89), a struct tm was used.
 */

is screaming obsolete.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
