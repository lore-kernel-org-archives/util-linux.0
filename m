Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:48842 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118Ab2FDOOj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Jun 2012 10:14:39 -0400
Date: Mon, 4 Jun 2012 16:14:12 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/5] fdisk: add total sectors
Message-ID: <20120604141412.GC9264@foxbat.suse.cz>
References: <1338747320.2864.11.camel@offbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
In-Reply-To: <1338747320.2864.11.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 03, 2012 at 08:15:20PM +0200, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
>=20
> Add the total_sectors variable to the context structure. This is the init=
ial geometry information.
>=20
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  fdisk/fdisk.c         |   21 ++++++++-------------
>  fdisk/fdisk.h         |    5 ++++-
>  fdisk/fdiskdoslabel.c |    4 ++--
>  fdisk/utils.c         |   12 ++++++++++++
>  4 files changed, 26 insertions(+), 16 deletions(-)
>=20
> diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
> index d7ff2e5..654d8f3 100644
> --- a/fdisk/fdisk.c
> +++ b/fdisk/fdisk.c
> @@ -145,7 +145,6 @@ unsigned int	heads,
>  	units_per_sector =3D 1,
>  	display_in_cyl_units =3D 0;
> =20
> -sector_t total_number_of_sectors; /* in logical sectors */
>  unsigned long grain =3D DEFAULT_SECTOR_SIZE;
>  enum labeltype disklabel;	/* Current disklabel */
> =20
> @@ -400,8 +399,8 @@ void update_units(void)
> =20
>  void warn_limits(struct fdisk_context *cxt)
>  {
> -	if (total_number_of_sectors > UINT_MAX && !nowarn) {
> -		unsigned long long bytes =3D total_number_of_sectors * cxt->sector_siz=
e;
> +	if (cxt->total_sectors > UINT_MAX && !nowarn) {
> +		unsigned long long bytes =3D cxt->total_sectors * cxt->sector_size;
>  		int giga =3D bytes / 1000000000;
>  		int hectogiga =3D (giga + 50) / 100;
> =20
> @@ -509,7 +508,7 @@ update_sector_offset(struct fdisk_context *cxt)
>  		sector_offset =3D x / cxt->sector_size;
> =20
>  		/* don't use huge offset on small devices */
> -		if (total_number_of_sectors <=3D sector_offset * 4)
> +		if (cxt->total_sectors <=3D sector_offset * 4)
>  			sector_offset =3D cxt->phy_sector_size / cxt->sector_size;
> =20
>  		/* use 1MiB grain always when possible */
> @@ -517,7 +516,7 @@ update_sector_offset(struct fdisk_context *cxt)
>  			grain =3D 2048 * 512;
> =20
>  		/* don't use huge grain on small devices */
> -		if (total_number_of_sectors <=3D (grain * 4 / cxt->sector_size))
> +		if (cxt->total_sectors <=3D (grain * 4 / cxt->sector_size))
>  			grain =3D cxt->phy_sector_size;
>  	}
>  }
> @@ -540,13 +539,9 @@ get_geometry(struct fdisk_context *cxt, struct geom =
*g) {
>  		pt_sectors ? pt_sectors :
>  		kern_sectors ? kern_sectors : 63;
> =20
> -	/* get number of 512-byte sectors, and convert it the real sectors */
> -	if (blkdev_get_sectors(cxt->dev_fd, &nsects) =3D=3D 0)
> -		total_number_of_sectors =3D (nsects / (cxt->sector_size >> 9));

This leaves 'nsect' as unused variable.

Otherwise it looks good to me.

Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk/MwrQACgkQnZxG0T6qDD1VVQCbBEwDbBTNNX4VxcdVh0cPcpsq
MIgAn3ZLI+zxzF1c+RcMk0PXJD5AEGfg
=65sS
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
