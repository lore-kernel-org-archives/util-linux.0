Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52843 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757453Ab2D0JtF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Apr 2012 05:49:05 -0400
Date: Fri, 27 Apr 2012 11:48:36 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [RFC] fdisk API
Message-ID: <20120427094836.GA6020@x2.net.home>
References: <1335444485.28151.15.camel@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335444485.28151.15.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 26, 2012 at 02:48:05PM +0200, Davidlohr Bueso wrote:
> typedef unsigned long long sector_t;
> 
> enum fdisk_partition_type {
> 	PARTITION_NORMAL            = 0x00,
> 	PARTITION_LOGICAL           = 0x01,
> 	PARTITION_EXTENDED          = 0x02,
> };
> 
> struct fdisk_sys_type {
>  ... <--- copy/simplify struct systypes i386_sys_types[]
> };

I agree with Petr, this is label specific -- all this specific
stuff should be in label specific file (e.g. mbr.c).

I understand (and agree) that you want to remove all the stupid
"if(disktype == FOO)" from the code, but then it seems that very
lightweight API is necessary only. From my point of view all
we need is:

  - operations
  - very basic and generic partitions description
  - device topology (i/o limits)
  - any top-level struct (context) where all stuff will be connected
    together.

That's all. Don't forget that tasks like "list all partitions" will be
also label specific (for DOS you need extended/primary/logical, for
GPT type UUIDs, ...).

> struct fdisk_partition {
> 	/* LBA geometry */
> 	sector_t p_start;
> 	sector_t p_end;
> 	sector_t p_len;

Why we need "p_end"? It seems that end = start + len.

> 	int p_num;                        /* partition number */

> 	enum fdisk_partition_type p_type; /* partition type */
> 	struct fdisk_sys_type p_systype;  /* bsd, minix, swap, etc */
> 	unsigned char p_is_boot;          /* active/bootable */

label specific, unnecessary here

> 
> 	struct list_head p_list;          /* maintain dlist */
> };

Can you describe interaction between libblkid (partitions probing) and
fdisk? Would be possible to use libblkid to get the current on-disk
layout? (Then we can support (at least) "fdisk -l"  for almost
arbitrary partition table type.)

Maybe you can also add "blkid_partition *ondisk" with the original
partition layout.

And as said Petr, "void *data" for private label specific data.

> /*
>  * All funtions return 0 on success and negative otherwise
>  */
> struct fdisk_operations {
> 	int (*add_partition)(struct fdisk_partition *new);
> 	int (*del_partition)(int partnum);
> 	int (*new_label)(void);
> 	int (*probe_label)(void);
> };

My experience is that the best is to create any central "context"
struct and use the struct in all high-level functions. This solution
allows to extend API in arbitrary way without API breaks.

   int (*add_partition)(struct fdisk *fdisk);

and if you want to add some new functionality then you only need to
add a new function to modify "struct fdisk" before you call add_partition().

Anyway, what about another operations like move-begin-of-partition,
set-partition-type, ... it seems that many many operations in fdisk
menu are label specific.


> struct fdisk_topology {
> 	 nsectors;
> 	sector_t t_lsector_size; /* logical */
> 	sector_t t_psector_size; /* physical */
> 	sector_t t_length;       /* size in bytes */
> 	sector_t t_min_io_size;
> 	sector_t t_io_size;      /* optimal */
> };

This is incomplete (you also need alignment_offset). Anyway, we
already have this struct in libblkid/src/topology/topology.c and all
is exported by blkid_topology_get_* functions.

What about to reuse the stuff from libblkid (especially if you want to
read the info from lbblkid).

> /* 
>  * Legacy CHS (cylinder-head-sector) based geometry
>  * can this layout be used for LBA addressing?
>  */
> struct fdisk_geometry {
> 	unsigned int heads;
> 	unsigned int sectors;
> 	unsigned int cylinders;
> };

Oh, CHS has to die! ;-)

> struct fdisk_disk {
> 	const char *d_name; /* pt type, ie: bsd, dos */

d_ptname or d_labelname ?

> 	struct fdisk_operations *d_ops;
> 	struct fdisk_partition *d_partitions;
> 
> };

but is it really necessary to have fdisk_disk?

> /* 
>  * Represent a single device to be handled (ie: /dev/sda)
>  */
> struct fdisk_device {
> 	int dev_fd;                    /* device descriptor */  
> 	char *dev_path;                /* device name/path */
> 	struct stat dev_sb;         
> 	struct fdisk_disk *d_disk;
> 	struct fdisk_topology *d_topo;
> 	struct fdisk_geometry *d_kgeo; /* kernel/bios geometry */
> };

What about to rename this to "struct fdisk" or "struct fdisk_context" and
use it as central struct for all fdisk stuff?

struct fdisk {
    const char *pttype;
    int dev_fd;
    char *dev_path;
    struct stat dev_sb;

    blkid_topology  *topology;
    struct fdisk_operations *ops;
    struct fdisk_partition *partitions;

    void *pt_data;  /* private layout data */
};


And:

 * debug support, the best thing on libmount and libblkid is
   LIB<NAME>_DEBUG=<mask> :-)

  - please see libmount/src/mountP.h and #ifdef CONFIG_LIBMOUNT_DEBUG
  - and libmount/src/init.c
  - and DBG() macros in code

 * use assert() (see also libmount)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
