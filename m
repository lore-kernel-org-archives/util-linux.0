Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:55670 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752987Ab2DQO5n (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Apr 2012 10:57:43 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Thomas Orgis <thomas-forum@orgis.org>
Subject: Re: losetup -d --force for zombie loop devices?
Date: Tue, 17 Apr 2012 10:58:22 -0400
Cc: util-linux@vger.kernel.org
References: <20120417100346.2a0b8301@orgis.org>
In-Reply-To: <20120417100346.2a0b8301@orgis.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1528911.rUBpQ8I7V9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201204171058.23776.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart1528911.rUBpQ8I7V9
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 17 April 2012 04:03:46 Thomas Orgis wrote:
> ioctl(0, 0x4c01, 0)                     =3D -1 EBUSY (Device or resource
> busy)

that's LOOP_CLR_FD returning EBUSY.  so there isn't much (afaik) that=20
userspace can do here.  you'd have to start a thread on lkml first to add=20
support for lazy/force loop device detaching.
=2Dmike

--nextPart1528911.rUBpQ8I7V9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPjYUPAAoJEEFjO5/oN/WBL3MP/2dxGWipGjgFZgPkavtf2ySE
LS1haHt2I8Z6+U3hG9U/7LD4NlwaVlMrvRplPI5TeFzawkzzKEywsODGEo6LCZDx
U4L9+onwgL2Hr6QFQfqenNwl5NKy1eX9dSnVdybFbbRRk4kalelV7a2amWWTJnB6
sX9eeS02GOx7z5RSe2qxzeQH4LiCiuiqjNbg6B3YFS7Ub++dwejFKjjXBIsmjbha
mRtIriPX+4uCNiX9JyR2xW4guiW1hlhDJJXLbv9ZJ79xQsuNHLbLzkR4EAyJ+W9G
PEe42A+njLVNOcmp3DSga+lMn3aS0oSqTi333y1OT/R3a3wqQhACwU3H1qiNghaq
NOlXTtKS/YvYgw6RQ5vGftxIMzy0zFVEGZ34TQVazQa+QXKoOEWq65+Idwb1XGDE
Z9COHh3VRUsrimtKApK5ji0QqJpIxcgYzX8oxESFjeacjhC0qsrkvBZCc93xfNYQ
R6sUcScfKzYBe7UGgFRqhMnYgiL4EdPV98EHsz4AlhcYTK6BQ6ShhxugNYN0NR3j
/UvIcG988irGJgTUZmKbXCCBYMlUafSB+lDcY0qfb5eoBosufFJQ5fhCnHlZ8/3X
TsatWoRf0P2bO1YyexMQ4YdF0hk7ew8sEHpwtK4wvgVW1hBheqKL1P2xELsLy+Cm
bAlIVV2UhPSHVheVlXq9
=Ti73
-----END PGP SIGNATURE-----

--nextPart1528911.rUBpQ8I7V9--
