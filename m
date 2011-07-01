Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:59618 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755554Ab1GANdM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jul 2011 09:33:12 -0400
Date: Fri, 1 Jul 2011 15:33:10 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] sfdisk: warn if partition starts above 2 TiB limit
Message-ID: <20110701133310.GB23585@foxbat.suse.cz>
References: <20110701111154.GA24105@foxbat.suse.cz>
 <20110701131140.GQ6418@nb.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
In-Reply-To: <20110701131140.GQ6418@nb.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 01, 2011 at 03:11:40PM +0200, Karel Zak wrote:
> On Fri, Jul 01, 2011 at 01:11:56PM +0200, Petr Uzel wrote:
> >=20
> > Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
> > ---
> >  fdisk/sfdisk.c |   11 +++++++++++
> >  1 files changed, 11 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
> > index 4ed5d37..d498371 100644
> > --- a/fdisk/sfdisk.c
> > +++ b/fdisk/sfdisk.c
> > @@ -1304,6 +1304,17 @@ partitions_ok(struct disk_desc *z) {
> >  	    }
> >      }
> > =20
> > +    /* Do the partitions start below the DOS 2TiB limit? */
> > +    {
> > +	for (p =3D partitions; p < partitions + partno; p++)
> > +	    if (p->size && p->start > (unsigned long) UINT32_MAX) {
>=20
>  ULONG_MAX is not greater than UINT32_MAX on 32-bit archs ;-)
>=20
>  IMHO you have to use 64-bit number for the p->size or you have=20
>  move the check to the place where (before) p->start is incremented.
>=20
> > +	        my_warn(_("Warning: partition %s has starting sector %lu, "
> > +		          "which is above the DOS 2 TiB limit\n"),
>=20
>  The warning is incorrect. The limit is not 2 TiB, but UINT32_MAX
>  *sectors*. It's 2TiB for 512-byte sectors, but for 4K sectors is it
>  more...
>=20
>  See fdisk.fdisk.c: warn_limits().
>=20
>     Karel

Thanks for the review! I'll rework the patch and resubmit.

Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAk4NzJYACgkQnZxG0T6qDD25JwCfdZEb5TKMio9HyzpZTgVzmTPg
QicAnj1XbgUF/9dRGvmZVBPAOzUmseby
=xIUb
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
