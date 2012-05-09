Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:49566 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162Ab2EIV4S (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 May 2012 17:56:18 -0400
Received: by wgbdr13 with SMTP id dr13so745235wgb.1
        for <util-linux@vger.kernel.org>; Wed, 09 May 2012 14:56:17 -0700 (PDT)
Message-ID: <4FAAE7FB.2060808@gmail.com>
Date: Wed, 09 May 2012 23:56:11 +0200
From: =?UTF-8?B?VmxhZGltaXIgJ8+GLWNvZGVyL3BoY29kZXInIFNlcmJpbmVua28=?=
	<phcoder@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] allow to create a minix3fs with a blocksize != 1K
References: <4FAAE6EA.3080308@gmail.com>
In-Reply-To: <4FAAE6EA.3080308@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enig5C2F02CFF210FCEAC0635CF7"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5C2F02CFF210FCEAC0635CF7
Content-Type: multipart/mixed;
 boundary="------------090402050209080902060001"

This is a multi-part message in MIME format.
--------------090402050209080902060001
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Have used it to test minixfs support with various block sizes.

--=20
Regards
Vladimir '=CF=86-coder/phcoder' Serbinenko




--------------090402050209080902060001
Content-Type: text/x-diff;
 name="minix-block.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="minix-block.diff"

diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index 139ab7a..7d1a737 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -497,9 +497,11 @@ write_super_block(void) {
 	else
 		Super.s_state &=3D ~MINIX_ERROR_FS;
=20
-	if (MINIX_BLOCK_SIZE !=3D lseek(IN, MINIX_BLOCK_SIZE, SEEK_SET))
+	if (MINIX_SUPERBLOCK_OFFSET !=3D lseek(IN, MINIX_SUPERBLOCK_OFFSET,
+					     SEEK_SET))
 		die(_("seek failed in write_super_block"));
-	if (MINIX_BLOCK_SIZE !=3D write(IN, super_block_buffer, MINIX_BLOCK_SIZ=
E))
+	if (MINIX_SUPERBLOCK_SIZE !=3D write(IN, super_block_buffer,
+					   MINIX_SUPERBLOCK_SIZE))
 		die(_("unable to write super-block"));
 	return;
 }
@@ -543,33 +545,41 @@ get_dirsize(void) {
 	/* use defaults */
 }
