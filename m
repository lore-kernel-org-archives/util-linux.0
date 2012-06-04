Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:54197 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596Ab2FDJGd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Jun 2012 05:06:33 -0400
Date: Mon, 4 Jun 2012 11:06:04 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/5] fdisk: add device topology to the API
Message-ID: <20120604090604.GA6290@foxbat.suse.cz>
References: <1338747317.2864.10.camel@offbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
In-Reply-To: <1338747317.2864.10.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Sun, Jun 03, 2012 at 08:15:17PM +0200, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
>=20
> This patch adds device topology discovery to the internal API. This funct=
ionality is static only to the API and therefore hidden
> from general fdisk code. Functionality itself doesn't really change, min_=
io_size, io_size, logical and physical sector sizes and
> alignment offset are added to the fdisk_context structure and elements ar=
e accessed from there. The logical sector size (sector_size)
> is now unsigned long instead of unsigned int, this as no effect otherwise.
>=20
> A few things to notice:
>  - The patch is larger than I wanted but we need to modify function param=
eters across fdisk and its labels to use the topology data from
>    cxt-> instances. Hopefully this will be pretty much it regarding this =
kind of modifications - perhaps geometry will need something
>    of the like too.
>=20
>  - The -b option must override internal discovery.
>=20
>  - A new helper function has added to verify if the device provides topol=
ogy information, this replaces the 'has_topology' global variable.

Could you please wrap the commit message not to have that long lines?
IMHO wrapping the lines makes the message more readable.
72 chars seems to be common value.

Also, please don't add any new trailing whitespace. Git can be
configured to give a warning on committing new trailing whitespace.

