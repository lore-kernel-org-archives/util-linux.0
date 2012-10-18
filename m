Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51412 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755115Ab2JRKLl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Oct 2012 06:11:41 -0400
Date: Thu, 18 Oct 2012 12:11:36 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/5] fdisk: gpt: create empty disklabels
Message-ID: <20121018101136.GA10096@x2.net.home>
References: <1349620433.2548.8.camel@offbook>
 <20121010093959.GB11072@foxbat.suse.cz>
 <1349864096.2576.16.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349864096.2576.16.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 10, 2012 at 12:14:56PM +0200, Davidlohr Bueso wrote:
> On Wed, 2012-10-10 at 11:40 +0200, Petr Uzel wrote:
> > On Sun, Oct 07, 2012 at 04:33:53PM +0200, Davidlohr Bueso wrote:
> > > +
> > > +	if (lba == GPT_PRIMARY_PARTITION_TABLE_LBA) { /* primary */
> > > +		header->alternative_lba = cpu_to_le64(cxt->total_sectors - 1);
> > > +		header->partition_entry_lba = cpu_to_le64(2);
> > > +	} else { /* backup */
> > > +		header->alternative_lba = cpu_to_le64(GPT_PRIMARY_PARTITION_TABLE_LBA);
> > > +		header->partition_entry_lba = header->last_usable_lba + cpu_to_le64(1);
> > 
> > Shouldn't this ^^^ rather be:
> > 
> > 		header->partition_entry_lba = cpu_to_le64(header->last_usable_lba + 1);

 Both is incorrect from my point of view. The range <first..last> usable
 LBA defines data area, nothing other. We should not use these numbers
 to count location of the header (or partition entry array).

 I can imagine device where data area will be smaller and behind the
 area will be hidden "gray zone" for example with truecrypt data...

 The primary header is at the begin of the device, backup header is
 at the end of the device. So, let's use cxt->total_sectors.

   esz = le32_to_cpu(h->npartition_entries) * sizeof(struct gpt_entry);
   h->partition_entry_lba = cpu_to_le64(cxt->total_sectors - 1 - esz)

..anyway, see parted/libparted/labels/gpt.c: _generate_header

> > Even with this modification, I'm still not sure if the computation is
> > correct. Are you sure that partition_entry_lba (in alternative header)
> > should be set to this value?
> 
> Well the UEFI specs sure don't make this very clear. It's obvious that
> for the primary header we want it to be LBA 2. Now, from this diagram
> http://en.wikipedia.org/w/index.php?title=File:GUID_Partition_Table_Scheme.svg&page=1
> I interpret it for the backup to be the last usable lba + 1.

 The diagram uses "-1" or "-2" LBA, it means from end of the device.

> In any case ->last_usable_lba needs to be set before calling

 Please, use last_usable_lba *only* to check validity of the entries in
 partition entry array. The partition start and end has to be within
 fist and last usable LBA. That's all.

 [...]

> > > +	/*
> > > +	 * 128 partitions is the default. It can go behond this, however,
> > > +	 * we're creating a de facto header here, so no funny business.
> > > +	 */
> > > +	header->npartition_entries     = cpu_to_le32(128);
> > > +	header->sizeof_partition_entry = cpu_to_le32(sizeof(struct gpt_entry));
> > > +
> > > +	header->first_usable_lba =
> > > +		(header->sizeof_partition_entry * header->npartition_entries /
> > > +		 cpu_to_le64(cxt->sector_size)) + cpu_to_le64(2);
> > > +	header->last_usable_lba =
> > > +		cpu_to_le64(cxt->total_sectors) -  header->first_usable_lba;


 I'm always somehow nervous when I see code where we use in math
 non-native byte order. It would be more robust and readable to have

    cpu_to_le64(a + b + c) rather than  cpu_to_le64(a) + b + c;

 :-)

 #define GPT_NPARTITIONS    128

 uint64_t esz = sizeof(struct gpt_entry) * GPT_NPARTITIONS / cxt->sector_size;

 header->npartition_entries     = cpu_to_le32(GPT_NPARTITIONS);
 header->sizeof_partition_entry = cpu_to_le32(sizeof(struct gpt_entry))
 header->first_usable_lba       = cpu_to_le64(2 + esz);
 header->last_usable_lba        = cpu_to_le64(cxt->total_sectors - 2 - esz);


> > > -	if (1 == write(cxt->dev_fd, pmbr, 1))
> > > +	
> > > +	/* pMBR covers the first sector (LBA) of the disk */
> > > +	if (cxt->sector_size == 
> > > +	    (unsigned long) write(cxt->dev_fd, pmbr, cxt->sector_size))
> > >  		return 0;
> > 
> > Why not use write_all() from all-io.h ?

+1

> 
> I don't really care, calling write directly is fine with me.
> 
> I'll send a v2 with the corrections. Thanks for reviewing!

 Please, send v2.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
