Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:54935 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753560Ab2GXJ4f (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 05:56:35 -0400
Date: Tue, 24 Jul 2012 11:56:17 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: dave@gnu.org, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 03/10] fdisk: API: add fdisk_label_change
Message-ID: <20120724095617.GD2086@foxbat.suse.cz>
References: <1342976704.2863.13.camel@offbook>
 <500E6F49.60406@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1sNVjLsmu1MXqwQ/"
In-Reply-To: <500E6F49.60406@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--1sNVjLsmu1MXqwQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2012 at 11:47:53AM +0200, Bernhard Voelker wrote:
>=20
>=20
> On 07/22/2012 07:05 PM, Davidlohr Bueso wrote:
> > --- a/fdisks/fdisksunlabel.c
> > +++ b/fdisks/fdisksunlabel.c
> > @@ -161,6 +161,7 @@ void create_sunlabel(struct fdisk_context *cxt)
> > =20
> >  	init();
> >  	fdisk_mbr_zeroize(cxt);
> > +	fdisk_label_change(cxt, "sun");
> > =20
>=20
> ...
>=20
> > +int fdisk_label_change(struct fdisk_context *cxt, const char *name)
> > +{
> > +	int i;
> > +
> > +	if (!cxt || !cxt->label || !name)
> > +		return FDISK_ERROR_UNKNOWN;
> > +
> > +	/* not really changing the label */
> > +	if (!strncmp(name, cxt->label->name, strlen(name)))
> > +		goto done;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(labels); i++) {
> > +		if (strncmp(name, labels[i]->name, strlen(name)))
> > +			continue;
>=20
> Shouldn't we use something else than hardcoded "sun"|"dos"|"sgi"|...
> strings here?=20

What's the problem with these strings? I think these are well
recognized with clear meaning. What alternative do you propose?

Thanks,

        Petr


> (See also "[PATCH 08/10] fdisk: API: add create disklabel
> to label operations".)
>=20
> Have a nice day,
> Berny
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--1sNVjLsmu1MXqwQ/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAlAOcUEACgkQnZxG0T6qDD0z9gCfe41awGLtHRDl07fx0cn4r81+
x6AAn2txHPdvbNThupAId9V2v6PQVk/Z
=kdqa
-----END PGP SIGNATURE-----

--1sNVjLsmu1MXqwQ/--
