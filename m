Return-Path: elseifthen@gmx.com
Subject: Re: pull: hwclock 27 changes
To: Karel Zak <kzak@redhat.com>, Sami Kerola <kerolasa@iki.fi>
References: <20161231214107.8658-1-kerolasa@iki.fi>
 <05e4405f-8096-9261-f9f2-d2c6b84675bc@gmx.com>
 <070fc458-ed69-a09c-11cc-42bb50fec888@gmx.com>
 <alpine.LNX.2.20.1701072212010.9096@imuri>
 <20170109113201.kt3mmxr7fqlwscdm@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <0e70d024-09f0-929f-f22f-ba29d3909e00@gmx.com>
Date: Mon, 9 Jan 2017 08:53:27 -0500
MIME-Version: 1.0
In-Reply-To: <20170109113201.kt3mmxr7fqlwscdm@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 01/09/2017 06:32 AM, Karel Zak wrote:
> On Sat, Jan 07, 2017 at 11:06:23PM +0000, Sami Kerola wrote:
>>>>
>>>>
>>>> I tried to convince Karel of this long ago. This code has been broken
>>>> from day one, so nobody can be using it. IMO, it should be removed now.
>>>>
>>>>
>>
>> I agree. --compare is broken. I think there are couple options.
>>
>> 1) remove --compare code, and mention in manual page it's gone
>> 2) keep the code, but deprecate it
>> 3) keep the code, and fix it (but how???)
>> 4) keep the broken code and whistle happy days theme song
>> 5) something else
>>
>> I am 60-40 leaning towards recommending removal. If we don't remove rest 
>> of my 40 goes to deprecate. Karel, I think we need maintainer advice.
> 
> I have re-read our old discussions about this topic and I agree that
> it's better to kill the problematic (broken?) functionality that care
> about backward compatibility. It really seems nobody uses this stuff. 
> 
> So, go ahead and send patch to remove all around --compare.
> 
> BTW, we had discussion about unmaintained adjtimex merge to
> util-linux.
> 
>     Karel
>    
> 

It is true, I suggested picking up the orphaned adjtimex(8) code as an
alternative to inserting it's functionality into hwclock(8). However, I
have since learned that the useful functions of adjtimex(8) are
available via the ntp utilities.  The rest of its (dis)abilities have
the same problems we are seeing when reimplementing them into
hwclock(8). I think perhaps there were good reasons adjtimex(8) was
abandoned. Before, I believed adjtimex(8) might be a good fit for
util-linux, now I am not so sure. If someone demonstrates a useful
purpose for it I will change my position.
