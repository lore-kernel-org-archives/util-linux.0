Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:40237 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753664AbbBPE60 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 15 Feb 2015 23:58:26 -0500
Date: Mon, 16 Feb 2015 00:00:53 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: libsmartcols patch
Message-ID: <20150216050053.GA4075@vapier>
References: <54A0AE98.70503@ubuntu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
In-Reply-To: <54A0AE98.70503@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28 Dec 2014 20:30, Phillip Susi wrote:
> --- libsmartcols/src/table_print.c	2014-12-24 23:59:55.780110296 +0200
> +++ libsmartcols/src/table_print.c	2014-12-28 22:45:20.347285226 +0200
> =20
> +	assert(ln);
> +	assert(buf);

general note: libraries should never assert/abort/exit.  if this were inter=
nal,=20
then you could make a case about the utilities being ok with that, but it l=
ooks=20
like the intention is for people to include the header and link against it =
=66rom=20
outside of util-linux.
-mike

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU4XmFAAoJEEFjO5/oN/WByZkP/AzpFHv7pcpOp2vL5a1Y0Y2X
Ywp5Quzzkyxls5bEEG5R7Nmgkq2tTt2QjfaUy01e2ykJCYr4DSWdBZFFTNDyCWui
Y7YY27dNPmuK/5Sbz5dp49GcjLYBbmnV7bTgjjOmSJmLAytEWF6Sacn2l2fSt//k
/6dvPYKCmJKII7Gbi/Oom+HyQMBakPNgXDNcZJUpFMpC7a7jJHIdUBz79NGwORBE
gdUYLYPW+N/zAB+HuRl26M5Clw6OCo0f5oQhEN3VSRWHW4tE+86ya/MAB6AFHiaA
ryKu2/vaIV7U8ZLElKJpLzUED5bdwTJb+owyNeKSYhHb3y3+VJcCKoI8y2KUGpW/
NntNObdzJv2q5rc3ComWZPwUjzWG6m+8znhLLwvWAmD1CLXkY8pppCdT4rh3QAOq
jBofvgz10Pu70YI2P/sVDvj1hKNTN2wsIlhVnjY7tCVfxNkn1ZsJ95jaZ1cwqavv
6cNZUTw8h41lvEOPeEzWGJKhcLZvQhaXq8T+0digGxH+2pJl6g51eN6htuWFNfnY
wwdiIxLD/ToU4rGNYapIBiBHeeVywIEHgcEPcUzgl0iW0GGz8QnMEw6xibhWOzSQ
QBUGU9ZJl++9WcEiJZV2P+7M4v23jGqfm1Oofid0fAyOP+EsYzNibrb2CVMLS4Y1
QLs2fpIKuSBNivy9qydJ
=Jc1o
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
