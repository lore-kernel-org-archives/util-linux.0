Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:63486 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab3LLO7M (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 12 Dec 2013 09:59:12 -0500
Message-ID: <52A9CF3E.1040402@ubuntu.com>
Date: Thu, 12 Dec 2013 09:59:10 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: read only bind mount ignores ready only
References: <52A878C5.6050505@ubuntu.com> <20131212120544.GJ16572@x2.net.home>
In-Reply-To: <20131212120544.GJ16572@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/12/2013 7:05 AM, Karel Zak wrote:
> I have it implemented, so
> 
> mount --bind --read-only /mnt /mnt
> 
> is interpreted as two requests (two mount(2) calls)
> 
> mount --bind /mnt /mnt mount -o remount,bind,ro /tmp

And mount -o bind,ro is the same right?  So you can set up a ro bind
mount in fstab?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSqc89AAoJEI5FoCIzSKrwdhUH/R0lBLjHBtgK6BBrh+ULpRyJ
o78QpMMrDH1qwui/MlCg1gXZe7ue6l7InIEfx3e62VBJTeMtIOUFKJB6Cvqt6/sb
wtP3iUgqTqlD2L4FTmbX5hAB9b1XTYpfko4NIfFy6Xc92jgpPoDjQh9W47q5keQ1
N1HgHAG2iyFWrtkBYsFBFv1tFIKqXF59/oPPF70lQESJldmvYr8FHtSinYISIHAH
Hcc+SVjTlUhQZVRb8teqcy7T8oAZu78NSqLXzgOG9uWooKduRG9Revye2/71tOHz
6PqPxreNXe+SgEHsQ2+R4tl4Rm1ttzMc7voJC04lDSIaxZJtPrxnylQnflndYjk=
=EJIS
-----END PGP SIGNATURE-----
