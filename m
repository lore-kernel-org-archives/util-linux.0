Return-Path: psusi@ubuntu.com
Message-ID: <54AE0005.9070502@ubuntu.com>
Date: Wed, 07 Jan 2015 22:56:53 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Linda Walsh <lkml@tlinx.org>
CC: util-linux@vger.kernel.org, Matthew Eaton <m.eaton82@gmail.com>,
        Karel Zak <kzak@redhat.com>
Subject: Re: fdisk units size & disk manufacturers buying the standard
References: <CAF+0mvmE_i0P350hT4E4a-ZTTuuS5PdZ2vw1siQ2HowpB2Xn-g@mail.gmail.com>	<20141204130044.GH1994@x2.net.home> <CAF+0mvm-fGvf3BOL6f8SsJgp75a3CP1xsVwkdD+_zP4hg06npQ@mail.gmail.com> <548619AF.5070900@tlinx.org> <54AB0D8F.2010100@ubuntu.com> <54ADCD95.4010903@tlinx.org>
In-Reply-To: <54ADCD95.4010903@tlinx.org>
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 01/07/2015 07:21 PM, Linda Walsh wrote:
> The basic SI units measure physical, real-world amounts.  Before 
> they were redefined in terms of atomic weights and constants, they 
> were based on physical objects.

So what?

> Metric prefixes were designed to make human calculation easy.
> Computer software and hardware doesn't count nor is measured in
> powers or 10.

Sure, which is why I agree with the age old practice of using 1024
instead of 1000, but that has nothing to do with the fact that a byte
is 2^3 bits.

> Converting a 'byte' to some number of bits, AT BEST, sticks out as 
> a non base-10 unit.  Arguably, 'Bytes' shouldn't be part of the
> metric

And like I said, a watt-hour is in the same boat.

> system as they don't have a fixed size based in the real world. 
> Even today, you can't convert bits to Bytes using a constant
> (ignoring computer architectures that don't have an 8-bit byte),
> communications

Of course you can: that constant is x8.

> speed in Bytes varies by protocol.  1Gb-Base-T ethernet maxes out
> at a theoretical 125MB/s - divisible by 8.  But 10Gb ethernet maxes
> out at 1000MB/s -- with 20% of its bandwidth going to protocol
> overhead.

I'm not aware of any additional overhead that 10Gb ethernet has over
1Gb ethernet, which is the overhead of the packet headers, which the
125MB/s figure does not take into account ( and that is base 10 MB,
not base 2 ).

> It was inaccurate for me to call 'B' a prefix -- as it doesn't
> prefix anything.  More accurately, it is variable,
> context-relative, derived unit.  And is completely out of place
> with base-10 units.

You didn't call it a prefix, you called it a unit, and you said that
because it is 8 times another unit ( bits ), it that should inherently
alter the meaning of the prefix applied to it.

> The HD industry blew it by talking about physical memory in Bytes
> because again -- what the HD provides is some number of 'bits'.
> That isn't

No, it provides some number of sectors, which historically are each
512 bytes.

> convertible to Bytes using a fixed constant.  I'm not sure about

Again, bytes are convertible to sectors by multiplying by 8.

> modern drives, but used to be you could vary the sector size on
> SCSI disks and end up with a disk that had a different number of
> Bytes.

Perhaps on a vendor specific basis, but not as part of the scsi
standard.  People used to do the same with floppy disks since the
control logic actually was accessible to the cpu instead of being
integrated into the drive.  This really hasn't been the case since the
advent of IDE ( what?  25 years ago ) though.

> The physical platters still had the same number of bits, but it's 
> up to software to decide how many bytes are squeezed out of that
> space. I.e. -- Bytes are a software-defined-unit that don't exist
> in the real world -- they are logical, derived units.

No, the physical platters don't hold bits at all.  They record an
analog signal that the controller has to decode into bits.  The
ability to do so depends on the signal to noise ratio, which gets
worse the higher you push the buad rate.  Some controllers and media (
and different regions of the media ) could push it higher than others
before the error rate got bad.

> It's not clear how much longer disk manufacturer's will continue to
> use their 'revised' computer-units as the memory manufacturers are
> slowly replacing platter-based technology.  You can't buy memory in
> base-10 units.  RAM comes in sizes of base-2.  You can't buy a
> 1000*1000*1000-bit RAM chip (at least not off-the-shelf).  While 
> flash memory chips are also sold using base-2 prefixes, its not
> clear how SSD's will go.  Since they are really solid state memory
> chips, it doesn't seem likely they will be measured in terms of bit
> density per track.

It isn't going away; SSDs are using base 10 probably in part for the
same reason HDD makers did ( it makes them seem larger ), and in part
because they have to reserve some of the flash for over provisioning.

> Basically, using base 10 prefixes to describe something that only 
> comes in sizes of base-2 is a setup for miscommunication as well as
> inherently being *unable* to accurately describe the quantities 
> used in the computer field.

The reason base 2 is convenient for ram is because that is how it
naturally aligns due to the way it is addressed, and they don't have
physical constraints in the manufacturing process, not because there
are 8 bits in a byte.  Bytes easily could have been defined to be 10
or 12 bits and it would still make sense for ram to be built in power
of 2 units of bytes.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJUrgAFAAoJENRVrw2cjl5RlXcH/2ZupptQxOjUJGS2dMyy8I8K
TltLZJYGyTWsypcgVXU9DwfwsHVNItk8ir4fYSWaJakq/FhXZjMFo2SwvFEybPwK
3Erdnr6f46lxdmU0EZ3ydwDK8X03p190gZKlqEhQgOUJbYY2IjrCIrmhgAAFD8QU
Ol+plU6hGdq5RLxnTD5hNO4rQB4KatW6TeQsY1JbIfT0X1oFJ+/jefwV1P9jpY8/
B5Zv6TtwECiga/HqaJVQ4jmxIcnHX5H56PNY1mLAporlB70m3q00iNdciAm7HKm4
uqvn4YEmnsK1eTmIN5vWFsVsvR3esOo2MtC3mUSk+6N214spi67dXLioNrKDmRw=
=y0cy
-----END PGP SIGNATURE-----
