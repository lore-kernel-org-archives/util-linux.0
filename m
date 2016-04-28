Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:56130 "EHLO
	resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752501AbcD1XI6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 28 Apr 2016 19:08:58 -0400
Date: Thu, 28 Apr 2016 16:00:46 -0700
From: "W. Trevor King" <wking@tremily.us>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        util-linux@vger.kernel.org, systemd-devel@lists.freedesktop.org
Subject: Re: Unprivileged containers and co-ordinating user namespaces
Message-ID: <20160428230045.GS22888@odin.tremily.us>
References: <1461880928.2307.48.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A/Qc/oxTFhy3MK1v"
In-Reply-To: <1461880928.2307.48.camel@HansenPartnership.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--A/Qc/oxTFhy3MK1v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 28, 2016 at 03:02:08PM -0700, James Bottomley wrote:
> /etc/usernamespaces
>=20
> and the format be <user>:<start>:<length>:<flags>
>
> =E2=80=A6
>=20
> If this sounds OK to people, I can code up a utility that does this,
> which should probably belong in util-linux.

This sounds a lot like shadow's newuidmap and newgidmap [1,2,3].

Cheers,
Trevor

[1]: https://github.com/shadow-maint/shadow/commit/673c2a6f9aa6c69588f4c1be=
08589b8d3475a520
[2]: http://man7.org/linux/man-pages/man1/newuidmap.1.html
[3]: http://man7.org/linux/man-pages/man5/subuid.5.html

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--A/Qc/oxTFhy3MK1v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJXIpYdAAoJEAPqygegUbGsalMP/iYdKxYkyqyQXyooApfm1r8g
s4TpqZo/TemduERXf0gM2upqKPhOQskymwUiEKVgkDPKmL58IlSX67pHzIPWXmrO
hj8uQkLXPsIfdObXsTEyy/QGWQNNOGRJHS2xuyWULVkEbl2niukd4Acq22jYDpi4
4OA08K9FtM6QTeNc5yHuW1r+4+qVFlrkjXTC08cvWPBnheMj2Jn6Zp8RKQDYFUdQ
frbpmw/s8reXz1nlIzk3XKymuk5usAG89upqcjKo78a3QQz611dUcmk24rqT0a0A
YTf18n18JgnwHTDJ6+jvy50D+7L/LRSg802asYmtyeYSC5rdIZSE4g+sIOYwonZP
J4kOAeSJ+K/GRcewG4fOrDs2Tk8TsgaEYS+oWXFjHVDUhXhOtiC5GdKejtb2Ygfu
Mw8t3hQXYq3A7kTzCfQRXBnV69/4qHXmMCEAX0Bk9RQ2hWr1Gjfc4CMakjleCVEY
9dlPEZDNiSXVAP2r1U6CNvYxk/Ifbo4TReHDq/TtkjLf7rxE/XVV34cHtFysJuD0
qTcP3tfmWNShg+QM1GEdzzNqs0ISzDQ7CgGm4Yl1xQsSXWs/Kw4WKvLJJDPpsmfp
zaC4G2NrPaVZxjrfch9UskKJpbUylKlm3DOLoA9USrySkdnFF8sy5mw9U/07PN6F
e0furFL0O9cSccumSRxM
=07bX
-----END PGP SIGNATURE-----

--A/Qc/oxTFhy3MK1v--
