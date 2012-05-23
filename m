Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:49590 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150Ab2EWWmh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 23 May 2012 18:42:37 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Dave Reisner <dreisner@archlinux.org>
Subject: Re: [PATCH 2/3] logger: use memcpy instead of bcopy
Date: Wed, 23 May 2012 18:43:50 -0400
Cc: util-linux@vger.kernel.org
References: <1337805360-16469-1-git-send-email-dreisner@archlinux.org> <1337805360-16469-2-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1337805360-16469-2-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8319880.8azZlc0QNh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201205231843.51118.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart8319880.8azZlc0QNh
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 23 May 2012 16:35:59 Dave Reisner wrote:
> bcopy is marked legacy in POSIX.1-2001 and should not be used.

wonder if it'd be useful to add local defines for bcopy() & friends that re=
sult=20
in an error if people try to use them ...
=2Dmike

--nextPart8319880.8azZlc0QNh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPvWgnAAoJEEFjO5/oN/WBbzkP/3SljHNn6iEa1OGGWcZqpDjP
LJWBcNEaqXENk39qvKicCnAC2j3Pr4nHYj5uwWmfEqqmzulG4nj27lQLt9QKcUC+
7VvPnvuFAJ6mGqqzT7MIBSwzn+CSVD2keoCc/0G50wn1dOlgqp/adW6IPE8Ax0eW
V9Yq8BQSXnHyjXxFDkl/V1cXULhFlORlYV/jv7SRz5SdB+F5SwMga4z2mvkgmy0z
/3OwhDDyKbnqc2j6WnVfHVt5Hjxwu5t5pv2dQQaj6FgqBMc++yPk7Q4zcsyBQhed
7ZSXOQE9iMm4Zd9/Ri59XLUfp1fHxnPyPl2QaUI7EHjd1K9SP5YUEcgqxK8Ykc6y
DQsS7qG3+ftcOdgy//5QVkRL14NgZuodnisDqkQC+mMNFfNETf1XgFxbZa5mMMf4
7yly3mMaOb8fib2bP9+8ObeqaB+2F+lRQKsvD6MFcK34M6nLJBAgC3ycW4IEJiQp
/oP+C6LTMpbyDU5jRU/ke8+okL8uqi1k9aXIcG+moI4ECK+SWsM4ENCpxHsTPTUG
Pgqb6kKNsa1RP7vl/XsNQNNsAt/K0SBFnmIv114v1cKf4rNxEazvdECJptI0KxwE
h+C8tLtE2kQbUt+lRNG51KGCeWDWFNGtS0EnefosAqmGsfdfmJSaNMOpW0jRYkoK
Qvtl0A5fOVWOTBGhmlj1
=XUW6
-----END PGP SIGNATURE-----

--nextPart8319880.8azZlc0QNh--
