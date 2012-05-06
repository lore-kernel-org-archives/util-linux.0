Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:33433 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754616Ab2EFSLu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 6 May 2012 14:11:50 -0400
Date: Sun, 6 May 2012 20:11:44 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/5] fdisk: create DOS specific write table function
Message-ID: <20120506181144.GB6429@skipper.site>
References: <1336306221.2685.12.camel@offbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
In-Reply-To: <1336306221.2685.12.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2012 at 02:10:21PM +0200, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
>=20
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  fdisk/fdisk.c         |   27 ++++-----------------------
>  fdisk/fdiskdoslabel.c |   27 +++++++++++++++++++++++++++
>  fdisk/fdiskdoslabel.h |    1 +
>  3 files changed, 32 insertions(+), 23 deletions(-)
>=20
> diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
> index 8c2a162..3044879 100644
> --- a/fdisk/fdisk.c
> +++ b/fdisk/fdisk.c
> @@ -1672,31 +1672,12 @@ static void
>  write_table(void) {
>  	int i;
> =20
> -	if (disklabel =3D=3D DOS_LABEL) {
> -		/* MBR (primary partitions) */
> -		if (!MBRbuffer_changed) {
> -			for (i =3D 0; i < 4; i++)
> -				if (ptes[i].changed)
> -					MBRbuffer_changed =3D 1;
> -		}
> -		if (MBRbuffer_changed) {
> -			write_part_table_flag(MBRbuffer);
> -			write_sector(fd, 0, MBRbuffer);
> -		}
> -		/* EBR (logical partitions) */
> -		for (i =3D 4; i < partitions; i++) {
> -			struct pte *pe =3D &ptes[i];
> -
> -			if (pe->changed) {
> -				write_part_table_flag(pe->sectorbuffer);
> -				write_sector(fd, pe->offset, pe->sectorbuffer);
> -			}
> -		}
> -	}
> -	else if (disklabel =3D=3D SGI_LABEL) {
> +	if (disklabel =3D=3D DOS_LABEL)
> +		dos_write_table();
> +	else if (disklabel =3D=3D SGI_LABEL)
>  		/* no test on change? the printf below might be mistaken */
>  		sgi_write_table();
> -	} else if (disklabel =3D=3D SUN_LABEL) {
> +	else if (disklabel =3D=3D SUN_LABEL) {
>  		int needw =3D 0;
> =20
>  		for (i=3D0; i<8; i++)
> diff --git a/fdisk/fdiskdoslabel.c b/fdisk/fdiskdoslabel.c
> index 3f820db..a13a83a 100644
> --- a/fdisk/fdiskdoslabel.c
> +++ b/fdisk/fdiskdoslabel.c
> @@ -657,3 +657,30 @@ void dos_new_partition(void)
>  			printf(_("Invalid partition type `%c'\n"), c);
>  	}
>  }
> +
> +void dos_write_table(void)
> +{
> +	int i;
> +
> +	if (disklabel =3D=3D DOS_LABEL) {

This if is unnecessary - the caller should make sure that
disklabel =3D=3D DOS_LABEL as write_table() does. What about

assert(disklabel =3D=3D DOS_LABEL) instead?

> +		/* MBR (primary partitions) */
> +		if (!MBRbuffer_changed) {
> +			for (i =3D 0; i < 4; i++)
> +				if (ptes[i].changed)
> +					MBRbuffer_changed =3D 1;
> +		}
> +		if (MBRbuffer_changed) {
> +			write_part_table_flag(MBRbuffer);
> +			write_sector(fd, 0, MBRbuffer);
> +		}
> +		/* EBR (logical partitions) */
> +		for (i =3D 4; i < partitions; i++) {
> +			struct pte *pe =3D &ptes[i];
> +
> +			if (pe->changed) {
> +				write_part_table_flag(pe->sectorbuffer);
> +				write_sector(fd, pe->offset, pe->sectorbuffer);
> +			}
> +		}
> +	}
> +}
> diff --git a/fdisk/fdiskdoslabel.h b/fdisk/fdiskdoslabel.h
> index e45a026..8c116f7 100644
> --- a/fdisk/fdiskdoslabel.h
> +++ b/fdisk/fdiskdoslabel.h
> @@ -52,5 +52,6 @@ extern int is_dos_partition(int t);
>  extern void dos_init(void);
>  extern void dos_add_partition(int n, int sys);
>  extern void dos_new_partition(void);
> +extern void dos_write_table(void);
> =20
>  #endif
> --=20
> 1.7.4.1

Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk+mvuAACgkQnZxG0T6qDD3r6wCdEnyVt81Fi5Fgl9ix5X/e3wBt
QQoAn2DAl6KXuRQfCm2KJjzZSY5W8MeD
=6X+9
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
