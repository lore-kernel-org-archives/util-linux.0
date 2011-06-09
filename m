Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:60136 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751215Ab1FIA60 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 8 Jun 2011 20:58:26 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Josiah Worcester <josiahw@gmail.com>
Subject: Re: [PATCH 6/6] hwclock: Don't use asm/io.h if sys/io.h can't be found
Date: Wed, 8 Jun 2011 20:58:25 -0400
Cc: util-linux@vger.kernel.org
References: <1307573568-23643-1-git-send-email-josiahw@gmail.com> <1307573568-23643-7-git-send-email-josiahw@gmail.com>
In-Reply-To: <1307573568-23643-7-git-send-email-josiahw@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1357012.YAB5QHuKUF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201106082058.26670.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart1357012.YAB5QHuKUF
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wednesday, June 08, 2011 18:52:48 Josiah Worcester wrote:
> -#include <asm/io.h>		/* for inb, outb */
> +/* Disable cmos access; we can no longer use asm/io.h, since
> + * the kernel does not export that header.
> + */
> +#undef __i386__
> +void outb(int a, int b){}
> +int inb(int c){ return 0; }

probably should be turned into a header check in configure
-mike

--nextPart1357012.YAB5QHuKUF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJN8BqyAAoJEEFjO5/oN/WB7eMP/jYVOA7y2ygaBCKJFSQOgjlp
ZJFN3YCIPvJDMqZteeynwzFMXzwD52LimPGhxWTkK1PDQKyQkPNjqJw5smfp7Ft8
3IkdEa42L+cN+Rkg/Jdx1j7vxuUe/Zqwpn2nMCQOFhBcb8knK7QR3YrIo8Gt5C2O
3S0+hwuir+ensH3s6Pfr6mjVqtRkWW0Afg40qrh6ugAcfr2LyPkEmgXRCmGUwCa3
ypG/c+k85CvbC2Sli+KNr+S/k4I7ip3/y1Px6hsUJdSEnqFKj21A6UUYJS46bHrC
N8qoYj7JjpqTK7c7Hn+W6zBwc2nAtyoOHVk0EhbaNJeTjqXIZznX0qkWbOb5WsWm
u07MpVDxqYQqe60jJuWH6HUzXfvH7IymDxe2bA275NnxCsgK2jmAiymbfJ3NvYOu
iyM7lG51hIKpKOE1ZYgRtpDWevOkyd6Ay//LrRzyvhr8FOgLvuGIA3yDWrmXV7KG
eBYEgu5ysjlv1UKwg/iaq3/hvCuGQpaSFN37dWGVA4xksp5Z/2X/VAn8pjmeY7CG
Zzr7n02r/2sDpRDE/TA2Qhd2+32GX4aqwFIpraDnLWRmdvlZHNA4MkqA+Vj+XYpV
X8qMJozvoUXiPTpDKemZxdgLvVwt/3C9eh3XvFwnm4rpwqoti2x2MmtHBZzTHv13
L50lOT/0mDA9Ktas6TES
=9ARB
-----END PGP SIGNATURE-----

--nextPart1357012.YAB5QHuKUF--
