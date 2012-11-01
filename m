Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:58218 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754831Ab2KAJHK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 1 Nov 2012 05:07:10 -0400
Date: Thu, 1 Nov 2012 10:06:59 +0100
From: Petr Uzel <petr.uzel@suse.cz>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] gpt: create empty disklabels
Message-ID: <20121101090659.GH3979@foxbat.suse.cz>
References: <1351358627.2842.3.camel@offbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Il7n/DHsA0sMLmDu"
In-Reply-To: <1351358627.2842.3.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 27, 2012 at 07:23:47PM +0200, Davidlohr Bueso wrote:
> This patch enables creating a new, empty, GPT disklabel from either
> an empty disk or one that already has a disklabel. For this
> purpose, a 'g' option is added to the main menu and is visible to all
> labels. Here's an example for a scsi_debug device (/dev/sdb):
>=20
> ...
> Device does not contain a recognized partition table
> Building a new DOS disklabel with disk identifier 0x20a614c8.
> 3696: fdisk:  CONTEXT: zeroize in-memory first sector buffer
>=20
> Command (m for help): g
> 3696: fdisk:    LABEL: changing to gpt label
>=20
> 3696: fdisk:  CONTEXT: zeroize in-memory first sector buffer
> 3696: fdisk:    LABEL: created new empty GPT disklabel (GUID: D4EA0706-F0=
11-46DC-B7DE-6A72C7090AF8)
>=20
> Command (m for help): w
> The partition table has been altered!
> ...
>=20
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>

Looks good to me and it also survived my testing.

Reviewed-and-tested-by: Petr Uzel <petr.uzel@suse.cz>


