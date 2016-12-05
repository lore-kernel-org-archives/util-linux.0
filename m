Return-Path: mtk.manpages@gmail.com
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
In-Reply-To: <20161205120631.qgyuymptnoacnppr@ws.net.home>
References: <CAKgNAkjtq0kh7X5umw26FQhh_cork1yb_C-gNL4jHZNr7Fz2qA@mail.gmail.com>
 <20161205115129.hvxasynsgszi33tu@ws.net.home> <CAKgNAkgLVYfiroRtGbP48uFps8=EGtAhdt5iLsmVdX0zsRAJMw@mail.gmail.com>
 <20161205120631.qgyuymptnoacnppr@ws.net.home>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Mon, 5 Dec 2016 15:16:40 +0100
Message-ID: <CAKgNAkix3xqS-yOOTZxi9K0X1_oMm7js1Rv-qM7SPNfAxKs3zw@mail.gmail.com>
Subject: Re: Pull request: nsenter(1) fixes
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 5 December 2016 at 13:06, Karel Zak <kzak@redhat.com> wrote:
> On Mon, Dec 05, 2016 at 12:56:36PM +0100, Michael Kerrisk (man-pages) wrote:
>> Hello Karel,
>>
>> On 5 December 2016 at 12:51, Karel Zak <kzak@redhat.com> wrote:
>> > On Mon, Dec 05, 2016 at 11:25:45AM +0100, Michael Kerrisk (man-pages) wrote:
>> >> I have various fixes to send, but I'll start small, with a couple of
>> >> fixes for nsenter(1).
>> >
>> >  Applied ... but you have removed "See also.. " sentence from
>> >  description of the --user. Would be better to keep there?
>>
>> My apologies. That was a blunder. I can send you a patch, or do you
>> want to revert that deletion manually. Let me know which you prefer.
>
> Fixed, I did the change manually.

Thanks. And thanks also for spotting my blunder.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
