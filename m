Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:58000 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757165AbbHZWiY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Aug 2015 18:38:24 -0400
Date: Wed, 26 Aug 2015 18:38:23 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Kees Cook <keescook@chromium.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] libmount: handle arbitrary line length for mounts
Message-ID: <20150826223823.GH3116@vapier>
References: <20150826220230.GA8599@www.outflux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
In-Reply-To: <20150826220230.GA8599@www.outflux.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 26 Aug 2015 15:02, Kees Cook wrote:
> + * Read a line with fgets. If it doesn't fit in the existing buffer,
> + * allocate more heap memory for storage until it does fit.

why not just use getline then ?

> +		if (fgets (current, remaining, f) == NULL) {

style omits space before the (.  comes up a few times in this patch.
-mike

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV3j/fAAoJEEFjO5/oN/WB6H8QANaLX2Ofl5ffZE6Z5wg7Ihz5
EcUK5ek3fxuJOUFFA9Shwlpq2N4hzUOTpcaidKD7oyisqfP+CihqAch4XVDObuas
4Uq3OAaICC9Z5TrAWbY0a9eZhmM7J66jLeAaFid/H79zVUIJPpYjgN3Iimst2H/V
aLD3BrMo+VPV+bZvIwOOzWh1M2HN4U+VhS+1Zbk3EPYxeAidT4U6LfHhMved0pqO
6mXxx5sA9TvowsC8Ek3nD1gLD5teny5zuN2ZhpNy3aQpOINB0noIG3jx/ZgO10QM
hrNU7J1dOcz0RNt6Ow9V264tuYCtPKum30RJiBx9DrwXQkG5752+a3LNxM5u+7KG
Whskc2sYEBGltIPtr2t5ZJyuI4ALrp2rsKDt2QKgt4XUBKEc7MX6yxJGVmFSD1C7
gaMsXAfnrMgkA6KelpsOW3uOKWlmLfkf4Tdfct8VF924gofegQ+3yFRDBfNIAZKF
W4UGhLeOlEKCTBkYycyF9dTlhUI/yhGHEQWksvQlNkuJNpK6VoCW+k5uNAxj6sI4
SwAR4HI5x7YRBiF9DhsqktiVEt6VHOYviDzx7+2hsJPDVdbLkGN9jn/MbC8/9scX
xVIuilFLBL2nkjHzy6f2nP2c/T86H5RsU23iUePPvgn3ORKIplYjcJTDAwmDd8RE
lk54TZnx8BV11r4sHWTV
=dRpX
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--
