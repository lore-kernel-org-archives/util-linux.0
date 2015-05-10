Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:45597 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbbEJP2p (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 10 May 2015 11:28:45 -0400
Date: Sun, 10 May 2015 11:28:44 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: =?utf-8?Q?P=C3=A1draig?= Brady <P@draigBrady.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] build-sys: fix parallel builds w/setarch links
Message-ID: <20150510152844.GJ30924@vapier>
References: <1430711464-4943-1-git-send-email-vapier@gentoo.org>
 <55489D6D.9010303@draigBrady.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p0aHTXLXY/BobAxh"
In-Reply-To: <55489D6D.9010303@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--p0aHTXLXY/BobAxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05 May 2015 11:37, P=C3=A1draig Brady wrote:
> On 04/05/15 04:51, Mike Frysinger wrote:
> > From: Mike Frysinger <vapier@chromium.org>
> >=20
> > The symlink generation tries to write to the sys-utils/ subdir but does
> > not make sure that dir exists.  This can sometimes lead to parallel bui=
ld
> > failures when building out-of-tree
>=20
> >  $(SETARCH_MAN_LINKS):
> > +	$(AM_V_at) test -d $(dir $@) || mkdir -p $(dir $@)
> >  	$(AM_V_GEN)echo ".so man8/setarch.8" > $@
> > =20
> >  install-exec-hook-setarch:
>=20
> The `test -d ... ||` bit is racy and redundant I think

i noticed that, but i didn't bother fixing it -- i just copied & pasted fro=
m an=20
earlier fix in this project which used the same exact line

note: it's really only racy if mkdir itself fails internally, and i'm kind =
of=20
the opinion that mkdir itself should be handling this
-mike

--p0aHTXLXY/BobAxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVT3ksAAoJEEFjO5/oN/WBgIcP/iI2Bzr4OYpOfrV78B9FVOgh
xpVBtezCqv78q/u0Lrk+euleTtEDjcvPoBZFDRe2yOwSJR8reIkMt3J/Kodc3W32
/h08hYHIggPFoXJtDQRedAk0wMitvVOTTwI+AQ7GMD5AnGDoGerwg0007nqaqCVu
CNdvaA+O0TLy1MNv9amUk1GIlDgcOM2rHUnhJLTV2/kFCD9GCaFXCvWq5XsGAvpZ
ZAOXHEawroD8QpDwk5PKCEbgegjzKDXEI9YxAIMtx88y8r1L+vQv7XmGGvK3vDiA
zE8090uFmtW1rlcgoJd2Lg3gTXHz5nq36C3jcGt2cuYPijK4avoz8PW7zsTZaRnY
Rqyf/wUhPD3Ri4BGtARX1Ubio2oHwEzPD4a6/Z5fAxbtqsnj73/Iv6dd4HKGjOyS
p3iZVRAkTDrN32r7Jpihe1JcCwYwnL+jgiV5bbZ2xt5cLjHMVxEjd6wK+PsOWdR1
BkPinfRe+FO3yo1tkaoZV2IaJC5hFzuWnJ6dZwFhXpZDYNK/j6mHlPnkYO8PVrgX
qqOYj2VuKWzx3J/6tLjA+sUA/4K3vwJ/BO8FrePfNdRMd0WmMmwqs+f/CrfH/daV
7c+AN9hm7QaZAOq3uv2nbVR2X1ZtEiTSvgyG38UvY2RPGwviAb95NFJPfX2GaWW2
8O3hJDfxoHpbj/11bjoa
=/EnZ
-----END PGP SIGNATURE-----

--p0aHTXLXY/BobAxh--
