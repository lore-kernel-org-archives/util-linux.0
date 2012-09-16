Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:57214 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614Ab2IPUoa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 16 Sep 2012 16:44:30 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Christer Solskogen <christer.solskogen@gmail.com>
Subject: Re: cross compiling util-linux
Date: Sun, 16 Sep 2012 16:44:35 -0400
Cc: util-linux@vger.kernel.org
References: <k2amjt$fh0$1@ger.gmane.org>
In-Reply-To: <k2amjt$fh0$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart74906279.WOUxtZsDdj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201209161644.36467.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart74906279.WOUxtZsDdj
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Thursday 06 September 2012 13:30:36 Christer Solskogen wrote:
> libtool: link: cannot find the library `/lib64/libpam.la' or unhandled
> argument `/lib64/libpam.la'

not a bug in util-linux.  libtool linker scripts do not play well with cross-
compiling.  you can remove them, hack them, or hack up the local libtool.

> configure was run like this: -prefix=/usr
> --build=x86_64-unknown-linux-gnu --host=x86_64-centix-linux-gnu
> --with-sysroot=/home/solskogen/obj/root.x86_64-centix-linux-gnu

the --with-sysroot isn't necessary
-mike

--nextPart74906279.WOUxtZsDdj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQVjo0AAoJEEFjO5/oN/WBZ28QALBUjvyDXKMaBHM4tZH4qDWs
k5Tc5+xd+J388qwZh8JtVVJy3iYbAsfRYuGtHF6wcmc2N/EQYixjb5/lu6VRKEDZ
YpEaVwtUNFq4vq9JBumIH9BAA+Lr6oLxxWJ1clRN1yDZdadEyaUBwqxPTjmN9KVg
s+biSfnV36+5FmEr/hIdRTwUpDQ6Of972Al84ukXxIkM53okVyiBAJDRXru7moV+
6z+Dp9Dbm4npLH2vnzgzzTiIlxEa6+iSYFJwSfug/tfi2z6hJvSnzVtgZ4KZnipv
E7CQtZrL5KNCKtkkf0748uTztyzbOvP1Or5Ksr+RWA+KNUaazzBqnJUzcpDP8Fo8
Ed4Lr3YeC6vS5V8A2kwf9WzpDjkVBrjg42QcJkLYd0R0dv6ANzxmEXU/OIHUBE7K
Jr7AmhEqJkc+0YguMBkx8VF5bVSRj9qSjWGzAIcLPEf6UFRTfQsriU1i+P3TWVUY
Rn/HHT1FtzhXGr2S6SexxIFwX/6LO/pajLuQSsMJ+3nSPb64+GjhpAvpFW20WIGH
G+7yKEQWOliUiHjUS0NHHl+9KRmBnliH6RTY/sGJPVMLwUkRteeMTakzZXE0Vsni
2b3CJM202B1x6rrkusEVTdKQMP07QQeJs3/tx54y7ozrWQP3lpj/xFq+j65WIkz8
QE6V/DdtQ/9L0LZ/x/cA
=VvW7
-----END PGP SIGNATURE-----

--nextPart74906279.WOUxtZsDdj--
