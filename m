Return-Path: lkml@tlinx.org
Message-ID: <54ADCD95.4010903@tlinx.org>
Date: Wed, 07 Jan 2015 16:21:41 -0800
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Phillip Susi <psusi@ubuntu.com>
CC: util-linux@vger.kernel.org, Matthew Eaton <m.eaton82@gmail.com>,
        Karel Zak <kzak@redhat.com>
Subject: Re: fdisk units size & disk manufacturers buying the standard
References: <CAF+0mvmE_i0P350hT4E4a-ZTTuuS5PdZ2vw1siQ2HowpB2Xn-g@mail.gmail.com>	<20141204130044.GH1994@x2.net.home> <CAF+0mvm-fGvf3BOL6f8SsJgp75a3CP1xsVwkdD+_zP4hg06npQ@mail.gmail.com> <548619AF.5070900@tlinx.org> <54AB0D8F.2010100@ubuntu.com>
In-Reply-To: <54AB0D8F.2010100@ubuntu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 12/8/2014 4:35 PM, Linda Walsh wrote:
>> They may a fundamental error that any engineer or mathematician 
>> could point out:
>>
>> 'B' == a prefix meaning 2^3bits.  I.e 'B' is a base-2 measurement. 
>> In science and engineering, you just don't mix units like that 
>> unless want to prove you don't know what you are talking about.
>
> While I do despise the HD industry for lieing about drive sizes, I
> have to point out your error here.  How the unit the prefix is applied
> to relates to some other unit has no bearing whatsoever on the prefix
> itself.
-----
The basic SI units measure physical, real-world amounts.  Before
they were redefined in terms of atomic weights and constants, they
were based on physical objects.

Metric prefixes were designed to make human calculation easy.  Computer
software and hardware doesn't count nor is measured in powers or 10.


The metric prefixes were not designed nor intended to be used with
non-base-10 units.  If the application of prefixes had no
"proper" set of units, use of milli-miles asking for conversions
to milli-feet or microns wouldn't make your head hurt.

Converting a 'byte' to some number of bits, AT BEST, sticks out as
a non base-10 unit.  Arguably, 'Bytes' shouldn't be part of the metric
system as they don't have a fixed size based in the real world.
Even today, you can't convert bits to Bytes using a constant (ignoring
computer architectures that don't have an 8-bit byte), communications
speed in Bytes varies by protocol.  1Gb-Base-T ethernet maxes out at
a theoretical 125MB/s - divisible by 8.  But 10Gb ethernet maxes out
at 1000MB/s -- with 20% of its bandwidth going to protocol overhead.

It was inaccurate for me to call 'B' a prefix -- as it doesn't prefix
anything.  More accurately, it is variable, context-relative,
derived unit.  And is completely out of place with base-10 units.

The HD industry blew it by talking about physical memory in Bytes because
again -- what the HD provides is some number of 'bits'.  That isn't
convertible to Bytes using a fixed constant.  I'm not sure about
modern drives, but used to be you could vary the sector size on SCSI
disks and end up with a disk that had a different number of Bytes.
The physical platters still had the same number of bits, but it's
up to software to decide how many bytes are squeezed out of that space.
I.e. -- Bytes are a software-defined-unit that don't exist in the real
world -- they are logical, derived units.


It's not clear how much longer disk manufacturer's will continue
to use their 'revised' computer-units as the memory manufacturers
are slowly replacing platter-based technology.  You can't buy memory
in base-10 units.  RAM comes in sizes of base-2.  You can't buy
a 1000*1000*1000-bit RAM chip (at least not off-the-shelf).  While
flash memory chips are also sold using base-2 prefixes, its not clear
how SSD's will go.  Since they are really solid state memory chips,
it doesn't seem likely they will be measured in terms of bit density
per track.

Basically, using base 10 prefixes to describe something that only
comes in sizes of base-2 is a setup for miscommunication as well
as inherently being *unable* to accurately describe the quantities
used in the computer field.

If one wants to use base-10 prefixes they should stick with bits, but
as soon as one moves to a base-2 (usually) sized unit, one should use
base-2 prefixes.  Use of base-10 prefixes for base-2 computer Software
and Hardware creates the same inherent difficulties as trying to use
base-10 prefixes with inches, feet, and pounds and was pushed by the
HD industry for some of the exact same reasons why it is preferable
for them to stick with english units -- you generally need a
calculator to find out cost/unit.  HD manufacturers successfully
pulled a marketing scam to get those units accepted -- because
from the manufacturing standpoint, platters with 'X' bits/cm^2 can
be manufactured to decimal specs -- it's just that they can't be
*used* that way.  They only way a computer can use a hard disk is if
it if formatted into some binary size.

Anyway, sorry to confuse the issue by calling Bytes a prefix.  My bad.