> ---
>  fdisks/fdisk.c |    4 ++
>  fdisks/gpt.c   |  202 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  2 files changed, 200 insertions(+), 6 deletions(-)
>=20
> diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
> index e271ea1..a3ac087 100644
> --- a/fdisks/fdisk.c
> +++ b/fdisks/fdisk.c
> @@ -90,6 +90,7 @@ static const struct menulist_descr menulist[] =3D {
>  	{'e', N_("edit drive data"), {OSF_LABEL, 0}},
>  	{'f', N_("fix partition order"), {0, DOS_LABEL}},
>  	{'g', N_("create an IRIX (SGI) partition table"), {0, ANY_LABEL}},
> +	{'g', N_("create a new empty GPT partition table"), {ANY_LABEL, 0}},
>  	{'h', N_("change number of heads"), {0, DOS_LABEL | SUN_LABEL}},
>  	{'i', N_("change interleave factor"), {0, SUN_LABEL}},
>  	{'i', N_("change the disk identifier"), {0, DOS_LABEL}},
> @@ -1694,6 +1695,9 @@ static void command_prompt(struct fdisk_context *cx=
t)
>  		case 'd':
>  			delete_partition(cxt, get_existing_partition(cxt, 1, partitions));
>  			break;
> +		case 'g':
> +			fdisk_create_disklabel(cxt, "gpt");
> +			break;
>  		case 'i':
>  			if (disklabel =3D=3D SGI_LABEL)
>  				create_sgiinfo(cxt);
> diff --git a/fdisks/gpt.c b/fdisks/gpt.c
> index 48397f3..843dc44 100644
> --- a/fdisks/gpt.c
> +++ b/fdisks/gpt.c
> @@ -19,7 +19,6 @@
>   * You should have received a copy of the GNU General Public License
>   * along with this program; if not, write to the Free Software
>   * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301,=
 USA
> - *
>   */
> =20
>  #include <stdio.h>
> @@ -59,7 +58,8 @@
> =20
>  #define EFI_PMBR_OSTYPE     0xEE
>  #define MSDOS_MBR_SIGNATURE 0xAA55
> -#define GPT_PART_NAME_LEN 72 / sizeof(uint16_t)
> +#define GPT_PART_NAME_LEN   72 / sizeof(uint16_t)
> +#define GPT_NPARTITIONS     128
> =20
>  /* Globally unique identifier */
>  struct gpt_guid {
> @@ -96,8 +96,8 @@ struct gpt_attr {
> =20
>  /* The GPT Partition entry array contains an array of GPT entries. */
>  struct gpt_entry {
> -	struct gpt_guid   partition_type_guid; /* purpose and type of the parti=
tion */
> -	struct gpt_guid   unique_partition_guid;
> +	struct gpt_guid     partition_type_guid; /* purpose and type of the par=
tition */
> +	struct gpt_guid     unique_partition_guid;
>  	uint64_t            lba_start;
>  	uint64_t            lba_end;
>  	struct gpt_attr     attr;
> @@ -115,7 +115,7 @@ struct gpt_header {
>  	uint64_t            alternative_lba; /* backup GPT header */
>  	uint64_t            first_usable_lba; /* first usable logical block for=
 partitions */
>  	uint64_t            last_usable_lba; /* last usable logical block for p=
artitions */
> -	struct gpt_guid   disk_guid; /* unique disk identifier */
> +	struct gpt_guid     disk_guid; /* unique disk identifier */
>  	uint64_t            partition_entry_lba; /* stat LBA of the partition e=
ntry array */
>  	uint32_t            npartition_entries; /* total partition entries - no=
rmally 128 */
>  	uint32_t            sizeof_partition_entry; /* bytes for each GUID pt */
> @@ -298,6 +298,125 @@ static inline int partition_unused(struct gpt_entry=
 e)
>  }
> =20
>  /*
> + * Builds a clean new valid protective MBR - will wipe out any existing =
data.
> + * Returns 0 on success, otherwise < 0 on error.
> + */
> +static int gpt_mknew_pmbr(struct fdisk_context *cxt)
> +{
> +	struct gpt_legacy_mbr *pmbr =3D NULL;
> +
> +	if (!cxt || !cxt->firstsector)
> +		return -ENOSYS;
> +
> +	fdisk_zeroize_firstsector(cxt);
> +
> +	pmbr =3D (struct gpt_legacy_mbr *) cxt->firstsector;
> +
> +	pmbr->signature =3D cpu_to_le16(MSDOS_MBR_SIGNATURE);
> +	pmbr->partition_record[0].os_type      =3D EFI_PMBR_OSTYPE;
> +	pmbr->partition_record[0].start_sector =3D 1;
> +	pmbr->partition_record[0].end_head     =3D 0xFE;
> +	pmbr->partition_record[0].end_sector   =3D 0xFF;
> +	pmbr->partition_record[0].end_track    =3D 0xFF;
> +	pmbr->partition_record[0].starting_lba =3D cpu_to_le32(1);
> +	pmbr->partition_record[0].size_in_lba  =3D
> +		cpu_to_le32(min((uint32_t) cxt->total_sectors - 1, 0xFFFFFFFF));
> +
> +	return 0;
> +}
> +
> +/* some universal differences between the headers */
> +static void gpt_mknew_header_common(struct fdisk_context *cxt,
> +				    struct gpt_header *header, uint64_t lba)
> +{
> +	if (!cxt || !header)
> +		return;
> +
> +	header->my_lba =3D cpu_to_le64(lba);
> +
> +	if (lba =3D=3D GPT_PRIMARY_PARTITION_TABLE_LBA) { /* primary */
> +		header->alternative_lba =3D cpu_to_le64(cxt->total_sectors - 1);
> +		header->partition_entry_lba =3D cpu_to_le64(2);
> +	} else { /* backup */
> +		uint64_t esz =3D le32_to_cpu(header->npartition_entries) * sizeof(stru=
ct gpt_entry);
> +		uint64_t esects =3D (esz + cxt->sector_size - 1) / cxt->sector_size;
> +
> +		header->alternative_lba =3D cpu_to_le64(GPT_PRIMARY_PARTITION_TABLE_LB=
A);
> +		header->partition_entry_lba =3D cpu_to_le64(cxt->total_sectors - 1 - e=
sects);
> +       	}
> +}
> +
> +/*
> + * Builds a new GPT header (at sector lba) from a backup header2.
> + * If building a primary header, then backup is the secondary, and vice =
versa.
> + *
> + * Always pass a new (zeroized) header to build upon as we don't
> + * explicitly zero-set some values such as CRCs and reserved.
> + *
> + * Returns 0 on success, otherwise < 0 on error.
> + */
> +static int gpt_mknew_header_from_bkp(struct fdisk_context *cxt,
> +				     struct gpt_header *header,
> +				     uint64_t lba,
> +				     struct gpt_header *header2)
> +{
> +	if (!cxt || !header || !header2)
> +		return -ENOSYS;
> +
> +	header->signature              =3D header2->signature;
> +	header->revision               =3D header2->revision;
> +	header->size                   =3D header2->size;
> +	header->npartition_entries     =3D header2->npartition_entries;
> +	header->sizeof_partition_entry =3D header2->sizeof_partition_entry;
> +	header->first_usable_lba       =3D header2->first_usable_lba;
> +	header->last_usable_lba        =3D header2->last_usable_lba;
> +
> +	memcpy(&header->disk_guid,
> +	       &header2->disk_guid, sizeof(header2->disk_guid));
> +	gpt_mknew_header_common(cxt, header, lba);
> +
> +	return 0;
> +}
> +
> +/*
> + * Builds a clean new GPT header (currently under revision 1.0).
> + *
> + * Always pass a new (zeroized) header to build upon as we don't
> + * explicitly zero-set some values such as CRCs and reserved.
> + *
> + * Returns 0 on success, otherwise < 0 on error.
> + */
> +static int gpt_mknew_header(struct fdisk_context *cxt,
> +			    struct gpt_header *header, uint64_t lba)
> +{
> +	uint64_t esz =3D 0;
> +
> +	if (!cxt || !header)
> +		return -ENOSYS;
> +
> +	esz =3D sizeof(struct gpt_entry) * GPT_NPARTITIONS / cxt->sector_size;
> +
> +	header->signature =3D cpu_to_le64(GPT_HEADER_SIGNATURE);
> +	header->revision  =3D cpu_to_le32(GPT_HEADER_REVISION_V1_00);
> +	header->size      =3D cpu_to_le32(sizeof(struct gpt_header));
> +
> +	/*
> +	 * 128 partitions is the default. It can go behond this, however,
> +	 * we're creating a de facto header here, so no funny business.
> +	 */
> +	header->npartition_entries     =3D cpu_to_le32(GPT_NPARTITIONS);
> +	header->sizeof_partition_entry =3D cpu_to_le32(sizeof(struct gpt_entry)=
);
> +	header->first_usable_lba       =3D cpu_to_le64(esz + 2);
> +	header->last_usable_lba        =3D cpu_to_le64(cxt->total_sectors - 2 -=
 esz);
> +
> +	gpt_mknew_header_common(cxt, header, lba);
> +	uuid_generate_random((unsigned char *) &header->disk_guid);
> +	swap_efi_guid(&header->disk_guid);
> +
> +	return 0;
> +}
> +
> +/*
>   * Checks if there is a valid protective MBR partition table.
>   * Returns 0 if it is invalid or failure. Otherwise, return
>   * GPT_MBR_PROTECTIVE or GPT_MBR_HYBRID, depeding on the detection.
> @@ -850,6 +969,22 @@ static void gpt_init(void)
>  	partitions =3D le32_to_cpu(pheader->npartition_entries);
>  }
> =20
> +/*
> + * Deinitialize fdisk-specific variables
> + */
> +static void gpt_deinit(void)
> +{
> +	free(ents);
> +	free(pheader);
> +	free(bheader);
> +	ents =3D NULL;
> +	pheader =3D NULL;
> +	bheader =3D NULL;
> +
> +	disklabel =3D ANY_LABEL;
> +	partitions =3D 0;
> +}
> +
>  static int gpt_probe_label(struct fdisk_context *cxt)
>  {
>  	int mbr_type;
> @@ -899,6 +1034,7 @@ static char *encode_to_utf8(unsigned char *src, size=
_t count)
>  	uint16_t c;
>  	char *dest =3D xmalloc(count * sizeof(char));
>  	size_t i, j, len =3D count;
> +
>  	memset(dest, 0, sizeof(char) * count);
> =20
>  	for (j =3D i =3D 0; i + 2 <=3D count; i +=3D 2) {
> @@ -1363,6 +1499,60 @@ static void gpt_add_partition(struct fdisk_context=
 *cxt, int partnum,
>  		printf(_("Created partition %d\n"), partnum + 1);
>  }
> =20
> +/*
> + * Create a new GPT disklabel - destroys any previous data.
> + */
> +static int gpt_create_disklabel(struct fdisk_context *cxt)
> +{
> +	int rc =3D 0;
> +	ssize_t entry_sz =3D 0;
> +
> +	/*
> +	 * Reset space or clear data from headers, pt entries and
> +	 * protective MBR. Big fat warning: any previous content is
> +	 * overwritten, so ask users to be sure!.
> +	 *
> +	 * When no header, entries or pmbr is set, we're probably
> +	 * dealing with a new, empty disk - so always allocate memory
> +	 * to deal with the data structures whatever the case is.
> +	 */
> +	gpt_deinit();
> +
> +	rc =3D gpt_mknew_pmbr(cxt);
> +	if (rc < 0)
> +		goto done;
> +
> +	pheader =3D xcalloc(1, sizeof(*pheader));
> +       	rc =3D gpt_mknew_header(cxt, pheader, GPT_PRIMARY_PARTITION_TABL=
E_LBA);
> +	if (rc < 0)
> +		goto done;
> +
> +	bheader =3D xcalloc(1, sizeof(*bheader));
> +	rc =3D gpt_mknew_header_from_bkp(cxt, bheader, last_lba(cxt), pheader);
> +	if (rc < 0)
> +		goto done;
> +
> +	entry_sz =3D le32_to_cpu(pheader->npartition_entries) *
> +		le32_to_cpu(pheader->sizeof_partition_entry);
> +	ents =3D xcalloc(1, sizeof(*ents) * entry_sz);
> +
> +	gpt_recompute_crc(pheader, ents);
> +	gpt_recompute_crc(bheader, ents);
> +
> +	gpt_init();
> +	DBG(LABEL, dbgprint("created new empty GPT disklabel "
> +			    "(GUID: %08X-%04X-%04X-%02X%02X-%02X%02X%02X%02X%02X%02X)",
> +			    pheader->disk_guid.time_low, pheader->disk_guid.time_mid,
> +			    pheader->disk_guid.time_hi_and_version,
> +			    pheader->disk_guid.clock_seq_hi,
> +			    pheader->disk_guid.clock_seq_low,
> +			    pheader->disk_guid.node[0], pheader->disk_guid.node[1],
> +			    pheader->disk_guid.node[2], pheader->disk_guid.node[3],
> +			    pheader->disk_guid.node[4], pheader->disk_guid.node[5]));
> +done:
> +	return rc;
> +}
> +
>  static struct fdisk_parttype *gpt_get_partition_type(struct fdisk_contex=
t *cxt,
>  						     int i)
>  {
> @@ -1409,7 +1599,7 @@ const struct fdisk_label gpt_label =3D
>  	.probe =3D gpt_probe_label,
>  	.write =3D gpt_write_disklabel,
>  	.verify =3D gpt_verify_disklabel,
> -	.create =3D NULL,
> +	.create =3D gpt_create_disklabel,
>  	.part_add =3D gpt_add_partition,
>  	.part_delete =3D gpt_delete_partition,
>  	.part_get_type =3D gpt_get_partition_type,
> --=20
> 1.7.9.5
>=20
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAlCSO7MACgkQnZxG0T6qDD08TgCgh+2puQTxumcP5ZHZe7vdrGhx
5QcAn1xlLGLqtkIaVhuknGuEmC6AhGQm
=/1F4
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--
