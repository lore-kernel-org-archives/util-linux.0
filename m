Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:43612 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933218AbeAYEWB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 24 Jan 2018 23:22:01 -0500
Received: from vapier (localhost [127.0.0.1])
        by smtp.gentoo.org (Postfix) with SMTP id 6F3E5335C2C
        for <util-linux@vger.kernel.org>; Thu, 25 Jan 2018 04:22:01 +0000 (UTC)
Date: Wed, 24 Jan 2018 23:22:01 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] cal: drop trailing blank line
Message-ID: <20180125042201.GC1718@vapier>
References: <1464037332-21996-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
In-Reply-To: <1464037332-21996-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23 May 2016 17:02, Mike Frysinger wrote:
> There's no history to be found behind this, and the comment in the
> code indicates no one else knows, and it makes me angry :).
>=20
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  misc-utils/cal.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/misc-utils/cal.c b/misc-utils/cal.c
> index 3e20530..479c967 100644
> --- a/misc-utils/cal.c
> +++ b/misc-utils/cal.c
> @@ -767,9 +767,6 @@ static void yearly(const struct cal_control *ctl)
>  		my_putstring("\n\n");
>  	}
>  	monthly(ctl);
> -
> -	/* Is empty line at the end year output really needed? */
> -	my_putstring("\n");
>  }
> =20
>  /*
> --=20
> 2.8.2

ping ...
-mike

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEuQK1JxMl+JKsJRrUQWM7n+g39YEFAlppW2gACgkQQWM7n+g3
9YH+MxAA3tn8eJ/It9pzvH0pHZyQL79+ef56vSxIXmrVY99x+g4+RfdfLEQt5CAu
otVoY+WnwjybBvbEbR6qolUmZV92Z6w/NtIy5U70YvyqDVl+rYFfm2osfz/b92BF
plbFF2z7dN+Sw0/UhcbmH+2nk8fgJ7tIo+9wvwl2jc6rEJVZ0BGI1Utj2PsSB4aH
59iYGOMfr9rcRLZAqpiFPVYy44SZ24ZwFv0QjpamlqfY9LxgdZWhzBy7ZAKGKc3k
n5C9Qn7C+watSN1N1apkrd83t2VlXQYLAudvSD3B1mdRtuuHh9gN8068fBGbRgjj
h4TKp5qenKxMtDXwhyTpFw2gA+X1bMlEi2q7IBXJiJ6sPsry1wfZG8vc5wJ3XG4h
77CRX7Ws+K1zWDaoymQ4pbFYPGY51lpLrpGoLypFNRgW7m04T0M7qhQE6Rak1tO6
nkS0rrg6nHwgFhYzdvlFqkaaYp/m09wLcLWzMwGjprnEqDB0JVmz0QSl/FjjKHDM
RJWSpgrfz6GAzgFtrpvCl+Fu1JYDzZWx2xQDTgN0lWTX3mpKl1kTL7FEvm/PDV13
IHaLw1/U6Qwk7LwsaJI3yHY6SQbaWQPHFbsu3ulZowzt0H49sdcBDKjLiZE/epZZ
6F8rruuB+zSVJOMw/hCL0TwdRpKGANzVg/kDa0s/P9UWytHWgz0=
=J+vM
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
