Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:58146 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753919AbdDER6K (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 5 Apr 2017 13:58:10 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] libfdisk: fix gpt for 32bit systems
Date: Wed, 5 Apr 2017 19:58:00 +0200
Cc: util-linux@vger.kernel.org
References: <1491386189-8163-1-git-send-email-sweet_f_a@gmx.de> <201704051314.07435.sweet_f_a@gmx.de> <20170405165022.fniqgeng46ec4auf@ws.net.home>
In-Reply-To: <20170405165022.fniqgeng46ec4auf@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201704051958.00857.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 05 April 2017, Karel Zak wrote:
> On Wed, Apr 05, 2017 at 01:14:07PM +0200, Ruediger Meier wrote:
> > On Wednesday 05 April 2017, Karel Zak wrote:
> > > On Wed, Apr 05, 2017 at 11:56:29AM +0200, Ruediger Meier wrote:
> > > > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> > > >
> > > > test libfdisk/gpt failed since bb676203 because UINT32_MAX does
> > > > not fit into ssize_t on 32bit systems.
> > > >
> > > > This patch rewrites parts of commit f71b96bf. Also handling
> > > > multiplication overflow and some typos. Note that it still
> > > > looks questionable that we would try to read() SSIZE_MAX bytes
> > > > in gpt_read_entries().
> > >
> > > Maybe it would be better to have
> > >
> > >   #define FDISK_GPT_NENTRIES_MAX  (SIZE_MAX/sizeof(struct
> > > gpt_entry))
> >
> > Yes, I was not sure whether f71b96bf really cares for UINT32_MAX or
> > if SIZE_MAX... would be good enough as the only limit.
>
> I did more changes to the code to consolidate all the work with
> ents[].
>
> 
> https://github.com/karelzak/util-linux/commit/b28df75eece3b65b79b2e56
>f1c197c2f128ac3d9
> https://github.com/karelzak/util-linux/commit/b683c081085381401f1f777
>d076d073759cdb964
> https://github.com/karelzak/util-linux/commit/9e320545bb6186b14aa9339
>cdcb83cfce1d9221b
>
> The limit is calculated by the patch below (the last patch). Not sure
> if it's paranoid enough ;-)

Thanks, It fixes the original "(ssize_t)UINT32_MAX" bug on my test 
systems.

I have one "paranoid" comment below.