=20
+int MINIX_BLOCK_SIZE =3D 0;
+
 static void
 read_superblock(void) {
-	if (MINIX_BLOCK_SIZE !=3D lseek(IN, MINIX_BLOCK_SIZE, SEEK_SET))
+	if (MINIX_SUPERBLOCK_OFFSET !=3D lseek(IN, MINIX_SUPERBLOCK_OFFSET,
+					     SEEK_SET))
 		die(_("seek failed"));
=20
-	super_block_buffer =3D calloc(1, MINIX_BLOCK_SIZE);
+	super_block_buffer =3D calloc(1, MINIX_SUPERBLOCK_SIZE);
 	if (!super_block_buffer)
 		die(_("unable to alloc buffer for superblock"));
=20
-	if (MINIX_BLOCK_SIZE !=3D read(IN, super_block_buffer, MINIX_BLOCK_SIZE=
))
+	if (MINIX_SUPERBLOCK_SIZE
+	    !=3D read(IN, super_block_buffer, MINIX_SUPERBLOCK_SIZE))
 		die(_("unable to read super block"));
 	if (MAGIC =3D=3D MINIX_SUPER_MAGIC) {
 		namelen =3D 14;
 		dirsize =3D 16;
 		fs_version =3D 1;
+		MINIX_BLOCK_SIZE =3D MINIX12_BLOCK_SIZE;
 	} else if (MAGIC =3D=3D MINIX_SUPER_MAGIC2) {
 		namelen =3D 30;
 		dirsize =3D 32;
 		fs_version =3D 1;
+		MINIX_BLOCK_SIZE =3D MINIX12_BLOCK_SIZE;
 	} else if (MAGIC =3D=3D MINIX2_SUPER_MAGIC) {
 		namelen =3D 14;
 		dirsize =3D 16;
 		fs_version =3D 2;
+		MINIX_BLOCK_SIZE =3D MINIX12_BLOCK_SIZE;
 	} else if (MAGIC =3D=3D MINIX2_SUPER_MAGIC2) {
 		namelen =3D 30;
 		dirsize =3D 32;
 		fs_version =3D 2;
+		MINIX_BLOCK_SIZE =3D MINIX12_BLOCK_SIZE;
 	} else
 		die(_("bad magic number in super-block"));
 	if (get_zone_size() !=3D 0 || MINIX_BLOCK_SIZE !=3D 1024)
@@ -812,7 +822,7 @@ add_zone2(unsigned int *znr, int *corrected) {
=20
 static void
 add_zone_ind(unsigned short *znr, int *corrected) {
-	static char blk[MINIX_BLOCK_SIZE];
+	static char blk[MAX_MINIX_BLOCK_SIZE];
 	int i, chg_blk =3D 0;
 	int block;
=20
@@ -828,7 +838,7 @@ add_zone_ind(unsigned short *znr, int *corrected) {
=20
 static void
 add_zone_ind2(unsigned int *znr, int *corrected) {
-	static char blk[MINIX_BLOCK_SIZE];
+	static char blk[MAX_MINIX_BLOCK_SIZE];
 	int i, chg_blk =3D 0;
 	int block;
=20
@@ -844,7 +854,7 @@ add_zone_ind2(unsigned int *znr, int *corrected) {
=20
 static void
 add_zone_dind(unsigned short *znr, int *corrected) {
-	static char blk[MINIX_BLOCK_SIZE];
+	static char blk[MAX_MINIX_BLOCK_SIZE];
 	int i, blk_chg =3D 0;
 	int block;
=20
@@ -860,7 +870,7 @@ add_zone_dind(unsigned short *znr, int *corrected) {
=20
 static void
 add_zone_dind2(unsigned int *znr, int *corrected) {
-	static char blk[MINIX_BLOCK_SIZE];
+	static char blk[MAX_MINIX_BLOCK_SIZE];
 	int i, blk_chg =3D 0;
 	int block;
=20
@@ -876,7 +886,7 @@ add_zone_dind2(unsigned int *znr, int *corrected) {
=20
 static void
 add_zone_tind2(unsigned int *znr, int *corrected) {
-	static char blk[MINIX_BLOCK_SIZE];
+	static char blk[MAX_MINIX_BLOCK_SIZE];
 	int i, blk_chg =3D 0;
 	int block;
=20
@@ -929,7 +939,7 @@ check_zones2(unsigned int i) {
=20
 static void
 check_file(struct minix_inode *dir, unsigned int offset) {
-	static char blk[MINIX_BLOCK_SIZE];
+	static char blk[MAX_MINIX_BLOCK_SIZE];
 	struct minix_inode *inode;
 	unsigned int ino;
 	char *name;
@@ -997,7 +1007,7 @@ check_file(struct minix_inode *dir, unsigned int off=
set) {
=20
 static void
 check_file2(struct minix2_inode *dir, unsigned int offset) {
-	static char blk[MINIX_BLOCK_SIZE];
+	static char blk[MAX_MINIX_BLOCK_SIZE];
 	struct minix2_inode *inode;
 	unsigned long ino;
 	char *name;
diff --git a/disk-utils/minix_programs.h b/disk-utils/minix_programs.h
index 4af1a34..8fced46 100644
--- a/disk-utils/minix_programs.h
+++ b/disk-utils/minix_programs.h
@@ -8,6 +8,7 @@
  */
 extern int fs_version;
 extern char *super_block_buffer;
+extern int MINIX_BLOCK_SIZE;
=20
 #define Super (*(struct minix_super_block *) super_block_buffer)
 #define Super3 (*(struct minix3_super_block *) super_block_buffer)
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 051cd5f..fd68fc9 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -123,7 +123,7 @@ static size_t namelen =3D 30;
 static size_t dirsize =3D 32;
 static int magic =3D MINIX_SUPER_MAGIC2;
=20
-static char root_block[MINIX_BLOCK_SIZE];
+static char root_block[MAX_MINIX_BLOCK_SIZE];
=20
 static char boot_block_buffer[512];
=20
@@ -146,7 +146,7 @@ static char *zone_map;
=20
 static void __attribute__((__noreturn__))
 usage(void) {
-	errx(MKFS_EX_USAGE, _("Usage: %s [-c | -l filename] [-nXX] [-iXX] /dev/=
name [blocks]"),
+	errx(MKFS_EX_USAGE, _("Usage: %s [-c | -l filename] [-nXX] [-BXX] [-iXX=
] /dev/name [blocks]"),
 	     program_name);
 }
=20
@@ -189,6 +189,13 @@ static void write_tables(void) {
 	unsigned long imaps =3D get_nimaps();
 	unsigned long zmaps =3D get_nzmaps();
 	unsigned long buffsz =3D get_inode_buffer_size();
+	unsigned pad;
+	char padbuffer[2 * MINIX_BLOCK_SIZE];
+
+	memset (padbuffer, 0, 2 * MINIX_BLOCK_SIZE);
+
+	pad =3D 2 * MINIX_BLOCK_SIZE - (MINIX_SUPERBLOCK_OFFSET
+				      + MINIX_SUPERBLOCK_SIZE);
=20
 	/* Mark the super block valid. */
 	super_set_state();
@@ -198,12 +205,16 @@ static void write_tables(void) {
 				   " in write_tables"), device_name);
 	if (write_all(DEV, boot_block_buffer, 512))
 		err(MKFS_EX_ERROR, _("%s: unable to clear boot sector"), device_name);=

-	if (MINIX_BLOCK_SIZE !=3D lseek(DEV, MINIX_BLOCK_SIZE, SEEK_SET))
+	if (MINIX_SUPERBLOCK_OFFSET !=3D lseek(DEV, MINIX_SUPERBLOCK_OFFSET,
+					     SEEK_SET))
 		err(MKFS_EX_ERROR, _("%s: seek failed in write_tables"), device_name);=

=20
-	if (write_all(DEV, super_block_buffer, MINIX_BLOCK_SIZE))
+	if (write_all(DEV, super_block_buffer, MINIX_SUPERBLOCK_SIZE))
 		err(MKFS_EX_ERROR, _("%s: unable to write super-block"), device_name);=

=20
+	if (write_all(DEV, padbuffer, pad))
+		err(MKFS_EX_ERROR, _("%s: unable to write super-block"), device_name);=
=09
+
 	if (write_all(DEV, inode_map, imaps * MINIX_BLOCK_SIZE))
 		err(MKFS_EX_ERROR, _("%s: unable to write inode map"), device_name);
=20
@@ -588,7 +600,7 @@ static void alarm_intr(int alnum __attribute__ ((__un=
used__))) {
=20
 static void check_blocks(void) {
 	int try,got;
-	static char buffer[MINIX_BLOCK_SIZE * TEST_BUFFER_BLOCKS];
+	static char buffer[MAX_MINIX_BLOCK_SIZE * TEST_BUFFER_BLOCKS];
 	unsigned long zones =3D get_nzones();
 	unsigned long first_zone =3D get_first_zone();
=20
@@ -646,6 +658,8 @@ static void get_list_blocks(char *filename) {
 		printf(_("one bad block\n"));
 }
=20
+int MINIX_BLOCK_SIZE =3D 0;
+
 int main(int argc, char ** argv) {
 	int i;
 	char * tmp;
@@ -653,6 +667,8 @@ int main(int argc, char ** argv) {
 	char * listfile =3D NULL;
 	char * p;
=20
+	MINIX_BLOCK_SIZE =3D MINIX12_BLOCK_SIZE;
+
 	if (argc && *argv)
 		program_name =3D *argv;
 	if ((p =3D strrchr(program_name, '/')) !=3D NULL)
@@ -675,8 +691,13 @@ int main(int argc, char ** argv) {
 		errx(MKFS_EX_ERROR, _("%s: bad inode size"), device_name);
=20
 	opterr =3D 0;
-	while ((i =3D getopt(argc, argv, "ci:l:n:v123")) !=3D -1)
+	while ((i =3D getopt(argc, argv, "ci:l:n:v123B:")) !=3D -1)
 		switch (i) {
+		case 'B':
+			MINIX_BLOCK_SIZE =3D strtoul(optarg,&tmp,0);
+			if (*tmp)
+				usage();
+			break;
 		case 'c':
 			check=3D1; break;
 		case 'i':
@@ -727,6 +748,13 @@ int main(int argc, char ** argv) {
 		}
 	}
=20
+	if (fs_version !=3D 3 && MINIX_BLOCK_SIZE !=3D MINIX12_BLOCK_SIZE)
+		usage();
+
+	if (MINIX_BLOCK_SIZE % 512 || MINIX_BLOCK_SIZE < 1024
+	    || MINIX_BLOCK_SIZE >=3D 65536)
+		usage();
+
 	if (!device_name) {
 		usage();
 	}
diff --git a/include/minix.h b/include/minix.h
index 57be239..059c050 100644
--- a/include/minix.h
+++ b/include/minix.h
@@ -60,12 +60,13 @@ struct minix3_super_block {
  */
 #define MINIX_MAXPARTITIONS  4
=20
-#define MINIX_BLOCK_SIZE_BITS 10
-#define MINIX_BLOCK_SIZE     (1 << MINIX_BLOCK_SIZE_BITS)
-
 #define MINIX_NAME_MAX       255             /* # chars in a file name *=
/
 #define MINIX_MAX_INODES     65535
=20
+#define MAX_MINIX_BLOCK_SIZE 65536
+#define MINIX12_BLOCK_SIZE   1024
+#define MINIX_SUPERBLOCK_OFFSET 1024
+#define MINIX_SUPERBLOCK_SIZE  512
 #define MINIX_INODES_PER_BLOCK ((MINIX_BLOCK_SIZE)/(sizeof (struct minix=
_inode)))
 #define MINIX2_INODES_PER_BLOCK ((MINIX_BLOCK_SIZE)/(sizeof (struct mini=
x2_inode)))
=20
diff --git a/libblkid/src/superblocks/minix.c b/libblkid/src/superblocks/=
minix.c
index 54e7139..7bf9089 100644
--- a/libblkid/src/superblocks/minix.c
+++ b/libblkid/src/superblocks/minix.c
@@ -45,9 +45,9 @@ static int probe_minix(blkid_probe pr, const struct blk=
id_idmag *mag)
 		zones =3D version =3D=3D 2 ? sb->s_zones : sb->s_nzones;
=20
 		/* sanity checks to be sure that the FS is really minix */
-		if (sb->s_imap_blocks * MINIX_BLOCK_SIZE * 8 < sb->s_ninodes + 1)
+		if (sb->s_imap_blocks * MINIX12_BLOCK_SIZE * 8 < sb->s_ninodes + 1)
 			return -1;
-		if (sb->s_zmap_blocks * MINIX_BLOCK_SIZE * 8 < zones - sb->s_firstdata=
zone + 1)
+		if (sb->s_zmap_blocks * MINIX12_BLOCK_SIZE * 8 < zones - sb->s_firstda=
tazone + 1)
 			return -1;
=20
 	} else if (version =3D=3D 3) {


--------------090402050209080902060001--

--------------enig5C2F02CFF210FCEAC0635CF7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iF4EAREKAAYFAk+q5/sACgkQNak7dOguQgknpgD+KKYEMS1BeZRCGmyVwFV9EzOH
6NCknD0Nap3NADZClqgA/2QU50gWH9ggv+hPiElv/sjkvNsgSD/P3MRnhaz7Y4j4
=J6k4
-----END PGP SIGNATURE-----

--------------enig5C2F02CFF210FCEAC0635CF7--
