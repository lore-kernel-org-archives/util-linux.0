Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:53288 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579Ab2LZSrP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Dec 2012 13:47:15 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Cristian =?iso-8859-1?q?Rodr=EDguez?= <crrodriguez@opensuse.org>
Subject: Re: [PATCH] include/bitops.h: Use the operating system byteswapping functions
Date: Wed, 26 Dec 2012 13:48:01 -0500
Cc: util-linux@vger.kernel.org
References: <1356543501-7033-1-git-send-email-crrodriguez@opensuse.org>
In-Reply-To: <1356543501-7033-1-git-send-email-crrodriguez@opensuse.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1403764.dLglSnIyH0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201212261348.01760.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart1403764.dLglSnIyH0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 26 December 2012 12:38:21 Cristian Rodr=C3=ADguez wrote:
> There is no need to reinvent the wheel.

the trouble is that util-linux supports more than linux, and the api of the=
se=20
funcs isn't the same (or even available) on other systems
=2Dmike

--nextPart1403764.dLglSnIyH0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQ20ZhAAoJEEFjO5/oN/WBIzgQAIgJMfjrUAhMm1R9AWEIDisN
mRrZdh4qrknfZq7dxHV7h8+RUHiai1QhejoVU4p+qVrwR/WTZY8GSWXeiu45UAdc
WzAq9wgUrvSgS90N5d8PNRxdDollkia9egNCC94pKks+Ny2SG3wVa4+PtdLe+Knn
hrK4fgiNSDpugNt6gCj+DDmndUsH3zZFbV4KkEzCtsaaYH73GCNs/2Mq7wl1SbMb
diuAA5tawZ7a4hMHsR/R6I18jUuN4fOoXhkPjKWUtZE7qGmc0eGErzF5eACe0T8Y
RqQNDowZZs/za8usdRaJvNrzwGK+irtQdlWNjig57nNKzjMBOEzfkVYvfQOej9VH
i8lV/BkD5gNvgBPHaL+UYocrr3A73t/doIhTCLX+BUZ7KSwNSHZmOfaRfOQnOuXg
7W0gMbiL2j0mbqAg4MbPXs3Wap8tLe4l78d87oeGhdOYhqfkls4JwQMe/V1+5LW8
shpCmVaxBD65DLKFSR7FfUbCAtYoQdouF+7nRChsyUHWa4kz8q885FyIcXf/N0NP
jfNJFvA5er8APc7NYGb/3nhD4Glkp241W6YmQ11ymFDAEaDx1bO2/P1tePIf86Vg
oImEh6W8RBJes3C2f92jzRl5bfiWWQvoeyxc34vAP7xoO+NGFbj5ssOWPx3Qno4Y
s9VoSmOofoCfIeib3Uy4
=Wo0n
-----END PGP SIGNATURE-----

--nextPart1403764.dLglSnIyH0--
