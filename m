Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:58089 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059Ab2D1QTH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 28 Apr 2012 12:19:07 -0400
Date: Sat, 28 Apr 2012 18:18:59 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/4] fdisk: rework fatal errors
Message-ID: <20120428161859.GB8714@skipper.site>
References: <1335525831.11068.6.camel@offworld>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
In-Reply-To: <1335525831.11068.6.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 27, 2012 at 01:23:51PM +0200, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
>=20
> When the device cannot be opened, there's no point calling fatal() when w=
e can just use err(3). When any other kind of fatal
> error occurs it's Ok, in addition we can also go ahead and close the desc=
riptor before exiting the program as it's currently leaking.
>=20
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  fdisk/fdisk.c |   18 ++++++------------
>  fdisk/fdisk.h |    9 ++++++---
>  2 files changed, 12 insertions(+), 15 deletions(-)
>=20
> diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
> index f49efd0..a16b672 100644
> --- a/fdisk/fdisk.c
> +++ b/fdisk/fdisk.c
> @@ -264,10 +264,8 @@ static void __attribute__ ((__noreturn__)) usage(FIL=
E *out)
> =20
>  void fatal(enum failure why)
>  {
> +	close(fd);
>  	switch (why) {
> -		case unable_to_open:
> -			err(EXIT_FAILURE, _("unable to open %s"), disk_device);
> -
>  		case unable_to_read:
>  			err(EXIT_FAILURE, _("unable to read %s"), disk_device);
> =20
> @@ -1087,18 +1085,14 @@ static int get_boot(int try_only) {
>  	disklabel =3D ANY_LABEL;
>  	memset(MBRbuffer, 0, 512);
> =20
> -	if (try_only && (fd =3D open(disk_device, O_RDONLY)) < 0) {
> -		fprintf(stderr, _("Cannot open %s\n"), disk_device);
> -		fatal(unable_to_open);
> -	}
> +	if (try_only && (fd =3D open(disk_device, O_RDONLY)) < 0)
> +		err(EXIT_FAILURE, _("unable to open %s"), disk_device);
>  	else {
>  		if ((fd =3D open(disk_device, O_RDWR)) < 0) {
>  			/* ok, can we read-only the device? */
>  			if ((fd =3D open(disk_device, O_RDONLY)) < 0)
> -				fatal(unable_to_open);
> -			else
> -				printf(_("You will not be able to write "
> -					 "the partition table.\n"));
> +				err(EXIT_FAILURE, _("unable to open %s"), disk_device);
> +			printf(_("You will not be able to write the partition table.\n"));
>  		}
>  	}
> =20
> @@ -2958,7 +2952,7 @@ main(int argc, char **argv) {
>  		for (j =3D optind; j < argc; j++) {
>  			disk_device =3D argv[j];
>  			if ((fd =3D open(disk_device, O_RDONLY)) < 0)
> -				fatal(unable_to_open);
> +				err(EXIT_FAILURE, _("unable to open %s"), disk_device);
>  			if (blkdev_get_sectors(fd, &size) =3D=3D -1)
>  				fatal(ioctl_error);
>  			close(fd);
> diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
> index 01e3d72..cff6b60 100644
> --- a/fdisk/fdisk.h
> +++ b/fdisk/fdisk.h
> @@ -44,9 +44,12 @@ enum menutype {
>  	EXPERT_MENU,
>  };
> =20
> -enum failure {ioctl_error,
> -	unable_to_open, unable_to_read, unable_to_seek,
> -	unable_to_write};
> +enum failure {
> +	ioctl_error,
> +	unable_to_read,=20

Trailing whitespace ^^ :)

Reviewed-by: Petr Uzel <petr.uzel@suse.cz>


Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk+cGHMACgkQnZxG0T6qDD323QCfSPv+7NH/br9pc/JQP3GqQQZS
rp4An2IJDOxGynKY2nKPcYwLzWr6Wf0P
=7Jeg
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
