Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:50516 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbaBHPsP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Feb 2014 10:48:15 -0500
Message-ID: <52F651BC.9090109@ubuntu.com>
Date: Sat, 08 Feb 2014 10:48:12 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>
CC: util-linux@vger.kernel.org
Subject: Re: setarch treats all x86 variants as i686?
References: <52F3F660.8060600@ubuntu.com> <1445010.UmVgbvgH5k@vapier>
In-Reply-To: <1445010.UmVgbvgH5k@vapier>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 02/08/2014 06:26 AM, Mike Frysinger wrote:
> no.  setarch is merely calling the kernel and the kernel is doing 
> this.  see `man personality` for more details.

Ahh, looking at the syscall it is clear that there is only a generic
linux 32 vs 64 bit flag, so setarch must be aliasing ix86 to the
generic 32 bit flag.  The man page probably should be a little more
clear that these aliases all map to the same thing.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJS9lG8AAoJEI5FoCIzSKrwKDoIAJI1+SHLvv20ZPBbNjG7ieT3
KDgBBD8kj50qQVTVdXBlp/TkdDNBO0GuuabQ+6PZm8UAUNSpfiYEOdMlma3y/o/g
ZfDBR43XBiqNK7ppnIZ/Ro9MS4rn7yze/UdLgg9t+Shm4RHHarl2VKaNEh0FB0UT
onUJt9SBG2czPY3evFGNWlmsaGNJ04nW70SHgiCLA14mIgaSx7tSU8FuCeEjg1dG
XFIMhbgCl4qeBqTEcwl/kwzz23wYoHpWHWHK0eMbc4j4CJCk0G7nbbnWI2IEdgzz
QGYdDurLT4lCdPDx5l5LoP8xTQzdvRy35HLjnZrVM0T6nAZXxf89h3wG64K+zBY=
=waCb
-----END PGP SIGNATURE-----
