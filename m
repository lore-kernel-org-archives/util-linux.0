Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:47813 "EHLO
	Ishtar.hs.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbbAIChh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 8 Jan 2015 21:37:37 -0500
Message-ID: <54AF3ED8.2030508@tlinx.org>
Date: Thu, 08 Jan 2015 18:37:12 -0800
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Phillip Susi <psusi@ubuntu.com>
CC: util-linux@vger.kernel.org, Matthew Eaton <m.eaton82@gmail.com>,
        Karel Zak <kzak@redhat.com>
Subject: Re: fdisk units size & disk manufacturers buying the standard
References: <CAF+0mvmE_i0P350hT4E4a-ZTTuuS5PdZ2vw1siQ2HowpB2Xn-g@mail.gmail.com>	<20141204130044.GH1994@x2.net.home> <CAF+0mvm-fGvf3BOL6f8SsJgp75a3CP1xsVwkdD+_zP4hg06npQ@mail.gmail.com> <548619AF.5070900@tlinx.org> <54AB0D8F.2010100@ubuntu.com> <54ADCD95.4010903@tlinx.org> <54AE0005.9070502@ubuntu.com>
In-Reply-To: <54AE0005.9070502@ubuntu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Phillip Susi wrote:
>> Converting a 'byte' to some number of bits, AT BEST, sticks out as 
>> a non base-10 unit.  Arguably, 'Bytes' shouldn't be part of the
>> metric
>
> And like I said, a watt-hour is in the same boat.
Not at all.  An hour is NOT a metric unit and is not, officially,
used with SI prefixes.  Clearly, if it is in the same boat,
you would be claiming that the Byte is not a metric unit -- and you
would be right.

SI-base units include: meter, kilogram, second ampere, kelvin, candela,
mole with 'liter' being an acceptable unit but not formally part of the
system.

No where does it talk about things like hours and Bytes being metric
units (http://en.wikipedia.org/wiki/SI_base_unit).


>> speed in Bytes varies by protocol.  1Gb-Base-T ethernet maxes out
>> at a theoretical 125MB/s - divisible by 8.  But 10Gb ethernet maxes
>> out at 1000MB/s -- with 20% of its bandwidth going to protocol
>> overhead.
>
> I'm not aware of any additional overhead that 10Gb ethernet has over
> 1Gb ethernet, 
----
See kernel messages for a 10b-T ethernet.

[   21.224641] ixgbe 0000:05:00.0: PCI Express bandwidth of 32GT/s available
[   21.224644] ixgbe 0000:05:00.0: (Speed:5.0GT/s, Width: x8, Encoding 
Loss:20%)

I don't recall a 20% encoding loss in 1Gb or 100Mb ethernet and the 
kernel displays
no such messages for the slower speed cards.


> which is the overhead of the packet headers, which the
> 125MB/s figure does not take into account ( and that is base 10 MB,
> not base 2 ).
----
    I said theoretical speed -- which excludes packet headers.  
Theoretical speed
excludes optional protocols.  The 125MB/s is a max theoretical rate and 
is in base 2.
In practice, 125 millionBytes for writes and 119 millionBytes are a 
benchmark
maximum that includes headers (SMB/CIFS for the test I most frequently run).

    I.e. 125millionBytes/s -- the base10 number IS a benchmark maximum 
that includes
protocol headers (specifically for SMB).
>
>> It was inaccurate for me to call 'B' a prefix -- as it doesn't
>> prefix anything.  More accurately, it is variable,
>> context-relative, derived unit.  And is completely out of place
>> with base-10 units.
>
> You didn't call it a prefix, you called it a unit, and you said that
> because it is 8 times another unit ( bits ), it that should inherently
> alter the meaning of the prefix applied to it.
----
    I'm sorry, I thought I wrote this:
-------- Original Message --------
Subject: 	Re: fdisk units size & disk manufacturers buying the standard
Date: 	Mon, 08 Dec 2014 13:35:43 -0800
From: 	Linda Walsh
To: 	util-linux@

'B' == a prefix meaning 2^3bits.
-----------

Glad to know that wasn't me....
>
>> The HD industry blew it by talking about physical memory in Bytes
>> because again -- what the HD provides is some number of 'bits'.
>> That isn't
>
> No, it provides some number of sectors, which historically are each
> 512 bytes.
----
I would assert you are contradicting yourself.  You said the platters 
don't contain any
logical computer storage unit:

    No, the physical platters don't hold bits at all.  They record an
    analog signal that the controller has to decode into bits.  The
    ability to do so depends on the signal to noise ratio, which gets
    worse the higher you push the buad rate.  ...


>   This really hasn't been the case since the
> advent of IDE ( what?  25 years ago ) though.
----
SCSI didn't go away with the advent of IDE.  Though it is true IDE drivers
were dumbed down for cost
>
>> The physical platters still had the same number of bits, but it's 
>> up to software to decide how many bytes are squeezed out of that
>> space. I.e. -- Bytes are a software-defined-unit that don't exist
>> in the real world -- they are logical, derived units.
>
> No, the physical platters don't hold bits at all.  
But you said above they hold sectors @ 512 bytes each,
which you have defined as being 8 bits each.  That would
imply 4kbit - data / physical sector.

Bytes are a unit specific to the computer field. 
They are not metric any more than hours.

But their core unit 'bit' like the 'second',
is based on a minimal distinct magnetic flux variation
on the media.  It is directly usable with SI prefixes as
there is a 1-1 mapping of the minimum sized, stable flux changes
per unit area and the devices maximum bit storage. 

You can't get the correct number of bytes transfered over
1 300bps modem by dividing by 8.  (Note, encoding overhead is not
the same type of overhead as protocol overhead, as the encoding overhead
is media specific, while protocol overhead is not).




