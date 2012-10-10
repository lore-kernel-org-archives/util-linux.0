Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdccah.dreamhost.com ([208.97.132.207]:37292 "EHLO
	homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755006Ab2JJKPA (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Oct 2012 06:15:00 -0400
Message-ID: <1349864096.2576.16.camel@offbook>
Subject: Re: [PATCH 3/5] fdisk: gpt: create empty disklabels
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Date: Wed, 10 Oct 2012 12:14:56 +0200
In-Reply-To: <20121010093959.GB11072@foxbat.suse.cz>
References: <1349620433.2548.8.camel@offbook>
	 <20121010093959.GB11072@foxbat.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, 2012-10-10 at 11:40 +0200, Petr Uzel wrote:
> On Sun, Oct 07, 2012 at 04:33:53PM +0200, Davidlohr Bueso wrote:
> > This patch enables creating a new, empty, GPT disklabel from either
> > an empty disk or one that already has a disklabel. For this
> > purpose, a 'g' option is added to the main menu and is visible to all
> > labels. Here's an example for a scsi_debug device (/dev/sdb):
> > 
> [SNIP]
> > ---
> >  fdisks/fdisk.c |    4 ++
> >  fdisks/gpt.c   |  211 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 204 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
> > index 1295d54..612bf87 100644
> > --- a/fdisks/fdisk.c
> > +++ b/fdisks/fdisk.c
> > @@ -90,6 +90,7 @@ static const struct menulist_descr menulist[] = {
> >  	{'e', N_("edit drive data"), {OSF_LABEL, 0}},
> >  	{'f', N_("fix partition order"), {0, DOS_LABEL}},
> >  	{'g', N_("create an IRIX (SGI) partition table"), {0, ANY_LABEL}},
> > +	{'g', N_("create a new empty GPT partition table"), {ANY_LABEL, 0}},
> >  	{'h', N_("change number of heads"), {0, DOS_LABEL | SUN_LABEL}},
> >  	{'i', N_("change interleave factor"), {0, SUN_LABEL}},
> >  	{'i', N_("change the disk identifier"), {0, DOS_LABEL}},
> > @@ -1693,6 +1694,9 @@ static void command_prompt(struct fdisk_context *cxt)
> >  		case 'd':
> >  			delete_partition(cxt, get_existing_partition(cxt, 1, partitions));
> >  			break;
> > +		case 'g':
> > +			fdisk_create_disklabel(cxt, "gpt");
> > +			break;
> >  		case 'i':
> >  			if (disklabel == SGI_LABEL)
> >  				create_sgiinfo(cxt);
> [SNIP]
> > +
> > +/* some universal differences between the headers */
> > +static void gpt_mknew_header_common(struct fdisk_context *cxt,
> > +				    struct gpt_header *header, uint64_t lba)
> > +{
> > +	if (!cxt || !header)
> > +		return;
> > +
> > +	header->my_lba = cpu_to_le32(lba);

Yes, my_lba is a 64bit variable.

> 
> This should be cpu_to_le64(lba);
> 
> > +
> > +	if (lba == GPT_PRIMARY_PARTITION_TABLE_LBA) { /* primary */
> > +		header->alternative_lba = cpu_to_le64(cxt->total_sectors - 1);
> > +		header->partition_entry_lba = cpu_to_le64(2);
> > +	} else { /* backup */
> > +		header->alternative_lba = cpu_to_le64(GPT_PRIMARY_PARTITION_TABLE_LBA);
> > +		header->partition_entry_lba = header->last_usable_lba + cpu_to_le64(1);
> 
> Shouldn't this ^^^ rather be:
> 
> 		header->partition_entry_lba = cpu_to_le64(header->last_usable_lba + 1);
> 
> ?
> 
> Even with this modification, I'm still not sure if the computation is
> correct. Are you sure that partition_entry_lba (in alternative header)
> should be set to this value?

Well the UEFI specs sure don't make this very clear. It's obvious that
for the primary header we want it to be LBA 2. Now, from this diagram
http://en.wikipedia.org/w/index.php?title=File:GUID_Partition_Table_Scheme.svg&page=1
I interpret it for the backup to be the last usable lba + 1.

In any case ->last_usable_lba needs to be set before calling
gpt_mknew_header_common(), so this function needs be called last, and
therefore I need to change the order in gpt_mknew_header().

> 
> > +	}
> > +}
> > +
> > +/*
> > + * Builds a new GPT header (at sector lba) from a backup header2.
> > + * If building a primary header, then backup is the secondary, and vice versa.
> > + *
> > + * Always pass a new (zeroized) header to build upon as we don't
> > + * explicitly zero-set some values such as CRCs and reserved.
> 
> Why is this? Why not zeroize the to-be-built header in this function?

Well since we always allocate memory with calloc, we're always zeroising
anyway.

> 
> > + *
> > + * Returns 0 on success, otherwise < 0 on error.
> > + */
> > +static int gpt_mknew_header_from_bkp(struct fdisk_context *cxt,
> > +				     struct gpt_header *header,
> > +				     uint64_t lba,
> > +				     struct gpt_header *header2)
> > +{
> > +	if (!cxt || !header || !header2)
> > +		return -ENOSYS;
> 
> Perhaps -EINVAL would be better if the arguments passed to the
> function are invalid?
> 
> > +
> > +	header->signature              = header2->signature;
> > +	header->revision               = header2->revision;
> > +	header->size                   = header2->size;
> > +	header->npartition_entries     = header2->npartition_entries;
> > +	header->sizeof_partition_entry = header2->sizeof_partition_entry;
> > +	header->first_usable_lba       = header2->first_usable_lba;
> > +	header->last_usable_lba        = header2->last_usable_lba;
> > +
> > +	memcpy(&header->disk_guid,
> > +	       &header2->disk_guid, sizeof(header2->disk_guid));
> > +	gpt_mknew_header_common(cxt, header, lba);
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Builds a clean new GPT header (currently under revision 1.0).
> > + *
> > + * Always pass a new (zeroized) header to build upon as we don't
> > + * explicitly zero-set some values such as CRCs and reserved.
> 
> Again; Why?
> 
> > + *
> > + * Returns 0 on success, otherwise < 0 on error.
> > + */
> > +static int gpt_mknew_header(struct fdisk_context *cxt,
> > +			    struct gpt_header *header, uint64_t lba)
> > +{
> > +	if (!cxt || !header)
> > +		return -ENOSYS;
> 
> -EINVAL ?
> 
> > +
> > +	gpt_mknew_header_common(cxt, header, lba);
> > +
> > +	header->signature = cpu_to_le64(GPT_HEADER_SIGNATURE);
> > +	header->revision  = cpu_to_le32(GPT_HEADER_REVISION_V1_00);
> > +	header->size      = cpu_to_le32(sizeof(struct gpt_header));
> > +
> > +	/*
> > +	 * 128 partitions is the default. It can go behond this, however,
> > +	 * we're creating a de facto header here, so no funny business.
> > +	 */
> > +	header->npartition_entries     = cpu_to_le32(128);
> > +	header->sizeof_partition_entry = cpu_to_le32(sizeof(struct gpt_entry));
> > +
> > +	header->first_usable_lba =
> > +		(header->sizeof_partition_entry * header->npartition_entries /
> > +		 cpu_to_le64(cxt->sector_size)) + cpu_to_le64(2);
> > +	header->last_usable_lba =
> > +		cpu_to_le64(cxt->total_sectors) -  header->first_usable_lba;
> > +
> > +	uuid_generate_random((unsigned char *) &header->disk_guid);
> > +	swap_efi_guid(&header->disk_guid);
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> >   * Checks if there is a valid protective MBR partition table.
> >   * Returns 0 if it is invalid or failure. Otherwise, return
> >   * GPT_MBR_PROTECTIVE or GPT_MBR_HYBRID, depeding on the detection.
> > @@ -849,6 +966,22 @@ static void gpt_init(void)
> >  	partitions = le32_to_cpu(pheader->npartition_entries);
> >  }
> >  
> > +/*
> > + * Deinitialize fdisk-specific variables
> > + */
> > +static void gpt_deinit(void)
> > +{
> > +	free(ents);
> > +	free(pheader);
> > +	free(bheader);
> > +	ents = NULL;
> > +	pheader = NULL;
> > +	bheader = NULL;
> > +
> > +	disklabel = ANY_LABEL;
> > +	partitions = 0;
> > +}
> > +
> >  static int gpt_probe_label(struct fdisk_context *cxt)
> >  {
> >  	int mbr_type;
> > @@ -1005,7 +1138,7 @@ fail:
> >   * Returns 0 on success, or corresponding error otherwise.
> >   */
> >  static int gpt_write_header(struct fdisk_context *cxt,
> > -			    struct gpt_header *header, uint64_t lba)
> > +		     struct gpt_header *header, uint64_t lba)
> >  {
> >  	off_t offset = lba * cxt->sector_size;
> >  
> > @@ -1056,8 +1189,10 @@ static int gpt_write_pmbr(struct fdisk_context *cxt)
> >  	offset = GPT_PMBR_LBA * cxt->sector_size;
> >  	if (offset != lseek(cxt->dev_fd, offset, SEEK_SET))
> >  		goto fail;
> > -
> > -	if (1 == write(cxt->dev_fd, pmbr, 1))
> > +	
> > +	/* pMBR covers the first sector (LBA) of the disk */
> > +	if (cxt->sector_size == 
> > +	    (unsigned long) write(cxt->dev_fd, pmbr, cxt->sector_size))
> >  		return 0;
> 
> Why not use write_all() from all-io.h ?

I don't really care, calling write directly is fine with me.

I'll send a v2 with the corrections. Thanks for reviewing!

Davidlohr

> 
> >  fail:
> >  	return -errno;
> > @@ -1318,7 +1453,7 @@ static int gpt_create_new_partition(int partnum, uint64_t fsect, uint64_t lsect,
> >  
> >  /* Performs logical checks to add a new partition entry */
> >  static void gpt_add_partition(struct fdisk_context *cxt, int partnum,
> > -			     struct fdisk_parttype *t)
> > +			      struct fdisk_parttype *t)
> >  {
> >  	char msg[256];
> >  	uint32_t tmp;
> > @@ -1370,6 +1505,60 @@ static void gpt_add_partition(struct fdisk_context *cxt, int partnum,
> >  		printf(_("Created partition %d\n"), partnum + 1);
> >  }
> >  
> [SNIP]
> 
> Petr
> 


