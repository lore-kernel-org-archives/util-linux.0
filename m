Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53772 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753343Ab2GXJlu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 05:41:50 -0400
Date: Tue, 24 Jul 2012 11:41:31 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH 02/10] fdisk: API: add to label operations to context
Message-ID: <20120724094131.GB2086@foxbat.suse.cz>
References: <1342976701.2863.12.camel@offbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
In-Reply-To: <1342976701.2863.12.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 22, 2012 at 07:05:01PM +0200, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
>=20
> The context structure is the fdisk API's main data type as it keeps all d=
ata together. Add the
> label structure to it, so that the pt-specific operations can be called f=
rom the context.
>=20
> The internal probing function is updated so that if a label is not probed=
, for example when a
> disk is not formated, it will default to use either sun or dos label oper=
ations. This avoids
> scenarios that could crash the program if no label is detected - ie: righ=
t after creating a device.

Wouldn't it be nicer to have dummy/fallback entry for unknown/nonexistent l=
abel
type, e.g. 'no_label'. It's operations could return something like
NO_LABEL_PLS_CREATE_IT_FIRST. fdisk_context would be initialized to
point to this dummy label type and later overridden by successful label
probe.


> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  fdisks/fdisk.c |    4 ++--
>  fdisks/fdisk.h |   23 +++++++++++++++--------
>  fdisks/utils.c |   35 ++++++++++++++++++++++++++++-------
>  3 files changed, 45 insertions(+), 17 deletions(-)
>=20
> diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
> index 3b9bd7b..46322bc 100644
> --- a/fdisks/fdisk.c
> +++ b/fdisks/fdisk.c
> @@ -68,7 +68,7 @@ int MBRbuffer_changed;
>  struct menulist_descr {
>  	char command;				/* command key */
>  	char *description;			/* command description */
> -	enum labeltype label[2];		/* disklabel types associated with main and e=
xpert menu */
> +	enum fdisk_labeltype label[2];		/* disklabel types associated with main=
 and expert menu */
>  };
> =20
>  static const struct menulist_descr menulist[] =3D {
> @@ -138,7 +138,7 @@ unsigned int	user_cylinders, user_heads, user_sectors;
>  sector_t sector_offset =3D 1;
>  unsigned int units_per_sector =3D 1, display_in_cyl_units =3D 0;
>  unsigned long grain =3D DEFAULT_SECTOR_SIZE;
> -enum labeltype disklabel;	/* Current disklabel */
> +enum fdisk_labeltype disklabel;	/* Current disklabel */
> =20
>  static void __attribute__ ((__noreturn__)) usage(FILE *out)
>  {
> diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
> index 8107aa8..d716824 100644
> --- a/fdisks/fdisk.h
> +++ b/fdisks/fdisk.h
> @@ -132,6 +132,8 @@ struct fdisk_context {
>  	/* geometry */
>  	sector_t total_sectors; /* in logical sectors */
>  	struct fdisk_geometry geom;
> +
> +	struct fdisk_label *label;
>  };
> =20
>  /*
> @@ -139,6 +141,8 @@ struct fdisk_context {
>   */
>  struct fdisk_label {
>  	const char *name;
> +
> +	/* probe disk label */
>  	int (*probe)(struct fdisk_context *cxt);
>  };
> =20
> @@ -206,17 +210,20 @@ extern const char * str_units(int);
> =20
>  extern sector_t get_nr_sects(struct partition *p);
> =20
> -enum labeltype {
> +/*
> + * Supported partition table types (labels)
> + */
> +enum fdisk_labeltype {
> +	ANY_LABEL =3D -1,
>  	DOS_LABEL =3D 1,
> -	SUN_LABEL =3D 2,
> -	SGI_LABEL =3D 4,
> -	AIX_LABEL =3D 8,
> -	OSF_LABEL =3D 16,
> -	MAC_LABEL =3D 32,
> -	ANY_LABEL =3D -1
> +	SUN_LABEL,
> +	SGI_LABEL,
> +	AIX_LABEL,
> +	OSF_LABEL,
> +	MAC_LABEL,
>  };
> =20
> -extern enum labeltype disklabel;
> +extern enum fdisk_labeltype disklabel;
>  extern int MBRbuffer_changed;
>  extern unsigned long grain;
> =20
> diff --git a/fdisks/utils.c b/fdisks/utils.c
> index 363f7aa..cf9484c 100644
> --- a/fdisks/utils.c
> +++ b/fdisks/utils.c
> @@ -36,11 +36,11 @@ int fdisk_debug_mask;
>   */
>  static const struct fdisk_label *labels[] =3D
>  {
> -	&bsd_label,
>  	&dos_label,
> -	&sgi_label,
>  	&sun_label,
> +	&sgi_label,
>  	&aix_label,
> +	&bsd_label,
>  	&mac_label,
>  };

Is the ordering of labels important here? If so, it should be documented.


> =20
> @@ -51,14 +51,34 @@ static int __probe_labels(struct fdisk_context *cxt)
>  	disklabel =3D ANY_LABEL;
>  	update_units(cxt);
> =20
> +	cxt->label =3D calloc(1, sizeof(struct fdisk_label));
> +	if (!cxt->label) {
> +		rc =3D FDISK_ERROR_MEM;
> +		goto done;
> +	}
> +
>  	for (i =3D 0; i < ARRAY_SIZE(labels); i++) {
>  		rc =3D labels[i]->probe(cxt);
> -		if (!rc) {
> -			DBG(LABEL, dbgprint("detected a %s label\n",
> -					    labels[i]->name));
> -			goto done;
> -		}
> +		if (rc)
> +			continue;
> +	=09
> +		/* found the label */
> +		DBG(LABEL, dbgprint("detected a %s label\n", labels[i]->name));
> +		goto copy;
>  	}
> +
> +	/*
> +	 * Did not find any label - perhaps un formated;
> +	 * initialize with default partition operations.
> +	 */
> +#ifdef __sparc__
> +	i =3D OSF_LABEL - 1;
> +#else
> +	i =3D DOS_LABEL - 1;
> +#endif
> +	DBG(LABEL, dbgprint("defaulting to a %s label\n", labels[i]->name));
> +copy:
> +	memcpy(cxt->label, labels[i], sizeof(struct fdisk_label));

Uh, may be I'm missing something, but why not just make cxt->label
point to corresponding entry from *labels array?


>  done:
>  	return rc;
>  }
> @@ -380,6 +400,7 @@ void fdisk_free_context(struct fdisk_context *cxt)
>  	DBG(CONTEXT, dbgprint("freeing context for %s", cxt->dev_path));
>  	close(cxt->dev_fd);
>  	free(cxt->dev_path);
> +	free(cxt->label);
>  	free(cxt->mbr);
>  	free(cxt);
>  }
> --=20
> 1.7.4.1
>=20
>=20
>=20
>=20

Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAlAObcsACgkQnZxG0T6qDD3s5ACfa+a1h4fk9msb5m9JIsfPN1bH
JMsAnjEwh4agcp1AMm7HY+DrMwYLpR55
=YBsq
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
