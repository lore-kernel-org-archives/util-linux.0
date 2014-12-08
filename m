Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:48788 "EHLO
	Ishtar.hs.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbaLHWEE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Dec 2014 17:04:04 -0500
Message-ID: <548619AF.5070900@tlinx.org>
Date: Mon, 08 Dec 2014 13:35:43 -0800
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
CC: Matthew Eaton <m.eaton82@gmail.com>, Karel Zak <kzak@redhat.com>
Subject: Re: fdisk units size & disk manufacturers buying the standard
References: <CAF+0mvmE_i0P350hT4E4a-ZTTuuS5PdZ2vw1siQ2HowpB2Xn-g@mail.gmail.com>	<20141204130044.GH1994@x2.net.home> <CAF+0mvm-fGvf3BOL6f8SsJgp75a3CP1xsVwkdD+_zP4hg06npQ@mail.gmail.com>
In-Reply-To: <CAF+0mvm-fGvf3BOL6f8SsJgp75a3CP1xsVwkdD+_zP4hg06npQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Matthew Eaton wrote:
>>  Frankly, use 10 based calculation in IT is ugly thing, we are not
>>  hard disk device marketing guys...
>>     
>
> I work for a SSD manufacturer! :)
>
> Actually, I agree with you.  But sometimes it's easier for me to see
> 240 GB in fdisk output and know that I have a 240 GB drive plugged in,
> rather than see 223.5 GiB.
>   
----
  The corporations told consumers how it would be so they could better sell
disks -- they bought the standard committee, and it's been screwed since.

They may a fundamental error that any engineer or mathematician could 
point out:

'B' == a prefix meaning 2^3bits.  I.e 'B' is a base-2 measurement.  In 
science
and engineering, you just don't mix units like that unless want to prove 
you don't
know what you are talking about.

NOTE:   saying 24000Gb is fine.  A bit is unit. 

But a Byte, (today), is defined as 2^3 bits.   (Unless someone want's to 
argue
that disk manufacturers really mean to use 10-12 bit bytes... *cough*).

So it becomes obvious -- in telecom, speeds are usually quoted in 
bits/time,
so decimal units make sense.  In most *physical sciences* decimal makes
sense.

Computers don't count in decimal but use binary (Show me 1 memory or
computer-cache description that tells me 16K = 16,000.

Also, disk manufacturers are lying.  Disk space is allocated in 2^9 (512 
Bytes or 2^12 bits)
or 2^12 Bytes (2^15 bits).   They ***CANNOT*** accurate quote disk space 
using
base 10.  I.e. 1MB = 2048 sectors.  But 1MBd = 1954.125 sectors -- and 
you cannot
use 1/8th of a sector.  So ANY figure they give will be a lie as 10 
doesn't divide into
a power of 2 which is how computer space is allocated and used.

Nice the way corporations can buy definitions... just like about 
anything else... ;-(

Another argument.  SI prefixes are applied to physical units (meter, 
gram, liter...etc).
A bit isn't a physical unit, so their argument that physical prefixes 
should apply to
virtual base-2 quantities becomes even more nonsensical.

But hey, what are science math and engineering to the power of ignorant 
consumer
powered corporations?

But SI overstepped their bounds, unless they want to define the 'bit' 
and the 'Byte' as
metric units and keep a representation of them in some clean room in 
Paris (or
the modern equivalent).




