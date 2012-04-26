Return-Path: util-linux-owner@vger.kernel.org
Received: from damascus.uab.es ([158.109.168.135]:58128 "EHLO damascus.uab.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752418Ab2DZOLH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Apr 2012 10:11:07 -0400
Received: from damascus.uab.es ([127.0.0.1])
 by damascus.uab.es (Sun Java System Messaging Server 6.1 HotFix 0.10 (built
 Jan  6 2005)) with ESMTP id <0M33003N6BEH9IC0@damascus.uab.es> for
 util-linux@vger.kernel.org; Thu, 26 Apr 2012 16:11:05 +0200 (CEST)
Received: from aomail.uab.es ([158.109.65.1])
 by damascus.uab.es (Sun Java	System Messaging Server 6.1 HotFix 0.10 (builtJan
 6 2005)) with ESMTP id	<0M3300FNCBEHAQ20@damascus.uab.es>
 forutil-linux@vger.kernel.org; Thu, 26 Apr 2012 16:11:05 +0200 (CEST)
Date: Thu, 26 Apr 2012 16:11:16 +0200
From: Davidlohr Bueso <dave@gnu.org>
Subject: Re: [RFC] fdisk API
In-reply-to: <20120426134938.GM8159@foxbat.suse.cz>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Message-id: <1335449476.28151.21.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
References: <1335444485.28151.15.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, 2012-04-26 at 15:49 +0200, Petr Uzel wrote:
> On Thu, Apr 26, 2012 at 02:48:05PM +0200, Davidlohr Bueso wrote:
> > Hi,
> 
> Hi Dave,
> 
> > The following structures are meant to represent and describe a single
> > device and the interactions that disk partitioners require. I would like
> > to know your opinion as we intend on gradually start adapting current
> > fdisk code around them.
> > 
> > It's important to mention that since flexibility is crucial, these are
> > opaque types and therefore all fields will be accessed through
> > interfaces -- same as libblkid. 
> > 
> > The functions themselves to use, populate/free these structures are
> > currently being worked on, and without wanting to overdesign things, it
> > will probably come in through patches. Again, I think we all want to
> > keep things simple.
> > 
> > Thanks,
> > Dave
> > 
> > -----
> > 
> > typedef unsigned long long sector_t;
> > 
> > enum fdisk_partition_type {
> > 	PARTITION_NORMAL            = 0x00,
> > 	PARTITION_LOGICAL           = 0x01,
> > 	PARTITION_EXTENDED          = 0x02,
> > };
> 
> This applies only for msdos label. With GPT (and other pt labels we
> might eventually want to support), there is nothing like
> extended or logical. E.g. parted maintains list of valid partition
> types per label.
> 
> > struct fdisk_sys_type {
> >  ... <--- copy/simplify struct systypes i386_sys_types[]
> > };
> 
> This is not applicable for GPT. What about adding something like
> 'void *label_data' to fdisk_partition to support these per-PT label data?

Makes sense. Consider as well that if it's not applicable to GPT it
might be an exception, since all other labels *do* require it.

> 
> I'm also missing a structure to describe a label as a whole, not only
> the individual partition entries.

Well, these structures are internal to each label and wasn't planning on
touching them. I only planned on having existing code fill
fdisk_operations and call that instead of always checking label type. If
(disklabel == DOS) add_dos_partition().

> > 
> > struct fdisk_partition {
> > 	/* LBA geometry */
> > 	sector_t p_start;
> > 	sector_t p_end;
> > 	sector_t p_len;
> > 
> > 	int p_num;                        /* partition number */
> > 	enum fdisk_partition_type p_type; /* partition type */
> > 	struct fdisk_sys_type p_systype;  /* bsd, minix, swap, etc */
> > 	unsigned char p_is_boot;          /* active/bootable */
> 
> Boot flag is also label specific.
> 
> > 
> > 	struct list_head p_list;          /* maintain dlist */
> > };
> > 
> > /*
> >  * All funtions return 0 on success and negative otherwise
> >  */
> > struct fdisk_operations {
> > 	int (*add_partition)(struct fdisk_partition *new);
> > 	int (*del_partition)(int partnum);
> > 	int (*new_label)(void);
> > 	int (*probe_label)(void);
> > };
> 
> Apart from add_partition, these prototypes do not allow any control over
> the operation. Also, shouldn't the functions take a pointer to struct
> fdisk_device ?

Well, this also goes for leaving current label code alone. If you see
fdisklabel.c, for example, it already controls its own label-specific
operations.

> 
> [Not a big deal for now since these functions are not supposed to be
> part of any future API, right?]

Although true, I'd like to get it right now and not have to rethink it
alter when implementing the API perse.

> > 
> > struct fdisk_topology {
> > 	 nsectors;
> > 	sector_t t_lsector_size; /* logical */
> > 	sector_t t_psector_size; /* physical */
> > 	sector_t t_length;       /* size in bytes */
> > 	sector_t t_min_io_size;
> > 	sector_t t_io_size;      /* optimal */
> > };
> 
> Having both nsectors and t_length is superfluous (with
> t_lsector_size). Does it have any advantage to have both?

IIRC when looking at the code, nsectors can obtained through ioctl. In
any case I'm planning on using blkid for most of the topology stuff.

> 
> > /* 
> >  * Legacy CHS (cylinder-head-sector) based geometry
> >  * can this layout be used for LBA addressing?
> >  */
> > struct fdisk_geometry {
> > 	unsigned int heads;
> > 	unsigned int sectors;
> > 	unsigned int cylinders;
> > };
> > 
> > struct fdisk_disk {
> > 	const char *d_name; /* pt type, ie: bsd, dos */
> > 	struct fdisk_operations *d_ops;
> > 	struct fdisk_partition *d_partitions;
> > 
> > };
> > 
> > /* 
> >  * Represent a single device to be handled (ie: /dev/sda)
> >  */
> > struct fdisk_device {
> > 	int dev_fd;                    /* device descriptor */  
> > 	char *dev_path;                /* device name/path */
> > 	struct stat dev_sb;         
> > 	struct fdisk_disk *d_disk;
> > 	struct fdisk_topology *d_topo;
> > 	struct fdisk_geometry *d_kgeo; /* kernel/bios geometry */
> > };
> > 
> 
> Petr
> 

Thanks for reviewing,
Davidlohr