>
>
>
> From 9e320545bb6186b14aa9339cdcb83cfce1d9221b Mon Sep 17 00:00:00
> 2001 From: Karel Zak <kzak@redhat.com>
> Date: Wed, 5 Apr 2017 18:40:56 +0200
> Subject: [PATCH] libfdisk: (gpt) make entries array size calculation
> more robust
>
> * use the same function everywhere
> * keep calculation based on size_t
>
> Signed-off-by: Karel Zak <kzak@redhat.com>
> ---
>  libfdisk/src/gpt.c | 81
> ++++++++++++++++++++++++++++++++++-------------------- 1 file
> changed, 51 insertions(+), 30 deletions(-)
>
> diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
> index 09c90a4..047ba59 100644
> --- a/libfdisk/src/gpt.c
> +++ b/libfdisk/src/gpt.c
> @@ -453,6 +453,24 @@ static inline size_t gpt_get_nentries(struct
> fdisk_gpt_label *gpt) return (size_t)
> le32_to_cpu(gpt->pheader->npartition_entries); }
>
> +static inline int gpt_calculate_sizeof_ents(struct gpt_header *hdr,
> uint32_t nents, size_t *sz) +{
> +	uint32_t esz = le32_to_cpu(hdr->sizeof_partition_entry);
> +
> +	if (nents == 0 || esz == 0 || SIZE_MAX/esz < nents) {
> +		DBG(LABEL, ul_debug("GPT entreis array size check failed"));
> +		return -ERANGE;
> +	}
> +
> +	*sz = nents * esz;
> +	return 0;
> +}
> +
> +static inline int gpt_sizeof_ents(struct gpt_header *hdr, size_t
> *sz) +{
> +	return gpt_calculate_sizeof_ents(hdr,
> le32_to_cpu(hdr->npartition_entries), sz); +}
> +
>  static inline int partition_unused(const struct gpt_entry *e)
>  {
>  	return !memcmp(&e->type, &GPT_UNUSED_ENTRY_GUID,
> @@ -468,7 +486,6 @@ static char *gpt_get_header_id(struct gpt_header
> *header) return strdup(str);
>  }
>
> -
>  /*
>   * Builds a clean new valid protective MBR - will wipe out any
> existing data. * Returns 0 on success, otherwise < 0 on error.
> @@ -845,31 +862,30 @@ static ssize_t read_lba(struct fdisk_context
> *cxt, uint64_t lba, static unsigned char *gpt_read_entries(struct
> fdisk_context *cxt, struct gpt_header *header)
>  {
> -	ssize_t sz;
> +	size_t sz;
> +	ssize_t ssz;
> +
>  	unsigned char *ret = NULL;
>  	off_t offset;
>
>  	assert(cxt);
>  	assert(header);
>
> -	sz = (ssize_t) le32_to_cpu(header->npartition_entries) *
> -	     le32_to_cpu(header->sizeof_partition_entry);
> -
> -	if (sz == 0 || sz >= (ssize_t) UINT32_MAX ||
> -	    le32_to_cpu(header->sizeof_partition_entry) != sizeof(struct
> gpt_entry)) { -		DBG(LABEL, ul_debug("GPT entreis array size check
> failed"));
> +	if (gpt_sizeof_ents(header, &sz)) 
>  		return NULL;
> -	}
>
>  	ret = calloc(1, sz);
>  	if (!ret)
>  		return NULL;
> +
>  	offset = (off_t) le64_to_cpu(header->partition_entry_lba) *
>  		       cxt->sector_size;
>
>  	if (offset != lseek(cxt->dev_fd, offset, SEEK_SET))
>  		goto fail;
> -	if (sz != read(cxt->dev_fd, ret, sz))
> +
> +	ssz = read(cxt->dev_fd, ret, sz);

The read(2) Linux manpage says: "If count is greater than SSIZE_MAX 
(signed!), the result is unspecified."

So maybe we should limit gpt_sizeof_ents() regarding SSIZE_MAX rather 
than SIZE_MAX. I guess that even smwaller sizes would not be possible 
to load into memory.

I'm also not sure that such big-reads (without using read() in a loop) 
are portable at all.


> +	if (ssz < 0 || (size_t) ssz != sz)
>  		goto fail;
>
>  	return ret;
> @@ -897,8 +913,8 @@ static inline uint32_t
> gpt_entryarr_count_crc32(struct gpt_header *header, unsig {
>  	size_t arysz = 0;
>
> -	arysz = (size_t) le32_to_cpu(header->npartition_entries) *
> -		le32_to_cpu(header->sizeof_partition_entry);
> +	if (gpt_sizeof_ents(header, &arysz))
> +		return 0;
>
>  	return count_crc32(ents, arysz, 0, 0);
>  }
> @@ -1093,9 +1109,7 @@ static int gpt_locate_disklabel(struct
> fdisk_context *cxt, int n, gpt = self_label(cxt);
>  		*offset = (uint64_t)
> le64_to_cpu(gpt->pheader->partition_entry_lba) * cxt->sector_size;
> -		*size = gpt_get_nentries(gpt) *
> -				le32_to_cpu(gpt->pheader->sizeof_partition_entry);
> -		break;
> +		return gpt_sizeof_ents(gpt->pheader, size);
>  	default:
>  		return 1;			/* no more chunks */
>  	}
> @@ -1847,18 +1861,22 @@ static int gpt_write_partitions(struct
> fdisk_context *cxt, struct gpt_header *header, unsigned char *ents)
>  {
>  	off_t offset = (off_t) le64_to_cpu(header->partition_entry_lba) *
> cxt->sector_size; -	uint32_t nparts =
> le32_to_cpu(header->npartition_entries); -	uint32_t totwrite = nparts
> * le32_to_cpu(header->sizeof_partition_entry); -	ssize_t rc;
> +	size_t towrite;
> +	ssize_t ssz;
> +	int rc;
> +
> +	rc = gpt_sizeof_ents(header, &towrite);
> +	if (rc)
> +		return rc;
>
>  	if (offset != lseek(cxt->dev_fd, offset, SEEK_SET))
> -		goto fail;
> +		return -errno;
>
> -	rc = write(cxt->dev_fd, ents, totwrite);
> -	if (rc > 0 && totwrite == (uint32_t) rc)
> -		return 0;
> -fail:
> -	return -errno;
> +	ssz = write(cxt->dev_fd, ents, towrite);
> +	if (ssz < 0 || (ssize_t) towrite != ssz)
> +		return -errno;
> +
> +	return 0;
>  }
>
>  /*
> @@ -2471,8 +2489,9 @@ static int gpt_create_disklabel(struct
> fdisk_context *cxt) if (rc < 0)
>  		goto done;
>
> -	esz = (size_t) le32_to_cpu(gpt->pheader->npartition_entries) *
> -	      le32_to_cpu(gpt->pheader->sizeof_partition_entry);
> +	rc = gpt_sizeof_ents(gpt->pheader, &esz);
> +	if (rc)
> +		goto done;
>  	gpt->ents = calloc(1, esz);
>  	if (!gpt->ents) {
>  		rc = -ENOMEM;
> @@ -2602,14 +2621,16 @@ int fdisk_gpt_set_npartitions(struct
> fdisk_context *cxt, uint32_t entries) return 0;	/* do nothing, say
> nothing */
>
>  	/* calculate the size (bytes) of the entries array */
> -	new_size = entries *
> le32_to_cpu(gpt->pheader->sizeof_partition_entry); -	if (new_size >=
> UINT32_MAX) {
> +	rc = gpt_calculate_sizeof_ents(gpt->pheader, entries, &new_size);
> +	if (rc) {
>  		fdisk_warnx(cxt, _("The number of the partition has be smaller
> than %zu."), UINT32_MAX /
> le32_to_cpu(gpt->pheader->sizeof_partition_entry)); -		return
> -EINVAL;
> +		return rc;
>  	}
>
> -	old_size = old * le32_to_cpu(gpt->pheader->sizeof_partition_entry);
> +	rc = gpt_calculate_sizeof_ents(gpt->pheader, old, &old_size);
> +	if (rc)
> +		return rc;
>
>  	/* calculate new range of usable LBAs */
>  	first_usable = (uint64_t) (new_size / cxt->sector_size) + 2ULL;


