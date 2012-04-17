Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:40341 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917Ab2DQTTZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Apr 2012 15:19:25 -0400
Date: Tue, 17 Apr 2012 20:19:03 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/8] fdisk: make CHS user values more robust
Message-ID: <20120417181903.GA8666@skipper.site>
References: <1334569473.2552.10.camel@offbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
In-Reply-To: <1334569473.2552.10.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2012 at 11:44:33AM +0200, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
>=20
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  fdisk/cfdisk.c |    6 +++---
>  fdisk/fdisk.c  |    8 ++++----
>  fdisk/sfdisk.c |    9 +++++----
>  3 files changed, 12 insertions(+), 11 deletions(-)
>=20
> diff --git a/fdisk/cfdisk.c b/fdisk/cfdisk.c
> index a6cf01e..33624bb 100644
> --- a/fdisk/cfdisk.c
> +++ b/fdisk/cfdisk.c
> @@ -2776,7 +2776,7 @@ main(int argc, char **argv)
>  	    arrow_cursor =3D TRUE;
>  	    break;
>  	case 'c':
> -	    user_cylinders =3D cylinders =3D atoll(optarg);
> +		user_cylinders =3D cylinders =3D strtoll_or_err(optarg, _("cannot pars=
e amount of cylinders"));

s/amount/number ?

dtto below

>  	    if (cylinders <=3D 0) {
>  		fprintf(stderr, "%s: %s\n", argv[0], _("Illegal cylinders value"));
>  		exit(1);
> @@ -2786,14 +2786,14 @@ main(int argc, char **argv)
>  	    use_partition_table_geometry =3D TRUE;
>  	    break;
>  	case 'h':
> -	    user_heads =3D heads =3D atoi(optarg);
> +	    user_heads =3D heads =3D strtol_or_err(optarg, _("cannot parse amou=
nt of heads"));

[SNIP]

--
Petr Uzel
IRC: ptr_uzl @ freenode

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk+NtBcACgkQnZxG0T6qDD0jfACfaUl7n4yImfs2JIZf7Pyc8aTG
QgkAn16rX8Dd1E0CeppAJuypoqDcoGYc
=3IP5
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