>=20
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  fdisk/fdisk.c         |  309 ++++++++++++++++++++-----------------------=
------
>  fdisk/fdisk.h         |   34 ++++--
>  fdisk/fdiskbsdlabel.c |   18 ++--
>  fdisk/fdiskdoslabel.c |   75 ++++++------
>  fdisk/fdiskdoslabel.h |    8 +-
>  fdisk/fdisksgilabel.c |   49 ++++----
>  fdisk/fdisksgilabel.h |    4 +-
>  fdisk/fdisksunlabel.c |   53 +++++----
>  fdisk/fdisksunlabel.h |   12 +-
>  fdisk/utils.c         |   73 ++++++++++++-
>  10 files changed, 329 insertions(+), 306 deletions(-)
>=20
> diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
> index 1143b2f..d7ff2e5 100644
> --- a/fdisk/fdisk.c
> +++ b/fdisk/fdisk.c
> @@ -47,9 +47,6 @@
>  #ifdef HAVE_LINUX_BLKPG_H
>  #include <linux/blkpg.h>
>  #endif
> -#ifdef HAVE_LIBBLKID
> -#include <blkid.h>
> -#endif
> =20
>  #include "gpt.h"
> =20
> @@ -144,19 +141,12 @@ sector_t sector_offset =3D 1, sectors;
> =20
>  unsigned int	heads,
>  	cylinders,
> -	sector_size =3D DEFAULT_SECTOR_SIZE,
>  	user_set_sector_size =3D 0,
>  	units_per_sector =3D 1,
>  	display_in_cyl_units =3D 0;
> =20
>  sector_t total_number_of_sectors; /* in logical sectors */
> -unsigned long grain =3D DEFAULT_SECTOR_SIZE,
> -	      io_size =3D DEFAULT_SECTOR_SIZE,
> -	      min_io_size =3D DEFAULT_SECTOR_SIZE,
> -	      phy_sector_size =3D DEFAULT_SECTOR_SIZE,
> -	      alignment_offset;
> -int has_topology;
> -
> +unsigned long grain =3D DEFAULT_SECTOR_SIZE;
>  enum labeltype disklabel;	/* Current disklabel */
> =20
>  static void __attribute__ ((__noreturn__)) usage(FILE *out)
> @@ -318,22 +308,22 @@ test_c(char **m, char *mesg) {
>  }
> =20
>  static int
> -lba_is_aligned(sector_t lba)
> +lba_is_aligned(struct fdisk_context *cxt, sector_t lba)
>  {
> -	unsigned int granularity =3D max(phy_sector_size, min_io_size);
> -	sector_t offset =3D (lba * sector_size) & (granularity - 1);
> +	unsigned int granularity =3D max(cxt->phy_sector_size, cxt->min_io_size=
);

Shouldn't granularity rather be 'unsigned long' to match type of
sector_size and min_io_size to match type of sector_size and
min_io_size ?

> +	sector_t offset =3D (lba * cxt->sector_size) & (granularity - 1);
> =20
> -	return !((granularity + alignment_offset - offset) & (granularity - 1));
> +	return !((granularity + cxt->alignment_offset - offset) & (granularity =
- 1));
>  }
> =20
> -sector_t align_lba(sector_t lba, int direction)
> +sector_t align_lba(struct fdisk_context *cxt, sector_t lba, int directio=
n)
>  {
>  	sector_t res;
> =20
> -	if (lba_is_aligned(lba))
> +	if (lba_is_aligned(cxt, lba))
>  		res =3D lba;
>  	else {
> -		sector_t sects_in_phy =3D grain / sector_size;
> +		sector_t sects_in_phy =3D grain / cxt->sector_size;
> =20
>  		if (lba < sector_offset)
>  			res =3D sector_offset;
> @@ -347,8 +337,8 @@ sector_t align_lba(sector_t lba, int direction)
>  		else /* ALIGN_NEAREST */
>  			res =3D ((lba + sects_in_phy / 2) / sects_in_phy) * sects_in_phy;
> =20
> -		if (alignment_offset && !lba_is_aligned(res) &&
> -		    res > alignment_offset / sector_size) {
> +		if (cxt->alignment_offset && !lba_is_aligned(cxt, res) &&
> +		    res > cxt->alignment_offset / cxt->sector_size) {
>  			/*
>  			 * apply alignment_offset
>  			 *
> @@ -357,8 +347,8 @@ sector_t align_lba(sector_t lba, int direction)
>  			 * according the offset to be on the physical boundary.
>  			 */
>  			/* fprintf(stderr, "LBA: %llu apply alignment_offset\n", res); */
> -			res -=3D (max(phy_sector_size, min_io_size) -
> -					alignment_offset) / sector_size;
> +			res -=3D (max(cxt->phy_sector_size, cxt->min_io_size) -
> +					cxt->alignment_offset) / cxt->sector_size;
> =20
>  			if (direction =3D=3D ALIGN_UP && res < lba)
>  				res +=3D sects_in_phy;
> @@ -408,31 +398,31 @@ void update_units(void)
>  		units_per_sector =3D 1;	/* in sectors */
>  }
> =20
> -void warn_limits(void)
> +void warn_limits(struct fdisk_context *cxt)
>  {
>  	if (total_number_of_sectors > UINT_MAX && !nowarn) {
> -		unsigned long long bytes =3D total_number_of_sectors * sector_size;
> +		unsigned long long bytes =3D total_number_of_sectors * cxt->sector_siz=
e;
>  		int giga =3D bytes / 1000000000;
>  		int hectogiga =3D (giga + 50) / 100;
> =20
>  		fprintf(stderr, _("\n"
>  "WARNING: The size of this disk is %d.%d TB (%llu bytes).\n"
>  "DOS partition table format can not be used on drives for volumes\n"
> -"larger than (%llu bytes) for %d-byte sectors. Use parted(1) and GUID \n"
> +"larger than (%llu bytes) for %ld-byte sectors. Use parted(1) and GUID \=
n"
>  "partition table format (GPT).\n\n"),
>  			hectogiga / 10, hectogiga % 10,
>  			bytes,
> -			(sector_t ) UINT_MAX * sector_size,
> -			sector_size);
> +			(sector_t ) UINT_MAX * cxt->sector_size,
> +			cxt->sector_size);
>  	}
>  }
> =20
> -void warn_alignment(void)
> +void warn_alignment(struct fdisk_context *cxt)
>  {
>  	if (nowarn)
>  		return;
> =20
> -	if (sector_size !=3D phy_sector_size)
> +	if (cxt->sector_size !=3D cxt->phy_sector_size)
>  		fprintf(stderr, _("\n"
>  "The device presents a logical sector size that is smaller than\n"
>  "the physical sector size. Aligning to a physical sector (or optimal\n"
> @@ -451,64 +441,6 @@ void warn_alignment(void)
>  }
> =20
>  static void
> -get_topology(struct fdisk_context *cxt) {
> -	int arg;
> -#ifdef HAVE_LIBBLKID
> -	blkid_probe pr;
> -
> -	pr =3D blkid_new_probe();
> -	if (pr && blkid_probe_set_device(pr, cxt->dev_fd, 0, 0) =3D=3D 0) {
> -		blkid_topology tp =3D blkid_probe_get_topology(pr);
> -
> -		if (tp) {
> -			min_io_size =3D blkid_topology_get_minimum_io_size(tp);
> -			io_size =3D blkid_topology_get_optimal_io_size(tp);
> -			phy_sector_size =3D blkid_topology_get_physical_sector_size(tp);
> -			alignment_offset =3D blkid_topology_get_alignment_offset(tp);
> -
> -			/* We assume that the device provides topology info if
> -			 * optimal_io_size is set or alignment_offset is set or
> -			 * minimum_io_size is not power of 2.
> -			 *
> -			 * See also update_sector_offset().
> -			 */
> -			if (io_size || alignment_offset ||
> -			    (min_io_size & (min_io_size - 1)))
> -				has_topology =3D 1;
> -			if (!io_size)
> -				/* optimal IO is optional, default to minimum IO */
> -				io_size =3D min_io_size;
> -		}
> -	}
> -	blkid_free_probe(pr);
> -#endif
> -
> -	if (user_set_sector_size)
> -		/* fdisk since 2.17 differentiate between logical and physical
> -		 * sectors size. For backward compatibility the
> -		 *    fdisk -b <sectorsize>
> -		 * changes both, logical and physical sector size.
> -		 */
> -		phy_sector_size =3D sector_size;
> -
> -	else if (blkdev_get_sector_size(cxt->dev_fd, &arg) =3D=3D 0) {
> -		sector_size =3D arg;
> -
> -		if (!phy_sector_size)
> -			phy_sector_size =3D sector_size;
> -	}
> -
> -	if (!min_io_size)
> -		min_io_size =3D phy_sector_size;
> -	if (!io_size)
> -		io_size =3D min_io_size;
> -
> -	if (sector_size !=3D DEFAULT_SECTOR_SIZE)
> -		printf(_("Note: sector size is %d (not %d)\n"),
> -		       sector_size, DEFAULT_SECTOR_SIZE);
> -}
> -
> -static void
>  get_partition_table_geometry(void) {
>  	unsigned char *bufp =3D MBRbuffer;
>  	struct partition *p;
> @@ -544,9 +476,9 @@ get_partition_table_geometry(void) {
>   * Sets LBA of the first partition
>   */
>  void
> -update_sector_offset(void)
> +update_sector_offset(struct fdisk_context *cxt)
>  {
> -	grain =3D io_size;
> +	grain =3D cxt->io_size;
> =20
>  	if (dos_compatible_flag)
>  		sector_offset =3D sectors;	/* usually 63 sectors */
> @@ -564,29 +496,29 @@ update_sector_offset(void)
>  		 */
>  		sector_t x =3D 0;
> =20
> -		if (has_topology) {
> -			if (alignment_offset)
> -				x =3D alignment_offset;
> -			else if (io_size > 2048 * 512)
> -				x =3D io_size;
> +		if (fdisk_dev_has_topology(cxt)) {
> +			if (cxt->alignment_offset)
> +				x =3D cxt->alignment_offset;
> +			else if (cxt->io_size > 2048 * 512)
> +				x =3D cxt->io_size;
>  		}
>  		/* default to 1MiB */
>  		if (!x)
>  			x =3D 2048 * 512;
> =20
> -		sector_offset =3D x / sector_size;
> +		sector_offset =3D x / cxt->sector_size;
> =20
>  		/* don't use huge offset on small devices */
>  		if (total_number_of_sectors <=3D sector_offset * 4)
> -			sector_offset =3D phy_sector_size / sector_size;
> +			sector_offset =3D cxt->phy_sector_size / cxt->sector_size;
> =20
>  		/* use 1MiB grain always when possible */
>  		if (grain < 2048 * 512)
>  			grain =3D 2048 * 512;
> =20
>  		/* don't use huge grain on small devices */
> -		if (total_number_of_sectors <=3D (grain * 4 / sector_size))
> -			grain =3D phy_sector_size;
> +		if (total_number_of_sectors <=3D (grain * 4 / cxt->sector_size))
> +			grain =3D cxt->phy_sector_size;
>  	}
>  }
> =20
> @@ -595,7 +527,6 @@ get_geometry(struct fdisk_context *cxt, struct geom *=
g) {
>  	sector_t llcyls, nsects =3D 0;
>  	unsigned int kern_heads =3D 0, kern_sectors =3D 0;
> =20
> -	get_topology(cxt);
>  	heads =3D cylinders =3D sectors =3D 0;
>  	pt_heads =3D pt_sectors =3D 0;
> =20
> @@ -611,9 +542,9 @@ get_geometry(struct fdisk_context *cxt, struct geom *=
g) {
> =20
>  	/* get number of 512-byte sectors, and convert it the real sectors */
>  	if (blkdev_get_sectors(cxt->dev_fd, &nsects) =3D=3D 0)
> -		total_number_of_sectors =3D (nsects / (sector_size >> 9));
> +		total_number_of_sectors =3D (nsects / (cxt->sector_size >> 9));
> =20
> -	update_sector_offset();
> +	update_sector_offset(cxt);
> =20
>  	llcyls =3D total_number_of_sectors / (heads * sectors);
>  	cylinders =3D llcyls;
> @@ -676,7 +607,7 @@ static int get_boot(struct fdisk_context *cxt, int tr=
y_only) {
> =20
>  	if (check_osf_label(cxt)) {
>  		/* intialize partitions for BSD as well */
> -		dos_init();
> +		dos_init(cxt);
>  		if (!valid_part_table_flag(MBRbuffer)) {
>  			disklabel =3D OSF_LABEL;
>  			return 0;
> @@ -695,7 +626,7 @@ static int get_boot(struct fdisk_context *cxt, int tr=
y_only) {
>  #ifdef __sparc__
>  		create_sunlabel(cxt);
>  #else
> -		create_doslabel();
> +		create_doslabel(cxt);
>  #endif
>  	}
>  	return 0;
> @@ -796,7 +727,8 @@ read_hex(struct systypes *sys)
>  }
> =20
>  unsigned int
> -read_int_with_suffix(unsigned int low, unsigned int dflt, unsigned int h=
igh,
> +read_int_with_suffix(struct fdisk_context *cxt,
> +	unsigned int low, unsigned int dflt, unsigned int high,

We only need 'sector_size' from the context structure in this
function. Wouldn't it be cleaner if you pass only sector_size to the
function instead of full context? I don't think function for 'reading'
the number should need anything else from the context.

>  	 unsigned int base, char *mesg, int *is_suffix_used)
>  {
>  	unsigned int res;
> @@ -895,7 +827,7 @@ read_int_with_suffix(unsigned int low, unsigned int d=
flt, unsigned int high,
>  				unsigned long unit;
> =20
>  				bytes =3D (unsigned long long) res * absolute;
> -				unit =3D sector_size * units_per_sector;
> +				unit =3D cxt->sector_size * units_per_sector;
>  				bytes +=3D unit/2;	/* round */
>  				bytes /=3D unit;
>  				res =3D bytes;
> @@ -932,18 +864,19 @@ read_int_with_suffix(unsigned int low, unsigned int=
 dflt, unsigned int high,
>   * There is no default if DFLT is not between LOW and HIGH.
>   */
>  unsigned int
> -read_int(unsigned int low, unsigned int dflt, unsigned int high,
> +read_int(struct fdisk_context *cxt,=20

Dtto.

> +	 unsigned int low, unsigned int dflt, unsigned int high,
>  	 unsigned int base, char *mesg)
>  {
> -	return read_int_with_suffix(low, dflt, high, base, mesg, NULL);
> +	return read_int_with_suffix(cxt, low, dflt, high, base, mesg, NULL);
>  }
> =20
>  int
> -get_partition_dflt(int warn, int max, int dflt) {
> +get_partition_dflt(struct fdisk_context *cxt, int warn, int max, int dfl=
t) {
>  	struct pte *pe;
>  	int i;
> =20
> -	i =3D read_int(1, dflt, max, 0, _("Partition number")) - 1;
> +	i =3D read_int(cxt, 1, dflt, max, 0, _("Partition number")) - 1;
>  	pe =3D &ptes[i];
> =20
>  	if (warn) {
> @@ -961,14 +894,14 @@ get_partition_dflt(int warn, int max, int dflt) {
>  }
> =20
>  int
> -get_partition(int warn, int max) {
> -	return get_partition_dflt(warn, max, 0);
> +get_partition(struct fdisk_context *cxt, int warn, int max) {
> +	return get_partition_dflt(cxt, warn, max, 0);
>  }
> =20
>  /* User partition selection unless one partition only is available */
> =20
>  static int
> -get_existing_partition(int warn, int max) {
> +get_existing_partition(struct fdisk_context *cxt, int warn, int max) {
>  	int pno =3D -1;
>  	int i;
> =20
> @@ -995,7 +928,7 @@ get_existing_partition(int warn, int max) {
> =20
>  not_implemented:
>  not_unique:
> -	return get_partition(warn, max);
> +	return get_partition(cxt, warn, max);
>  }
> =20
>  const char *
> @@ -1031,18 +964,18 @@ toggle_active(int i) {
>  }
> =20
>  static void
> -toggle_dos_compatibility_flag(void) {
> +toggle_dos_compatibility_flag(struct fdisk_context *cxt) {
>  	dos_compatible_flag =3D ~dos_compatible_flag;
>  	if (dos_compatible_flag)
>  		printf(_("DOS Compatibility flag is set (DEPRECATED!)\n"));
>  	else
>  		printf(_("DOS Compatibility flag is not set\n"));
> =20
> -	update_sector_offset();
> +	update_sector_offset(cxt);
>  }
> =20
>  static void
> -delete_partition(int i)
> +delete_partition(struct fdisk_context *cxt, int i)
>  {
>  	if (i < 0)
>  		return;
> @@ -1057,18 +990,18 @@ delete_partition(int i)
>  	else if (disklabel =3D=3D SUN_LABEL)
>  		sun_delete_partition(i);
>  	else if (disklabel =3D=3D SGI_LABEL)
> -		sgi_delete_partition(i);
> +		sgi_delete_partition(cxt, i);
> =20
>  	printf(_("Partition %d is deleted\n"), i + 1);
>  }
> =20
> -static void
> -change_sysid(void) {
> +static void change_sysid(struct fdisk_context *cxt)
> +{
>  	char *temp;
>  	int i, sys, origsys;
>  	struct partition *p;
> =20
> -	i =3D get_existing_partition(0, partitions);
> +	i =3D get_existing_partition(cxt, 0, partitions);
> =20
>  	if (i =3D=3D -1)
>  		return;
> @@ -1204,16 +1137,16 @@ static void check_consistency(struct partition *p=
, int partition) {
>  }
> =20
>  static void
> -check_alignment(sector_t lba, int partition)
> +check_alignment(struct fdisk_context *cxt, sector_t lba, int partition)
>  {
> -	if (!lba_is_aligned(lba))
> +	if (!lba_is_aligned(cxt, lba))
>  		printf(_("Partition %i does not start on physical sector boundary.\n"),
>  			partition + 1);
>  }
> =20
>  static void
>  list_disk_geometry(struct fdisk_context *cxt) {
> -	unsigned long long bytes =3D total_number_of_sectors * sector_size;
> +	unsigned long long bytes =3D total_number_of_sectors * cxt->sector_size;
>  	long megabytes =3D bytes/1000000;
> =20
>  	if (megabytes < 10000)
> @@ -1229,16 +1162,16 @@ list_disk_geometry(struct fdisk_context *cxt) {
>  	if (units_per_sector =3D=3D 1)
>  		printf(_(", total %llu sectors"), total_number_of_sectors);
>  	printf("\n");
> -	printf(_("Units =3D %s of %d * %d =3D %d bytes\n"),
> +	printf(_("Units =3D %s of %d * %ld =3D %ld bytes\n"),
>  	       str_units(PLURAL),
> -	       units_per_sector, sector_size, units_per_sector * sector_size);
> +	       units_per_sector, cxt->sector_size, units_per_sector * cxt->sect=
or_size);
> =20
> -	printf(_("Sector size (logical/physical): %u bytes / %lu bytes\n"),
> -				sector_size, phy_sector_size);
> +	printf(_("Sector size (logical/physical): %lu bytes / %lu bytes\n"),
> +				cxt->sector_size, cxt->phy_sector_size);
>  	printf(_("I/O size (minimum/optimal): %lu bytes / %lu bytes\n"),
> -				min_io_size, io_size);
> -	if (alignment_offset)
> -		printf(_("Alignment offset: %lu bytes\n"), alignment_offset);
> +				cxt->min_io_size, cxt->io_size);
> +	if (cxt->alignment_offset)
> +		printf(_("Alignment offset: %lu bytes\n"), cxt->alignment_offset);
>  	if (disklabel =3D=3D DOS_LABEL)
>  		dos_print_mbr_id();
>  	printf("\n");
> @@ -1428,12 +1361,12 @@ list_table(struct fdisk_context *cxt, int xtra) {
>  			unsigned int pblocks =3D psects;
>  			unsigned int podd =3D 0;
> =20
> -			if (sector_size < 1024) {
> -				pblocks /=3D (1024 / sector_size);
> -				podd =3D psects % (1024 / sector_size);
> +			if (cxt->sector_size < 1024) {
> +				pblocks /=3D (1024 / cxt->sector_size);
> +				podd =3D psects % (1024 / cxt->sector_size);
>  			}
> -			if (sector_size > 1024)
> -				pblocks *=3D (sector_size / 1024);
> +			if (cxt->sector_size > 1024)
> +				pblocks *=3D (cxt->sector_size / 1024);
>                          printf(
>  			    "%s  %c %11lu %11lu %11lu%c  %2x  %s\n",
>  			partname(cxt->dev_path, i+1, w+2),
> @@ -1447,7 +1380,7 @@ list_table(struct fdisk_context *cxt, int xtra) {
>  /* type name */		(type =3D partition_type(p->sys_ind)) ?
>  			type : _("Unknown"));
>  			check_consistency(p, i);
> -			check_alignment(get_partition_start(pe), i);
> +			check_alignment(cxt, get_partition_start(pe), i);
>  		}
>  	}
> =20
> @@ -1482,7 +1415,7 @@ x_list_table(struct fdisk_context *cxt, int extend)=
 {
>  				(unsigned long) get_nr_sects(p), p->sys_ind);
>  			if (p->sys_ind) {
>  				check_consistency(p, i);
> -				check_alignment(get_partition_start(pe), i);
> +				check_alignment(cxt, get_partition_start(pe), i);
>  			}
>  		}
>  	}
> @@ -1533,7 +1466,7 @@ check(int n, unsigned int h, unsigned int s, unsign=
ed int c,
>  }
> =20
>  static void
> -verify(void) {
> +verify(struct fdisk_context *cxt) {
>  	int i, j;
>  	sector_t total =3D 1, n_sectors =3D total_number_of_sectors;
>  	unsigned long long first[partitions], last[partitions];
> @@ -1559,7 +1492,7 @@ verify(void) {
>  		p =3D pe->part_table;
>  		if (p->sys_ind && !IS_EXTENDED (p->sys_ind)) {
>  			check_consistency(p, i);
> -			check_alignment(get_partition_start(pe), i);
> +			check_alignment(cxt, get_partition_start(pe), i);
>  			if (get_partition_start(pe) < first[i])
>  				printf(_("Warning: bad start-of-data in "
>  					"partition %d\n"), i + 1);
> @@ -1603,30 +1536,31 @@ verify(void) {
>  		printf(_("Total allocated sectors %llu greater than the maximum"
>  			" %llu\n"), total, n_sectors);
>  	else if (total < n_sectors)
> -		printf(_("Remaining %lld unallocated %d-byte sectors\n"),
> -		       n_sectors - total, sector_size);
> +		printf(_("Remaining %lld unallocated %ld-byte sectors\n"),
> +		       n_sectors - total, cxt->sector_size);
>  }
> =20
> -void print_partition_size(int num, sector_t start, sector_t stop, int sy=
sid)
> +void print_partition_size(struct fdisk_context *cxt,
> +			  int num, sector_t start, sector_t stop, int sysid)
>  {
>  	char *str =3D size_to_human_string(SIZE_SUFFIX_3LETTER | SIZE_SUFFIX_SP=
ACE,
> -				     (stop - start + 1) * sector_size);
> +				     (stop - start + 1) * cxt->sector_size);
>  	printf(_("Partition %d of type %s and of size %s is set\n"), num, parti=
tion_type(sysid), str);
>  	free(str);
>  }
> =20
> -static void new_partition(void)
> +static void new_partition(struct fdisk_context *cxt)
>  {
>  	if (warn_geometry())
>  		return;
> =20
>  	if (disklabel =3D=3D SUN_LABEL) {
> -		add_sun_partition(get_partition(0, partitions), LINUX_NATIVE);
> +		add_sun_partition(cxt, get_partition(cxt, 0, partitions), LINUX_NATIVE=
);
>  		return;
>  	}
> =20
>  	if (disklabel =3D=3D SGI_LABEL) {
> -		sgi_add_partition(get_partition(0, partitions), LINUX_NATIVE);
> +		sgi_add_partition(cxt, get_partition(cxt, 0, partitions), LINUX_NATIVE=
);
>  		return;
>  	}
> =20
> @@ -1649,7 +1583,7 @@ static void new_partition(void)
>  	}
> =20
>  	/* default to DOS/BSD */
> -	dos_new_partition();
> +	dos_new_partition(cxt);
>  }
> =20
>  static void
> @@ -1719,10 +1653,10 @@ reread_partition_table(struct fdisk_context *cxt,=
 int leave) {
> =20
>  #define MAX_PER_LINE	16
>  static void
> -print_buffer(unsigned char pbuffer[]) {
> +print_buffer(struct fdisk_context *cxt, unsigned char pbuffer[]) {

Take something like 'unsigned long buflen' instead of 'full' context?

>  	unsigned int i, l;
> =20
> -	for (i =3D 0, l =3D 0; i < sector_size; i++, l++) {
> +	for (i =3D 0, l =3D 0; i < cxt->sector_size; i++, l++) {
>  		if (l =3D=3D 0)
>  			printf("0x%03X:", i);
>  		printf(" %02X", pbuffer[i]);
> @@ -1736,19 +1670,19 @@ print_buffer(unsigned char pbuffer[]) {
>  	printf("\n");
>  }
> =20
> -static void
> -print_raw(char *dev) {
> +static void print_raw(struct fdisk_context *cxt)
> +{
>  	int i;
> =20
> -	printf(_("Device: %s\n"), dev);
> +	printf(_("Device: %s\n"), cxt->dev_path);
>  	if (disklabel =3D=3D SUN_LABEL || disklabel =3D=3D SGI_LABEL)
> -		print_buffer(MBRbuffer);
> +		print_buffer(cxt, MBRbuffer);
>  	else for (i =3D 3; i < partitions; i++)
> -		print_buffer(ptes[i].sectorbuffer);
> +		     print_buffer(cxt, ptes[i].sectorbuffer);
>  }
> =20
>  static void
> -move_begin(int i) {
> +move_begin(struct fdisk_context *cxt, int i) {
>  	struct pte *pe =3D &ptes[i];
>  	struct partition *p =3D pe->part_table;
>  	unsigned int new, free_start, curr_start, last;
> @@ -1785,7 +1719,7 @@ move_begin(int i) {
> =20
>  	last =3D get_partition_start(pe) + get_nr_sects(p) - 1;
> =20
> -	new =3D read_int(free_start, curr_start, last, free_start,
> +	new =3D read_int(cxt, free_start, curr_start, last, free_start,
>  		       _("New beginning of data")) - pe->offset;
> =20
>  	if (new !=3D get_nr_sects(p)) {
> @@ -1814,27 +1748,27 @@ expert_command_prompt(struct fdisk_context *cxt)
>  		switch (c) {
>  		case 'a':
>  			if (disklabel =3D=3D SUN_LABEL)
> -				sun_set_alt_cyl();
> +				sun_set_alt_cyl(cxt);
>  			break;
>  		case 'b':
>  			if (disklabel =3D=3D DOS_LABEL)
> -				move_begin(get_partition(0, partitions));
> +				move_begin(cxt, get_partition(cxt, 0, partitions));
>  			break;
>  		case 'c':
>  			user_cylinders =3D cylinders =3D
> -				read_int(1, cylinders, 1048576, 0,
> +				read_int(cxt, 1, cylinders, 1048576, 0,
>  					 _("Number of cylinders"));
>  			if (disklabel =3D=3D SUN_LABEL)
>  				sun_set_ncyl(cylinders);
>  			break;
>  		case 'd':
> -			print_raw(cxt->dev_path);
> +			print_raw(cxt);
>  			break;
>  		case 'e':
>  			if (disklabel =3D=3D SGI_LABEL)
>  				sgi_set_xcyl();
>  			else if (disklabel =3D=3D SUN_LABEL)
> -				sun_set_xcyl();
> +				sun_set_xcyl(cxt);
>  			else
>  			if (disklabel =3D=3D DOS_LABEL)
>  				x_list_table(cxt, 1);
> @@ -1847,19 +1781,19 @@ expert_command_prompt(struct fdisk_context *cxt)
>  			create_sgilabel(cxt);
>  			break;
>  		case 'h':
> -			user_heads =3D heads =3D read_int(1, heads, 256, 0,
> +			user_heads =3D heads =3D read_int(cxt, 1, heads, 256, 0,
>  					 _("Number of heads"));
>  			update_units();
>  			break;
>  		case 'i':
>  			if (disklabel =3D=3D SUN_LABEL)
> -				sun_set_ilfact();
> +				sun_set_ilfact(cxt);
>  			else if (disklabel =3D=3D DOS_LABEL)
>  				dos_set_mbr_id();
>  			break;
>  		case 'o':
>  			if (disklabel =3D=3D SUN_LABEL)
> -				sun_set_rspeed();
> +				sun_set_rspeed(cxt);
>  			break;
>  		case 'p':
>  			if (disklabel =3D=3D SUN_LABEL)
> @@ -1872,24 +1806,24 @@ expert_command_prompt(struct fdisk_context *cxt)
>  		case 'r':
>  			return;
>  		case 's':
> -			user_sectors =3D sectors =3D read_int(1, sectors, 63, 0,
> +			user_sectors =3D sectors =3D read_int(cxt, 1, sectors, 63, 0,
>  					   _("Number of sectors"));
>  			if (dos_compatible_flag)
>  				fprintf(stderr, _("Warning: setting "
>  					"sector offset for DOS "
>  					"compatiblity\n"));
> -			update_sector_offset();
> +			update_sector_offset(cxt);
>  			update_units();
>  			break;
>  		case 'v':
> -			verify();
> +			verify(cxt);
>  			break;
>  		case 'w':
>  			write_table(cxt);
>  			break;
>  		case 'y':
>  			if (disklabel =3D=3D SUN_LABEL)
> -				sun_set_pcylcount();
> +				sun_set_pcylcount(cxt);
>  			break;
>  		default:
>  			print_menu(EXPERT_MENU);
> @@ -1918,15 +1852,15 @@ gpt_warning(char *dev)
>  }
> =20
>  /* Print disk geometry and partition table of a specified device (-l opt=
ion) */
> -
> -static void
> -print_partition_table_from_option(char *device)
> +static void print_partition_table_from_option(char *device, unsigned lon=
g sector_size)
>  {
>  	int gb;
> =20
>  	struct fdisk_context *cxt =3D fdisk_new_context_from_filename(device, 1=
);	/* read-only */
>  	if (!cxt)
>  		err(EXIT_FAILURE, _("unable to open %s"), device);
> +	if (sector_size)  /* passed -b option, override autodiscovery */
> +		cxt->phy_sector_size =3D cxt->sector_size =3D sector_size;

Perhaps this user-provided sector_size together with a bit-flag
denoting that the user wants to override the sector_size should be
made part of the context? But that'd be material for separate patch,
IMHO.

[SNIP]
=20
>  int fdisk_debug_mask;
> =20
> +static unsigned long __get_sector_size(int fd)
> +{
> +	unsigned int sect_sz;

This introduces type mismatch - should be just int.

> +
> +	if (!blkdev_get_sector_size(fd, &sect_sz))
> +		return (unsigned long) sect_sz;
> +	return DEFAULT_SECTOR_SIZE;
> +}


Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk/MenwACgkQnZxG0T6qDD2ERACfTJTAPiWaEZdGy4Nbndux3z8q
6BUAn3+4WhjiVx8m+FBTUd8Bm+xfZWTm
=ImbR
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
