Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:54280 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232Ab2GXJxN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 05:53:13 -0400
Date: Tue, 24 Jul 2012 11:52:54 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH 03/10] fdisk: API: add fdisk_label_change
Message-ID: <20120724095254.GC2086@foxbat.suse.cz>
References: <1342976704.2863.13.camel@offbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
In-Reply-To: <1342976704.2863.13.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 22, 2012 at 07:05:04PM +0200, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
>=20
> A new fdisk_label_change() function is added for situations when the disk=
 label is
> changed (ie: creating a new sun label). This function only updates the la=
bel pointer
> in the context to use the newly specified label type.

Why can't we just call __probe_labels() after creating new label, e.g.
in soon-to-be introduced fdisk_label_create()?

>=20
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  fdisks/fdisk.h         |    2 ++
>  fdisks/fdiskdoslabel.c |    1 +
>  fdisks/fdisksgilabel.c |    2 ++
>  fdisks/fdisksunlabel.c |    1 +
>  fdisks/utils.c         |   37 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 43 insertions(+), 0 deletions(-)
>=20
> diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
> index d716824..d7e85f5 100644
> --- a/fdisks/fdisk.h
> +++ b/fdisks/fdisk.h
> @@ -104,6 +104,7 @@ enum fdisk_error {
>  	FDISK_ERROR_WRITE,
>  	FDISK_ERROR_IOCTL,
>  	FDISK_ERROR_PROBE,
> +	FDISK_ERROR_NOLABEL,
>  	FDISK_ERROR_UNKNOWN
>  };
> =20
> @@ -164,6 +165,7 @@ extern void fdisk_mbr_zeroize(struct fdisk_context *c=
xt);
>  extern void fdisk_geom_set_cyls(struct fdisk_context *cxt);
>  extern const char *fdisk_error_name(enum fdisk_error errcode);
>  extern void fdisk_error_fatal(struct fdisk_context *cxt, enum fdisk_erro=
r errcode);
> +extern int fdisk_label_change(struct fdisk_context *cxt, const char *nam=
e);
> =20
>  /* prototypes for fdisk.c */
>  extern char *disk_device, *line_ptr;
> diff --git a/fdisks/fdiskdoslabel.c b/fdisks/fdiskdoslabel.c
> index 535afdc..9b9b23a 100644
> --- a/fdisks/fdiskdoslabel.c
> +++ b/fdisks/fdiskdoslabel.c
> @@ -230,6 +230,7 @@ void create_doslabel(struct fdisk_context *cxt)
> =20
>  	dos_init(cxt);
>  	fdisk_mbr_zeroize(cxt);
> +	fdisk_label_change(cxt, "dos");
>  	set_all_unchanged();
>  	set_changed(0);
> =20
> diff --git a/fdisks/fdisksgilabel.c b/fdisks/fdisksgilabel.c
> index e38d98f..6001038 100644
> --- a/fdisks/fdisksgilabel.c
> +++ b/fdisks/fdisksgilabel.c
> @@ -780,6 +780,8 @@ create_sgilabel(struct fdisk_context *cxt)
>  		}
> =20
>  	fdisk_mbr_zeroize(cxt);
> +	fdisk_label_change(cxt, "sgi");
> +
>  	sgilabel->magic =3D SSWAP32(SGI_LABEL_MAGIC);
>  	sgilabel->boot_part =3D SSWAP16(0);
>  	sgilabel->swap_part =3D SSWAP16(1);
> diff --git a/fdisks/fdisksunlabel.c b/fdisks/fdisksunlabel.c
> index 4123806..b63335c 100644
> --- a/fdisks/fdisksunlabel.c
> +++ b/fdisks/fdisksunlabel.c
> @@ -161,6 +161,7 @@ void create_sunlabel(struct fdisk_context *cxt)
> =20
>  	init();
>  	fdisk_mbr_zeroize(cxt);
> +	fdisk_label_change(cxt, "sun");
> =20
>  	sunlabel->magic =3D SSWAP16(SUN_LABEL_MAGIC);
>  	sunlabel->sanity =3D SSWAP32(SUN_LABEL_SANE);
> diff --git a/fdisks/utils.c b/fdisks/utils.c
> index cf9484c..48dedfb 100644
> --- a/fdisks/utils.c
> +++ b/fdisks/utils.c
> @@ -44,6 +44,43 @@ static const struct fdisk_label *labels[] =3D
>  	&mac_label,
>  };
> =20
> +/**
> + * fdisk_label_change:
> + * @cxt: fdisk context
> + * @name: new label name
> + *
> + * Updates the disk label type to the one specified by @name.
> + *
> + * Returns 0 on success, otherwise, a corresponding error.
> + */
> +int fdisk_label_change(struct fdisk_context *cxt, const char *name)
> +{
> +	int i;
> +
> +	if (!cxt || !cxt->label || !name)
> +		return FDISK_ERROR_UNKNOWN;
> +
> +	/* not really changing the label */
> +	if (!strncmp(name, cxt->label->name, strlen(name)))
> +		goto done;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(labels); i++) {
> +		if (strncmp(name, labels[i]->name, strlen(name)))
> +			continue;
> +=09
> +		/* found the new label */
> +		memset(cxt->label, 0, sizeof(struct fdisk_label));
> +		memcpy(cxt->label, labels[i], sizeof(struct fdisk_label));
> +		DBG(LABEL, dbgprint("changing to a %s label\n", labels[i]->name));
> +		goto done;
> +	}
> +
> +	/* couldn't find the requested label type */
> +	return FDISK_ERROR_NOLABEL;
> +done:
> +	return 0;
> +}
> +
>  static int __probe_labels(struct fdisk_context *cxt)
>  {
>  	int i, rc =3D 0;
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

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAlAOcHYACgkQnZxG0T6qDD0hAwCeLulhjwXoleNbf39Qd6VB8NmG
S88An1Y/vlazDpnJv98mMLFDXxUuhfNH
=YEde
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
