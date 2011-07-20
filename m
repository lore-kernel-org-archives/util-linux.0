Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61398 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab1GTUzR convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 20 Jul 2011 16:55:17 -0400
Received: by qyk9 with SMTP id 9so369840qyk.19
        for <util-linux@vger.kernel.org>; Wed, 20 Jul 2011 13:55:16 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Wed, 20 Jul 2011 22:55:16 +0200
Message-ID: <CAG27Bk1uKnqR62SRNgTXFPGfTseraC0AUgpAMQ5zhdcsAM-79w@mail.gmail.com>
Subject: [git pull] cramfs fixes
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The following changes since commit 608d45015f78d85510b22181e7afd189876ac6c6:

  dmesg: allow to print time delta without timestamp (2011-07-20 17:03:24 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit cramfs

Sami Kerola (15):
      cramfs_common: coding style
      cramfs: use stdint.h instead of u{8,16,32}
      cramfs.h: coding style
      fsck.cramfs: retire die function
      fsck.cramfs: use xalloc.h
      fsck.cramfs: coding style
      fsck.cramfs: add missed strings to translation
      mkfs.cramfs: use xalloc.h
      mkfs.cramfs: use program_invocation_short_name
      md5: use symbolical digest length
      mkfs.cramfs: few symbolic exit codes where missing
      mkfs.cramfs: validate numeric user inputs
      mkfs.cramfs: convert spaces to tabs
      mkfs.cramfs: error printing fixes
      mkfs.cramfs: include-what-you-use header check

 disk-utils/Makefile.am         |    2 +-
 disk-utils/cramfs.h            |   67 +++---
 disk-utils/cramfs_common.c     |   46 ++--
 disk-utils/fsck.cramfs.c       |  538 ++++++++++++++++++----------------------
 disk-utils/mkfs.cramfs.c       |  280 +++++++++-------------
 include/md5.h                  |    4 +-
 lib/md5.c                      |    4 +-
 libblkid/src/superblocks/hfs.c |    6 +-
 misc-utils/mcookie.c           |    4 +-
 tests/helpers/test_md5.c       |    4 +-
 10 files changed, 423 insertions(+), 532 deletions(-)

diff --git a/disk-utils/Makefile.am b/disk-utils/Makefile.am
index a7c2eaa..4f26b90 100644
--- a/disk-utils/Makefile.am
+++ b/disk-utils/Makefile.am
@@ -64,7 +64,7 @@ if BUILD_CRAMFS
 cramfs_common = $(utils_common) cramfs.h cramfs_common.c
 sbin_PROGRAMS += fsck.cramfs mkfs.cramfs
 fsck_cramfs_SOURCES = fsck.cramfs.c $(cramfs_common)
-mkfs_cramfs_SOURCES = mkfs.cramfs.c mkfs.h $(cramfs_common)
$(top_srcdir)/lib/md5.c
+mkfs_cramfs_SOURCES = mkfs.cramfs.c mkfs.h $(cramfs_common)
$(top_srcdir)/lib/md5.c $(top_srcdir)/lib/strutils.c
 fsck_cramfs_LDADD = -lz
 mkfs_cramfs_LDADD = -lz
 endif
diff --git a/disk-utils/cramfs.h b/disk-utils/cramfs.h
index ba4ba7f..fcfae56 100644
--- a/disk-utils/cramfs.h
+++ b/disk-utils/cramfs.h
@@ -19,9 +19,7 @@
 #ifndef __CRAMFS_H
 #define __CRAMFS_H

-typedef unsigned char u8;
-typedef unsigned short u16;
-typedef unsigned int u32;
+#include <stdint.h>

 #define CRAMFS_MAGIC		0x28cd3d45	/* some random number */
 #define CRAMFS_SIGNATURE	"Compressed ROMFS"
@@ -49,47 +47,50 @@ typedef unsigned int u32;
  * Reasonably terse representation of the inode data.
  */
 struct cramfs_inode {
-	u32 mode:16, uid:16;
+	uint32_t mode:16, uid:16;
 	/* SIZE for device files is i_rdev */
-	u32 size:24, gid:8;
-	/* NAMELEN is the length of the file name, divided by 4 and
-           rounded up.  (cramfs doesn't support hard links.) */
-	/* OFFSET: For symlinks and non-empty regular files, this
-	   contains the offset (divided by 4) of the file data in
-	   compressed form (starting with an array of block pointers;
-	   see README).  For non-empty directories it is the offset
-	   (divided by 4) of the inode of the first file in that
-	   directory.  For anything else, offset is zero. */
+	uint32_t size:24, gid:8;
+	/*
+	 * NAMELEN is the length of the file name, divided by 4 and
+	 * rounded up.  (cramfs doesn't support hard links.)
+	 *
+	 * OFFSET: For symlinks and non-empty regular files, this
+	 * contains the offset (divided by 4) of the file data in
+	 * compressed form (starting with an array of block pointers;
+	 * see README).  For non-empty directories it is the offset
+	 * (divided by 4) of the inode of the first file in that
+	 * directory.  For anything else, offset is zero.
+	 */
 	u32 namelen:6, offset:26;
 };

 struct cramfs_info {
-        u32 crc;
-        u32 edition;
-        u32 blocks;
-        u32 files;
+	uint32_t crc;
+	uint32_t edition;
+	uint32_t blocks;
+	uint32_t files;
 };

 /*
  * Superblock information at the beginning of the FS.
  */
 struct cramfs_super {
-	u32 magic;		/* 0x28cd3d45 - random number */
-	u32 size;		/* Not used.  mkcramfs currently
-                                   writes a constant 1<<16 here. */
-	u32 flags;		/* 0 */
-	u32 future;		/* 0 */
-	u8 signature[16];	/* "Compressed ROMFS" */
+	uint32_t magic;		/* 0x28cd3d45 - random number */
+	uint32_t size;		/* Not used.  mkcramfs currently
+				   writes a constant 1<<16 here. */
+	uint32_t flags;		/* 0 */
+	uint32_t future;		/* 0 */
+	uint8_t signature[16];	/* "Compressed ROMFS" */
 	struct cramfs_info fsid;/* unique filesystem info */
-	u8 name[16];		/* user-defined name */
+	uint8_t name[16];		/* user-defined name */
 	struct cramfs_inode root;	/* Root inode data */
 };

-#define CRAMFS_FLAG_FSID_VERSION_2      0x00000001      /* fsid version #2 */
-#define CRAMFS_FLAG_SORTED_DIRS         0x00000002      /* sorted dirs */
-#define CRAMFS_FLAG_HOLES               0x00000100      /* support for holes */
-#define CRAMFS_FLAG_WRONG_SIGNATURE     0x00000200      /* reserved */
-#define CRAMFS_FLAG_SHIFTED_ROOT_OFFSET 0x00000400      /* shifted root fs */
+#define CRAMFS_FLAG_FSID_VERSION_2	0x00000001	/* fsid version #2 */
+#define CRAMFS_FLAG_SORTED_DIRS		0x00000002	/* sorted dirs */
+#define CRAMFS_FLAG_HOLES		0x00000100	/* support for holes */
+#define CRAMFS_FLAG_WRONG_SIGNATURE	0x00000200	/* reserved */
+#define CRAMFS_FLAG_SHIFTED_ROOT_OFFSET 0x00000400	/* shifted root fs */

 /*
  * Valid values in super.flags.  Currently we refuse to mount
@@ -103,9 +104,11 @@ int cramfs_uncompress_block(void *dst, int
dstlen, void *src, int srclen);
 int cramfs_uncompress_init(void);
 int cramfs_uncompress_exit(void);

-u32 u32_toggle_endianness(int big_endian, u32 what);
+uint32_t u32_toggle_endianness(int big_endian, uint32_t what);
 void super_toggle_endianness(int from_big_endian, struct cramfs_super *super);
-void inode_to_host(int from_big_endian, struct cramfs_inode
*inode_in, struct cramfs_inode *inode_out);
-void inode_from_host(int to_big_endian, struct cramfs_inode
*inode_in, struct cramfs_inode *inode_out);
+void inode_to_host(int from_big_endian, struct cramfs_inode *inode_in,
+		   struct cramfs_inode *inode_out);
+void inode_from_host(int to_big_endian, struct cramfs_inode *inode_in,
+		     struct cramfs_inode *inode_out);

 #endif
diff --git a/disk-utils/cramfs_common.c b/disk-utils/cramfs_common.c
index 4f679cb..f4a257d 100644
--- a/disk-utils/cramfs_common.c
+++ b/disk-utils/cramfs_common.c
@@ -20,7 +20,7 @@
 #include "cramfs.h"
 #include "../include/bitops.h"

-u32 u32_toggle_endianness(int big_endian, u32 what)
+uint32_t u32_toggle_endianness(int big_endian, uint32_t what)
 {
 	return big_endian == HOST_IS_BIG_ENDIAN ? what : swab32(what);
 }
@@ -35,16 +35,17 @@ void super_toggle_endianness(int big_endian,
struct cramfs_super *super)
 		super->fsid.crc = swab32(super->fsid.crc);
 		super->fsid.edition = swab32(super->fsid.edition);
 		super->fsid.blocks = swab32(super->fsid.blocks);
-		super->fsid.files = swab32(super->fsid.files);	
+		super->fsid.files = swab32(super->fsid.files);
 	}
 }

-void inode_toggle_endianness(int input_big_endian, int
output_big_endian, struct cramfs_inode *inode_in, struct cramfs_inode
*inode_out)
+void inode_toggle_endianness(int input_big_endian, int output_big_endian,
+			     struct cramfs_inode *inode_in,
+			     struct cramfs_inode *inode_out)
 {
 	if (input_big_endian == output_big_endian) {
 		memmove(inode_out, inode_in, sizeof(*inode_out));
-	}
-	else {
+	} else {
 		unsigned char inode_out_buf[sizeof(*inode_in)];
 		unsigned char *inode_in_buf = (unsigned char*)inode_in;

@@ -52,7 +53,7 @@ void inode_toggle_endianness(int input_big_endian,
int output_big_endian, struct
 		inode_out_buf[1] = inode_in_buf[0];

 		inode_out_buf[2] = inode_in_buf[3]; /* 16 bit: uid */
-		inode_out_buf[3] = inode_in_buf[2];
+		inode_out_buf[3] = inode_in_buf[2];

 		inode_out_buf[4] = inode_in_buf[6]; /* 24 bit: size */
 		inode_out_buf[5] = inode_in_buf[5];
@@ -60,11 +61,12 @@ void inode_toggle_endianness(int input_big_endian,
int output_big_endian, struct

 		inode_out_buf[7] = inode_in_buf[7]; /* 8 bit: gid width */

-		/* Stop the madness! Outlaw C bitfields! They are unportable and nasty!
-		See for yourself what a mess this is: */
-
+		/*
+		 * Stop the madness! Outlaw C bitfields! They are unportable
+		 * and nasty! See for yourself what a mess this is:
+		 */
 		if (output_big_endian) {
-			inode_out_buf[ 8] = ( (inode_in_buf[ 8]&0x3F) << 2 ) |
+			inode_out_buf[ 8] = ( (inode_in_buf[ 8]&0x3F) << 2 ) |
 				( (inode_in_buf[11]&0xC0) >> 6 );

 			inode_out_buf[ 9] = ( (inode_in_buf[11]&0x3F) << 2 ) |
@@ -75,31 +77,33 @@ void inode_toggle_endianness(int input_big_endian,
int output_big_endian, struct

 			inode_out_buf[11] = ( (inode_in_buf[ 9]&0x3F) << 2 ) |
 				( (inode_in_buf[ 8]&0xC0) >> 6 );
-		}
-		else {
-			inode_out_buf[ 8] = ( (inode_in_buf[ 8]&0xFD) >> 2 ) |
+		} else {
+			inode_out_buf[ 8] = ( (inode_in_buf[ 8]&0xFD) >> 2 ) |
 				( (inode_in_buf[11]&0x03) << 6 );

-			inode_out_buf[ 9] = ( (inode_in_buf[11]&0xFD) >> 2 ) |
+			inode_out_buf[ 9] = ( (inode_in_buf[11]&0xFD) >> 2 ) |
 				( (inode_in_buf[10]&0x03) << 6 );

-			inode_out_buf[10] = ( (inode_in_buf[10]&0xFD) >> 2 ) |
+			inode_out_buf[10] = ( (inode_in_buf[10]&0xFD) >> 2 ) |
 				( (inode_in_buf[ 9]&0x03) << 6 );

-			inode_out_buf[11] = ( (inode_in_buf[ 9]&0xFD) >> 2 ) |
+			inode_out_buf[11] = ( (inode_in_buf[ 9]&0xFD) >> 2 ) |
 				( (inode_in_buf[ 8]&0x03) << 6 );
 		}
-
 		memmove(inode_out, inode_out_buf, sizeof(*inode_out));
 	}
 }

-void inode_to_host(int from_big_endian, struct cramfs_inode
*inode_in, struct cramfs_inode *inode_out)
+void inode_to_host(int from_big_endian, struct cramfs_inode *inode_in,
+		   struct cramfs_inode *inode_out)
 {
-	inode_toggle_endianness(from_big_endian, HOST_IS_BIG_ENDIAN,
inode_in, inode_out);
+	inode_toggle_endianness(from_big_endian, HOST_IS_BIG_ENDIAN, inode_in,
+				inode_out);
 }

-void inode_from_host(int to_big_endian, struct cramfs_inode
*inode_in, struct cramfs_inode *inode_out)
+void inode_from_host(int to_big_endian, struct cramfs_inode *inode_in,
+		     struct cramfs_inode *inode_out)
 {
-	inode_toggle_endianness(HOST_IS_BIG_ENDIAN, to_big_endian, inode_in,
inode_out);
+	inode_toggle_endianness(HOST_IS_BIG_ENDIAN, to_big_endian, inode_in,
+				inode_out);
 }
diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index 3d0c3e5..181c113 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -36,8 +36,18 @@
 /* compile-time options */
 //#define INCLUDE_FS_TESTS	/* include cramfs checking and extraction */

+/* Exit codes used by fsck-type programs */
+#define FSCK_OK			0	/* No errors */
+#define FSCK_NONDESTRUCT	1	/* File system errors corrected */
+#define FSCK_REBOOT		2	/* System should be rebooted */
+#define FSCK_UNCORRECTED	4	/* File system errors left uncorrected */
+#define FSCK_ERROR		8	/* Operational error */
+#define FSCK_USAGE		16	/* Usage or syntax error */
+#define FSCK_LIBRARY		128	/* Shared library error */
+
 #include <stdio.h>
 #include <stdarg.h>
+#include <stdint.h>
 #include <unistd.h>
 #include <dirent.h>
 #include <stdlib.h>
@@ -56,6 +66,10 @@
 #include "cramfs.h"
 #include "nls.h"
 #include "blkdev.h"
+#include "c.h"
+
+#define XALLOC_EXIT_CODE FSCK_ERROR
+#include "xalloc.h"

 static const char *progname = "cramfsck";

@@ -65,16 +79,7 @@ struct cramfs_super super;	/* just find the cramfs
superblock once */
 static int cramfs_is_big_endian = 0;	/* source is big endian */
 static int opt_verbose = 0;	/* 1 = verbose (-v), 2+ = very verbose (-vv) */

-char *extract_dir = "";	/* extraction directory (-x) */
-
-/* Exit codes used by fsck-type programs */
-#define FSCK_OK          0	/* No errors */
-#define FSCK_NONDESTRUCT 1	/* File system errors corrected */
-#define FSCK_REBOOT      2	/* System should be rebooted */
-#define FSCK_UNCORRECTED 4	/* File system errors left uncorrected */
-#define FSCK_ERROR       8	/* Operational error */
-#define FSCK_USAGE       16	/* Usage or syntax error */
-#define FSCK_LIBRARY     128	/* Shared library error */
+char *extract_dir = "";		/* extraction directory (-x) */

 #define PAD_SIZE 512

@@ -82,19 +87,19 @@ char *extract_dir = "";	/* extraction directory (-x) */

 static int opt_extract = 0;	/* extract cramfs (-x) */

-static uid_t euid;                     /* effective UID */
+static uid_t euid;		/* effective UID */

 /* (cramfs_super + start) <= start_dir < end_dir <= start_data <= end_data */
-static unsigned long start_dir = ~0UL; /* start of first non-root inode */
-static unsigned long end_dir = 0;      /* end of the directory structure */
-static unsigned long start_data = ~0UL;        /* start of the data
(256 MB = max) */
-static unsigned long end_data = 0;     /* end of the data */
+static unsigned long start_dir = ~0UL;	/* start of first non-root inode */
+static unsigned long end_dir = 0;	/* end of the directory structure */
+static unsigned long start_data = ~0UL;	/* start of the data (256 MB = max) */
+static unsigned long end_data = 0;	/* end of the data */


 /* Guarantee access to at least 8kB at a time */
 #define ROMBUFFER_BITS	13
 #define ROMBUFFERSIZE	(1 << ROMBUFFER_BITS)
-#define ROMBUFFERMASK	(ROMBUFFERSIZE-1)
+#define ROMBUFFERMASK	(ROMBUFFERSIZE - 1)
 static char read_buffer[ROMBUFFERSIZE * 2];
 static unsigned long read_buffer_block = ~0UL;

@@ -122,169 +127,138 @@ static void usage(int status)
 	exit(status);
 }

