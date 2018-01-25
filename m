Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:43854 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933369AbeAYE1I (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 24 Jan 2018 23:27:08 -0500
Date: Wed, 24 Jan 2018 23:27:06 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Libor Bukata <lbukata@gmail.com>
Cc: util-linux@vger.kernel.org, Nefelim4ag@gmail.com, kzak@redhat.com
Subject: Re: Patch to add support for lz4hc and deflate optimization
 algorithms in zramctl.
Message-ID: <20180125042706.GF1718@vapier>
References: <90fb3b4a-38b8-17fc-f1b6-03e8c23eb808@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
In-Reply-To: <90fb3b4a-38b8-17fc-f1b6-03e8c23eb808@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 22 Jan 2018 21:45, Libor Bukata wrote:
> +			if (strcmp(optarg,"lzo") && strcmp(optarg,"lz4")
> +					&& strcmp(optarg,"lz4hc") && strcmp(optarg, "deflate"))

not exactly a new issue, but there should be a space after each of those commas
-mike

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEuQK1JxMl+JKsJRrUQWM7n+g39YEFAlppXJoACgkQQWM7n+g3
9YFOPQ//WSvOxU+RYg3F7qQT7v1TqUqqaKeUcvBp8zfMnfLVnSloPAD6LKGt4RK/
ss2mwy2l0cip6w2du+JrGi6b+OfDPwA55WYEfxhtsIVZJCLcAOkf3ABZ43btFSDg
6MA2Xkh6cC5H1UK8ZZvD2nVpGo7CDIajQCCm2QaNQuZxXm7QYw3KgCx/djSaX2WA
W7rXRaOgyB4WTvzw2OESD9QujrInmq2r2/bwJSsHMJoJyXbBXbUHq+60TaxdLmRU
8cyp/L4mRtvM/Vgt4oFI5IPcGihVrsyXd7M/+N9fsYNRxOArnpYGCq6b80JOFbxT
tZ86iXgfErd2xRCyhhSj6X1GAiN4akEzYrtXiFdnfEbYxdrbqD4bCJ198ltb2VwH
S9EiyO7NfN34ylk+TqTRoH61cNlB4rDE4kcx8deqhzoKO/mWn/RPWVgd7L5v9nhI
G0nVbUKmc8m2uvR6+kvNVzBg2JJQk69voM+qy6xJkJDFwhp7xvuBj2tuiCn3LoyN
biQBV0EuCHr0xVZFdd2xDDJi+NBIlVRYzGjbVhXq+m4Y2nKgdf7wzVU7SdwvdK0/
6Vx0aWkknMYnKRS7i0OR3R1TMkaRHxAiOeav+SJXB3Rs5EZZCHy1mewdg9g7RdhO
AsWFOQCNdcPU8m/NfDfgNwFUYxdwjuBN1K6BOp+UhlLkbwi3TmE=
=TIBi
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
