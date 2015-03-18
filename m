Return-Path: elseifthen@gmx.com
Message-ID: <5508D1E0.205@gmx.com>
Date: Tue, 17 Mar 2015 21:16:16 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>, Benno Schulenberg <bensberg@justemail.net>
CC: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 4/5] hwclock: add '11 minute mode' information
References: <5503364E.6010302@gmx.com> <550338F2.2000908@gmx.com> <1426434447.3228874.240611693.0EF4BF24@webmail.messagingengine.com> <20150317095745.GT28925@ws.net.home>
In-Reply-To: <20150317095745.GT28925@ws.net.home>
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>



On 03/17/2015 05:57 AM, Karel Zak wrote:
> On Sun, Mar 15, 2015 at 04:47:27PM +0100, Benno Schulenberg wrote:
>> "When in this state, bit 6 (the bit that is set in the mask 0x0040)
>> of the kernel's time_status variable is *unset*."
> 
> Yes, this is more readable (at least for me:-).

I explained to Mr Schulenbuerg that I wrote it that way for layman users. 
Are they going to understand 'the bit that is set in the mask 0x0040'?
What does that even mean? What does 'mask' have to do with it? It could
simply say "the bit that is set by binary 0x0040"
How does that differ from saying the binary 64's bit?

Using hex will help the average user how?

I used decimal because adjtimex displays the status variable as a decimal
number:

adjtimex -p
status: 8193

adjtimex -p
status: 8257

Which one is synchronized?

The adjtimex man-page says:

"status" gives the value of the time_status variable in the kernel.
64	clock unsynchronized

The average user will likely have trouble with this.

By saying 'the binary 64 bit' it will allow average users to understand
the relationship.  When Bryan originally wrote this section (it was
removed because of the adjtimex issue), he used the same language 'the 64
bit'. I suspect he did it for the same reasons. I added the binary
number example to help people that do not understand binary to visualize 
exactly where the the unset bit would be. Then if they manage to convert
the adjtimex output from decimal to binary it should be clear to them.

Calling it bit 6 will likely cause average users to make an off-by-one
error. There is no ambiguity with the binary 64 bit.

Karel, it makes good sense to you because you have a clear understanding of
binary bit masks. Does the rest of the world have the same
understanding?

What I wrote is far from optimum, but I do not think this is an
improvement.

> 
>>> +It can be turned off by running anything, including
>>>  .BR \%hwclock\ \-\-hctosys ,
>>>  that sets the System Clock the old fashioned way.
>>
>> I would move the "including..." phrase to the end of the sentence,
>> as now one at first thinks that really *anything* can turn 11-minute
>> mode off.
> 
> I have applied this two changes.
> 
>     Karel
> 
> 
