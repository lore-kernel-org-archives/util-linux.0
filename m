Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qg0-f41.google.com ([209.85.192.41]:44227 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbbALSu1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 12 Jan 2015 13:50:27 -0500
Received: by mail-qg0-f41.google.com with SMTP id e89so18939045qgf.0
        for <util-linux@vger.kernel.org>; Mon, 12 Jan 2015 10:50:26 -0800 (PST)
Message-ID: <54B41759.4070909@ubuntu.com>
Date: Mon, 12 Jan 2015 13:50:01 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Linda Walsh <lkml@tlinx.org>
CC: util-linux@vger.kernel.org
Subject: Re: fdisk units size & disk manufacturers buying the standard
References: <CAF+0mvmE_i0P350hT4E4a-ZTTuuS5PdZ2vw1siQ2HowpB2Xn-g@mail.gmail.com>	<20141204130044.GH1994@x2.net.home> <CAF+0mvm-fGvf3BOL6f8SsJgp75a3CP1xsVwkdD+_zP4hg06npQ@mail.gmail.com> <548619AF.5070900@tlinx.org> <54AB0D8F.2010100@ubuntu.com> <54ADCD95.4010903@tlinx.org> <54AE0005.9070502@ubuntu.com> <54AF3ED8.2030508@tlinx.org> <54AFECE2.1050407@ubuntu.com> <54B0725A.2030704@tlinx.org>
In-Reply-To: <54B0725A.2030704@tlinx.org>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/9/2015 7:29 PM, Linda Walsh wrote:
> You will see articles talking about hard disk technologies
> speaking of density in 'bits'/area (where either bit OR area can
> have an SI quantity), since a bit requires no conversion constant
> to go from flux-changes/area. HD-densities (in the US) are
> expressed in <metric-prefix>-bits/in².  Again, with the metric
> prefix applying to the unit that requires no conversion constant
> (the bit) to be expressed as some combination of SI units.

And this is a purely synthetic value obtained by dividing the capacity
of the disk by its size.  If you look at the distance between any two
symbols on the disk, it is not precisely constant but varies
throughout the disk, and there are gaps between sectors and between
the sector header and the payload where there is no data at all (
because it takes the logic some time to switch from reading to writing
).  The size of these gaps is not infinitely accurate; they vary
within some tolerance.

> Maybe not, but it is repeatable by myself and other people. Do you
> have samba and a 1Gb connection?  It's fairly easy to setup.

Then your measurements are not accurate enough to detect the overhead.
 If you are using 9k jumbo frames that overhead would be rather small,
lowering throughput to something like 124,305,555 bytes per second (
assuming 50 bytes out of every 9000 ).

> Maybe it's your hardware?  For my fastest results, I've been using 
> Intel dual-port cards:

No; it has nothing to do with hardware, but rather the specs, which
state that the speed of 1000Base-T is 1,000,000,000 bps with a pretty
narrow tolerance, and you just aren't going to get that unless you
have zero overhead.

>> No, it isn't.
> Reality disagrees: See:
> 
> http://en.wikipedia.org/wiki/Bit_cell 
> http://www.softpres.org/?id=glossary:bit_cell
> 
> Specifically: (quote)
> 
> This is essentially the distance along the track allocated for the 
> recording of an area of Flux. That is, in each “cell” there are
> magnetic particles that together indicate a detectable magnetic
> polarity of set length. Note that bit cells are not read as bits of
> data directly, they are used to form the flux transitions used to
> make up the Encoding. Every bit cell contains either a change of
> polarity (1) or not (0).

Reality != a description on wikipedia.  This is an abstraction used to
conceptualize how the device works; it is not reality.  Until you get
down to the quantum scale, the real world does not operate in discrete
quantities.  When you pass the read head over the medium, you do not
get a 1 or a 0; you get an analog signal whose voltage varies
continuously between, for example, 0 and 1.0 volts.  Manchester
encoding uses an edge detector to detect a sharp change between
somewhere less than 0.5 volts and somewhere over 0.5 volts and
combined with a clock source whose timing is kept synchronized to the
detected edges and whose duration is set correctly can manage to
decode bits from that continuous signal.  Note that manchester
encoding is very simplistic and inefficient, which is why 10Base-T
ethernet required 20 MHz of bandwidth but 100Base-T delivers 10 times
the data rate but only increased the required bandwidth to 25 MHz.
Modern communications systems use better modulation techniques that
pack multiple bits per baud, so the description of a "bit cell" either
being a 1 or a 0 is entirely non applicable.  For example, 1000Base-T
uses 5 different voltage levels to encode 3 bits per baud.

> Disk manufacturers describe and talk about "bits"/area when
> describing disk technologies.

Yes, and this is merely an approximation, not a hard constant across
the entire disk surface.  Much like how you can divide the number of
gallons of gas in your tank into the number of miles you drive before
having to refill to estimate the fuel economy of your car.  That
doesn't mean you can put one gallon of gas in and drive exactly that
far under any conditions before running out of gas; the economy varies
quite a bit.

>>> You can't get the correct number of bytes transfered over 1
>>> 300bps modem by dividing by 8.
>>> 
>> 
>> Umm, yes, that is exactly what you do.  It kind of follows from
>> the definition of bits and bytes.  Of course, there weren't 1,300
>> bps modems, but still.
>> 
> --- That's "one" 300bps modem.  And no, you don't divide by 8 since
> 300bps modems only had a 30cps throughput -- not 37.5 as you would
> seem to indicate.

Ahh, yes... the original 300 baud modem was external and connected
with an RS-232 cable, which bracketed every byte in a start and stop
bit, effectively using 10 baud to transmit each byte.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJUtBdZAAoJENRVrw2cjl5RECcH/0gWjtJyN7gnAG9htHcIrpn2
QB02igaPQgn7Gzs0BIlI9fp965jWDuYGmSomg4XVVAIIsWFpJzB+ks7WnYiOS+wc
tZprznTJCngSqjGQ/pcfDjO6M7mDmAeF8lSJFUMukVtiKr6SsAy1Qwe9b7H4b/Wm
lQQJPiECjbC4mbn3HURl8H1/NIwqqkLjcdOEmM0uMF7nYG3BBKrcTJg+D6GxmaYa
JrpMIfYleS8eZJfZfvnwaOIaAadjIiTPGPXrv5mkmorio6sZBDzK66w4nxITRyj3
ALRSa9hMBs2/e6cRR3AkMtKE5HMkc0Gdi4wo5WSFva0EP8Q1iqY/38IOkEl5K9s=
=L5il
-----END PGP SIGNATURE-----
