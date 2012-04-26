Return-Path: dave@gnu.org
Date: Thu, 26 Apr 2012 14:48:05 +0200
From: Davidlohr Bueso <dave@gnu.org>
Subject: [RFC] fdisk API
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1335444485.28151.15.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

Hi,

The following structures are meant to represent and describe a single
device and the interactions that disk partitioners require. I would like
to know your opinion as we intend on gradually start adapting current
fdisk code around them.

It's important to mention that since flexibility is crucial, these are
opaque types and therefore all fields will be accessed through
interfaces -- same as libblkid. 

The functions themselves to use, populate/free these structures are
currently being worked on, and without wanting to overdesign things, it
will probably come in through patches. Again, I think we all want to
keep things simple.

Thanks,
Dave

-----

typedef unsigned long long sector_t;

enum fdisk_partition_type {
	PARTITION_NORMAL            = 0x00,
	PARTITION_LOGICAL           = 0x01,
	PARTITION_EXTENDED          = 0x02,
};

struct fdisk_sys_type {
 ... <--- copy/simplify struct systypes i386_sys_types[]
};

struct fdisk_partition {
	/* LBA geometry */
	sector_t p_start;
	sector_t p_end;
	sector_t p_len;

	int p_num;                        /* partition number */
	enum fdisk_partition_type p_type; /* partition type */
	struct fdisk_sys_type p_systype;  /* bsd, minix, swap, etc */
	unsigned char p_is_boot;          /* active/bootable */

	struct list_head p_list;          /* maintain dlist */
};

/*
 * All funtions return 0 on success and negative otherwise
 */
struct fdisk_operations {
	int (*add_partition)(struct fdisk_partition *new);
	int (*del_partition)(int partnum);
	int (*new_label)(void);
	int (*probe_label)(void);
};

struct fdisk_topology {
	 nsectors;
	sector_t t_lsector_size; /* logical */
	sector_t t_psector_size; /* physical */
	sector_t t_length;       /* size in bytes */
	sector_t t_min_io_size;
	sector_t t_io_size;      /* optimal */
};

/* 
 * Legacy CHS (cylinder-head-sector) based geometry
 * can this layout be used for LBA addressing?
 */
struct fdisk_geometry {
	unsigned int heads;
	unsigned int sectors;
	unsigned int cylinders;
};

struct fdisk_disk {
	const char *d_name; /* pt type, ie: bsd, dos */
	struct fdisk_operations *d_ops;
	struct fdisk_partition *d_partitions;

};

/* 
 * Represent a single device to be handled (ie: /dev/sda)
 */
struct fdisk_device {
	int dev_fd;                    /* device descriptor */  
	char *dev_path;                /* device name/path */
	struct stat dev_sb;         
	struct fdisk_disk *d_disk;
	struct fdisk_topology *d_topo;
	struct fdisk_geometry *d_kgeo; /* kernel/bios geometry */
};
