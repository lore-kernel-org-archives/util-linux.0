Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:52637 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751229Ab2GXJUp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 05:20:45 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 91AC7A4478
	for <util-linux@vger.kernel.org>; Tue, 24 Jul 2012 11:20:44 +0200 (CEST)
Date: Tue, 24 Jul 2012 11:20:27 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 01/10] fdisk: API: add error handling
Message-ID: <20120724092027.GA2086@foxbat.suse.cz>
References: <1342976698.2863.11.camel@offbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
In-Reply-To: <1342976698.2863.11.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 22, 2012 at 07:04:58PM +0200, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
>=20
> Although the fdisk (and family) program is exposed to multiple scenarios =
where things can go wrong and fail,
> the API is not capable of reporting these errors in a detailed way. This =
patch adds generic error handling
> to it, by defining different errors (non-zero values), and its string rep=
resentation. Since most errors are
> fatal, the current fatal() function has been adapted to the API, but user=
s can, of course, still build their
> own ones.
>=20
> Also note that the return value of the probing functions have also been m=
odified: when the label is detected
> it returns 0, otherwise FDISK_ERROR_PROBE.
>=20
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>

Reviewed-by: Petr Uzel <petr.uzel@suse.cz>

> ---
>  fdisks/fdisk.c                |   35 +++-------------
>  fdisks/fdisk.h                |   33 +++++++++-----
>  fdisks/fdiskaixlabel.c        |    4 +-
>  fdisks/fdiskbsdlabel.c        |   20 +++++-----
>  fdisks/fdiskdoslabel.c        |    4 +-
>  fdisks/fdiskmaclabel.c        |    4 +-
>  fdisks/fdisksgilabel.c        |   12 +++---
>  fdisks/fdisksunlabel.c        |    8 ++--
>  fdisks/utils.c                |   90 ++++++++++++++++++++++++++++++++++-=
------
>  tests/expected/fdisk/oddinput |    4 +-
>  10 files changed, 131 insertions(+), 83 deletions(-)
>=20
> diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
> index 32b6de9..3b9bd7b 100644
> --- a/fdisks/fdisk.c
> +++ b/fdisks/fdisk.c
> @@ -159,27 +159,6 @@ static void __attribute__ ((__noreturn__)) usage(FIL=
E *out)
>  	exit(out =3D=3D stderr ? EXIT_FAILURE : EXIT_SUCCESS);
>  }
> =20
> -void fatal(struct fdisk_context *cxt, enum failure why)
> -{
> -	close(cxt->dev_fd);
> -	switch (why) {
> -		case unable_to_read:
> -			err(EXIT_FAILURE, _("unable to read %s"), cxt->dev_path);
> -
> -		case unable_to_seek:
> -			err(EXIT_FAILURE, _("unable to seek on %s"), cxt->dev_path);
> -
> -		case unable_to_write:
> -			err(EXIT_FAILURE, _("unable to write %s"), cxt->dev_path);
> -
> -		case ioctl_error:
> -			err(EXIT_FAILURE, _("BLKGETSIZE ioctl failed on %s"), cxt->dev_path);
> -
> -		default:
> -			err(EXIT_FAILURE, _("fatal error"));
> -	}
> -}
> -
>  struct partition *
>  get_part_table(int i) {
>  	return ptes[i].part_table;
> @@ -1758,11 +1737,10 @@ gpt_warning(char *dev)
>  /* Print disk geometry and partition table of a specified device (-l opt=
ion) */
>  static void print_partition_table_from_option(char *device, unsigned lon=
g sector_size)
>  {
> -	int gb;
> -
> -	struct fdisk_context *cxt =3D fdisk_new_context_from_filename(device, 1=
);	/* read-only */
> +	int gb, errcode;
> +	struct fdisk_context *cxt =3D fdisk_new_context_from_filename(device, 1=
, &errcode);=09
>  	if (!cxt)
> -		err(EXIT_FAILURE, _("cannot open %s"), device);
> +		errx(EXIT_FAILURE, _("%s: %s"), fdisk_error_name(errcode), device);
>  	if (sector_size)  /* passed -b option, override autodiscovery */
>  		cxt->phy_sector_size =3D cxt->sector_size =3D sector_size;
>  	/* passed CHS option(s), override autodiscovery */
> @@ -1960,7 +1938,7 @@ static sector_t get_dev_blocks(char *dev)
> =20
>  int main(int argc, char **argv)
>  {
> -	int c, optl =3D 0, opts =3D 0;
> +	int errcode, c, optl =3D 0, opts =3D 0;
>  	unsigned long sector_size =3D 0;
>  	struct fdisk_context *cxt =3D NULL;
> =20
> @@ -2062,9 +2040,10 @@ int main(int argc, char **argv)
>  	if (argc-optind !=3D 1)
>  		usage(stderr);
> =20
> -	cxt =3D fdisk_new_context_from_filename(argv[optind], 0);
> +	cxt =3D fdisk_new_context_from_filename(argv[optind], 0, &errcode);
>  	if (!cxt)
> -		err(EXIT_FAILURE, _("cannot open %s"), argv[optind]);
> +		errx(EXIT_FAILURE, _("%s: %s"), fdisk_error_name(errcode),=20
> +		    argv[optind]);
>  	if (sector_size)	/* passed -b option, override autodiscovery */
>  		cxt->phy_sector_size =3D cxt->sector_size =3D sector_size;
>  	/* passed CHS option(s), override autodiscovery */
> diff --git a/fdisks/fdisk.h b/fdisks/fdisk.h
> index 64a8147..8107aa8 100644
> --- a/fdisks/fdisk.h
> +++ b/fdisks/fdisk.h
> @@ -90,16 +90,24 @@ enum menutype {
>  	EXPERT_MENU,
>  };
> =20
> -enum failure {
> -	ioctl_error,
> -	unable_to_read,
> -	unable_to_seek,
> -	unable_to_write
> -};
> -
>  typedef unsigned long long sector_t;
> =20
>  /*
> + * fdisk error codes.
> + */
> +enum fdisk_error {
> +	FDISK_SUCCESS,
> +	FDISK_ERROR_OPEN,
> +	FDISK_ERROR_MEM,
> +	FDISK_ERROR_READ,
> +	FDISK_ERROR_SEEK,
> +	FDISK_ERROR_WRITE,
> +	FDISK_ERROR_IOCTL,
> +	FDISK_ERROR_PROBE,
> +	FDISK_ERROR_UNKNOWN
> +};
> +
> +/*
>   * Legacy CHS based geometry
>   */
>  struct fdisk_geometry {
> @@ -144,19 +152,20 @@ extern const struct fdisk_label mac_label;
>  extern const struct fdisk_label sun_label;
>  extern const struct fdisk_label sgi_label;
> =20
> -extern struct fdisk_context *fdisk_new_context_from_filename(const char =
*fname, int readonly);
> +extern struct fdisk_context *fdisk_new_context_from_filename(const char =
*fname, int readonly, int *errcode);
>  extern int fdisk_dev_has_topology(struct fdisk_context *cxt);
>  extern int fdisk_dev_sectsz_is_default(struct fdisk_context *cxt);
>  extern void fdisk_free_context(struct fdisk_context *cxt);
>  extern void fdisk_mbr_zeroize(struct fdisk_context *cxt);
>  extern void fdisk_geom_set_cyls(struct fdisk_context *cxt);
> +extern const char *fdisk_error_name(enum fdisk_error errcode);
> +extern void fdisk_error_fatal(struct fdisk_context *cxt, enum fdisk_erro=
r errcode);
> =20
>  /* prototypes for fdisk.c */
>  extern char *disk_device, *line_ptr;
>  extern int fd, partitions;
>  extern unsigned int display_in_cyl_units, units_per_sector;
>  extern void change_units(struct fdisk_context *cxt);
> -extern void fatal(struct fdisk_context *cxt, enum failure why);
>  extern int  get_partition(struct fdisk_context *cxt, int warn, int max);
>  extern void list_types(struct systypes *sys);
>  extern int read_line (int *asked);
> @@ -242,21 +251,21 @@ static inline void seek_sector(struct fdisk_context=
 *cxt, sector_t secno)
>  {
>  	off_t offset =3D (off_t) secno * cxt->sector_size;
>  	if (lseek(cxt->dev_fd, offset, SEEK_SET) =3D=3D (off_t) -1)
> -		fatal(cxt, unable_to_seek);
> +		fdisk_error_fatal(cxt, FDISK_ERROR_SEEK);
>  }
> =20
>  static inline void read_sector(struct fdisk_context *cxt, sector_t secno=
, unsigned char *buf)
>  {
>  	seek_sector(cxt, secno);
>  	if (read(cxt->dev_fd, buf, cxt->sector_size) !=3D (ssize_t) cxt->sector=
_size)
> -		fatal(cxt, unable_to_read);
> +		fdisk_error_fatal(cxt, FDISK_ERROR_READ);
>  }
> =20
>  static inline void write_sector(struct fdisk_context *cxt, sector_t secn=
o, unsigned char *buf)
>  {
>  	seek_sector(cxt, secno);
>  	if (write(cxt->dev_fd, buf, cxt->sector_size) !=3D (ssize_t) cxt->secto=
r_size)
> -		fatal(cxt, unable_to_write);
> +		fdisk_error_fatal(cxt, FDISK_ERROR_WRITE);
>  }
> =20
>  static inline sector_t get_start_sect(struct partition *p)
> diff --git a/fdisks/fdiskaixlabel.c b/fdisks/fdiskaixlabel.c
> index ebf9365..f590e3a 100644
> --- a/fdisks/fdiskaixlabel.c
> +++ b/fdisks/fdiskaixlabel.c
> @@ -54,7 +54,7 @@ static int aix_probe_label(struct fdisk_context *cxt)
>      if (aixlabel->magic !=3D AIX_LABEL_MAGIC &&
>  	aixlabel->magic !=3D AIX_LABEL_MAGIC_SWAPPED) {
>  	other_endian =3D 0;
> -	return 0;
> +	return FDISK_ERROR_PROBE;
>      }
>      other_endian =3D (aixlabel->magic =3D=3D AIX_LABEL_MAGIC_SWAPPED);
>      disklabel =3D AIX_LABEL;
> @@ -62,7 +62,7 @@ static int aix_probe_label(struct fdisk_context *cxt)
>      volumes =3D 15;
>      aix_info();
>      aix_nolabel(cxt);		/* %% */
> -    return 1;
> +    return 0;
>  }
> =20
>  const struct fdisk_label aix_label =3D
> diff --git a/fdisks/fdiskbsdlabel.c b/fdisks/fdiskbsdlabel.c
> index 548a86d..fe91fe8 100644
> --- a/fdisks/fdiskbsdlabel.c
> +++ b/fdisks/fdiskbsdlabel.c
> @@ -112,8 +112,8 @@ static struct xbsd_disklabel xbsd_dlabel;
>  static int
>  osf_probe_label(struct fdisk_context *cxt) {
>  	if (xbsd_readlabel (cxt, NULL, &xbsd_dlabel) =3D=3D 0)
> -		return 0;
> -	return 1;
> +		return FDISK_ERROR_PROBE;
> +	return 0;
>  }
> =20
>  int
> @@ -548,9 +548,9 @@ xbsd_write_bootstrap (struct fdisk_context *cxt)
>  #endif
> =20
>    if (lseek (cxt->dev_fd, (off_t) sector * SECTOR_SIZE, SEEK_SET) =3D=3D=
 -1)
> -	  fatal (cxt, unable_to_seek);
> +	  fdisk_error_fatal (cxt, FDISK_ERROR_SEEK);
>    if (BSD_BBSIZE !=3D write (cxt->dev_fd, disklabelbuffer, BSD_BBSIZE))
> -	  fatal (cxt, unable_to_write);
> +	  fdisk_error_fatal (cxt, FDISK_ERROR_WRITE);
> =20
>  #if defined (__alpha__)
>    printf (_("Bootstrap installed on %s.\n"), cxt->dev_path);
> @@ -716,9 +716,9 @@ xbsd_readlabel (struct fdisk_context *cxt, struct par=
tition *p, struct xbsd_disk
>  #endif
> =20
>  	if (lseek (cxt->dev_fd, (off_t) sector * SECTOR_SIZE, SEEK_SET) =3D=3D =
-1)
> -		fatal (cxt, unable_to_seek);
> +		fdisk_error_fatal (cxt, FDISK_ERROR_SEEK);
>  	if (BSD_BBSIZE !=3D read (cxt->dev_fd, disklabelbuffer, BSD_BBSIZE))
> -		fatal (cxt, unable_to_read);
> +		fdisk_error_fatal (cxt, FDISK_ERROR_READ);
> =20
>  	memmove (d,
>  	         &disklabelbuffer[BSD_LABELSECTOR * SECTOR_SIZE + BSD_LABELOFFS=
ET],
> @@ -763,15 +763,15 @@ xbsd_writelabel (struct fdisk_context *cxt, struct =
partition *p, struct xbsd_dis
>  #if defined (__alpha__) && BSD_LABELSECTOR =3D=3D 0
>    alpha_bootblock_checksum (disklabelbuffer);
>    if (lseek (cxt->dev_fd, (off_t) 0, SEEK_SET) =3D=3D -1)
> -	  fatal (cxt, unable_to_seek);
> +	  fdisk_error_fatal (cxt, FDISK_ERROR_SEEK);
>    if (BSD_BBSIZE !=3D write (cxt->dev_fd, disklabelbuffer, BSD_BBSIZE))
> -	  fatal (cxt, unable_to_write);
> +	  fdisk_error_fatal (cxt, FDISK_ERROR_WRITE);
>  #else
>    if (lseek (cxt->dev_fd, (off_t) sector * SECTOR_SIZE + BSD_LABELOFFSET,
>  		   SEEK_SET) =3D=3D -1)
> -	  fatal (cxt, unable_to_seek);
> +	  fdisk_error_fatal (cxt, FDISK_ERROR_SEEK);
>    if (sizeof (struct xbsd_disklabel) !=3D write (cxt->dev_fd, d, sizeof =
(struct xbsd_disklabel)))
> -	  fatal (cxt, unable_to_write);
> +	  fdisk_error_fatal (cxt, FDISK_ERROR_WRITE);
>  #endif
> =20
>    sync_disks ();
> diff --git a/fdisks/fdiskdoslabel.c b/fdisks/fdiskdoslabel.c
> index a115e66..535afdc 100644
> --- a/fdisks/fdiskdoslabel.c
> +++ b/fdisks/fdiskdoslabel.c
> @@ -321,7 +321,7 @@ static int dos_probe_label(struct fdisk_context *cxt)
>  	int i;
> =20
>  	if (!valid_part_table_flag(cxt->mbr))
> -		return 0;
> +		return FDISK_ERROR_PROBE;
> =20
>  	dos_init(cxt);
> =20
> @@ -349,7 +349,7 @@ static int dos_probe_label(struct fdisk_context *cxt)
>  		}
>  	}
> =20
> -	return 1;
> +	return 0;
>  }
> =20
>  /*
> diff --git a/fdisks/fdiskmaclabel.c b/fdisks/fdiskmaclabel.c
> index 555245d..98cff26 100644
> --- a/fdisks/fdiskmaclabel.c
> +++ b/fdisks/fdiskmaclabel.c
> @@ -65,7 +65,7 @@ mac_probe_label(struct fdisk_context *cxt)
>  			break;
>  		default:
>  			other_endian =3D 0;
> -			return 0;
> +			return FDISK_ERROR_PROBE;
> =20
>=20
>  	}
> @@ -77,7 +77,7 @@ IS_MAC:
>      volumes =3D 15;	// =3D?
>      mac_info();
>      mac_nolabel(cxt);		/* %% */
> -    return 1;
> +    return 0;
>  }
> =20
>  const struct fdisk_label mac_label =3D
> diff --git a/fdisks/fdisksgilabel.c b/fdisks/fdisksgilabel.c
> index 071a84e..e38d98f 100644
> --- a/fdisks/fdisksgilabel.c
> +++ b/fdisks/fdisksgilabel.c
> @@ -139,7 +139,7 @@ sgi_probe_label(struct fdisk_context *cxt) {
>  	if (sgilabel->magic !=3D SGI_LABEL_MAGIC &&
>  	    sgilabel->magic !=3D SGI_LABEL_MAGIC_SWAPPED) {
>  		other_endian =3D 0;
> -		return 0;
> +		return FDISK_ERROR_PROBE;
>  	}
> =20
>  	other_endian =3D (sgilabel->magic =3D=3D SGI_LABEL_MAGIC_SWAPPED);
> @@ -154,7 +154,7 @@ sgi_probe_label(struct fdisk_context *cxt) {
>  	disklabel =3D SGI_LABEL;
>  	partitions=3D 16;
>  	volumes =3D 15;
> -	return 1;
> +	return 0;
>  }
> =20
>  void
> @@ -338,9 +338,9 @@ sgi_write_table(struct fdisk_context *cxt) {
>  	assert(two_s_complement_32bit_sum(
>  		(unsigned int*)sgilabel, sizeof(*sgilabel)) =3D=3D 0);
>  	if (lseek(cxt->dev_fd, 0, SEEK_SET) < 0)
> -		fatal(cxt, unable_to_seek);
> +		fdisk_error_fatal(cxt, FDISK_ERROR_SEEK);
>  	if (write(cxt->dev_fd, sgilabel, SECTOR_SIZE) !=3D SECTOR_SIZE)
> -		fatal(cxt, unable_to_write);
> +		fdisk_error_fatal(cxt, FDISK_ERROR_WRITE);
>  	if (! strncmp((char *) sgilabel->directory[0].vol_file_name, "sgilabel"=
, 8)) {
>  		/*
>  		 * keep this habit of first writing the "sgilabel".
> @@ -350,9 +350,9 @@ sgi_write_table(struct fdisk_context *cxt) {
>  		int infostartblock =3D SSWAP32(sgilabel->directory[0].vol_file_start);
>  		if (lseek(cxt->dev_fd, (off_t) infostartblock*
>  				SECTOR_SIZE, SEEK_SET) < 0)
> -			fatal(cxt, unable_to_seek);
> +			fdisk_error_fatal(cxt, FDISK_ERROR_SEEK);
>  		if (write(cxt->dev_fd, info, SECTOR_SIZE) !=3D SECTOR_SIZE)
> -			fatal(cxt, unable_to_write);
> +			fdisk_error_fatal(cxt, FDISK_ERROR_WRITE);
>  		free(info);
>  	}
>  }
> diff --git a/fdisks/fdisksunlabel.c b/fdisks/fdisksunlabel.c
> index 909f159..4123806 100644
> --- a/fdisks/fdisksunlabel.c
> +++ b/fdisks/fdisksunlabel.c
> @@ -86,7 +86,7 @@ static int sun_probe_label(struct fdisk_context *cxt)
>  	if (sunlabel->magic !=3D SUN_LABEL_MAGIC &&
>  	    sunlabel->magic !=3D SUN_LABEL_MAGIC_SWAPPED) {
>  		other_endian =3D 0;
> -		return 0;
> +		return FDISK_ERROR_PROBE;
>  	}
> =20
>  	init();
> @@ -141,7 +141,7 @@ static int sun_probe_label(struct fdisk_context *cxt)
>  		}
>  	}
>  	update_units(cxt);
> -	return 1;
> +	return 0;
>  }
> =20
>  void create_sunlabel(struct fdisk_context *cxt)
> @@ -633,9 +633,9 @@ void sun_write_table(struct fdisk_context *cxt)
>  		csum ^=3D *ush++;
>  	sunlabel->cksum =3D csum;
>  	if (lseek(cxt->dev_fd, 0, SEEK_SET) < 0)
> -		fatal(cxt, unable_to_seek);
> +		fdisk_error_fatal(cxt, FDISK_ERROR_SEEK);
>  	if (write(cxt->dev_fd, sunlabel, SECTOR_SIZE) !=3D SECTOR_SIZE)
> -		fatal(cxt, unable_to_write);
> +		fdisk_error_fatal(cxt, FDISK_ERROR_WRITE);
>  }
> =20
>  int sun_get_sysid(struct fdisk_context *cxt, int i)
> diff --git a/fdisks/utils.c b/fdisks/utils.c
> index 94a080f..363f7aa 100644
> --- a/fdisks/utils.c
> +++ b/fdisks/utils.c
> @@ -53,32 +53,37 @@ static int __probe_labels(struct fdisk_context *cxt)
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(labels); i++) {
>  		rc =3D labels[i]->probe(cxt);
> -		if (rc) {
> +		if (!rc) {
>  			DBG(LABEL, dbgprint("detected a %s label\n",
>  					    labels[i]->name));
>  			goto done;
>  		}
>  	}
> -
>  done:
>  	return rc;
>  }
> =20
>  static int __init_mbr_buffer(struct fdisk_context *cxt)
>  {
> +	int errcode =3D 0;
> +
>  	DBG(TOPOLOGY, dbgprint("initialize MBR buffer"));
> =20
>  	cxt->mbr =3D calloc(1, MAX_SECTOR_SIZE);
> -	if (!cxt->mbr)
> -		goto fail;
> +	if (!cxt->mbr) {
> +		errcode =3D FDISK_ERROR_MEM;
> +		goto done;
> +	}
> =20
>  	/* read MBR */
>  	if (512 !=3D read(cxt->dev_fd, cxt->mbr, 512))
> -		goto fail;
> -
> -	return 0;
> -fail:
> -	return -1;
> +		/*
> +		 * this error is either a legitimate read failure,
> +		 * or the device is too small for reading 512 bytes.
> +		 */
> +		errcode =3D FDISK_ERROR_READ;
> +done:
> +	return errcode;
>  }
> =20
>  static unsigned long __get_sector_size(int fd)
> @@ -254,17 +259,65 @@ void fdisk_init_debug(int mask)
>  }
> =20
>  /**
> + * fdisk_error_name:
> + * @errcode: fdisk specific error code
> + *
> + * Returns: Corresponding error message.
> + */
> +const char *fdisk_error_name(enum fdisk_error errcode)
> +{
> +	switch (errcode) {
> +	case FDISK_ERROR_OPEN:
> +		return "error: cannot open";
> +	case FDISK_ERROR_MEM:
> +		return "error: no memory";
> +	case FDISK_ERROR_READ:
> +		return "error: cannot read";
> +	case FDISK_ERROR_SEEK:
> +		return "error: cannot seek";
> +	case FDISK_ERROR_WRITE:
> +		return "error: cannot write";
> +	case FDISK_ERROR_IOCTL:
> +		return "error: ioctl";
> +	case FDISK_ERROR_PROBE:
> +		return "error: cannot probe";
> +	default:
> +		return "error: unknown";
> +	}
> +}
> +
> +/**
> + * fdisk_error_fatal:
> + * @cxt: fdisk context
> + * @errcode: fdisk specific error code
> + *
> + * Deinitializes the fdisk context and exits, printing an appropiate
> + * error message to standard error. Use only for unrecoverable failures.
> + */
> +void __attribute__((__noreturn__))
> +fdisk_error_fatal(struct fdisk_context *cxt, enum fdisk_error errcode)
> +{
> +	fprintf(stderr, _("%s: %s\n"), fdisk_error_name(errcode),
> +		                       cxt->dev_path);
> +	fdisk_free_context(cxt);
> +	exit(EXIT_FAILURE);
> +}
> +
> +/**
>   * fdisk_new_context:
>   * @filename: path to the device to be handled
>   * @readonly: how to open the device
> + * @errcode: specific fdisk error code (returned value)
>   *
>   * If the @readonly flag is set to false, fdisk will attempt to open
>   * the device with read-write mode and will fallback to read-only if
>   * unsuccessful.
>   *
> - * Returns: newly allocated fdisk context
> + * Returns: newly allocated fdisk context. If failure, returns NULL
> + *          and @errcode is set.
>   */
> -struct fdisk_context *fdisk_new_context_from_filename(const char *fname,=
 int readonly)
> +struct fdisk_context *fdisk_new_context_from_filename(const char *fname,=
 int readonly,
> +						      int *errcode)
>  {
>  	int fd, errsv =3D 0;
>  	struct fdisk_context *cxt =3D NULL;
> @@ -272,21 +325,28 @@ struct fdisk_context *fdisk_new_context_from_filena=
me(const char *fname, int rea
>  	DBG(CONTEXT, dbgprint("initializing context for %s", fname));
> =20
>  	if (readonly =3D=3D 1 || (fd =3D open(fname, O_RDWR)) < 0) {
> -		if ((fd =3D open(fname, O_RDONLY)) < 0)
> +		if ((fd =3D open(fname, O_RDONLY)) < 0) {
> +			*errcode =3D FDISK_ERROR_OPEN;
>  			return NULL;
> +		}
>  		readonly =3D 1;
>  	}
> =20
>  	cxt =3D calloc(1, sizeof(*cxt));
> -	if (!cxt)
> +	if (!cxt) {
> +		*errcode =3D FDISK_ERROR_MEM;
>  		goto fail;
> +	}
> =20
>  	cxt->dev_fd =3D fd;
>  	cxt->dev_path =3D strdup(fname);
> -	if (!cxt->dev_path)
> +	if (!cxt->dev_path) {
> +		*errcode =3D FDISK_ERROR_MEM;
>  		goto fail;
> +	}
> =20
> -	if (__init_mbr_buffer(cxt) < 0)
> +	*errcode =3D __init_mbr_buffer(cxt);
> +	if(*errcode)
>  		goto fail;
> =20
>  	__discover_topology(cxt);
> diff --git a/tests/expected/fdisk/oddinput b/tests/expected/fdisk/oddinput
> index d90866b..2c89e31 100644
> --- a/tests/expected/fdisk/oddinput
> +++ b/tests/expected/fdisk/oddinput
> @@ -9,6 +9,6 @@ Sector size (logical/physical): 512 bytes / 512 bytes
>  I/O size (minimum/optimal): 512 bytes / 512 bytes
> =20
>  Nonexistant file
> -lt-fdisk: unable to open _a_file_that_does_not_exist_: No such file or d=
irectory
> +lt-fdisk: error: cannot open: _a_file_that_does_not_exist_
>  Too small file
> -lt-fdisk: unable to open oddinput.toosmall: Success
> +lt-fdisk: error: cannot read: oddinput.toosmall
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

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEUEARECAAYFAlAOaNsACgkQnZxG0T6qDD1i5wCeM6jJyDri1M2tcVgv6U/puYcU
GFsAmL0Ucfb4bp4hiY6tXEUGpO6b5II=
=eiwP
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
