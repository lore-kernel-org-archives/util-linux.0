Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:65250 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595Ab3K0UJA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Nov 2013 15:09:00 -0500
Message-ID: <5296515A.1070505@ubuntu.com>
Date: Wed, 27 Nov 2013 15:08:58 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Curtis Gedak <gedakc@gmail.com>, Karel Zak <kzak@redhat.com>
CC: Marc MERLIN <marc@merlins.org>, util-linux@vger.kernel.org
Subject: Re: Severe fdisk problem leading to data loss?
References: <20131118102051.GA31813@merlins.org> <20131124135226.GH11389@merlins.org> <20131125103124.GQ5572@x2.net.home> <529605B7.3020903@ubuntu.com> <20131127145840.GB32483@x2.net.home> <52963910.60800@ubuntu.com> <52964ED3.8030504@gmail.com>
In-Reply-To: <52964ED3.8030504@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/27/2013 2:58 PM, Curtis Gedak wrote:
> Unfortunately at least one company produces devices that have
> partitions with ID set to 0, yet these same partitions contain
> data.
> 
> An Apple iPod Shuffle is such an example as shown in the following
> fdisk output:

Wow, what is in there?  And more hilariously, what happens when you
plug the thing into a Windows machine and try to create a partition in
the "free space"?

Also, I thought iPods don't use the USB MASS STORAGE protocol so they
don't show up as a block device at all; you have to use iTunes to
access them.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSllFaAAoJEI5FoCIzSKrw+lQIAKl7REeobwpPHtZrxbQztb67
SdgQScZUPy93Mi6qsnW4n6v090iIceo+g1HYnVLzzevNPAcJJRYQ1ZdKhpzgEPZe
OQFN8m1WnAKogCa1WsbAPtAKgDDaZnlLhAM3XVT4S2Yz5QZkx8EV5lVvTazo2w9X
ZhtpO1c8kvqr9P7y9EcDWnOiWWJRaXsUbqzsQ6GdtG+NtobDsheMPC8zsa0nWPn7
gjBMYWHuaVxJTuGQo2yyRPovpOOIxNYrd9fBTybI4np18a6dFD2cxPnipS/CwBPr
B4n5/YWKVf3M1jXZYPlUdlWrZVifCrO0NOkJ+/nlzIa/q71xRsGV/DhKbutA/Kg=
=7API
-----END PGP SIGNATURE-----
