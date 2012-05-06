Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:33825 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754638Ab2EFSRG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 6 May 2012 14:17:06 -0400
Date: Sun, 6 May 2012 20:17:00 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 5/5] fdisk: sgi: abort on HDIO_GETGEO failure
Message-ID: <20120506181700.GC6429@skipper.site>
References: <1336306225.2685.14.camel@offbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
In-Reply-To: <1336306225.2685.14.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 06, 2012 at 02:10:25PM +0200, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
>=20
> When the HDIO_GETGEO ioctl fails on non IRIX/MIPS platforms (ie:
> inappropriate ioctl for device) the variables that describe the
> geometry are compromissed. One clear example is a division by 0 bug
> because the cylinder size is 0 is verify_sgi():

I agree with the change, however I think that more descriptive error
message should be printed; see below.

>=20
> $> fdisk sgi.img
> Welcome to fdisk (util-linux 2.21.392-4b1c).
>=20
> ...
>=20
> Command (m for help): x
>=20
> Expert command (m for help): g
> Building a new SGI disklabel.
> Partition 11 of type SGI volume and of size 7.9 MiB is set
> Floating point exception
>=20
> Fix this by simply exiting the program instead of leaving it in a vulnera=
ble state.
>=20
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  fdisk/fdisksgilabel.c |   39 ++++++++++++++++++++-------------------
>  1 files changed, 20 insertions(+), 19 deletions(-)
>=20
> diff --git a/fdisk/fdisksgilabel.c b/fdisk/fdisksgilabel.c
> index 822f55d..b61f102 100644
> --- a/fdisk/fdisksgilabel.c
> +++ b/fdisk/fdisksgilabel.c
> @@ -705,25 +705,26 @@ create_sgilabel(void)
>  	res =3D blkdev_get_sectors(fd, &llsectors);
> =20
>  #ifdef HDIO_GETGEO
> -	if (!ioctl(fd, HDIO_GETGEO, &geometry)) {
> -		heads =3D geometry.heads;
> -		sectors =3D geometry.sectors;
> -		if (res =3D=3D 0) {
> -			/* the get device size ioctl was successful */
> -			unsigned long long llcyls;
> -			llcyls =3D llsectors / (heads * sectors * sec_fac);
> -			cylinders =3D llcyls;
> -			if (cylinders !=3D llcyls)	/* truncated? */
> -				cylinders =3D ~0;
> -		} else {
> -			/* otherwise print error and use truncated version */
> -			cylinders =3D geometry.cylinders;
> -			fprintf(stderr,
> -				_("Warning:  BLKGETSIZE ioctl failed on %s.  "
> -				  "Using geometry cylinder value of %d.\n"
> -				  "This value may be truncated for devices"
> -				  " > 33.8 GB.\n"), disk_device, cylinders);
> -		}
> +	if (ioctl(fd, HDIO_GETGEO, &geometry) < 0)
> +		err(EXIT_FAILURE, _("ioctl failed on %s"), disk_device);

s/"ioctl failed..."/"HDIO_GETGEO ioctl failed..."

[SNIP]

Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk+mwBwACgkQnZxG0T6qDD2Z+QCeILbq/qhURwFTmEktasSpT88h
D0wAn2WkGdE1eNNKwD1PT8Iwu9h50U+H
=Go8E
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
