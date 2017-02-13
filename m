Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 0/3] hwclock: remove date(1)
To: Karel Zak <kzak@redhat.com>, kerolasa@gmail.com
References: <bbd64daa-5431-8c7d-580b-3382a33edccd@gmx.com>
 <CAG27Bk2kJ0P3i82vRK=cREtDhjO0VDBzXXpKpMBTvpnBCWefdA@mail.gmail.com>
 <20170213130408.psp6qoyaa6htl6aa@ws.net.home>
Cc: util-linux <util-linux@vger.kernel.org>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <cf262dfa-c897-b7b7-c361-5e42676e87a7@gmx.com>
Date: Mon, 13 Feb 2017 09:42:23 -0500
MIME-Version: 1.0
In-Reply-To: <20170213130408.psp6qoyaa6htl6aa@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 02/13/2017 08:04 AM, Karel Zak wrote:
> On Sat, Feb 11, 2017 at 11:24:38AM +0000, Sami Kerola wrote:
>> On 10 February 2017 at 20:58, J William Piggott <elseifthen@gmx.com> wrote:
>>> This branch adds the parse_datetime module from the gnu
>>> portability library.
>>
>> Assuming gnulib integration is wanted then replacing bootstrap process,
>> deduplicating pieces of code in include/ with gnulib versions would be in
>> todo list.  For example why one would keep util-linux xmalloc() when gnulib
>> provides the same.  Same is true for close_stdout(), and many other
>> functions.
>>
>> While code reuse is good idea I have doubts if this really is direction
>> where to go to.
> 
> I have no doubts, I'm sure that we don't want it. It's overkill.
> 
I expected that. That's okay, I learned a lot from making it work.

Would you consider a single file: sys-utils/hwclock-parse-datetime.c?
I don't want to waste time rewriting it if the answer is no.
