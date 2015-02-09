Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qg0-f54.google.com ([209.85.192.54]:61170 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760310AbbBIOqR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 9 Feb 2015 09:46:17 -0500
Received: by mail-qg0-f54.google.com with SMTP id z60so21080507qgd.13
        for <util-linux@vger.kernel.org>; Mon, 09 Feb 2015 06:46:16 -0800 (PST)
Message-ID: <54D8C81C.30804@ubuntu.com>
Date: Mon, 09 Feb 2015 09:45:48 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Felix Miata <mrmazda@earthlink.net>, util-linux@vger.kernel.org
Subject: Re: fdisk -l hits floppy drive
References: <54D5126A.3020308@earthlink.net>
In-Reply-To: <54D5126A.3020308@earthlink.net>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2/6/2015 2:13 PM, Felix Miata wrote:
> util-linux-2.25.1-5.2.x86_64 on openSUSE kernels 3.16.6 and 3.18.3
> 
> fdisk -l is causing the floppy drive to get hit, which reflects the
> 4 kernel messages onto the tty running fdisk. Is this expected or
> intended?

I'm guessing you don't actually have a floppy, in which case, your
bios is misconfigured to think you do and you should fix that.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJU2MgcAAoJENRVrw2cjl5RAWIH/R6n+VbEfKcUhbjlbUR0wSzo
E6fqw+3G+MCUH6O0L/e+MvbME8WrJagtzgfvBcTMLjZUihOamcyZ8icQncybDp13
60lsaTosvrwWwt3lNTQvEVAVTnJem5Yj987zTDY4tHpmZushL2a6oeVLCmy5s8WU
zN4CBlJnWJ+xZd+OWe11s5owacxrasty4nUIAwrQKmH75+hdS7z3BRV3YUJ7YVkl
XDGprm5g/XOgu+QlS2VRFW7n/OS0Jp0Hx0cHY3KBVokI/i4+gqSn5yIbA+qqSSok
KlBDtHQG1uNfif+00aoLBNb/8RfDjZ9IYzY6qIIhvlKlIJW7rgWiDD19+ysPDm8=
=Q8uE
-----END PGP SIGNATURE-----
