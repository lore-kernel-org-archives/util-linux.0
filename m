Return-Path: util-linux-owner@vger.kernel.org
Received: from vint.altlinux.org ([194.107.17.35]:60123 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580Ab2JRSSK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 18 Oct 2012 14:18:10 -0400
Date: Thu, 18 Oct 2012 22:18:07 +0400
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Ayan George <ayan@ayan.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Use C99 idioms in kill.c
Message-ID: <20121018181807.GA25656@altlinux.org>
References: <508025be.e81S03iobeo1edmy%ayan@ayan.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
In-Reply-To: <508025be.e81S03iobeo1edmy%ayan@ayan.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 18, 2012 at 03:52:30PM +0000, Ayan George wrote:
> * Moved some declarations closer to where the vairable is used.
> * Declared variables used only in loops within the loop itself.
> ---
>  misc-utils/kill.c |   45 +++++++++++++++++++--------------------------
>  1 file changed, 19 insertions(+), 26 deletions(-)
>=20
> diff --git a/misc-utils/kill.c b/misc-utils/kill.c
> index 6abfd24..2b88852 100644
> --- a/misc-utils/kill.c
> +++ b/misc-utils/kill.c
[...]
> -    numsig =3D SIGTERM;
> -    do_pid =3D (! strcmp (progname, "pid")); 	/* Yecch */
> -    do_kill =3D 0;
> -    check_all =3D 0;
> +    int numsig =3D SIGTERM,
> +    	do_pid =3D (! strcmp (progname, "pid")), 	/* Yecch */
> +    	do_kill =3D 0;
> +    	check_all =3D 0;

Please enable your .git/hooks/pre-commit to stop these whitespace errors,
no matter whether to use C99 or not.


--=20
ldv

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlCAR98ACgkQfKvmrJ41Nh7oVwCbBqqcuWn8zSU02fLOv0YlLGKU
uVgAoJQlz+CN0W1MWY4qk+VCAJncaitO
=VEyS
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
