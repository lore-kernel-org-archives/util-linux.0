Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:58086 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab2D1QTG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 28 Apr 2012 12:19:06 -0400
Date: Sat, 28 Apr 2012 18:15:02 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/4] fdisk: remove stack jumping
Message-ID: <20120428161502.GA8714@skipper.site>
References: <1335525822.11068.4.camel@offworld>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
In-Reply-To: <1335525822.11068.4.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 27, 2012 at 01:23:42PM +0200, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
>=20
> This patch eliminates the long/setjmp code. The current logic
> does not do anything with stack jumps as it only exits from
> print_partition_table_from_option() when a fatal error occurs.

The stack jumping makes fdisk remain silent and return success (!)
if the listing fails on any of the devices. Not that I think this
is useful behavior, but IMHO this change in behavior is worth
mentioning in the release notes.

Reviewed-by: Petr Uzel <petr.uzel@suse.cz>

> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  fdisk/fdisk.c |   17 ++---------------
>  1 files changed, 2 insertions(+), 15 deletions(-)
>=20
> diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
> index 4054b4d..886f011 100644
> --- a/fdisk/fdisk.c
> +++ b/fdisk/fdisk.c
> @@ -14,7 +14,6 @@
>  #include <string.h>
>  #include <fcntl.h>
>  #include <ctype.h>
> -#include <setjmp.h>
>  #include <errno.h>
>  #include <getopt.h>
>  #include <sys/stat.h>
> @@ -245,8 +244,6 @@ int has_topology;
> =20
>  enum labeltype disklabel;	/* Current disklabel */
> =20
> -jmp_buf listingbuf;
> -
>  static void __attribute__ ((__noreturn__)) usage(FILE *out)
>  {
>  	fprintf(out, _("Usage:\n"
> @@ -266,13 +263,8 @@ static void __attribute__ ((__noreturn__)) usage(FIL=
E *out)
>  	exit(out =3D=3D stderr ? EXIT_FAILURE : EXIT_SUCCESS);
>  }
> =20
> -void fatal(enum failure why) {
> -
> -	if (listing) {
> -		close(fd);
> -		longjmp(listingbuf, 1);
> -	}
> -
> +void fatal(enum failure why)
> +{
>  	switch (why) {
>  		case unable_to_open:
>  			err(EXIT_FAILURE, _("unable to open %s"), disk_device);
> @@ -2708,8 +2700,6 @@ print_partition_table_from_option(char *device)
>  	int gb;
> =20
>  	disk_device =3D device;
> -	if (setjmp(listingbuf))
> -		return;
>  	gpt_warning(device);
>  	gb =3D get_boot(1);
>  	if (gb < 0) { /* no DOS signature */
> @@ -2950,9 +2940,6 @@ main(int argc, char **argv) {
>  		nowarn =3D 1;
>  		if (argc > optind) {
>  			int k;
> -			/* avoid gcc warning:
> -			   variable `k' might be clobbered by `longjmp' */
> -			dummy(&k);
>  			listing =3D 1;
>  			for (k =3D optind; k < argc; k++)
>  				print_partition_table_from_option(argv[k]);
> --=20
> 1.7.4.1
>=20
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEUEARECAAYFAk+cF4YACgkQnZxG0T6qDD1sFQCXXpL4zqpYYMkLAr4xPhcwYY/w
WACfWkSNf8tpAAjydB+jaUgjrAlXiHI=
=QO6m
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
