Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcaib.dreamhost.com ([208.97.132.81]:36194 "EHLO
	homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756666Ab2FDJoN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 4 Jun 2012 05:44:13 -0400
Subject: Re: [PATCH 1/5] fdisk: add device topology to the API
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20120604090604.GA6290@foxbat.suse.cz>
References: <1338747317.2864.10.camel@offbook>
	 <20120604090604.GA6290@foxbat.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Jun 2012 11:44:09 +0200
Message-ID: <1338803049.2553.5.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 2012-06-04 at 11:06 +0200, Petr Uzel wrote:
> Hi David,
> 
> On Sun, Jun 03, 2012 at 08:15:17PM +0200, Davidlohr Bueso wrote:
> > From: Davidlohr Bueso <dave@gnu.org>
> > 
> > This patch adds device topology discovery to the internal API. This functionality is static only to the API and therefore hidden
> > from general fdisk code. Functionality itself doesn't really change, min_io_size, io_size, logical and physical sector sizes and
> > alignment offset are added to the fdisk_context structure and elements are accessed from there. The logical sector size (sector_size)
> > is now unsigned long instead of unsigned int, this as no effect otherwise.
> > 
> > A few things to notice:
> >  - The patch is larger than I wanted but we need to modify function parameters across fdisk and its labels to use the topology data from
> >    cxt-> instances. Hopefully this will be pretty much it regarding this kind of modifications - perhaps geometry will need something
> >    of the like too.
> > 
> >  - The -b option must override internal discovery.
> > 
> >  - A new helper function has added to verify if the device provides topology information, this replaces the 'has_topology' global variable.
> 
> Could you please wrap the commit message not to have that long lines?
> IMHO wrapping the lines makes the message more readable.
> 72 chars seems to be common value.
> 
> Also, please don't add any new trailing whitespace. Git can be
> configured to give a warning on committing new trailing whitespace.

I'll look into that.

> 
> > 
> > Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> > ---
> >  fdisk/fdisk.c         |  309 ++++++++++++++++++++-----------------------------
> >  fdisk/fdisk.h         |   34 ++++--
> >  fdisk/fdiskbsdlabel.c |   18 ++--
> >  fdisk/fdiskdoslabel.c |   75 ++++++------
> >  fdisk/fdiskdoslabel.h |    8 +-
> >  fdisk/fdisksgilabel.c |   49 ++++----
> >  fdisk/fdisksgilabel.h |    4 +-
> >  fdisk/fdisksunlabel.c |   53 +++++----
> >  fdisk/fdisksunlabel.h |   12 +-
> >  fdisk/utils.c         |   73 ++++++++++++-
> >  10 files changed, 329 insertions(+), 306 deletions(-)
> > 
> > diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
> > index 1143b2f..d7ff2e5 100644
> > --- a/fdisk/fdisk.c
> > +++ b/fdisk/fdisk.c
> > @@ -47,9 +47,6 @@
> >  #ifdef HAVE_LINUX_BLKPG_H
> >  #include <linux/blkpg.h>
> >  #endif
> > -#ifdef HAVE_LIBBLKID
> > -#include <blkid.h>
> > -#endif
> >  
> >  #include "gpt.h"
> >  
> > @@ -144,19 +141,12 @@ sector_t sector_offset = 1, sectors;
> >  
> >  unsigned int	heads,
> >  	cylinders,
> > -	sector_size = DEFAULT_SECTOR_SIZE,
> >  	user_set_sector_size = 0,
> >  	units_per_sector = 1,
> >  	display_in_cyl_units = 0;
> >  
> >  sector_t total_number_of_sectors; /* in logical sectors */
> > -unsigned long grain = DEFAULT_SECTOR_SIZE,
> > -	      io_size = DEFAULT_SECTOR_SIZE,
> > -	      min_io_size = DEFAULT_SECTOR_SIZE,
> > -	      phy_sector_size = DEFAULT_SECTOR_SIZE,
> > -	      alignment_offset;
> > -int has_topology;
> > -
> > +unsigned long grain = DEFAULT_SECTOR_SIZE;
> >  enum labeltype disklabel;	/* Current disklabel */
> >  
> >  static void __attribute__ ((__noreturn__)) usage(FILE *out)
> > @@ -318,22 +308,22 @@ test_c(char **m, char *mesg) {
> >  }
> >  
> >  static int
> > -lba_is_aligned(sector_t lba)
> > +lba_is_aligned(struct fdisk_context *cxt, sector_t lba)
> >  {
> > -	unsigned int granularity = max(phy_sector_size, min_io_size);
> > -	sector_t offset = (lba * sector_size) & (granularity - 1);
> > +	unsigned int granularity = max(cxt->phy_sector_size, cxt->min_io_size);
> 
> Shouldn't granularity rather be 'unsigned long' to match type of
> sector_size and min_io_size to match type of sector_size and
> min_io_size ?
> 
> > +	sector_t offset = (lba * cxt->sector_size) & (granularity - 1);
> >  
> > -	return !((granularity + alignment_offset - offset) & (granularity - 1));
> > +	return !((granularity + cxt->alignment_offset - offset) & (granularity - 1));
> >  }
> >  
> > -sector_t align_lba(sector_t lba, int direction)
> > +sector_t align_lba(struct fdisk_context *cxt, sector_t lba, int direction)
> >  {
> >  	sector_t res;
> >  
> > -	if (lba_is_aligned(lba))
> > +	if (lba_is_aligned(cxt, lba))
> >  		res = lba;
> >  	else {
> > -		sector_t sects_in_phy = grain / sector_size;
> > +		sector_t sects_in_phy = grain / cxt->sector_size;
> >  
> >  		if (lba < sector_offset)
> >  			res = sector_offset;
> > @@ -347,8 +337,8 @@ sector_t align_lba(sector_t lba, int direction)
> >  		else /* ALIGN_NEAREST */
> >  			res = ((lba + sects_in_phy / 2) / sects_in_phy) * sects_in_phy;
> >  
> > -		if (alignment_offset && !lba_is_aligned(res) &&
> > -		    res > alignment_offset / sector_size) {
> > +		if (cxt->alignment_offset && !lba_is_aligned(cxt, res) &&
> > +		    res > cxt->alignment_offset / cxt->sector_size) {
> >  			/*
> >  			 * apply alignment_offset
> >  			 *
> > @@ -357,8 +347,8 @@ sector_t align_lba(sector_t lba, int direction)
> >  			 * according the offset to be on the physical boundary.
> >  			 */
> >  			/* fprintf(stderr, "LBA: %llu apply alignment_offset\n", res); */
> > -			res -= (max(phy_sector_size, min_io_size) -
> > -					alignment_offset) / sector_size;
> > +			res -= (max(cxt->phy_sector_size, cxt->min_io_size) -
> > +					cxt->alignment_offset) / cxt->sector_size;
> >  
> >  			if (direction == ALIGN_UP && res < lba)
> >  				res += sects_in_phy;
> > @@ -408,31 +398,31 @@ void update_units(void)
> >  		units_per_sector = 1;	/* in sectors */
> >  }
> >  
> > -void warn_limits(void)
> > +void warn_limits(struct fdisk_context *cxt)
> >  {
> >  	if (total_number_of_sectors > UINT_MAX && !nowarn) {
> > -		unsigned long long bytes = total_number_of_sectors * sector_size;
> > +		unsigned long long bytes = total_number_of_sectors * cxt->sector_size;
> >  		int giga = bytes / 1000000000;
> >  		int hectogiga = (giga + 50) / 100;
> >  
> >  		fprintf(stderr, _("\n"
> >  "WARNING: The size of this disk is %d.%d TB (%llu bytes).\n"
> >  "DOS partition table format can not be used on drives for volumes\n"
> > -"larger than (%llu bytes) for %d-byte sectors. Use parted(1) and GUID \n"
> > +"larger than (%llu bytes) for %ld-byte sectors. Use parted(1) and GUID \n"
> >  "partition table format (GPT).\n\n"),
> >  			hectogiga / 10, hectogiga % 10,
> >  			bytes,
> > -			(sector_t ) UINT_MAX * sector_size,
> > -			sector_size);
> > +			(sector_t ) UINT_MAX * cxt->sector_size,
> > +			cxt->sector_size);
> >  	}
> >  }
> >  
> > -void warn_alignment(void)
> > +void warn_alignment(struct fdisk_context *cxt)
> >  {
> >  	if (nowarn)
> >  		return;
> >  
> > -	if (sector_size != phy_sector_size)
> > +	if (cxt->sector_size != cxt->phy_sector_size)
> >  		fprintf(stderr, _("\n"
> >  "The device presents a logical sector size that is smaller than\n"
> >  "the physical sector size. Aligning to a physical sector (or optimal\n"
> > @@ -451,64 +441,6 @@ void warn_alignment(void)
> >  }
> >  
> >  static void
> > -get_topology(struct fdisk_context *cxt) {
> > -	int arg;
> > -#ifdef HAVE_LIBBLKID
> > -	blkid_probe pr;
> > -
> > -	pr = blkid_new_probe();
> > -	if (pr && blkid_probe_set_device(pr, cxt->dev_fd, 0, 0) == 0) {
> > -		blkid_topology tp = blkid_probe_get_topology(pr);
> > -
> > -		if (tp) {
> > -			min_io_size = blkid_topology_get_minimum_io_size(tp);
> > -			io_size = blkid_topology_get_optimal_io_size(tp);
> > -			phy_sector_size = blkid_topology_get_physical_sector_size(tp);
> > -			alignment_offset = blkid_topology_get_alignment_offset(tp);
> > -
> > -			/* We assume that the device provides topology info if
> > -			 * optimal_io_size is set or alignment_offset is set or
> > -			 * minimum_io_size is not power of 2.
> > -			 *
> > -			 * See also update_sector_offset().
> > -			 */
> > -			if (io_size || alignment_offset ||
> > -			    (min_io_size & (min_io_size - 1)))
> > -				has_topology = 1;
> > -			if (!io_size)
> > -				/* optimal IO is optional, default to minimum IO */
> > -				io_size = min_io_size;
> > -		}
> > -	}
> > -	blkid_free_probe(pr);
> > -#endif
> > -
> > -	if (user_set_sector_size)
> > -		/* fdisk since 2.17 differentiate between logical and physical
> > -		 * sectors size. For backward compatibility the
> > -		 *    fdisk -b <sectorsize>
> > -		 * changes both, logical and physical sector size.
> > -		 */
> > -		phy_sector_size = sector_size;
> > -
> > -	else if (blkdev_get_sector_size(cxt->dev_fd, &arg) == 0) {
> > -		sector_size = arg;
> > -
> > -		if (!phy_sector_size)
> > -			phy_sector_size = sector_size;
> > -	}
> > -
> > -	if (!min_io_size)
> > -		min_io_size = phy_sector_size;
> > -	if (!io_size)
> > -		io_size = min_io_size;
> > -
> > -	if (sector_size != DEFAULT_SECTOR_SIZE)
> > -		printf(_("Note: sector size is %d (not %d)\n"),
> > -		       sector_size, DEFAULT_SECTOR_SIZE);
> > -}
> > -
> > -static void
> >  get_partition_table_geometry(void) {
> >  	unsigned char *bufp = MBRbuffer;
> >  	struct partition *p;
> > @@ -544,9 +476,9 @@ get_partition_table_geometry(void) {
> >   * Sets LBA of the first partition
> >   */
> >  void
> > -update_sector_offset(void)
> > +update_sector_offset(struct fdisk_context *cxt)
> >  {
> > -	grain = io_size;
> > +	grain = cxt->io_size;
> >  
> >  	if (dos_compatible_flag)
> >  		sector_offset = sectors;	/* usually 63 sectors */
> > @@ -564,29 +496,29 @@ update_sector_offset(void)
> >  		 */
> >  		sector_t x = 0;
> >  
> > -		if (has_topology) {
> > -			if (alignment_offset)
> > -				x = alignment_offset;
> > -			else if (io_size > 2048 * 512)
> > -				x = io_size;
> > +		if (fdisk_dev_has_topology(cxt)) {
> > +			if (cxt->alignment_offset)
> > +				x = cxt->alignment_offset;
> > +			else if (cxt->io_size > 2048 * 512)
> > +				x = cxt->io_size;
> >  		}
> >  		/* default to 1MiB */
> >  		if (!x)
> >  			x = 2048 * 512;
> >  
> > -		sector_offset = x / sector_size;
> > +		sector_offset = x / cxt->sector_size;
> >  
> >  		/* don't use huge offset on small devices */
> >  		if (total_number_of_sectors <= sector_offset * 4)
> > -			sector_offset = phy_sector_size / sector_size;
> > +			sector_offset = cxt->phy_sector_size / cxt->sector_size;
> >  
> >  		/* use 1MiB grain always when possible */
> >  		if (grain < 2048 * 512)
> >  			grain = 2048 * 512;
> >  
> >  		/* don't use huge grain on small devices */
> > -		if (total_number_of_sectors <= (grain * 4 / sector_size))
> > -			grain = phy_sector_size;
> > +		if (total_number_of_sectors <= (grain * 4 / cxt->sector_size))
> > +			grain = cxt->phy_sector_size;
> >  	}
> >  }
> >  
> > @@ -595,7 +527,6 @@ get_geometry(struct fdisk_context *cxt, struct geom *g) {
> >  	sector_t llcyls, nsects = 0;
> >  	unsigned int kern_heads = 0, kern_sectors = 0;
> >  
> > -	get_topology(cxt);
> >  	heads = cylinders = sectors = 0;
> >  	pt_heads = pt_sectors = 0;
> >  
> > @@ -611,9 +542,9 @@ get_geometry(struct fdisk_context *cxt, struct geom *g) {
> >  
> >  	/* get number of 512-byte sectors, and convert it the real sectors */
> >  	if (blkdev_get_sectors(cxt->dev_fd, &nsects) == 0)
> > -		total_number_of_sectors = (nsects / (sector_size >> 9));
> > +		total_number_of_sectors = (nsects / (cxt->sector_size >> 9));
> >  
> > -	update_sector_offset();
> > +	update_sector_offset(cxt);
> >  
> >  	llcyls = total_number_of_sectors / (heads * sectors);
> >  	cylinders = llcyls;
> > @@ -676,7 +607,7 @@ static int get_boot(struct fdisk_context *cxt, int try_only) {
> >  
> >  	if (check_osf_label(cxt)) {
> >  		/* intialize partitions for BSD as well */
> > -		dos_init();
> > +		dos_init(cxt);
> >  		if (!valid_part_table_flag(MBRbuffer)) {
> >  			disklabel = OSF_LABEL;
> >  			return 0;
> > @@ -695,7 +626,7 @@ static int get_boot(struct fdisk_context *cxt, int try_only) {
> >  #ifdef __sparc__
> >  		create_sunlabel(cxt);
> >  #else
> > -		create_doslabel();
> > +		create_doslabel(cxt);
> >  #endif
> >  	}
> >  	return 0;
> > @@ -796,7 +727,8 @@ read_hex(struct systypes *sys)
> >  }
> >  
> >  unsigned int
> > -read_int_with_suffix(unsigned int low, unsigned int dflt, unsigned int high,
> > +read_int_with_suffix(struct fdisk_context *cxt,
> > +	unsigned int low, unsigned int dflt, unsigned int high,
> 
> We only need 'sector_size' from the context structure in this
> function. Wouldn't it be cleaner if you pass only sector_size to the
> function instead of full context? I don't think function for 'reading'
> the number should need anything else from the context.
> 
> >  	 unsigned int base, char *mesg, int *is_suffix_used)
> >  {
> >  	unsigned int res;
> > @@ -895,7 +827,7 @@ read_int_with_suffix(unsigned int low, unsigned int dflt, unsigned int high,
> >  				unsigned long unit;
> >  
> >  				bytes = (unsigned long long) res * absolute;
> > -				unit = sector_size * units_per_sector;
> > +				unit = cxt->sector_size * units_per_sector;
> >  				bytes += unit/2;	/* round */
> >  				bytes /= unit;
> >  				res = bytes;
> > @@ -932,18 +864,19 @@ read_int_with_suffix(unsigned int low, unsigned int dflt, unsigned int high,
> >   * There is no default if DFLT is not between LOW and HIGH.
> >   */
> >  unsigned int
> > -read_int(unsigned int low, unsigned int dflt, unsigned int high,
> > +read_int(struct fdisk_context *cxt, 
> 
> Dtto.
> 
> > +	 unsigned int low, unsigned int dflt, unsigned int high,
> >  	 unsigned int base, char *mesg)
> >  {
> > -	return read_int_with_suffix(low, dflt, high, base, mesg, NULL);
> > +	return read_int_with_suffix(cxt, low, dflt, high, base, mesg, NULL);
> >  }
> >  
> >  int
> > -get_partition_dflt(int warn, int max, int dflt) {
> > +get_partition_dflt(struct fdisk_context *cxt, int warn, int max, int dflt) {
> >  	struct pte *pe;
> >  	int i;
> >  
> > -	i = read_int(1, dflt, max, 0, _("Partition number")) - 1;
> > +	i = read_int(cxt, 1, dflt, max, 0, _("Partition number")) - 1;
> >  	pe = &ptes[i];
> >  
> >  	if (warn) {
> > @@ -961,14 +894,14 @@ get_partition_dflt(int warn, int max, int dflt) {
> >  }
> >  
> >  int
> > -get_partition(int warn, int max) {
> > -	return get_partition_dflt(warn, max, 0);
> > +get_partition(struct fdisk_context *cxt, int warn, int max) {
> > +	return get_partition_dflt(cxt, warn, max, 0);
> >  }
> >  
> >  /* User partition selection unless one partition only is available */
> >  
> >  static int
> > -get_existing_partition(int warn, int max) {
> > +get_existing_partition(struct fdisk_context *cxt, int warn, int max) {
> >  	int pno = -1;
> >  	int i;
> >  
> > @@ -995,7 +928,7 @@ get_existing_partition(int warn, int max) {
> >  
> >  not_implemented:
> >  not_unique:
> > -	return get_partition(warn, max);
> > +	return get_partition(cxt, warn, max);
> >  }
> >  
> >  const char *
> > @@ -1031,18 +964,18 @@ toggle_active(int i) {
> >  }
> >  
> >  static void
> > -toggle_dos_compatibility_flag(void) {
> > +toggle_dos_compatibility_flag(struct fdisk_context *cxt) {
> >  	dos_compatible_flag = ~dos_compatible_flag;
> >  	if (dos_compatible_flag)
> >  		printf(_("DOS Compatibility flag is set (DEPRECATED!)\n"));
> >  	else
> >  		printf(_("DOS Compatibility flag is not set\n"));
> >  
> > -	update_sector_offset();
> > +	update_sector_offset(cxt);
> >  }
> >  
> >  static void
> > -delete_partition(int i)
> > +delete_partition(struct fdisk_context *cxt, int i)
> >  {
> >  	if (i < 0)
> >  		return;
> > @@ -1057,18 +990,18 @@ delete_partition(int i)
> >  	else if (disklabel == SUN_LABEL)
> >  		sun_delete_partition(i);
> >  	else if (disklabel == SGI_LABEL)
> > -		sgi_delete_partition(i);
> > +		sgi_delete_partition(cxt, i);
> >  
> >  	printf(_("Partition %d is deleted\n"), i + 1);
> >  }
> >  
> > -static void
> > -change_sysid(void) {
> > +static void change_sysid(struct fdisk_context *cxt)
> > +{
> >  	char *temp;
> >  	int i, sys, origsys;
> >  	struct partition *p;
> >  
> > -	i = get_existing_partition(0, partitions);
> > +	i = get_existing_partition(cxt, 0, partitions);
> >  
> >  	if (i == -1)
> >  		return;
> > @@ -1204,16 +1137,16 @@ static void check_consistency(struct partition *p, int partition) {
> >  }
> >  
> >  static void
> > -check_alignment(sector_t lba, int partition)
> > +check_alignment(struct fdisk_context *cxt, sector_t lba, int partition)
> >  {
> > -	if (!lba_is_aligned(lba))
> > +	if (!lba_is_aligned(cxt, lba))
> >  		printf(_("Partition %i does not start on physical sector boundary.\n"),
> >  			partition + 1);
> >  }
> >  
> >  static void
> >  list_disk_geometry(struct fdisk_context *cxt) {
> > -	unsigned long long bytes = total_number_of_sectors * sector_size;
> > +	unsigned long long bytes = total_number_of_sectors * cxt->sector_size;
> >  	long megabytes = bytes/1000000;
> >  
> >  	if (megabytes < 10000)
> > @@ -1229,16 +1162,16 @@ list_disk_geometry(struct fdisk_context *cxt) {
> >  	if (units_per_sector == 1)
> >  		printf(_(", total %llu sectors"), total_number_of_sectors);
> >  	printf("\n");
> > -	printf(_("Units = %s of %d * %d = %d bytes\n"),
> > +	printf(_("Units = %s of %d * %ld = %ld bytes\n"),
> >  	       str_units(PLURAL),
> > -	       units_per_sector, sector_size, units_per_sector * sector_size);
> > +	       units_per_sector, cxt->sector_size, units_per_sector * cxt->sector_size);
> >  
> > -	printf(_("Sector size (logical/physical): %u bytes / %lu bytes\n"),
> > -				sector_size, phy_sector_size);
> > +	printf(_("Sector size (logical/physical): %lu bytes / %lu bytes\n"),
> > +				cxt->sector_size, cxt->phy_sector_size);
> >  	printf(_("I/O size (minimum/optimal): %lu bytes / %lu bytes\n"),
> > -				min_io_size, io_size);
> > -	if (alignment_offset)
> > -		printf(_("Alignment offset: %lu bytes\n"), alignment_offset);
> > +				cxt->min_io_size, cxt->io_size);
> > +	if (cxt->alignment_offset)
> > +		printf(_("Alignment offset: %lu bytes\n"), cxt->alignment_offset);
> >  	if (disklabel == DOS_LABEL)
> >  		dos_print_mbr_id();
> >  	printf("\n");
> > @@ -1428,12 +1361,12 @@ list_table(struct fdisk_context *cxt, int xtra) {
> >  			unsigned int pblocks = psects;
> >  			unsigned int podd = 0;
> >  
> > -			if (sector_size < 1024) {
> > -				pblocks /= (1024 / sector_size);
> > -				podd = psects % (1024 / sector_size);
> > +			if (cxt->sector_size < 1024) {
> > +				pblocks /= (1024 / cxt->sector_size);
> > +				podd = psects % (1024 / cxt->sector_size);
> >  			}
> > -			if (sector_size > 1024)
> > -				pblocks *= (sector_size / 1024);
> > +			if (cxt->sector_size > 1024)
> > +				pblocks *= (cxt->sector_size / 1024);
> >                          printf(
> >  			    "%s  %c %11lu %11lu %11lu%c  %2x  %s\n",
> >  			partname(cxt->dev_path, i+1, w+2),
> > @@ -1447,7 +1380,7 @@ list_table(struct fdisk_context *cxt, int xtra) {
> >  /* type name */		(type = partition_type(p->sys_ind)) ?
> >  			type : _("Unknown"));
> >  			check_consistency(p, i);
> > -			check_alignment(get_partition_start(pe), i);
> > +			check_alignment(cxt, get_partition_start(pe), i);
> >  		}
> >  	}
> >  
> > @@ -1482,7 +1415,7 @@ x_list_table(struct fdisk_context *cxt, int extend) {
> >  				(unsigned long) get_nr_sects(p), p->sys_ind);
> >  			if (p->sys_ind) {
> >  				check_consistency(p, i);
> > -				check_alignment(get_partition_start(pe), i);
> > +				check_alignment(cxt, get_partition_start(pe), i);
> >  			}
> >  		}
> >  	}
> > @@ -1533,7 +1466,7 @@ check(int n, unsigned int h, unsigned int s, unsigned int c,
> >  }
> >  
> >  static void
> > -verify(void) {
> > +verify(struct fdisk_context *cxt) {
> >  	int i, j;
> >  	sector_t total = 1, n_sectors = total_number_of_sectors;
> >  	unsigned long long first[partitions], last[partitions];
> > @@ -1559,7 +1492,7 @@ verify(void) {
> >  		p = pe->part_table;
> >  		if (p->sys_ind && !IS_EXTENDED (p->sys_ind)) {
> >  			check_consistency(p, i);
> > -			check_alignment(get_partition_start(pe), i);
> > +			check_alignment(cxt, get_partition_start(pe), i);
> >  			if (get_partition_start(pe) < first[i])
> >  				printf(_("Warning: bad start-of-data in "
> >  					"partition %d\n"), i + 1);
> > @@ -1603,30 +1536,31 @@ verify(void) {
> >  		printf(_("Total allocated sectors %llu greater than the maximum"
> >  			" %llu\n"), total, n_sectors);
> >  	else if (total < n_sectors)
> > -		printf(_("Remaining %lld unallocated %d-byte sectors\n"),
> > -		       n_sectors - total, sector_size);
> > +		printf(_("Remaining %lld unallocated %ld-byte sectors\n"),
> > +		       n_sectors - total, cxt->sector_size);
> >  }
> >  
> > -void print_partition_size(int num, sector_t start, sector_t stop, int sysid)
> > +void print_partition_size(struct fdisk_context *cxt,
> > +			  int num, sector_t start, sector_t stop, int sysid)
> >  {
> >  	char *str = size_to_human_string(SIZE_SUFFIX_3LETTER | SIZE_SUFFIX_SPACE,
> > -				     (stop - start + 1) * sector_size);
> > +				     (stop - start + 1) * cxt->sector_size);
> >  	printf(_("Partition %d of type %s and of size %s is set\n"), num, partition_type(sysid), str);
> >  	free(str);
> >  }
> >  
> > -static void new_partition(void)
> > +static void new_partition(struct fdisk_context *cxt)
> >  {
> >  	if (warn_geometry())
> >  		return;
> >  
> >  	if (disklabel == SUN_LABEL) {
> > -		add_sun_partition(get_partition(0, partitions), LINUX_NATIVE);
> > +		add_sun_partition(cxt, get_partition(cxt, 0, partitions), LINUX_NATIVE);
> >  		return;
> >  	}
> >  
> >  	if (disklabel == SGI_LABEL) {
> > -		sgi_add_partition(get_partition(0, partitions), LINUX_NATIVE);
> > +		sgi_add_partition(cxt, get_partition(cxt, 0, partitions), LINUX_NATIVE);
> >  		return;
> >  	}
> >  
> > @@ -1649,7 +1583,7 @@ static void new_partition(void)
> >  	}
> >  
> >  	/* default to DOS/BSD */
> > -	dos_new_partition();
> > +	dos_new_partition(cxt);
> >  }
> >  
> >  static void
> > @@ -1719,10 +1653,10 @@ reread_partition_table(struct fdisk_context *cxt, int leave) {
> >  
> >  #define MAX_PER_LINE	16
> >  static void
> > -print_buffer(unsigned char pbuffer[]) {
> > +print_buffer(struct fdisk_context *cxt, unsigned char pbuffer[]) {
> 
> Take something like 'unsigned long buflen' instead of 'full' context?
> 
> >  	unsigned int i, l;
> >  
> > -	for (i = 0, l = 0; i < sector_size; i++, l++) {
> > +	for (i = 0, l = 0; i < cxt->sector_size; i++, l++) {
> >  		if (l == 0)
> >  			printf("0x%03X:", i);
> >  		printf(" %02X", pbuffer[i]);
> > @@ -1736,19 +1670,19 @@ print_buffer(unsigned char pbuffer[]) {
> >  	printf("\n");
> >  }
> >  
> > -static void
> > -print_raw(char *dev) {
> > +static void print_raw(struct fdisk_context *cxt)
> > +{
> >  	int i;
> >  
> > -	printf(_("Device: %s\n"), dev);
> > +	printf(_("Device: %s\n"), cxt->dev_path);
> >  	if (disklabel == SUN_LABEL || disklabel == SGI_LABEL)
> > -		print_buffer(MBRbuffer);
> > +		print_buffer(cxt, MBRbuffer);
> >  	else for (i = 3; i < partitions; i++)
> > -		print_buffer(ptes[i].sectorbuffer);
> > +		     print_buffer(cxt, ptes[i].sectorbuffer);
> >  }
> >  
> >  static void
> > -move_begin(int i) {
> > +move_begin(struct fdisk_context *cxt, int i) {
> >  	struct pte *pe = &ptes[i];
> >  	struct partition *p = pe->part_table;
> >  	unsigned int new, free_start, curr_start, last;
> > @@ -1785,7 +1719,7 @@ move_begin(int i) {
> >  
> >  	last = get_partition_start(pe) + get_nr_sects(p) - 1;
> >  
> > -	new = read_int(free_start, curr_start, last, free_start,
> > +	new = read_int(cxt, free_start, curr_start, last, free_start,
> >  		       _("New beginning of data")) - pe->offset;
> >  
> >  	if (new != get_nr_sects(p)) {
> > @@ -1814,27 +1748,27 @@ expert_command_prompt(struct fdisk_context *cxt)
> >  		switch (c) {
> >  		case 'a':
> >  			if (disklabel == SUN_LABEL)
> > -				sun_set_alt_cyl();
> > +				sun_set_alt_cyl(cxt);
> >  			break;
> >  		case 'b':
> >  			if (disklabel == DOS_LABEL)
> > -				move_begin(get_partition(0, partitions));
> > +				move_begin(cxt, get_partition(cxt, 0, partitions));
> >  			break;
> >  		case 'c':
> >  			user_cylinders = cylinders =
> > -				read_int(1, cylinders, 1048576, 0,
> > +				read_int(cxt, 1, cylinders, 1048576, 0,
> >  					 _("Number of cylinders"));
> >  			if (disklabel == SUN_LABEL)
> >  				sun_set_ncyl(cylinders);
> >  			break;
> >  		case 'd':
> > -			print_raw(cxt->dev_path);
> > +			print_raw(cxt);
> >  			break;
> >  		case 'e':
> >  			if (disklabel == SGI_LABEL)
> >  				sgi_set_xcyl();
> >  			else if (disklabel == SUN_LABEL)
> > -				sun_set_xcyl();
> > +				sun_set_xcyl(cxt);
> >  			else
> >  			if (disklabel == DOS_LABEL)
> >  				x_list_table(cxt, 1);
> > @@ -1847,19 +1781,19 @@ expert_command_prompt(struct fdisk_context *cxt)
> >  			create_sgilabel(cxt);
> >  			break;
> >  		case 'h':
> > -			user_heads = heads = read_int(1, heads, 256, 0,
> > +			user_heads = heads = read_int(cxt, 1, heads, 256, 0,
> >  					 _("Number of heads"));
> >  			update_units();
> >  			break;
> >  		case 'i':
> >  			if (disklabel == SUN_LABEL)
> > -				sun_set_ilfact();
> > +				sun_set_ilfact(cxt);
> >  			else if (disklabel == DOS_LABEL)
> >  				dos_set_mbr_id();
> >  			break;
> >  		case 'o':
> >  			if (disklabel == SUN_LABEL)
> > -				sun_set_rspeed();
> > +				sun_set_rspeed(cxt);
> >  			break;
> >  		case 'p':
> >  			if (disklabel == SUN_LABEL)
> > @@ -1872,24 +1806,24 @@ expert_command_prompt(struct fdisk_context *cxt)
> >  		case 'r':
> >  			return;
> >  		case 's':
> > -			user_sectors = sectors = read_int(1, sectors, 63, 0,
> > +			user_sectors = sectors = read_int(cxt, 1, sectors, 63, 0,
> >  					   _("Number of sectors"));
> >  			if (dos_compatible_flag)
> >  				fprintf(stderr, _("Warning: setting "
> >  					"sector offset for DOS "
> >  					"compatiblity\n"));
> > -			update_sector_offset();
> > +			update_sector_offset(cxt);
> >  			update_units();
> >  			break;
> >  		case 'v':
> > -			verify();
> > +			verify(cxt);
> >  			break;
> >  		case 'w':
> >  			write_table(cxt);
> >  			break;
> >  		case 'y':
> >  			if (disklabel == SUN_LABEL)
> > -				sun_set_pcylcount();
> > +				sun_set_pcylcount(cxt);
> >  			break;
> >  		default:
> >  			print_menu(EXPERT_MENU);
> > @@ -1918,15 +1852,15 @@ gpt_warning(char *dev)
> >  }
> >  
> >  /* Print disk geometry and partition table of a specified device (-l option) */
> > -
> > -static void
> > -print_partition_table_from_option(char *device)
> > +static void print_partition_table_from_option(char *device, unsigned long sector_size)
> >  {
> >  	int gb;
> >  
> >  	struct fdisk_context *cxt = fdisk_new_context_from_filename(device, 1);	/* read-only */
> >  	if (!cxt)
> >  		err(EXIT_FAILURE, _("unable to open %s"), device);
> > +	if (sector_size)  /* passed -b option, override autodiscovery */
> > +		cxt->phy_sector_size = cxt->sector_size = sector_size;
> 
> Perhaps this user-provided sector_size together with a bit-flag
> denoting that the user wants to override the sector_size should be
> made part of the context? But that'd be material for separate patch,
> IMHO.
> 

Well for now this seemed like the saner way of proceeding, but yes, I'm
definitely up for debating as I don't like the idea of overwriting the
discovery. Perhaps an extra parameter in the initialization context for
flags. IIRC there are other similar issues that we'll have to deal with
soon - like user passed CHS.


> [SNIP]
>  
> >  int fdisk_debug_mask;
> >  
> > +static unsigned long __get_sector_size(int fd)
> > +{
> > +	unsigned int sect_sz;
> 
> This introduces type mismatch - should be just int.
> 
ah yes, BLKSSZGET wants an int.
> > +
> > +	if (!blkdev_get_sector_size(fd, &sect_sz))
> > +		return (unsigned long) sect_sz;
> > +	return DEFAULT_SECTOR_SIZE;
> > +}
> 
> 

Thanks for reviewing,
Davidlohr

> Petr
> 


