Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:58937 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752954Ab2GXKyo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 06:54:44 -0400
Date: Tue, 24 Jul 2012 12:54:24 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 05/10] fdisk: API: add write to label operations
Message-ID: <20120724105424.GH2086@foxbat.suse.cz>
References: <1342976710.2863.15.camel@offbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qVHblb/y9DPlgkHs"
In-Reply-To: <1342976710.2863.15.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--qVHblb/y9DPlgkHs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 22, 2012 at 07:05:10PM +0200, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
>=20
> Note that sun labels are no longer checked to see if there were changes.
>=20
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>

Reviewed-by: Petr Uzel <petr.uzel@suse.cz>

> ---
>  fdisks/fdisk.c         |   23 +++++------------------
>  fdisks/fdisk.h         |   10 +++-------
>  fdisks/fdiskaixlabel.c |    1 +
>  fdisks/fdiskbsdlabel.c |   30 ++++++++++++++++--------------
>  fdisks/fdiskdoslabel.c |   24 ++++++++++++++++++++----
>  fdisks/fdiskdoslabel.h |    1 -
>  fdisks/fdiskmaclabel.c |    1 +
>  fdisks/fdisksgilabel.c |   15 +++++++++------
>  fdisks/fdisksgilabel.h |    1 -
>  fdisks/fdisksunlabel.c |    9 ++++++---
>  fdisks/fdisksunlabel.h |    1 -
>  fdisks/utils.c         |   13 +++++++++++++
>  12 files changed, 74 insertions(+), 55 deletions(-)
>=20
> diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
> index 27002f6..7212840 100644
> --- a/fdisks/fdisk.c
> +++ b/fdisks/fdisk.c
> @@ -1458,24 +1458,11 @@ static void new_partition(struct fdisk_context *c=
xt)
>  	dos_new_partition(cxt);
>  }
> =20
> -static void
> -write_table(struct fdisk_context *cxt) {
> -	int i;
> -
> -	if (disklabel =3D=3D DOS_LABEL)
> -		dos_write_table(cxt);
> -	else if (disklabel =3D=3D SGI_LABEL)
> -		/* no test on change? the printf below might be mistaken */
> -		sgi_write_table(cxt);
> -	else if (disklabel =3D=3D SUN_LABEL) {
> -		int needw =3D 0;
> -
> -		for (i=3D0; i<8; i++)
> -			if (ptes[i].changed)
> -				needw =3D 1;
> -		if (needw)
> -			sun_write_table(cxt);
> -	}
> +static void write_table(struct fdisk_context *cxt)
> +{
> +	int errcode =3D fdisk_label_write_table(cxt);
> +	if (errcode)
> +		fdisk_error_fatal(cxt, errcode);
> =20
>  	printf(_("The partition table has been altered!\n\n"));
>  	reread_partition_table(cxt, 1);
> diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
> index 816e127..577303b 100644
> --- a/fdisks/fdisk.h
> +++ b/fdisks/fdisk.h
> @@ -145,6 +145,8 @@ struct fdisk_label {
> =20
>  	/* probe disk label */
>  	int (*probe)(struct fdisk_context *cxt);
> +	/* write in-memory changes to disk */
> +	int (*write)(struct fdisk_context *cxt);
>  	/* delete partition */
>  	void (*part_delete)(struct fdisk_context *cxt, int partnum);
>  };
> @@ -169,6 +171,7 @@ extern const char *fdisk_error_name(enum fdisk_error =
errcode);
>  extern void fdisk_error_fatal(struct fdisk_context *cxt, enum fdisk_erro=
r errcode);
>  extern int fdisk_label_change(struct fdisk_context *cxt, const char *nam=
e);
>  extern int fdisk_label_partition_delete(struct fdisk_context *cxt, int p=
artnum);
> +extern int fdisk_label_write_table(struct fdisk_context *cxt);
> =20
>  /* prototypes for fdisk.c */
>  extern char *disk_device, *line_ptr;
> @@ -273,13 +276,6 @@ static inline void read_sector(struct fdisk_context =
*cxt, sector_t secno, unsign
>  		fdisk_error_fatal(cxt, FDISK_ERROR_READ);
>  }
> =20
> -static inline void write_sector(struct fdisk_context *cxt, sector_t secn=
o, unsigned char *buf)
> -{
> -	seek_sector(cxt, secno);
> -	if (write(cxt->dev_fd, buf, cxt->sector_size) !=3D (ssize_t) cxt->secto=
r_size)
> -		fdisk_error_fatal(cxt, FDISK_ERROR_WRITE);
> -}
> -
>  static inline sector_t get_start_sect(struct partition *p)
>  {
>  	return read4_little_endian(p->start4);
> diff --git a/fdisks/fdiskaixlabel.c b/fdisks/fdiskaixlabel.c
> index 45f3aa9..d264027 100644
> --- a/fdisks/fdiskaixlabel.c
> +++ b/fdisks/fdiskaixlabel.c
> @@ -69,5 +69,6 @@ const struct fdisk_label aix_label =3D
>  {
>  	.name =3D "aix",
>  	.probe =3D aix_probe_label,
> +	.write =3D NULL,
>  	.part_delete =3D NULL,
>  };
> diff --git a/fdisks/fdiskbsdlabel.c b/fdisks/fdiskbsdlabel.c
> index c7f3f86..b827a5b 100644
> --- a/fdisks/fdiskbsdlabel.c
> +++ b/fdisks/fdiskbsdlabel.c
> @@ -63,7 +63,6 @@
> =20
>  static void xbsd_delete_part (struct fdisk_context *cxt, int partnum);
>  static void xbsd_new_part (struct fdisk_context *cxt);
> -static void xbsd_write_disklabel (struct fdisk_context *cxt);
>  static int xbsd_create_disklabel (struct fdisk_context *cxt);
>  static void xbsd_edit_disklabel (void);
>  static void xbsd_write_bootstrap (struct fdisk_context *cxt);
> @@ -140,6 +139,21 @@ is_bsd_partition_type(int type) {
>  }
>  #endif
> =20
> +static int xbsd_write_disklabel (struct fdisk_context *cxt)
> +{
> +#if defined (__alpha__)
> +	printf (_("Writing disklabel to %s.\n"), cxt->dev_path);
> +	xbsd_writelabel (cxt, NULL, &xbsd_dlabel);
> +#else
> +	printf (_("Writing disklabel to %s.\n"),
> +		partname(cxt->dev_path, xbsd_part_index+1, 0));
> +	xbsd_writelabel (cxt, xbsd_part, &xbsd_dlabel);
> +#endif
> +	reread_partition_table(cxt, 0);	/* no exit yet */
> +
> +	return 0;
> +}
> +
>  void
>  bsd_command_prompt (struct fdisk_context *cxt)
>  {
> @@ -376,19 +390,6 @@ xbsd_print_disklabel (struct fdisk_context *cxt, int=
 show_all) {
>    }
>  }
> =20
> -static void
> -xbsd_write_disklabel (struct fdisk_context *cxt) {
> -#if defined (__alpha__)
> -	printf (_("Writing disklabel to %s.\n"), cxt->dev_path);
> -	xbsd_writelabel (cxt, NULL, &xbsd_dlabel);
> -#else
> -	printf (_("Writing disklabel to %s.\n"),
> -		partname(cxt->dev_path, xbsd_part_index+1, 0));
> -	xbsd_writelabel (cxt, xbsd_part, &xbsd_dlabel);
> -#endif
> -	reread_partition_table(cxt, 0);	/* no exit yet */
> -}
> -
>  static int
>  xbsd_create_disklabel (struct fdisk_context *cxt) {
>  	char c;
> @@ -846,5 +847,6 @@ const struct fdisk_label bsd_label =3D
>  {
>  	.name =3D "bsd",
>  	.probe =3D osf_probe_label,
> +	.write =3D xbsd_write_disklabel,
>  	.part_delete =3D xbsd_delete_part,
>  };
> diff --git a/fdisks/fdiskdoslabel.c b/fdisks/fdiskdoslabel.c
> index e32088e..65609c5 100644
> --- a/fdisks/fdiskdoslabel.c
> +++ b/fdisks/fdiskdoslabel.c
> @@ -657,9 +657,18 @@ void dos_new_partition(struct fdisk_context *cxt)
>  	}
>  }
> =20
> -void dos_write_table(struct fdisk_context *cxt)
> +static int write_sector(struct fdisk_context *cxt, sector_t secno,
> +			       unsigned char *buf)
>  {
> -	int i;
> +	seek_sector(cxt, secno);
> +	if (write(cxt->dev_fd, buf, cxt->sector_size) !=3D (ssize_t) cxt->secto=
r_size)
> +		return FDISK_ERROR_WRITE;
> +	return 0;
> +}
> +
> +static int dos_write_table(struct fdisk_context *cxt)
> +{
> +	int i, rc =3D 0;
> =20
>  	/* MBR (primary partitions) */
>  	if (!MBRbuffer_changed) {
> @@ -669,7 +678,9 @@ void dos_write_table(struct fdisk_context *cxt)
>  	}
>  	if (MBRbuffer_changed) {
>  		write_part_table_flag(cxt->mbr);
> -		write_sector(cxt, 0, cxt->mbr);
> +		rc =3D write_sector(cxt, 0, cxt->mbr);
> +		if (rc)
> +			goto done;
>  	}
>  	/* EBR (logical partitions) */
>  	for (i =3D 4; i < partitions; i++) {
> @@ -677,14 +688,19 @@ void dos_write_table(struct fdisk_context *cxt)
> =20
>  		if (pe->changed) {
>  			write_part_table_flag(pe->sectorbuffer);
> -			write_sector(cxt, pe->offset, pe->sectorbuffer);
> +			rc =3D write_sector(cxt, pe->offset, pe->sectorbuffer);
> +			if (rc)
> +				goto done;
>  		}
>  	}
> +done:
> +	return rc;
>  }
> =20
>  const struct fdisk_label dos_label =3D
>  {
>  	.name =3D "dos",
>  	.probe =3D dos_probe_label,
> +	.write =3D dos_write_table,
>  	.part_delete =3D dos_delete_partition,
>  };
> diff --git a/fdisks/fdiskdoslabel.h b/fdisks/fdiskdoslabel.h
> index 4aa16e5..8a2c6dd 100644
> --- a/fdisks/fdiskdoslabel.h
> +++ b/fdisks/fdiskdoslabel.h
> @@ -50,6 +50,5 @@ extern int is_dos_partition(int t);
>  extern void dos_init(struct fdisk_context *cxt);
>  extern void dos_add_partition(struct fdisk_context *cxt, int n, int sys);
>  extern void dos_new_partition(struct fdisk_context *cxt);
> -extern void dos_write_table(struct fdisk_context *cxt);
> =20
>  #endif
> diff --git a/fdisks/fdiskmaclabel.c b/fdisks/fdiskmaclabel.c
> index 198a2d0..19c99f6 100644
> --- a/fdisks/fdiskmaclabel.c
> +++ b/fdisks/fdiskmaclabel.c
> @@ -84,5 +84,6 @@ const struct fdisk_label mac_label =3D
>  {
>  	.name =3D "mac",
>  	.probe =3D mac_probe_label,
> +	.write =3D NULL,
>  	.part_delete =3D NULL,
>  };
> diff --git a/fdisks/fdisksgilabel.c b/fdisks/fdisksgilabel.c
> index 51b0e1f..39ba58d 100644
> --- a/fdisks/fdisksgilabel.c
> +++ b/fdisks/fdisksgilabel.c
> @@ -329,8 +329,8 @@ create_sgiinfo(struct fdisk_context *cxt) {
> =20
>  sgiinfo *fill_sgiinfo(void);
> =20
> -void
> -sgi_write_table(struct fdisk_context *cxt) {
> +static int sgi_write_table(struct fdisk_context *cxt)
> +{
>  	sgilabel->csum =3D 0;
>  	sgilabel->csum =3D SSWAP32(two_s_complement_32bit_sum(
>  		(unsigned int*)sgilabel,
> @@ -338,9 +338,9 @@ sgi_write_table(struct fdisk_context *cxt) {
>  	assert(two_s_complement_32bit_sum(
>  		(unsigned int*)sgilabel, sizeof(*sgilabel)) =3D=3D 0);
>  	if (lseek(cxt->dev_fd, 0, SEEK_SET) < 0)
> -		fdisk_error_fatal(cxt, FDISK_ERROR_SEEK);
> +		return FDISK_ERROR_SEEK;
>  	if (write(cxt->dev_fd, sgilabel, SECTOR_SIZE) !=3D SECTOR_SIZE)
> -		fdisk_error_fatal(cxt, FDISK_ERROR_WRITE);
> +		return FDISK_ERROR_WRITE;
>  	if (! strncmp((char *) sgilabel->directory[0].vol_file_name, "sgilabel"=
, 8)) {
>  		/*
>  		 * keep this habit of first writing the "sgilabel".
> @@ -350,11 +350,13 @@ sgi_write_table(struct fdisk_context *cxt) {
>  		int infostartblock =3D SSWAP32(sgilabel->directory[0].vol_file_start);
>  		if (lseek(cxt->dev_fd, (off_t) infostartblock*
>  				SECTOR_SIZE, SEEK_SET) < 0)
> -			fdisk_error_fatal(cxt, FDISK_ERROR_SEEK);
> +			return FDISK_ERROR_SEEK;
>  		if (write(cxt->dev_fd, info, SECTOR_SIZE) !=3D SECTOR_SIZE)
> -			fdisk_error_fatal(cxt, FDISK_ERROR_WRITE);
> +			return FDISK_ERROR_WRITE;
>  		free(info);
>  	}
> +
> +	return 0;
>  }
> =20
>  static int
> @@ -882,5 +884,6 @@ const struct fdisk_label sgi_label =3D
>  {
>  	.name =3D "sgi",
>  	.probe =3D sgi_probe_label,
> +	.write =3D sgi_write_table,
>  	.part_delete =3D sgi_delete_partition,
>  };
> diff --git a/fdisks/fdisksgilabel.h b/fdisks/fdisksgilabel.h
> index 98cf093..14f488f 100644
> --- a/fdisks/fdisksgilabel.h
> +++ b/fdisks/fdisksgilabel.h
> @@ -120,7 +120,6 @@ extern void	sgi_add_partition( struct fdisk_context *=
cxt, int n, int sys );
>  extern void	create_sgilabel( struct fdisk_context *cxt );
>  extern void	create_sgiinfo(struct fdisk_context *cxt);
>  extern int	verify_sgi(struct fdisk_context *cxt, int verbose );
> -extern void	sgi_write_table( struct fdisk_context *cxt );
>  extern void	sgi_set_ilfact( void );
>  extern void	sgi_set_rspeed( void );
>  extern void	sgi_set_pcylcount( void );
> diff --git a/fdisks/fdisksunlabel.c b/fdisks/fdisksunlabel.c
> index c74ffbb..2cae2dd 100644
> --- a/fdisks/fdisksunlabel.c
> +++ b/fdisks/fdisksunlabel.c
> @@ -625,7 +625,7 @@ void sun_set_pcylcount(struct fdisk_context *cxt)
>  				 _("Number of physical cylinders")));
>  }
> =20
> -void sun_write_table(struct fdisk_context *cxt)
> +static int sun_write_table(struct fdisk_context *cxt)
>  {
>  	unsigned short *ush =3D (unsigned short *)sunlabel;
>  	unsigned short csum =3D 0;
> @@ -634,9 +634,11 @@ void sun_write_table(struct fdisk_context *cxt)
>  		csum ^=3D *ush++;
>  	sunlabel->cksum =3D csum;
>  	if (lseek(cxt->dev_fd, 0, SEEK_SET) < 0)
> -		fdisk_error_fatal(cxt, FDISK_ERROR_SEEK);
> +		return FDISK_ERROR_SEEK;
>  	if (write(cxt->dev_fd, sunlabel, SECTOR_SIZE) !=3D SECTOR_SIZE)
> -		fdisk_error_fatal(cxt, FDISK_ERROR_WRITE);
> +		return FDISK_ERROR_WRITE;
> +
> +	return 0;
>  }
> =20
>  int sun_get_sysid(struct fdisk_context *cxt, int i)
> @@ -648,5 +650,6 @@ const struct fdisk_label sun_label =3D
>  {
>  	.name =3D "sun",
>  	.probe =3D sun_probe_label,
> +	.write =3D sun_write_table,
>  	.part_delete =3D sun_delete_partition,
>  };
> diff --git a/fdisks/fdisksunlabel.h b/fdisks/fdisksunlabel.h
> index 47aa30a..0ede6e3 100644
> --- a/fdisks/fdisksunlabel.h
> +++ b/fdisks/fdisksunlabel.h
> @@ -82,7 +82,6 @@ extern int sun_change_sysid(struct fdisk_context *cxt, =
int i, uint16_t sys);
>  extern void sun_list_table(struct fdisk_context *cxt, int xtra);
>  extern void verify_sun(struct fdisk_context *cxt);
>  extern void add_sun_partition(struct fdisk_context *cxt, int n, int sys);
> -extern void sun_write_table(struct fdisk_context *cxt);
>  extern void sun_set_alt_cyl(struct fdisk_context *cxt);
>  extern void sun_set_ncyl(struct fdisk_context *cxt, int cyl);
>  extern void sun_set_xcyl(struct fdisk_context *cxt);
> diff --git a/fdisks/utils.c b/fdisks/utils.c
> index c8b8f7e..9b5092d 100644
> --- a/fdisks/utils.c
> +++ b/fdisks/utils.c
> @@ -82,6 +82,19 @@ done:
>  }
> =20
>  /**
> + * fdisk_label_write_table:
> + * @cxt: fdisk context
> + *
> + * Write in-memory changes to disk
> + *
> + * Returns 0 on success, otherwise, a corresponding error.
> + */
> +int fdisk_label_write_table(struct fdisk_context *cxt)
> +{
> +	return cxt->label->write(cxt);
> +}=09
> +
> +/**
>   * fdisk_label_partition_delete:
>   * @cxt: fdisk context
>   * @partnum: partition number to delete
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

--qVHblb/y9DPlgkHs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAlAOfuAACgkQnZxG0T6qDD2hPACeJwwMHhvRq3kEyLx7y4r5s4zJ
NR0An0D14U8Gjhkqf6+hFPNmfBzMc51j
=uiLS
-----END PGP SIGNATURE-----

--qVHblb/y9DPlgkHs--
