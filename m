Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:47213 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab2IONRe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 15 Sep 2012 09:17:34 -0400
Message-ID: <50547FE7.204@archlinux.org>
Date: Sat, 15 Sep 2012 15:17:27 +0200
From: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
CC: Dave Reisner <d@falconindy.com>, Tobias Powalowski <tpowa@archlinux.org>
Subject: [su] New su utility messes with my PATH
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig9A0C6D8C3BB5602CF3B620BE"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9A0C6D8C3BB5602CF3B620BE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I found what I think is absolutely unexpected behaviour in the new su
utility. It seems to have been introduced by commit a6fdd3f8.

It is about /sbin and /usr/sbin being in the path: Whenever you switch
to a non-root user, they are removed from the path, and when you switch
to root, they are added. I find it completely unexpected that su (when
not running with -l) messes with my environment at all.

Commands like
 PATH=3D... su -c "cmd" user
do not work as expected.

In my opinion, when you wish your path (or anything in the environment)
to change you should a) use -l to start a login shell or b) configure
your scripts to take care of it.

I propose to revert the mentioned patch. Opinions?


--------------enig9A0C6D8C3BB5602CF3B620BE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBCAAGBQJQVH/pAAoJEChPw0yOSxolRvEQAMjc5W/kiZQo0he0lZbPqwh7
zLPZX8p0uGxHB2WGxrXhykitBh1G+Hvc5iy/FJOLBjuX9mI9EMudiGlr8A3rXH0v
/r7f8Q0yLGD+UzJjknkp6Tb9kmd1VlnwOitoaZxh/hTYyuBl7iQpJQ5MuXubpNKQ
Txz+muzMIC2cqbajkNYK+Mf+pm6wHoaE+7caVAxAHGTHa/27gwWWJBMstpl1KN4E
79xCPLUNuIihWTZXR1u0hs9QhsGMo3LKG8n/wqoi8iMRHV3cM6/rElUAZyuTeN5q
+To/VYW8/sCqT410Jfj6q7QOsoFl+K5Uh2ofNWE1jY8EI7JE1edTC1BYcXeDxYUZ
aBpjhqgRf2jN+A/0gYBMwo7slX1zNYZMNnWEZYs9nRcJyrLEg7Me380VsmQz6uk6
qSNtq/mJW0UIE2BFmekKWQf3ikUm1f0gSXN+J5wC5LxPqPmymQz+LREsC/14Q0TG
eOaR95hI+OPZBKdxMM4qScmmmKxhVGuBKJU5JkFxAakZeejfVzr19ne338Y5nXwT
JcHVLj5u6g6u8U9/TigmG9GPQ66lOsHxe8ZzsLXin4K9fCcgN7oOUG0EsxsJu+e5
8LIhkQl0juybbQQ3eSdA5sTMsI6leX4Lx4kPYdf5K9Zgu2FrMfcDl4vkJBRTu+wB
Nu72PZC5oaOz8BbVg/N/
=4iwL
-----END PGP SIGNATURE-----

--------------enig9A0C6D8C3BB5602CF3B620BE--
