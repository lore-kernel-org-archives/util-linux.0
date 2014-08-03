Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:52628 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783AbaHCOuQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 3 Aug 2014 10:50:16 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/7] zramctl: print all devices as a default action
Date: Sun, 03 Aug 2014 10:50:17 -0400
Message-ID: <2423860.9OdLEsNW7s@vapier>
In-Reply-To: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
References: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2007508.TPNrdW7FtL"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--nextPart2007508.TPNrdW7FtL
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Sun 03 Aug 2014 15:17:37 Sami Kerola wrote:
> -static int zram_used(struct zram *z)
> +static int zram_used(struct zram *z, int find_unused)

s/int/bool/ ?
=2Dmike
--nextPart2007508.TPNrdW7FtL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJT3kwpAAoJEEFjO5/oN/WBcwwP/0B8zIfV4tpMeXoBewn7+EyR
zxnsxPpwaGxqa2aBwUJCIPBx39I03Hio/fRQ96HOoBq4FNp/1UjMxtWbhBC68Cr8
n1nS4nlmRKF1/PL8sg79IsGcKjMDCI3w/IoGEdW1i0DZBZXp7lPCVJYZb/fW/Fsg
nNMFBCghonr14RY4T0pG+vcfGvsImgH4Cz8G7ryDkr+GPX/NMaAeL21I6iRm2HtK
BFOuPLtmrB6THnE6OoLl2Dgf7hc7gJdDVa6eq6EHZ2fzQR3sNOW1rSKSYmE7az+M
9bBJD/P2dRBUp7GcdTg6EVMuBD7MF2A8rQJ+YCgzNs94vE8+MF2Z6+byilb7qdx+
/WqwUHI9aX31Abc2pCWY1ec+ipjqFTDwZXW7ixCFMTAAuorTUVtibD6Z7YPDth9J
XGP95yBo2A0dcyl+5Jwn/LPVkFDG12d0mD2430hO8NBfKeVldgkH2nbiajLciunw
44JrPcqKBPSVyi9FIFvUir+OMmfybF7HJ6fggWPeBMLAV/YSZz1hOALSBhssDGJB
qk6m9ZysPgt1Pvdig2jzA6sH1G3Z/YIY0kryDZHbyZlwENxAltzRJftc7whrK5Dk
/dagjr4tD+Z5U5z94m7Kmy1Tr3ggZn2lHfBPzcrlA3giS0W5GisNzqUqrQNSDUli
1GsHLPRfPj7ThkL9Xb9K
=05D3
-----END PGP SIGNATURE-----

--nextPart2007508.TPNrdW7FtL--

