Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qg0-f45.google.com ([209.85.192.45]:55781 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbbAIO7v (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 9 Jan 2015 09:59:51 -0500
Received: by mail-qg0-f45.google.com with SMTP id z107so9082775qgd.4
        for <util-linux@vger.kernel.org>; Fri, 09 Jan 2015 06:59:50 -0800 (PST)
Message-ID: <54AFECE2.1050407@ubuntu.com>
Date: Fri, 09 Jan 2015 09:59:46 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Linda Walsh <lkml@tlinx.org>
CC: util-linux@vger.kernel.org, Matthew Eaton <m.eaton82@gmail.com>,
        Karel Zak <kzak@redhat.com>
Subject: Re: fdisk units size & disk manufacturers buying the standard
References: <CAF+0mvmE_i0P350hT4E4a-ZTTuuS5PdZ2vw1siQ2HowpB2Xn-g@mail.gmail.com>	<20141204130044.GH1994@x2.net.home> <CAF+0mvm-fGvf3BOL6f8SsJgp75a3CP1xsVwkdD+_zP4hg06npQ@mail.gmail.com> <548619AF.5070900@tlinx.org> <54AB0D8F.2010100@ubuntu.com> <54ADCD95.4010903@tlinx.org> <54AE0005.9070502@ubuntu.com> <54AF3ED8.2030508@tlinx.org>
In-Reply-To: <54AF3ED8.2030508@tlinx.org>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/8/2015 9:37 PM, Linda Walsh wrote:
> Phillip Susi wrote:
>> And like I said, a watt-hour is in the same boat.
> Not at all.  An hour is NOT a metric unit and is not, officially, 
> used with SI prefixes.  Clearly, if it is in the same boat, you
> would be claiming that the Byte is not a metric unit -- and you 
> would be right.

Umm... yea.. you said bytes are not SI, I'm saying watt-hours aren't
either.  You said that means the kilo prefix should be base 2 since a
byte is 2^3 bits.  I'm saying by the same silly logic, a
killowatt-hour should be 3600 watt-hours since a watt-hour is 60^2
joules.  Are you getting it now?

> See kernel messages for a 10b-T ethernet.
> 
> [   21.224641] ixgbe 0000:05:00.0: PCI Express bandwidth of 32GT/s 
> available [   21.224644] ixgbe 0000:05:00.0: (Speed:5.0GT/s, Width:
> x8, Encoding Loss:20%)
> 
> I don't recall a 20% encoding loss in 1Gb or 100Mb ethernet and
> the kernel displays no such messages for the slower speed cards.

That message is referring to the encoding loss on the pci express gen
2 bus, not ethernet.

> excludes optional protocols.  The 125MB/s is a max theoretical rate
> and is in base 2.

No, as I said, that is base 10, not base 2.  1,000,000,000 bps / 8
bits per byte = 125,000,000 bytes / second, not 131,072,000 bytes.

> In practice, 125 millionBytes for writes and 119 millionBytes are
> a benchmark maximum that includes headers (SMB/CIFS for the test I
> most frequently run).

Nope, not possible.

> I.e. 125millionBytes/s -- the base10 number IS a benchmark maximum 
> that includes protocol headers (specifically for SMB).

Nope.

> I would assert you are contradicting yourself.  You said the
> platters don't contain any logical computer storage unit:
> 
> No, the physical platters don't hold bits at all.  They record an 
> analog signal that the controller has to decode into bits.  The 
> ability to do so depends on the signal to noise ratio, which gets 
> worse the higher you push the buad rate.  ...
> 
> 
>> This really hasn't been the case since the advent of IDE ( what?
>> 25 years ago ) though.
> ---- SCSI didn't go away with the advent of IDE.  Though it is true
> IDE drivers were dumbed down for cost

I didn't say it did.  I said the SCSI standards never have specified a
way to ask the drive to change its low level format.  IIRC, you could
do this with MFM/RLL hard drives, but when IDE came along, it too
decided not to give a way to do a low level format.  Thus the nature
of how the drive actually stores data on the platter is specifically
hidden from the computer and the drive deals only with whole sectors,
as far as the computer is concerned.

>>> The physical platters still had the same number of bits, but
>>> it's up to software to decide how many bytes are squeezed out
>>> of that space. I.e. -- Bytes are a software-defined-unit that
>>> don't exist in the real world -- they are logical, derived
>>> units.
>> 
>> No, the physical platters don't hold bits at all.
> But you said above they hold sectors @ 512 bytes each, which you
> have defined as being 8 bits each.  That would imply 4kbit - data /
> physical sector.

There is no such thing as a "physical sector".  On the platter, we are
in the analog domain now rather than the digital, so here everything
is a continuous function.  You can not point to an exact spot and say
right there is the first bit in the sector, right there is the second,
and so on.  You get a continuous signal that you have to decide to
recognize as a series of symbols that can be mapped to some number of
bits.  Exactly where they start and end is a bit fuzzy, which is why
decoding it sometimes gets it wrong.

> But their core unit 'bit' like the 'second', is based on a minimal
> distinct magnetic flux variation on the media.  It is directly
> usable with SI prefixes as

No, it isn't.  The bit is based purely on a mathematical notion of a
base 2 numbering system because digital logic is very good at
representing two distinct states.  The fact that we came up with ways
of recording bits in signals of magnetic flux on spinning rust has
nothing to do with the definition of a bit.  Even such recordings
typically do not record a single bit per baud, but use multi bit
symbols, such as 8PSK or 16QAM.

> You can't get the correct number of bytes transfered over 1 300bps
> modem by dividing by 8.  (Note, encoding overhead is not the same
> type of overhead as protocol overhead, as the encoding overhead is
> media specific, while protocol overhead is not).

Umm, yes, that is exactly what you do.  It kind of follows from the
definition of bits and bytes.  Of course, there weren't 1,300 bps
modems, but still.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUr+ziAAoJENRVrw2cjl5RS0kIAIqE61iOR3mFfqBz0gt9eP7B
PylDcPBdJw1kg7BNSTpMvLBRqutePvIDGIDr9+b9xKsx24g6+Dl42AdZj3dNdfak
7yih6goDCgAjARpSoSsYNGS7IiTTDtIEpc+bXIyQJzKzBl5n8MQV2VDyYEUXjZvN
sN0vZHnM2g3BoXUK0nNJbnvgiykyS964QSv0UgmdqYfqg6KtAxV3tFZtnZt/EYYU
XGxJaK8wvoIOL+lb+qxOpr5Dsa9XEFvHNFD6yM+W2/9bIe0TE9wb5IQJGF+b/IiM
b8EsVdKHem2Inorp6Yfuxklt0Dy5TWMhME7p0k2afo9gE/v4MmwE9s1Rbde5+OM=
=mvaH
-----END PGP SIGNATURE-----
