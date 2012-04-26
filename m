Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:41948 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662Ab2DZNtj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Apr 2012 09:49:39 -0400
Date: Thu, 26 Apr 2012 15:49:38 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [RFC] fdisk API
Message-ID: <20120426134938.GM8159@foxbat.suse.cz>
References: <1335444485.28151.15.camel@offworld>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5fECsWged6836Ycf"
In-Reply-To: <1335444485.28151.15.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--5fECsWged6836Ycf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2012 at 02:48:05PM +0200, Davidlohr Bueso wrote:
> Hi,

Hi Dave,

> The following structures are meant to represent and describe a single
> device and the interactions that disk partitioners require. I would like
> to know your opinion as we intend on gradually start adapting current
> fdisk code around them.
>=20
> It's important to mention that since flexibility is crucial, these are
> opaque types and therefore all fields will be accessed through
> interfaces -- same as libblkid.=20
>=20
> The functions themselves to use, populate/free these structures are
> currently being worked on, and without wanting to overdesign things, it
> will probably come in through patches. Again, I think we all want to
> keep things simple.
>=20
> Thanks,
> Dave
>=20
> -----
>=20
> typedef unsigned long long sector_t;
>=20
> enum fdisk_partition_type {
> 	PARTITION_NORMAL            =3D 0x00,
> 	PARTITION_LOGICAL           =3D 0x01,
> 	PARTITION_EXTENDED          =3D 0x02,
> };

This applies only for msdos label. With GPT (and other pt labels we
might eventually want to support), there is nothing like
extended or logical. E.g. parted maintains list of valid partition
types per label.

> struct fdisk_sys_type {
>  ... <--- copy/simplify struct systypes i386_sys_types[]
> };

This is not applicable for GPT. What about adding something like
'void *label_data' to fdisk_partition to support these per-PT label data?

I'm also missing a structure to describe a label as a whole, not only
the individual partition entries.
>=20
> struct fdisk_partition {
> 	/* LBA geometry */
> 	sector_t p_start;
> 	sector_t p_end;
> 	sector_t p_len;
>=20
> 	int p_num;                        /* partition number */
> 	enum fdisk_partition_type p_type; /* partition type */
> 	struct fdisk_sys_type p_systype;  /* bsd, minix, swap, etc */
> 	unsigned char p_is_boot;          /* active/bootable */

Boot flag is also label specific.

>=20
> 	struct list_head p_list;          /* maintain dlist */
> };
>=20
> /*
>  * All funtions return 0 on success and negative otherwise
>  */
> struct fdisk_operations {
> 	int (*add_partition)(struct fdisk_partition *new);
> 	int (*del_partition)(int partnum);
> 	int (*new_label)(void);
> 	int (*probe_label)(void);
> };

Apart from add_partition, these prototypes do not allow any control over
the operation. Also, shouldn't the functions take a pointer to struct
fdisk_device ?

[Not a big deal for now since these functions are not supposed to be
part of any future API, right?]
>=20
> struct fdisk_topology {
> 	 nsectors;
> 	sector_t t_lsector_size; /* logical */
> 	sector_t t_psector_size; /* physical */
> 	sector_t t_length;       /* size in bytes */
> 	sector_t t_min_io_size;
> 	sector_t t_io_size;      /* optimal */
> };

Having both nsectors and t_length is superfluous (with
t_lsector_size). Does it have any advantage to have both?

> /*=20
>  * Legacy CHS (cylinder-head-sector) based geometry
>  * can this layout be used for LBA addressing?
>  */
> struct fdisk_geometry {
> 	unsigned int heads;
> 	unsigned int sectors;
> 	unsigned int cylinders;
> };
>=20
> struct fdisk_disk {
> 	const char *d_name; /* pt type, ie: bsd, dos */
> 	struct fdisk_operations *d_ops;
> 	struct fdisk_partition *d_partitions;
>=20
> };
>=20
> /*=20
>  * Represent a single device to be handled (ie: /dev/sda)
>  */
> struct fdisk_device {
> 	int dev_fd;                    /* device descriptor */ =20
> 	char *dev_path;                /* device name/path */
> 	struct stat dev_sb;        =20
> 	struct fdisk_disk *d_disk;
> 	struct fdisk_topology *d_topo;
> 	struct fdisk_geometry *d_kgeo; /* kernel/bios geometry */
> };
>=20

Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--5fECsWged6836Ycf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk+ZUnIACgkQnZxG0T6qDD1zAwCffcCW1/lrPe5kq+hS+BZzZ98S
roIAnA8ecoh9NQN1EUzUXDLkVQK6k3Kc
=6rhs
-----END PGP SIGNATURE-----

--5fECsWged6836Ycf--
