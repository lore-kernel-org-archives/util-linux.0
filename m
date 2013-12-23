Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:49397 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756189Ab3LWCmk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 22 Dec 2013 21:42:40 -0500
Received: from vapier.localnet (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 73E2C33F3EE
	for <util-linux@vger.kernel.org>; Mon, 23 Dec 2013 02:42:39 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: tests: cal/bigyear only works on 64bit (sizeof(long) == 8) systems
Date: Sun, 22 Dec 2013 21:42:43 -0500
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2172243.ZrWgCHjbvC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201312222142.44536.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart2172243.ZrWgCHjbvC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

the cal bigyear test uses a year of 1234567890123456789, but the parsing lo=
gic=20
reads it in like so:
	year =3D strtol_or_err(*argv++, _("illegal year value"));

that's a signed long type, so on 32bit systems, you get:
          cal: Year 1234567890123456789       ...cal: illegal year value:=20
'1234567890123456789': Numerical result out of range
cal: illegal year value: '1234567890123456789': Numerical result out of ran=
ge
cal: illegal year value: '1234567890123456789': Numerical result out of ran=
ge
cal: illegal year value: '1234567890123456789': Numerical result out of ran=
ge
cal: illegal year value: '1234567890123456789': Numerical result out of ran=
ge
cal: illegal year value: '1234567890123456789': Numerical result out of ran=
ge
cal: illegal year value: '1234567890123456789': Numerical result out of ran=
ge
cal: illegal year value: '1234567890123456789': Numerical result out of ran=
ge
cal: illegal year value: '1234567890123456789': Numerical result out of ran=
ge
cal: illegal year value: '1234567890123456789': Numerical result out of ran=
ge
cal: illegal year value: '1234567890123456789': Numerical result out of ran=
ge
 FAILED (cal/bigyear)

should the test detect the sizeof(long) and then calculate a number that is=
=20
smaller than that ?
=2Dmike

--nextPart2172243.ZrWgCHjbvC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSt6MkAAoJEEFjO5/oN/WB904QAJt5esnIumAULfmURAj7gvOT
2dL0TA81ri1hO37ZmPCG2ipB5ccBuI8sTk/DPXUrsH5t1RISTJfSrenTL9RMxF2w
3gmKKxAQOkjBc7tog75zvzfoIIbq+DvRVfs/MCrvsAdq2o2QnqiNd+Sl0BA1FAgQ
JW3WTzCLp7kzg8UMnZ4yRqbNRziSceBUQvoS72ySHgadNMySoZoveDPwVrmoWYma
VNc8X2b5zZcOoQ7/sMxHyrWIzrIGFT/PfKVtMDxg7H/7hHSs2Cm++HfCVE7Mb1PS
yDQ+tcXD237Mk0I38hlYYegiKT4Ap74HiZrbHLEYbjQeDWsc97RfblkpDZKyBl1d
wwAdiJk0N4YWZqnsm/o9bpcwqc8hsqdDNtuWm4JoqR2IVjrQmsngXI67QImnuWlx
v/xzI0Z9w1/vkFMwyIu9hBCYKSqIazNk7eE+fHq7eSPxbDLjrF66HfW6t0SL102o
MesO2SQSBz3SqzWyKOr/1ShvdB5O4IGa9emlXf+DF4/AjiOAlfOVt+P+bYfBiqqz
2sqqBMN/o3+5dh1lplfxVMCdxamaJDq25jXEhARrLuYfM29dgY0iycUesvqJzMiz
0EsZm5Nur68qjhTDIEaMa8lJ/GXjj3srFNd+Gl3yNDS6aTK11AZBdRSxUnrE0twG
dMwC6RsBiKnHm8VL0YGY
=MM0V
-----END PGP SIGNATURE-----

--nextPart2172243.ZrWgCHjbvC--
