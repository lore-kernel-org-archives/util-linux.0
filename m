Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:60072 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbaA2Awe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Jan 2014 19:52:34 -0500
Message-ID: <52E850D1.6090807@ubuntu.com>
Date: Tue, 28 Jan 2014 19:52:33 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Christoph Anton Mitterer <calestyo@scientia.net>,
        util-linux@vger.kernel.org
Subject: Re: fdisk: add GPT partition types for plain dm-crypt and LUKS
References: <1390934933.15213.17.camel@heisenberg.scientia.net>		 <52E819BF.4090503@ubuntu.com>	 <1390943356.7021.7.camel@heisenberg.scientia.net>	 <52E8210F.2000007@ubuntu.com> <1390945287.7021.16.camel@heisenberg.scientia.net>
In-Reply-To: <1390945287.7021.16.camel@heisenberg.scientia.net>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 01/28/2014 04:41 PM, Christoph Anton Mitterer wrote:
> Well some people don't want to do so... whether that makes sense
> or not.. is probably up to them :)

Sure, but they are just as likely to continue to be ignorant of this
type code and never use it.

> Sure and that's likely the best approach,... but there is not only 
> Linux ;-)

So are there any other operating systems that want to or already are
using these codes?

> Again... other systems may use it... there is the ID for the ESP,
> which is definitely used... and you never know which other system
> (other OS, bootloader) comes a long and tries to do something based
> on it.

The possibility that someone some day may use it isn't a good reason
to add it.  The ESP has a special ID because the UEFI standard
requires it, and that causes enough trouble as it is.

> Anyway.. as I said... no one is forced to use it at all... it just 
> sounds better to have something defined that to leave that open and
> have people choose anything...
> 
> And this mail was merely to inform fdisk upstream that these values
> were now "chosen".

Unless someone is doing the work to actually be able to use them then
I don't see any point in adding them.  I also don't see any point in a
code for LUKS, though pure a pure dm-crypt code would at least have a use.

> Well but that exception just proves my point.. that feature was 
> deprecated for good reason as it caused many issues... and you
> cannot guarantee that no one else (e.g. outside the FLOSS world)
> comes along and adds some other seemingly smart functionality...
> and at least one could hope that such someone wouldn't touch any
> IDs which clearly don't "belong" to him.

Ummm... how does it prove your point?  You admit that it was a bad
idea that caused many issues... and somehow that makes repeating the
same mistake a good idea?

> Aprart from that one would usually rather try not to run around
> shouting that one has an encrypted container...

Yet you propose doing exactly that via the partition type code.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJS6FDQAAoJEI5FoCIzSKrwnHgH/35xp4IqiMtYVeoY6+B5qyZk
1aY3C3RirnPtVw9xgCWiVCX+rA/x1fyKfmu1VO7SMcyPCY0tSHMjj6S5WVgPM0g9
9PNTc6lr0EGzCcEPyFl2/VU9QNcoorUR3/hfuTzEo01klh73jHxRkIsi80qbtxA3
e5g+96h092myovWZyqrFcgYyLoXcM7VreUdIPBBKyGlDRf0WrGZTnBVZW1lo/6X8
ny35FdOlWD1zap0cMNmUDLcXF2VXA38e7thlFbDH4CiuvjoUyTZfpXr0E2f6hsf0
s/QWuCIgygD6ObYrcfMgsxdsNG9+QGfc7KIL6T0hhjDur7U4G1jYLnM0evhM0PQ=
=x1QU
-----END PGP SIGNATURE-----