-static void die(int status, int syserr, const char *fmt, ...)
-{
-	va_list arg_ptr;
-	int save = errno;
-
-	fflush(0);
-	va_start(arg_ptr, fmt);
-	fprintf(stderr, "%s: ", progname);
-	vfprintf(stderr, fmt, arg_ptr);
-	if (syserr) {
-		fprintf(stderr, ": %s", strerror(save));
-	}
-	fprintf(stderr, "\n");
-	va_end(arg_ptr);
-	exit(status);
-}
-
-int get_superblock_endianness(u32 magic)
+int get_superblock_endianness(uint32_t magic)
 {
 	if (magic == CRAMFS_MAGIC) {
 		cramfs_is_big_endian = HOST_IS_BIG_ENDIAN;
 		return 0;
-	}
-	else if (magic == u32_toggle_endianness(!HOST_IS_BIG_ENDIAN, CRAMFS_MAGIC)) {
+	} else if (magic ==
+		   u32_toggle_endianness(!HOST_IS_BIG_ENDIAN, CRAMFS_MAGIC)) {
 		cramfs_is_big_endian = !HOST_IS_BIG_ENDIAN;
 		return 0;
-	}
-	else {
+	} else
 		return -1;
-	}
 }

-static void test_super(int *start, size_t *length) {
+static void test_super(int *start, size_t * length)
+{
 	struct stat st;

 	/* find the physical size of the file or block device */
-	if (stat(filename, &st) < 0) {
-		die(FSCK_ERROR, 1, _("stat failed: %s"), filename);
-	}
+	if (stat(filename, &st) < 0)
+		err(FSCK_ERROR, _("stat failed: %s"), filename);
+
 	fd = open(filename, O_RDONLY);
-	if (fd < 0) {
-		die(FSCK_ERROR, 1, _("open failed: %s"), filename);
-	}
+	if (fd < 0)
+		err(FSCK_ERROR, _("open failed: %s"), filename);
+
 	if (S_ISBLK(st.st_mode)) {
 		unsigned long long bytes;
-		if (blkdev_get_size(fd, &bytes)) {
-			die(FSCK_ERROR, 1, _("ioctl failed: unable to determine device
size: %s"), filename);
-		}
+		if (blkdev_get_size(fd, &bytes))
+			err(FSCK_ERROR,
+			    _("ioctl failed: unable to determine device size: %s"),
+			    filename);
 		*length = bytes;
-	}
-	else if (S_ISREG(st.st_mode)) {
+	} else if (S_ISREG(st.st_mode))
 		*length = st.st_size;
-	}
-	else {
-		die(FSCK_ERROR, 0, _("not a block device or file: %s"), filename);
-	}
+	else
+		errx(FSCK_ERROR, _("not a block device or file: %s"), filename);

-	if (*length < sizeof(struct cramfs_super)) {
-		die(FSCK_UNCORRECTED, 0, _("file length too short"));
-	}
+	if (*length < sizeof(struct cramfs_super))
+		errx(FSCK_UNCORRECTED, _("file length too short"));

 	/* find superblock */
-	if (read(fd, &super, sizeof(super)) != sizeof(super)) {
-		die(FSCK_ERROR, 1, _("read failed: %s"), filename);
-	}
-	if (get_superblock_endianness(super.magic) != -1) {
+	if (read(fd, &super, sizeof(super)) != sizeof(super))
+		err(FSCK_ERROR, _("read failed: %s"), filename);
+	if (get_superblock_endianness(super.magic) != -1)
 		*start = 0;
-	}
 	else if (*length >= (PAD_SIZE + sizeof(super))) {
 		lseek(fd, PAD_SIZE, SEEK_SET);
-		if (read(fd, &super, sizeof(super)) != sizeof(super)) {
-			die(FSCK_ERROR, 1, _("read failed: %s"), filename);
-		}
-		if (get_superblock_endianness(super.magic) != -1) {
+		if (read(fd, &super, sizeof(super)) != sizeof(super))
+			err(FSCK_ERROR, _("read failed: %s"), filename);
+		if (get_superblock_endianness(super.magic) != -1)
 			*start = PAD_SIZE;
-		}
-		else {
-			die(FSCK_UNCORRECTED, 0, "superblock magic not found");
-		}
-	}
-	else {
-		die(FSCK_UNCORRECTED, 0, _("superblock magic not found"));
-	}
+		else
+			errx(FSCK_UNCORRECTED, _("superblock magic not found"));
+	} else
+		errx(FSCK_UNCORRECTED, _("superblock magic not found"));

-	if (opt_verbose) {
-		printf("cramfs endianness is %s\n", cramfs_is_big_endian ? "big" : "little");
-	}
+	if (opt_verbose)
+		printf(_("cramfs endianness is %s\n"),
+		       cramfs_is_big_endian ? _("big") : _("little"));

 	super_toggle_endianness(cramfs_is_big_endian, &super);
-	if (super.flags & ~CRAMFS_SUPPORTED_FLAGS) {
-		die(FSCK_ERROR, 0, _("unsupported filesystem features"));
-	}
-	if (super.size < page_size) {
-		die(FSCK_UNCORRECTED, 0, _("superblock size (%d) too small"), super.size);
-	}
+	if (super.flags & ~CRAMFS_SUPPORTED_FLAGS)
+		errx(FSCK_ERROR, _("unsupported filesystem features"));
+
+	if (super.size < page_size)
+		errx(FSCK_UNCORRECTED, _("superblock size (%d) too small"),
+		     super.size);
+
 	if (super.flags & CRAMFS_FLAG_FSID_VERSION_2) {
-		if (super.fsid.files == 0) {
-			die(FSCK_UNCORRECTED, 0, _("zero file count"));
-		}
-		if (*length < super.size) {
-			die(FSCK_UNCORRECTED, 0, _("file length too short"));
-		}
-		else if (*length > super.size) {
-			fprintf(stderr, _("warning: file extends past end of filesystem\n"));
-		}
-	}
-	else {
+		if (super.fsid.files == 0)
+			errx(FSCK_UNCORRECTED, _("zero file count"));
+		if (*length < super.size)
+			errx(FSCK_UNCORRECTED, _("file length too short"));
+		else if (*length > super.size)
+			fprintf(stderr,
+				_("warning: file extends past end of filesystem\n"));
+	} else
 		fprintf(stderr, _("warning: old cramfs format\n"));
-	}
 }

 static void test_crc(int start)
 {
 	void *buf;
-	u32 crc;
+	uint32_t crc;

 	if (!(super.flags & CRAMFS_FLAG_FSID_VERSION_2)) {
 #ifdef INCLUDE_FS_TESTS
 		return;
-#else /* not INCLUDE_FS_TESTS */
-		die(FSCK_USAGE, 0, _("unable to test CRC: old cramfs format"));
-#endif /* not INCLUDE_FS_TESTS */
+#else
+		errx(FSCK_USAGE, _("unable to test CRC: old cramfs format"));
+#endif
 	}

 	crc = crc32(0L, Z_NULL, 0);

-	buf = mmap(NULL, super.size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	buf =
+	    mmap(NULL, super.size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if (buf == MAP_FAILED) {
-		buf = mmap(NULL, super.size, PROT_READ | PROT_WRITE, MAP_PRIVATE |
MAP_ANONYMOUS, -1, 0);
+		buf =
+		    mmap(NULL, super.size, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 		if (buf != MAP_FAILED) {
 			lseek(fd, 0, SEEK_SET);
 			if (read(fd, buf, super.size) < 0)
-				die(FSCK_ERROR, 1, _("read failed: %s"), filename);
+				err(FSCK_ERROR, _("read failed: %s"), filename);
 		}
 	}
 	if (buf != MAP_FAILED) {
-		((struct cramfs_super *) (buf+start))->fsid.crc = crc32(0L, Z_NULL, 0);
-		crc = crc32(crc, buf+start, super.size-start);
+		((struct cramfs_super *)(buf + start))->fsid.crc =
+		    crc32(0L, Z_NULL, 0);
+		crc = crc32(crc, buf + start, super.size - start);
 		munmap(buf, super.size);
-	}
-	else {
+	} else {
 		int retval;
 		size_t length = 0;

-		buf = malloc(4096);
-		if (!buf) {
-			die(FSCK_ERROR, 1, _("malloc failed"));
-		}
+		buf = xmalloc(4096);
 		lseek(fd, start, SEEK_SET);
 		for (;;) {
 			retval = read(fd, buf, 4096);
-			if (retval < 0) {
-				die(FSCK_ERROR, 1, _("read failed: %s"), filename);
-			}
-			else if (retval == 0) {
+			if (retval < 0)
+				err(FSCK_ERROR, _("read failed: %s"), filename);
+			else if (retval == 0)
 				break;
-			}
-			if (length == 0) {
-				((struct cramfs_super *) buf)->fsid.crc = crc32(0L, Z_NULL, 0);
-			}
+			if (length == 0)
+				((struct cramfs_super *)buf)->fsid.crc =
+				    crc32(0L, Z_NULL, 0);
 			length += retval;
-			if (length > (super.size-start)) {
-				crc = crc32(crc, buf, retval - (length - (super.size-start)));
+			if (length > (super.size - start)) {
+				crc = crc32(crc, buf,
+					  retval - (length -
+						    (super.size - start)));
 				break;
 			}
 			crc = crc32(crc, buf, retval);
@@ -292,9 +266,8 @@ static void test_crc(int start)
 		free(buf);
 	}

-	if (crc != super.fsid.crc) {
-		die(FSCK_UNCORRECTED, 0, _("crc error"));
-	}
+	if (crc != super.fsid.crc)
+		errx(FSCK_UNCORRECTED, _("crc error"));
 }

 #ifdef INCLUDE_FS_TESTS
@@ -302,14 +275,12 @@ static void print_node(char type, struct
cramfs_inode *i, char *name)
 {
 	char info[10];

-	if (S_ISCHR(i->mode) || (S_ISBLK(i->mode))) {
+	if (S_ISCHR(i->mode) || (S_ISBLK(i->mode)))
 		/* major/minor numbers can be as high as 2^12 or 4096 */
 		snprintf(info, 10, "%4d,%4d", major(i->size), minor(i->size));
-	}
-	else {
+	else
 		/* size be as high as 2^24 or 16777216 */
 		snprintf(info, 10, "%9d", i->size);
-	}

 	printf("%c %04o %s %5d:%-3d %s\n",
 	       type, i->mode & ~S_IFMT, info, i->uid, i->gid,
@@ -330,13 +301,10 @@ static void *romfs_read(unsigned long offset)
 	return read_buffer + (offset & ROMBUFFERMASK);
 }

-static struct cramfs_inode *cramfs_iget(struct cramfs_inode * i)
+static struct cramfs_inode *cramfs_iget(struct cramfs_inode *i)
 {
-	struct cramfs_inode *inode = malloc(sizeof(struct cramfs_inode));
+	struct cramfs_inode *inode = xmalloc(sizeof(struct cramfs_inode));

-	if (!inode) {
-		die(FSCK_ERROR, 1, _("malloc failed"));
-	}
 	inode_to_host(cramfs_is_big_endian, i, inode);
 	return inode;
 }
@@ -356,16 +324,15 @@ static void iput(struct cramfs_inode *inode)
  */
 static struct cramfs_inode *read_super(void)
 {
-	struct cramfs_inode * root = cramfs_iget(&super.root);
+	struct cramfs_inode *root = cramfs_iget(&super.root);
 	unsigned long offset = root->offset << 2;

 	if (!S_ISDIR(root->mode))
-		die(FSCK_UNCORRECTED, 0, _("root inode is not directory"));
+		errx(FSCK_UNCORRECTED, _("root inode is not directory"));
 	if (!(super.flags & CRAMFS_FLAG_SHIFTED_ROOT_OFFSET) &&
 	    ((offset != sizeof(struct cramfs_super)) &&
-	     (offset != PAD_SIZE + sizeof(struct cramfs_super))))
-	{
-		die(FSCK_UNCORRECTED, 0, _("bad root offset (%lu)"), offset);
+	     (offset != PAD_SIZE + sizeof(struct cramfs_super)))) {
+		errx(FSCK_UNCORRECTED, _("bad root offset (%lu)"), offset);
 	}
 	return root;
 }
@@ -377,68 +344,68 @@ static int uncompress_block(void *src, int len)
 	stream.next_in = src;
 	stream.avail_in = len;

-	stream.next_out = (unsigned char *) outbuffer;
-	stream.avail_out = page_size*2;
+	stream.next_out = (unsigned char *)outbuffer;
+	stream.avail_out = page_size * 2;

 	inflateReset(&stream);

-	if (len > page_size*2) {
-		die(FSCK_UNCORRECTED, 0, _("data block too large"));
-	}
+	if (len > page_size * 2)
+		errx(FSCK_UNCORRECTED, _("data block too large"));
+
 	err = inflate(&stream, Z_FINISH);
-	if (err != Z_STREAM_END) {
-		die(FSCK_UNCORRECTED, 0, _("decompression error %p(%d): %s"),
-		    zError(err), src, len);
-	}
+	if (err != Z_STREAM_END)
+		errx(FSCK_UNCORRECTED, _("decompression error %p(%d): %s"),
+		     zError(err), src, len);
 	return stream.total_out;
 }

 #if !HAVE_LCHOWN
 #define lchown chown
 #endif
-static void do_uncompress(char *path, int fd, unsigned long offset,
unsigned long size)
+
+static void do_uncompress(char *path, int fd, unsigned long offset,
+			  unsigned long size)
 {
 	unsigned long curr = offset + 4 * ((size + page_size - 1) / page_size);

 	do {
 		unsigned long out = page_size;
-		unsigned long next = u32_toggle_endianness(cramfs_is_big_endian,
*(u32 *) romfs_read(offset));
+		unsigned long next = u32_toggle_endianness(cramfs_is_big_endian,
+							   *(uint32_t *)
+							   romfs_read(offset));

-		if (next > end_data) {
+		if (next > end_data)
 			end_data = next;
-		}

 		offset += 4;
 		if (curr == next) {
-			if (opt_verbose > 1) {
-				printf(_("  hole at %ld (%zd)\n"), curr, page_size);
-			}
+			if (opt_verbose > 1)
+				printf(_("  hole at %ld (%zd)\n"), curr,
+				       page_size);
 			if (size < page_size)
 				out = size;
 			memset(outbuffer, 0x00, out);
-		}
-		else {
-			if (opt_verbose > 1) {
-				printf(_("  uncompressing block at %ld to %ld (%ld)\n"), curr,
next, next - curr);
-			}
+		} else {
+			if (opt_verbose > 1)
+				printf(_("  uncompressing block at %ld to %ld (%ld)\n"),
+				       curr, next, next - curr);
 			out = uncompress_block(romfs_read(curr), next - curr);
 		}
 		if (size >= page_size) {
-			if (out != page_size) {
-				die(FSCK_UNCORRECTED, 0, _("non-block (%ld) bytes"), out);
-			}
-		} else {
-			if (out != size) {
-				die(FSCK_UNCORRECTED, 0, _("non-size (%ld vs %ld) bytes"), out, size);
-			}
-		}
-		size -= out;
-		if (opt_extract) {
-			if (write(fd, outbuffer, out) < 0) {
-				die(FSCK_ERROR, 1, _("write failed: %s"), path);
-			}
+			if (out != page_size)
+				errx(FSCK_UNCORRECTED,
+				     _("non-block (%ld) bytes"), out);
+			else if (out != size)
+				errx(FSCK_UNCORRECTED,
+				     _("non-size (%ld vs %ld) bytes"), out,
+				     size);
+			size -= out;
+			if (opt_extract)
+				if (write(fd, outbuffer, out) < 0)
+					err(FSCK_ERROR, _("write failed: %s"),
+					    path);
+			curr = next;
 		}
-		curr = next;
 	} while (size);
 }

@@ -447,22 +414,18 @@ static void change_file_status(char *path,
struct cramfs_inode *i)
 	struct utimbuf epoch = { 0, 0 };

 	if (euid == 0) {
-		if (lchown(path, i->uid, i->gid) < 0) {
-			die(FSCK_ERROR, 1, _("lchown failed: %s"), path);
-		}
+		if (lchown(path, i->uid, i->gid) < 0)
+			err(FSCK_ERROR, _("lchown failed: %s"), path);
 		if (S_ISLNK(i->mode))
 			return;
-		if ((S_ISUID | S_ISGID) & i->mode) {
-			if (chmod(path, i->mode) < 0) {
-				die(FSCK_ERROR, 1, _("chown failed: %s"), path);
-			}
-		}
+		if ((S_ISUID | S_ISGID) & i->mode)
+			if (chmod(path, i->mode) < 0)
+				err(FSCK_ERROR, _("chown failed: %s"), path);
 	}
 	if (S_ISLNK(i->mode))
 		return;
-	if (utime(path, &epoch) < 0) {
-		die(FSCK_ERROR, 1, _("utime failed: %s"), path);
-	}
+	if (utime(path, &epoch) < 0)
+		err(FSCK_ERROR, _("utime failed: %s"), path);
 }

 static void do_directory(char *path, struct cramfs_inode *i)
@@ -470,28 +433,26 @@ static void do_directory(char *path, struct
cramfs_inode *i)
 	int pathlen = strlen(path);
 	int count = i->size;
 	unsigned long offset = i->offset << 2;
-	char *newpath = malloc(pathlen + 256);
+	char *newpath = xmalloc(pathlen + 256);

-	if (!newpath) {
-		die(FSCK_ERROR, 1, _("malloc failed"));
-	}
-	if (offset == 0 && count != 0) {
-		die(FSCK_UNCORRECTED, 0, _("directory inode has zero offset and
non-zero size: %s"), path);
-	}
-	if (offset != 0 && offset < start_dir) {
+	if (offset == 0 && count != 0)
+		errx(FSCK_UNCORRECTED,
+		     _("directory inode has zero offset and non-zero size: %s"),
+		     path);
+
+	if (offset != 0 && offset < start_dir)
 		start_dir = offset;
-	}
+
 	/* TODO: Do we need to check end_dir for empty case? */
 	memcpy(newpath, path, pathlen);
 	newpath[pathlen] = '/';
 	pathlen++;
-	if (opt_verbose) {
+	if (opt_verbose)
 		print_node('d', i, path);
-	}
+
 	if (opt_extract) {
-		if (mkdir(path, i->mode) < 0) {
-			die(FSCK_ERROR, 1, _("mkdir failed: %s"), path);
-		}
+		if (mkdir(path, i->mode) < 0)
+			err(FSCK_ERROR, _("mkdir failed: %s"), path);
 		change_file_status(path, i);
 	}
 	while (count > 0) {
@@ -506,23 +467,19 @@ static void do_directory(char *path, struct
cramfs_inode *i)

 		memcpy(newpath + pathlen, romfs_read(offset), newlen);
 		newpath[pathlen + newlen] = 0;
-		if (newlen == 0) {
-			die(FSCK_UNCORRECTED, 0, _("filename length is zero"));
-		}
-		if ((pathlen + newlen) - strlen(newpath) > 3) {
-			die(FSCK_UNCORRECTED, 0, _("bad filename length"));
-		}
+		if (newlen == 0)
+			errx(FSCK_UNCORRECTED, _("filename length is zero"));
+		if ((pathlen + newlen) - strlen(newpath) > 3)
+			errx(FSCK_UNCORRECTED, _("bad filename length"));
 		expand_fs(newpath, child);

 		offset += newlen;

-		if (offset <= start_dir) {
-			die(FSCK_UNCORRECTED, 0, _("bad inode offset"));
-		}
-		if (offset > end_dir) {
+		if (offset <= start_dir)
+			errx(FSCK_UNCORRECTED, _("bad inode offset"));
+		if (offset > end_dir)
 			end_dir = offset;
-		}
-		iput(child); /* free(child) */
+		iput(child);	/* free(child) */
 	}
 	free(newpath);
 }
@@ -532,27 +489,23 @@ static void do_file(char *path, struct cramfs_inode *i)
 	unsigned long offset = i->offset << 2;
 	int fd = 0;

-	if (offset == 0 && i->size != 0) {
-		die(FSCK_UNCORRECTED, 0, _("file inode has zero offset and non-zero size"));
-	}
-	if (i->size == 0 && offset != 0) {
-		die(FSCK_UNCORRECTED, 0, _("file inode has zero size and non-zero offset"));
-	}
-	if (offset != 0 && offset < start_data) {
+	if (offset == 0 && i->size != 0)
+		errx(FSCK_UNCORRECTED,
+		     _("file inode has zero offset and non-zero size"));
+	if (i->size == 0 && offset != 0)
+		errx(FSCK_UNCORRECTED,
+		     _("file inode has zero size and non-zero offset"));
+	if (offset != 0 && offset < start_data)
 		start_data = offset;
-	}
-	if (opt_verbose) {
+	if (opt_verbose)
 		print_node('f', i, path);
-	}
 	if (opt_extract) {
 		fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, i->mode);
-		if (fd < 0) {
-			die(FSCK_ERROR, 1, _("open failed: %s"), path);
-		}
+		if (fd < 0)
+			err(FSCK_ERROR, _("open failed: %s"), path);
 	}
-	if (i->size) {
+	if (i->size)
 		do_uncompress(path, fd, offset, i->size);
-	}
 	if (opt_extract) {
 		close(fd);
 		change_file_status(path, i);
@@ -563,42 +516,38 @@ static void do_symlink(char *path, struct cramfs_inode *i)
 {
 	unsigned long offset = i->offset << 2;
 	unsigned long curr = offset + 4;
-	unsigned long next = u32_toggle_endianness(cramfs_is_big_endian,
*(u32 *) romfs_read(offset));
+	unsigned long next =
+	    u32_toggle_endianness(cramfs_is_big_endian,
+				  *(uint32_t *) romfs_read(offset));
 	unsigned long size;

-	if (offset == 0) {
-		die(FSCK_UNCORRECTED, 0, _("symbolic link has zero offset"));
-	}
-	if (i->size == 0) {
-		die(FSCK_UNCORRECTED, 0, _("symbolic link has zero size"));
-	}
+	if (offset == 0)
+		errx(FSCK_UNCORRECTED, _("symbolic link has zero offset"));
+	if (i->size == 0)
+		errx(FSCK_UNCORRECTED, _("symbolic link has zero size"));

-	if (offset < start_data) {
+	if (offset < start_data)
 		start_data = offset;
-	}
-	if (next > end_data) {
+	if (next > end_data)
 		end_data = next;
-	}

 	size = uncompress_block(romfs_read(curr), next - curr);
-	if (size != i->size) {
-		die(FSCK_UNCORRECTED, 0, _("size error in symlink: %s"), path);
-	}
+	if (size != i->size)
+		errx(FSCK_UNCORRECTED, _("size error in symlink: %s"), path);
 	outbuffer[size] = 0;
 	if (opt_verbose) {
 		char *str;

 		asprintf(&str, "%s -> %s", path, outbuffer);
 		print_node('l', i, str);
-		if (opt_verbose > 1) {
-			printf(_("  uncompressing block at %ld to %ld (%ld)\n"), curr,
next, next - curr);
-		}
+		if (opt_verbose > 1)
+			printf(_("  uncompressing block at %ld to %ld (%ld)\n"),
+			       curr, next, next - curr);
 		free(str);
 	}
 	if (opt_extract) {
-		if (symlink(outbuffer, path) < 0) {
-			die(FSCK_ERROR, 1, _("symlink failed: %s"), path);
-		}
+		if (symlink(outbuffer, path) < 0)
+			err(FSCK_ERROR, _("symlink failed: %s"), path);
 		change_file_status(path, i);
 	}
 }
@@ -608,60 +557,52 @@ static void do_special_inode(char *path, struct
cramfs_inode *i)
 	dev_t devtype = 0;
 	char type;

-	if (i->offset) {	/* no need to shift offset */
-		die(FSCK_UNCORRECTED, 0, _("special file has non-zero offset: %s"), path);
-	}
+	if (i->offset)
+		/* no need to shift offset */
+		errx(FSCK_UNCORRECTED,
+		     _("special file has non-zero offset: %s"), path);
+
 	if (S_ISCHR(i->mode)) {
 		devtype = i->size;
 		type = 'c';
-	}
-	else if (S_ISBLK(i->mode)) {
+	} else if (S_ISBLK(i->mode)) {
 		devtype = i->size;
 		type = 'b';
-	}
-	else if (S_ISFIFO(i->mode)) {
-		if (i->size != 0) {
-			die(FSCK_UNCORRECTED, 0, _("fifo has non-zero size: %s"), path);
-		}
+	} else if (S_ISFIFO(i->mode)) {
+		if (i->size != 0)
+			errx(FSCK_UNCORRECTED, _("fifo has non-zero size: %s"),
+			     path);
 		type = 'p';
-	}
-	else if (S_ISSOCK(i->mode)) {
-		if (i->size != 0) {
-			die(FSCK_UNCORRECTED, 0, _("socket has non-zero size: %s"), path);
-		}
+	} else if (S_ISSOCK(i->mode)) {
+		if (i->size != 0)
+			errx(FSCK_UNCORRECTED,
+			     _("socket has non-zero size: %s"), path);
 		type = 's';
-	}
-	else {
-		die(FSCK_UNCORRECTED, 0, _("bogus mode: %s (%o)"), path, i->mode);
+	} else {
+		errx(FSCK_UNCORRECTED, _("bogus mode: %s (%o)"), path, i->mode);
 		return;		/* not reached */
 	}

-	if (opt_verbose) {
+	if (opt_verbose)
 		print_node(type, i, path);
-	}

 	if (opt_extract) {
-		if (mknod(path, i->mode, devtype) < 0) {
-			die(FSCK_ERROR, 1, _("mknod failed: %s"), path);
-		}
+		if (mknod(path, i->mode, devtype) < 0)
+			err(FSCK_ERROR, _("mknod failed: %s"), path);
 		change_file_status(path, i);
 	}
 }

 static void expand_fs(char *path, struct cramfs_inode *inode)
 {
-	if (S_ISDIR(inode->mode)) {
+	if (S_ISDIR(inode->mode))
 		do_directory(path, inode);
-	}
-	else if (S_ISREG(inode->mode)) {
+	else if (S_ISREG(inode->mode))
 		do_file(path, inode);
-	}
-	else if (S_ISLNK(inode->mode)) {
+	else if (S_ISLNK(inode->mode))
 		do_symlink(path, inode);
-	}
-	else {
+	else
 		do_special_inode(path, inode);
-	}
 }

 static void test_fs(int start)
@@ -677,18 +618,19 @@ static void test_fs(int start)
 	expand_fs(extract_dir, root);
 	inflateEnd(&stream);
 	if (start_data != ~0UL) {
-		if (start_data < (sizeof(struct cramfs_super) + start)) {
-			die(FSCK_UNCORRECTED, 0, _("directory data start (%ld) <
sizeof(struct cramfs_super) + start (%ld)"), start_data, sizeof(struct
cramfs_super) + start);
-		}
-		if (end_dir != start_data) {
-			die(FSCK_UNCORRECTED, 0, _("directory data end (%ld) != file data
start (%ld)"), end_dir, start_data);
-		}
-	}
-	if (super.flags & CRAMFS_FLAG_FSID_VERSION_2) {
-		if (end_data > super.size) {
-			die(FSCK_UNCORRECTED, 0, _("invalid file data offset"));
-		}
-	}
+		if (start_data < (sizeof(struct cramfs_super) + start))
+			errx(FSCK_UNCORRECTED,
+			     _("directory data start (%ld) < sizeof(struct cramfs_super) +
start (%ld)"),
+			     start_data, sizeof(struct cramfs_super) + start);
+		if (end_dir != start_data)
+			errx(FSCK_UNCORRECTED,
+			     _("directory data end (%ld) != file data start (%ld)"),
+			     end_dir, start_data);
+	}
+	if (super.flags & CRAMFS_FLAG_FSID_VERSION_2)
+		if (end_data > super.size)
+			errx(FSCK_UNCORRECTED, _("invalid file data offset"));
+
 	iput(root);		/* free(root) */
 }
 #endif /* INCLUDE_FS_TESTS */
@@ -708,12 +650,10 @@ int main(int argc, char **argv)
 	if (argc)
 		progname = argv[0];

-	outbuffer = malloc(page_size * 2);
-	if (!outbuffer)
-		die(FSCK_ERROR, 1, _("failed to allocate outbuffer"));
+	outbuffer = xmalloc(page_size * 2);

 	/* command line options */
-	while ((c = getopt(argc, argv, "hx:v")) != EOF) {
+	while ((c = getopt(argc, argv, "hx:v")) != EOF)
 		switch (c) {
 		case 'h':
 			usage(FSCK_OK);
@@ -722,14 +662,13 @@ int main(int argc, char **argv)
 			opt_extract = 1;
 			extract_dir = optarg;
 			break;
-#else /* not INCLUDE_FS_TESTS */
-			die(FSCK_USAGE, 0, _("compiled without -x support"));
-#endif /* not INCLUDE_FS_TESTS */
+#else
+			errx(FSCK_USAGE, _("compiled without -x support"));
+#endif
 		case 'v':
 			opt_verbose++;
 			break;
 		}
-	}

 	if ((argc - optind) != 1)
 		usage(FSCK_USAGE);
@@ -739,11 +678,10 @@ int main(int argc, char **argv)
 	test_crc(start);
 #ifdef INCLUDE_FS_TESTS
 	test_fs(start);
-#endif /* INCLUDE_FS_TESTS */
+#endif

-	if (opt_verbose) {
-		printf("%s: OK\n", filename);
-	}
+	if (opt_verbose)
+		printf(_("%s: OK\n"), filename);

 	exit(FSCK_OK);
 }
diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index 6767ba3..1446a57 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -30,22 +30,26 @@
 #include <sys/mman.h>
 #include <fcntl.h>
 #include <dirent.h>
+#include <stddef.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
 #include <getopt.h>
-#include <stdarg.h>
+#include <zconf.h>
 #include <zlib.h>

+#include "c.h"
 #include "cramfs.h"
 #include "md5.h"
 #include "nls.h"
 #include "mkfs.h"
+#include "strutils.h"
+#define XALLOC_EXIT_CODE MKFS_ERROR
+#include "xalloc.h"

 /* The kernel only supports PAD_SIZE of 0 and 512. */
 #define PAD_SIZE 512

-static const char *progname = "mkcramfs";
 static int verbose = 0;

 static unsigned int blksize; /* settable via -b option */
@@ -88,14 +92,14 @@ struct entry {
 	/* stats */
 	unsigned char *name;
 	unsigned int mode, size, uid, gid;
-	unsigned char md5sum[16];
+	unsigned char md5sum[MD5LENGTH];
 	unsigned char flags;	   /* CRAMFS_EFLAG_* */

 	/* FS data */
 	char *path;
 	int fd;			    /* temporarily open files while mmapped */
-        struct entry *same;	    /* points to other identical file */
-        unsigned int offset;        /* pointer to compressed data in archive */
+	struct entry *same;	    /* points to other identical file */
+	unsigned int offset;        /* pointer to compressed data in archive */
 	unsigned int dir_offset;    /* offset of directory entry in archive */

 	/* organization */
@@ -135,22 +139,11 @@ usage(int status) {
 		  " -z         make explicit holes (requires >= 2.3.39)\n"
 		  " dirname    root of the filesystem to be compressed\n"
 		  " outfile    output file\n"),
-		progname, PAD_SIZE);
+		program_invocation_short_name, PAD_SIZE);

 	exit(status);
 }

-/* malloc or die */
-static void *
-xmalloc (size_t size) {
-	void *t = malloc(size);
-	if (t == NULL) {
-		perror(NULL);
-		exit(MKFS_ERROR);	/* out of memory */
-	}
-	return t;
-}
-
 static char *
 do_mmap(char *path, unsigned int size, unsigned int mode){
 	int fd;
@@ -177,10 +170,8 @@ do_mmap(char *path, unsigned int size, unsigned int mode){
 	}

 	start = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
-	if (-1 == (int) (long) start) {
-		perror("mmap");
-		exit(MKFS_ERROR);
-	}
+	if (-1 == (int) (long) start)
+		err(MKFS_ERROR, "mmap");
 	close(fd);

 	return start;
@@ -244,11 +235,11 @@ identical_file(struct entry *e1, struct entry *e2){

 static int find_identical_file(struct entry *orig, struct entry *new,
loff_t *fslen_ub)
 {
-        if (orig == new)
+	if (orig == new)
 		return 1;
-        if (!orig)
+	if (!orig)
 		return 0;
-        if (orig->size == new->size && orig->path) {
+	if (orig->size == new->size && orig->path) {
 		if (!orig->flags)
 			mdfile(orig);
 		if (!new->flags)
@@ -256,24 +247,24 @@ static int find_identical_file(struct entry
*orig, struct entry *new, loff_t *fs

 		if ((orig->flags & CRAMFS_EFLAG_MD5) &&
 		    (new->flags & CRAMFS_EFLAG_MD5) &&
-		    !memcmp(orig->md5sum, new->md5sum, 16) &&
+		    !memcmp(orig->md5sum, new->md5sum, MD5LENGTH) &&
 		    identical_file(orig, new)) {
 			new->same = orig;
 			*fslen_ub -= new->size;
 			return 1;
 		}
-        }
-        return find_identical_file(orig->child, new, fslen_ub) ||
-                   find_identical_file(orig->next, new, fslen_ub);
+	}
+	return find_identical_file(orig->child, new, fslen_ub) ||
+		   find_identical_file(orig->next, new, fslen_ub);
 }

 static void eliminate_doubles(struct entry *root, struct entry *orig,
loff_t *fslen_ub) {
-        if (orig) {
-                if (orig->size && orig->path)
+	if (orig) {
+		if (orig->size && orig->path)
 			find_identical_file(root,orig, fslen_ub);
-                eliminate_doubles(root,orig->child, fslen_ub);
-                eliminate_doubles(root,orig->next, fslen_ub);
-        }
+		eliminate_doubles(root,orig->child, fslen_ub);
+		eliminate_doubles(root,orig->next, fslen_ub);
+	}
 }

 /*
@@ -300,13 +291,11 @@ static unsigned int parse_directory(struct entry
*root_entry, const char *name,
 	*endpath = '/';
 	endpath++;

-        /* read in the directory and sort */
-        dircount = scandir(name, &dirlist, 0, cramsort);
+	/* read in the directory and sort */
+	dircount = scandir(name, &dirlist, 0, cramsort);

-	if (dircount < 0) {
-		perror(name);
-		exit(MKFS_ERROR);
-	}
+	if (dircount < 0)
+		err(MKFS_ERROR, _("could not read directory %s"), name);

 	/* process directory */
 	for (dirindex = 0; dirindex < dircount; dirindex++) {
@@ -329,14 +318,12 @@ static unsigned int parse_directory(struct entry
*root_entry, const char *name,
 			}
 		}
 		namelen = strlen(dirent->d_name);
-		if (namelen > MAX_INPUT_NAMELEN) {
-			fprintf(stderr,
+		if (namelen > MAX_INPUT_NAMELEN)
+			errx(MKFS_ERROR,
 				_("Very long (%zu bytes) filename `%s' found.\n"
 				  " Please increase MAX_INPUT_NAMELEN in "
-				  "mkcramfs.c and recompile.  Exiting.\n"),
+				  "mkcramfs.c and recompile.  Exiting."),
 				namelen, dirent->d_name);
-			exit(MKFS_ERROR);
-		}
 		memcpy(endpath, dirent->d_name, namelen + 1);

 		if (lstat(path, &st) < 0) {
@@ -344,16 +331,8 @@ static unsigned int parse_directory(struct entry
*root_entry, const char *name,
 			warn_skip = 1;
 			continue;
 		}
-		entry = calloc(1, sizeof(struct entry));
-		if (!entry) {
-			perror(NULL);
-			exit(MKFS_ERROR);
-		}
-		entry->name = (unsigned char *)strdup(dirent->d_name);
-		if (!entry->name) {
-			perror(NULL);
-			exit(MKFS_ERROR);
-		}
+		entry = xcalloc(1, sizeof(struct entry));
+		entry->name = (unsigned char *)xstrdup(dirent->d_name);
 		if (namelen > 255) {
 			/* Can't happen when reading from ext2fs. */

@@ -370,17 +349,17 @@ static unsigned int parse_directory(struct entry
*root_entry, const char *name,
 		entry->gid = st.st_gid;
 		if (entry->gid >= 1 << CRAMFS_GID_WIDTH)
 			/* TODO: We ought to replace with a default
-                           gid instead of truncating; otherwise there
-                           are security problems.  Maybe mode should
-                           be &= ~070.  Same goes for uid once Linux
-                           supports >16-bit uids. */
+			   gid instead of truncating; otherwise there
+			   are security problems.  Maybe mode should
+			   be &= ~070.  Same goes for uid once Linux
+			   supports >16-bit uids. */
 			warn_gid = 1;
 		size = sizeof(struct cramfs_inode) + ((namelen + 3) & ~3);
 		*fslen_ub += size;
 		if (S_ISDIR(st.st_mode)) {
 			entry->size = parse_directory(root_entry, path, &entry->child, fslen_ub);
 		} else if (S_ISREG(st.st_mode)) {
-			entry->path = strdup(path);
+			entry->path = xstrdup(path);
 			if (entry->size) {
 				if (entry->size >= (1 << CRAMFS_SIZE_WIDTH)) {
 					warn_size = 1;
@@ -388,7 +367,7 @@ static unsigned int parse_directory(struct entry
*root_entry, const char *name,
 				}
 			}
 		} else if (S_ISLNK(st.st_mode)) {
-			entry->path = strdup(path);
+			entry->path = xstrdup(path);
 		} else if (S_ISFIFO(st.st_mode) || S_ISSOCK(st.st_mode)) {
 			/* maybe we should skip sockets */
 			entry->size = 0;
@@ -404,7 +383,7 @@ static unsigned int parse_directory(struct entry
*root_entry, const char *name,
 			/* block pointers & data expansion allowance + data */
 			if (entry->size)
 				*fslen_ub += (4+26)*blocks + entry->size + 3;
-                }
+		}

 		/* Link it into the list */
 		*prev = entry;
@@ -462,10 +441,8 @@ static void set_data_offset(struct entry *entry,
char *base, unsigned long offse
 {
 	struct cramfs_inode *inode = (struct cramfs_inode *) (base +
entry->dir_offset);
 	inode_to_host(cramfs_is_big_endian, inode, inode);
-	if (offset >= (1 << (2 + CRAMFS_OFFSET_WIDTH))) {
-		fprintf(stderr, _("filesystem too big.  Exiting.\n"));
-		exit(MKFS_ERROR);
-	}
+	if (offset >= (1 << (2 + CRAMFS_OFFSET_WIDTH)))
+		errx(MKFS_ERROR, _("filesystem too big.  Exiting."));
 	inode->offset = (offset >> 2);
 	inode_from_host(cramfs_is_big_endian, inode, inode);
 }
@@ -517,11 +494,7 @@ static unsigned int
write_directory_structure(struct entry *entry, char *base, u
 			if (entry->child) {
 				if (stack_entries >= stack_size) {
 					stack_size *= 2;
-					entry_stack = realloc(entry_stack, stack_size * sizeof(struct entry *));
-					if (!entry_stack) {
-						perror(NULL);
-						exit(MKFS_ERROR);        /* out of memory */
-					}
+					entry_stack = xrealloc(entry_stack, stack_size * sizeof(struct entry *));
 				}
 				entry_stack[stack_entries] = entry;
 				stack_entries++;
@@ -532,9 +505,9 @@ static unsigned int
write_directory_structure(struct entry *entry, char *base, u

 		/*
 		 * Reverse the order the stack entries pushed during
-                 * this directory, for a small optimization of disk
-                 * access in the created fs.  This change makes things
-                 * `ls -UR' order.
+		 * this directory, for a small optimization of disk
+		 * access in the created fs.  This change makes things
+		 * `ls -UR' order.
 		 */
 		{
 			struct entry **lo = entry_stack + dir_start;
@@ -634,7 +607,7 @@ do_compress(char *base, unsigned int offset,
unsigned char const *name,
 			exit(MKFS_ERROR);
 		}

-		*(u32 *) (base + offset) = u32_toggle_endianness(cramfs_is_big_endian, curr);
+		*(uint32_t *) (base + offset) =
u32_toggle_endianness(cramfs_is_big_endian, curr);
 		offset += 4;
 	} while (size);

@@ -665,15 +638,15 @@ write_data(struct entry *entry, char *base,
unsigned int offset) {

 	for (e = entry; e; e = e->next) {
 		if (e->path) {
-                        if (e->same) {
-                                set_data_offset(e, base, e->same->offset);
-                                e->offset = e->same->offset;
-                        } else if (e->size) {
-                                set_data_offset(e, base, offset);
-                                e->offset = offset;
-                                offset = do_compress(base, offset, e->name,
+			if (e->same) {
+				set_data_offset(e, base, e->same->offset);
+				e->offset = e->same->offset;
+			} else if (e->size) {
+				set_data_offset(e, base, offset);
+				e->offset = offset;
+				offset = do_compress(base, offset, e->name,
 						     e->path, e->size,e->mode);
-                        }
+			}
 		} else if (e->child)
 			offset = write_data(e->child, base, offset);
 	}
@@ -686,14 +659,13 @@ static unsigned int write_file(char *file, char
*base, unsigned int offset)
 	char *buf;

 	fd = open(file, O_RDONLY);
-	if (fd < 0) {
-		perror(file);
-		exit(MKFS_ERROR);
-	}
+	if (fd < 0)
+		err(MKFS_ERROR, _("cannot open file %s"), file);
 	buf = mmap(NULL, image_length, PROT_READ, MAP_PRIVATE, fd, 0);
 	memcpy(base + offset, buf, image_length);
 	munmap(buf, image_length);
-	close (fd);
+	if (close (fd) < 0)
+		err(MKFS_ERROR, _("closing file %s"), file);
 	/* Pad up the image_length to a 4-byte boundary */
 	while (image_length & 3) {
 		*(base + offset + image_length) = '\0';
@@ -736,20 +708,13 @@ int main(int argc, char **argv)
 	loff_t fslen_ub = sizeof(struct cramfs_super);
 	unsigned int fslen_max;
 	char const *dirname, *outfile;
-	u32 crc = crc32(0L, Z_NULL, 0);
+	uint32_t crc = crc32(0L, Z_NULL, 0);
 	int c;
 	cramfs_is_big_endian = HOST_IS_BIG_ENDIAN; /* default is to use host order */

 	blksize = getpagesize();
 	total_blocks = 0;

-	if (argc) {
-		char *p;
-		progname = argv[0];
-		if ((p = strrchr(progname, '/')) != NULL)
-			progname = p+1;
-	}
-
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
@@ -758,17 +723,17 @@ int main(int argc, char **argv)
 	while ((c = getopt(argc, argv, "hb:Ee:i:n:N:psVvz")) != EOF) {
 		switch (c) {
 		case 'h':
-			usage(0);
+			usage(MKFS_OK);
 		case 'b':
-			blksize = atoi(optarg);
+			blksize = strtoll_or_err(optarg, _("blocksize argument failed"));
 			if (blksize <= 0)
-				usage(1);
+				usage(MKFS_USAGE);
 			break;
 		case 'E':
 			opt_errors = 1;
 			break;
 		case 'e':
-			opt_edition = atoi(optarg);
+			opt_edition = strtoll_or_err(optarg, _("edition number argument failed"));
 			break;
 		case 'N':
 			if (strcmp(optarg, "big") == 0)  {
@@ -778,18 +743,15 @@ int main(int argc, char **argv)
 				cramfs_is_big_endian = 0;
 			}
 			else if (strcmp(optarg, "host") == 0);	/* default */
-			else 	{
-				perror("invalid endianness given. Must be 'big', 'little', or 'host'");
-				exit(MKFS_USAGE);
-			}
+			else
+				errx(MKFS_USAGE, _("invalid endianness given."
+						   " Must be 'big', 'little', or 'host'"));

 			break;
 		case 'i':
 			opt_image = optarg;
-			if (lstat(opt_image, &st) < 0) {
-				perror(opt_image);
-				exit(MKFS_USAGE);
-			}
+			if (lstat(opt_image, &st) < 0)
+				err(MKFS_USAGE, _("cannot stat %s"), opt_image);
 			image_length = st.st_size; /* may be padded later */
 			fslen_ub += (image_length + 3); /* 3 is for padding */
 			break;
@@ -805,7 +767,7 @@ int main(int argc, char **argv)
 			break;
 		case 'V':
 			printf(_("%s (%s)\n"),
-			       progname, PACKAGE_STRING);
+			       program_invocation_short_name, PACKAGE_STRING);
 			exit(MKFS_OK);
 		case 'v':
 			verbose = 1;
@@ -817,21 +779,17 @@ int main(int argc, char **argv)
 	}

 	if ((argc - optind) != 2)
-		usage(16);
+		usage(MKFS_USAGE);
 	dirname = argv[optind];
 	outfile = argv[optind + 1];

-	if (stat(dirname, &st) < 0) {
-		perror(dirname);
-		exit(MKFS_USAGE);
-	}
+	if (stat(dirname, &st) < 0)
+		err(MKFS_USAGE, _("cannot stat %s"), dirname);
 	fd = open(outfile, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	if (fd < 0)
+		err(MKFS_USAGE, _("cannot open %s"), outfile);

-	root_entry = calloc(1, sizeof(struct entry));
-	if (!root_entry) {
-		perror(NULL);
-		exit(MKFS_ERROR);
-	}
+	root_entry = xcalloc(1, sizeof(struct entry));
 	root_entry->mode = st.st_mode;
 	root_entry->uid = st.st_uid;
 	root_entry->gid = st.st_gid;
@@ -839,42 +797,39 @@ int main(int argc, char **argv)
 	root_entry->size = parse_directory(root_entry, dirname,
&root_entry->child, &fslen_ub);

 	/* always allocate a multiple of blksize bytes because that's
-           what we're going to write later on */
+	   what we're going to write later on */
 	fslen_ub = ((fslen_ub - 1) | (blksize - 1)) + 1;
 	fslen_max = maxfslen();

 	if (fslen_ub > fslen_max) {
-		fprintf(stderr,
-			_("warning: guestimate of required size (upper bound) "
+		warnx(	_("warning: guestimate of required size (upper bound) "
 			  "is %lldMB, but maximum image size is %uMB.  "
-			  "We might die prematurely.\n"),
+			  "We might die prematurely."),
 			(long long)fslen_ub >> 20,
 			fslen_max >> 20);
 		fslen_ub = fslen_max;
 	}

-        /* find duplicate files */
-        eliminate_doubles(root_entry,root_entry, &fslen_ub);
+	/* find duplicate files */
+	eliminate_doubles(root_entry,root_entry, &fslen_ub);

 	/* TODO: Why do we use a private/anonymous mapping here
-           followed by a write below, instead of just a shared mapping
-           and a couple of ftruncate calls?  Is it just to save us
-           having to deal with removing the file afterwards?  If we
-           really need this huge anonymous mapping, we ought to mmap
-           in smaller chunks, so that the user doesn't need nn MB of
-           RAM free.  If the reason is to be able to write to
-           un-mmappable block devices, then we could try shared mmap
-           and revert to anonymous mmap if the shared mmap fails. */
+	   followed by a write below, instead of just a shared mapping
+	   and a couple of ftruncate calls?  Is it just to save us
+	   having to deal with removing the file afterwards?  If we
+	   really need this huge anonymous mapping, we ought to mmap
+	   in smaller chunks, so that the user doesn't need nn MB of
+	   RAM free.  If the reason is to be able to write to
+	   un-mmappable block devices, then we could try shared mmap
+	   and revert to anonymous mmap if the shared mmap fails. */
 	rom_image = mmap(NULL,
 			 fslen_ub?fslen_ub:1,
 			 PROT_READ | PROT_WRITE,
 			 MAP_PRIVATE | MAP_ANONYMOUS,
 			 -1, 0);

-	if (-1 == (int) (long) rom_image) {
-		perror(_("ROM image map"));
-		exit(MKFS_ERROR);
-	}
+	if (-1 == (int) (long) rom_image)
+		err(MKFS_ERROR, _("ROM image map"));

 	/* Skip the first opt_pad bytes for boot loader code */
 	offset = opt_pad;
@@ -897,7 +852,7 @@ int main(int argc, char **argv)
 	offset = write_data(root_entry, rom_image, offset);

 	/* We always write a multiple of blksize bytes, so that
-           losetup works. */
+	   losetup works. */
 	offset = ((offset - 1) | (blksize - 1)) + 1;
 	if (verbose)
 		printf(_("Everything: %zd kilobytes\n"), offset >> 10);
@@ -915,56 +870,45 @@ int main(int argc, char **argv)
 		printf(_("CRC: %x\n"), crc);

 	/* Check to make sure we allocated enough space. */
-	if (fslen_ub < offset) {
-		fprintf(stderr,
+	if (fslen_ub < offset)
+		errx(MKFS_ERROR,
 			_("not enough space allocated for ROM image "
-			  "(%lld allocated, %zu used)\n"),
+			  "(%lld allocated, %zu used)"),
 			(long long) fslen_ub, offset);
-		exit(MKFS_ERROR);
-	}

 	written = write(fd, rom_image, offset);
-	if (written < 0) {
-		perror(_("ROM image"));
-		exit(MKFS_ERROR);
-	}
-	if (offset != written) {
-		fprintf(stderr, _("ROM image write failed (%zd %zd)\n"),
+	if (written < 0)
+		err(MKFS_ERROR, _("ROM image"));
+	if (offset != written)
+		errx(MKFS_ERROR, _("ROM image write failed (%zd %zd)"),
 			written, offset);
-		exit(MKFS_ERROR);
-	}

 	/* (These warnings used to come at the start, but they scroll off the
-           screen too quickly.) */
+	   screen too quickly.) */
 	if (warn_namelen) /* (can't happen when reading from ext2fs) */
-		fprintf(stderr, /* bytes, not chars: think UTF8. */
-			_("warning: filenames truncated to 255 bytes.\n"));
+		warnx(/* bytes, not chars: think UTF8. */
+			_("warning: filenames truncated to 255 bytes."));
 	if (warn_skip)
-		fprintf(stderr,
-			_("warning: files were skipped due to errors.\n"));
+		warnx(	_("warning: files were skipped due to errors."));
 	if (warn_size)
-		fprintf(stderr,
-			_("warning: file sizes truncated to %luMB "
-			  "(minus 1 byte).\n"),
+		warnx(	_("warning: file sizes truncated to %luMB "
+			  "(minus 1 byte)."),
 			1L << (CRAMFS_SIZE_WIDTH - 20));
 	if (warn_uid) /* (not possible with current Linux versions) */
-		fprintf(stderr,
-			_("warning: uids truncated to %u bits.  "
-			  "(This may be a security concern.)\n"),
+		warnx(	_("warning: uids truncated to %u bits.  "
+			  "(This may be a security concern.)"),
 			CRAMFS_UID_WIDTH);
 	if (warn_gid)
-		fprintf(stderr,
-			_("warning: gids truncated to %u bits.  "
-			  "(This may be a security concern.)\n"),
+		warnx(	_("warning: gids truncated to %u bits.  "
+			  "(This may be a security concern.)"),
 			CRAMFS_GID_WIDTH);
 	if (warn_dev)
-		fprintf(stderr,
-			_("WARNING: device numbers truncated to %u bits.  "
+		warnx(	_("WARNING: device numbers truncated to %u bits.  "
 			  "This almost certainly means\n"
-			  "that some device files will be wrong.\n"),
+			  "that some device files will be wrong."),
 			CRAMFS_OFFSET_WIDTH);
 	if (opt_errors &&
 	    (warn_namelen|warn_skip|warn_size|warn_uid|warn_gid|warn_dev))
 		exit(MKFS_ERROR);
-	return 0;
+	return EXIT_SUCCESS;
 }
diff --git a/include/md5.h b/include/md5.h
index d598e81..1222cf0 100644
--- a/include/md5.h
+++ b/include/md5.h
@@ -7,6 +7,8 @@
 typedef unsigned int uint32_t;
 #endif

+#define MD5LENGTH 16
+
 struct MD5Context {
 	uint32_t buf[4];
 	uint32_t bits[2];
@@ -16,7 +18,7 @@ struct MD5Context {
 void MD5Init(struct MD5Context *context);
 void MD5Update(struct MD5Context *context, unsigned char const *buf,
 	       unsigned len);
-void MD5Final(unsigned char digest[16], struct MD5Context *context);
+void MD5Final(unsigned char digest[MD5LENGTH], struct MD5Context *context);
 void MD5Transform(uint32_t buf[4], uint32_t const in[16]);

 /*
diff --git a/lib/md5.c b/lib/md5.c
index 071630f..26ec4bb 100644
--- a/lib/md5.c
+++ b/lib/md5.c
@@ -107,7 +107,7 @@ void MD5Update(struct MD5Context *ctx, unsigned
char const *buf, unsigned len)
  * Final wrapup - pad to 64-byte boundary with the bit pattern
  * 1 0* (64-bit count of bits processed, MSB-first)
  */
-void MD5Final(unsigned char digest[16], struct MD5Context *ctx)
+void MD5Final(unsigned char digest[MD5LENGTH], struct MD5Context *ctx)
 {
     unsigned count;
     unsigned char *p;
@@ -144,7 +144,7 @@ void MD5Final(unsigned char digest[16], struct
MD5Context *ctx)

     MD5Transform(ctx->buf, (uint32_t *) ctx->in);
     byteReverse((unsigned char *) ctx->buf, 4);
-    memcpy(digest, ctx->buf, 16);
+    memcpy(digest, ctx->buf, MD5LENGTH);
     memset(ctx, 0, sizeof(*ctx));	/* In case it's sensitive */
 }

diff --git a/libblkid/src/superblocks/hfs.c b/libblkid/src/superblocks/hfs.c
index e043994..6d960e9 100644
--- a/libblkid/src/superblocks/hfs.c
+++ b/libblkid/src/superblocks/hfs.c
@@ -130,17 +130,17 @@ struct hfsplus_vol_header {

 static int hfs_set_uuid(blkid_probe pr, unsigned char const
*hfs_info, size_t len)
 {
-	static unsigned char const hash_init[16] = {
+	static unsigned char const hash_init[MD5LENGTH] = {
 		0xb3, 0xe2, 0x0f, 0x39, 0xf2, 0x92, 0x11, 0xd6,
 		0x97, 0xa4, 0x00, 0x30, 0x65, 0x43, 0xec, 0xac
 	};
-	unsigned char uuid[16];
+	unsigned char uuid[MD5LENGTH];
 	struct MD5Context md5c;

 	if (memcmp(hfs_info, "\0\0\0\0\0\0\0\0", len) == 0)
 		return -1;
 	MD5Init(&md5c);
-	MD5Update(&md5c, hash_init, 16);
+	MD5Update(&md5c, hash_init, MD5LENGTH);
 	MD5Update(&md5c, hfs_info, len);
 	MD5Final(uuid, &md5c);
 	uuid[6] = 0x30 | (uuid[6] & 0x0f);
diff --git a/misc-utils/mcookie.c b/misc-utils/mcookie.c
index 61896e1..1e6b64b 100644
--- a/misc-utils/mcookie.c
+++ b/misc-utils/mcookie.c
@@ -79,7 +79,7 @@ int main(int argc, char **argv)
 {
 	size_t i;
 	struct MD5Context ctx;
-	unsigned char digest[16];
+	unsigned char digest[MD5LENGTH];
 	unsigned char buf[BUFFERSIZE];
 	int fd;
 	int c;
@@ -178,7 +178,7 @@ int main(int argc, char **argv)
 	}

 	MD5Final(digest, &ctx);
-	for (i = 0; i < 16; i++)
+	for (i = 0; i < MD5LENGTH; i++)
 		printf("%02x", digest[i]);
 	putchar('\n');

diff --git a/tests/helpers/test_md5.c b/tests/helpers/test_md5.c
index b99882b..7f1e4f3 100644
--- a/tests/helpers/test_md5.c
+++ b/tests/helpers/test_md5.c
@@ -9,7 +9,7 @@ main(int argc, char *argv[])
 {
 	int i, ret;
 	struct MD5Context ctx;
-	unsigned char digest[16];
+	unsigned char digest[MD5LENGTH];
 	unsigned char buf[BUFSIZ];

 	MD5Init( &ctx );
@@ -23,7 +23,7 @@ main(int argc, char *argv[])
 	fclose(stdin);
 	MD5Final( digest, &ctx );

-	for (i = 0; i < 16; i++)
+	for (i = 0; i < MD5LENGTH; i++)
 		printf( "%02x", digest[i] );
 	printf("  -\n");
 	return 0;

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
