Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:44036 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756869Ab3D2P7z (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Mon, 29 Apr 2013 11:59:55 -0400
Message-ID: <517E96F8.6030701@archlinux.org>
Date: Mon, 29 Apr 2013 17:51:20 +0200
From: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
MIME-Version: 1.0
To: Sami Kerola <kerolasa-X3B1VOXEql0@public.gmane.org>
CC: util-linux-ng@vger.kernel.org
Subject: Re: [PATCH 03/11] cal: clean up use of constants
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi> <1367169067-23705-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367169067-23705-4-git-send-email-kerolasa@iki.fi>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="----enig2WNNBBTJFFQGJWROFFCDW"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2WNNBBTJFFQGJWROFFCDW
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 28.04.2013 19:10, schrieb Sami Kerola:
> +#define	FIRST_WEEKDAY		SATURDAY	/* Jan 1st, 1 was a Saturday */
> +#define	REFORMATION_WEEKDAY	TUESDAY		/* after reformation it was Thurs=
day */

The constant says Tuesday, the comment says Thursday. You should maybe
double-check the rest of the constants, too.



------enig2WNNBBTJFFQGJWROFFCDW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJRfpb4AAoJEChPw0yOSxolHH8P/3SsZbmYFZC3aa1H58Hk8Hgv
QAawGo5kacWrzqsRH86BOfT4W3dL0x8O/qTALKne9bNlEIp/5SBWWgzyPiDw8ui/
We91FoDspyi7MThfl22btXP7VYCly3I3og+qTRyX09kz1YO3EqyKEBXrTGe2oS1R
3Lo1wc57UNFhaAQePwwiDE0njZ+PvP4gXmNxpY+fx6hyTgcKqp+5yGzCv0cN2rDu
SKNdIjmsE4Yh4oVV902AFszGo4rEIlE8XSE7CXjlfNZyS+7LrmfHH5rpKaPLJn+g
E2Bp/PYP9MsdK3MJYrsbgGO90gqXhjZlgeKPUm32AnH4rcA3SZvBtvKRPAOXUZc/
sAYgR9TtjKNAkce1tAvxp/MkmXIKaeHxdcJmYeReSD7kr8UqLOwDl+br/bBtQSZa
LwUacI9CCIjsDjTDpp9s4dgvq9MMP7FV7CyOi8Y4KYcf31XF+anVDvQZJ4mZoAZc
7+m01/7upN4QUBcBW/v3/9vaJ7hGlI9/yw9PA47zB36/ENmSo5GG/lq0GhAu+0L6
xtsem5xiWeXdR5KUq7cmxQDMfWXkCS6jzIMzl52XWb2OizWo867OxvnGnoVLZnWj
Toudt9dKHj1WQ9THNHcCDEMGyfBQObtuKvNSg6JV2fCllQtL/D+YAvB43G80N6Wx
MRKpE2YvQRlWanBOCwY4
=ftKV
-----END PGP SIGNATURE-----

------enig2WNNBBTJFFQGJWROFFCDW--
