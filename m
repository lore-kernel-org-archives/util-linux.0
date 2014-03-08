Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oa0-f48.google.com ([209.85.219.48]:33672 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbaCHRCZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Mar 2014 12:02:25 -0500
Received: by mail-oa0-f48.google.com with SMTP id m1so5463430oag.21
        for <util-linux@vger.kernel.org>; Sat, 08 Mar 2014 09:02:24 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 5/5] build-sys: unify function and variable attribute spacing
Date: Sat,  8 Mar 2014 11:01:57 -0600
Message-Id: <1394298117-16531-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1394298117-16531-1-git-send-email-kerolasa@iki.fi>
References: <1394298117-16531-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From two different styles the more popular is picked to be the correct
for this package.

$ git grep -hc '_ ((*_' | awk -F: '{T+=$2} END  {print T}'
141
$ git grep -hc '_((*_'  | awk -F: '{T+=$2} END  {print T}'
168

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/addpart.c                   |  2 +-
 disk-utils/blockdev.c                  |  2 +-
 disk-utils/delpart.c                   |  2 +-
 disk-utils/fdformat.c                  |  2 +-
 disk-utils/fsck.c                      |  2 +-
 disk-utils/fsck.minix.c                |  2 +-
 disk-utils/mkfs.bfs.c                  |  4 ++--
 disk-utils/mkfs.c                      |  4 ++--
 disk-utils/mkfs.minix.c                |  2 +-
 disk-utils/mkswap.c                    |  2 +-
 disk-utils/raw.c                       |  2 +-
 disk-utils/resizepart.c                |  2 +-
 fdisks/cfdisk.c                        |  2 +-
 fdisks/fdisk.c                         |  2 +-
 fdisks/sfdisk.c                        | 24 ++++++++++++------------
 include/path.h                         | 18 +++++++++---------
 include/xalloc.h                       |  2 +-
 lib/at.c                               |  6 +++---
 lib/loopdev.c                          |  2 +-
 lib/pager.c                            |  4 ++--
 lib/randutils.c                        |  4 ++--
 libblkid/src/blkidP.h                  |  4 ++--
 libblkid/src/superblocks/btrfs.c       |  4 ++--
 libblkid/src/superblocks/ntfs.c        |  2 +-
 libblkid/src/superblocks/superblocks.h |  4 ++--
 libblkid/src/superblocks/vmfs.c        |  4 ++--
 libfdisk/src/dos.c                     |  2 +-
 libfdisk/src/fdiskP.h                  |  2 +-
 libfdisk/src/libfdisk.h                | 10 +++++-----
 libmount/python/pylibmount.h           |  4 ++--
 libmount/src/mountP.h                  |  4 ++--
 libmount/src/optstr.c                  |  8 ++++----
 login-utils/login.c                    |  8 ++++----
 login-utils/newgrp.c                   |  2 +-
 login-utils/su-common.c                |  2 +-
 login-utils/sulogin-consoles.c         |  2 +-
 misc-utils/cal.c                       |  2 +-
 misc-utils/findmnt.c                   |  6 +++---
 misc-utils/getopt.c                    |  4 ++--
 misc-utils/logger.c                    |  2 +-
 misc-utils/look.c                      |  4 ++--
 misc-utils/lslocks.c                   |  2 +-
 misc-utils/mcookie.c                   |  2 +-
 misc-utils/rename.c                    |  2 +-
 misc-utils/uuidd.c                     |  4 ++--
 misc-utils/uuidgen.c                   |  2 +-
 schedutils/ionice.c                    |  2 +-
 sys-utils/ctrlaltdel.c                 |  2 +-
 sys-utils/cytune.c                     |  2 +-
 sys-utils/eject.c                      |  2 +-
 sys-utils/hwclock-cmos.c               | 18 +++++++++---------
 sys-utils/hwclock.c                    |  8 ++++----
 sys-utils/ipcmk.c                      |  2 +-
 sys-utils/ipcrm.c                      |  2 +-
 sys-utils/ipcs.c                       |  2 +-
 sys-utils/ldattach.c                   |  2 +-
 sys-utils/pivot_root.c                 |  2 +-
 sys-utils/prlimit.c                    |  2 +-
 sys-utils/readprofile.c                |  2 +-
 sys-utils/setsid.c                     |  2 +-
 sys-utils/swapoff.c                    |  2 +-
 sys-utils/swapon.c                     |  2 +-
 term-utils/agetty.c                    |  2 +-
 term-utils/mesg.c                      |  2 +-
 term-utils/script.c                    |  4 ++--
 term-utils/setterm.c                   |  4 ++--
 term-utils/write.c                     | 10 +++++-----
 text-utils/colcrt.c                    |  4 ++--
 text-utils/colrm.c                     |  2 +-
 text-utils/hexdump-parse.c             |  8 ++++----
 text-utils/rev.c                       |  4 ++--
 text-utils/tailf.c                     |  2 +-
 text-utils/ul.c                        |  2 +-
 73 files changed, 141 insertions(+), 141 deletions(-)

diff --git a/disk-utils/addpart.c b/disk-utils/addpart.c
index c0f25a5..2665859 100644
--- a/disk-utils/addpart.c
+++ b/disk-utils/addpart.c
@@ -8,7 +8,7 @@
 #include "partx.h"
 #include "strutils.h"
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s <disk device> <partition number> <start> <length>\n"),
diff --git a/disk-utils/blockdev.c b/disk-utils/blockdev.c
index efaa0ea..a9150a5 100644
--- a/disk-utils/blockdev.c
+++ b/disk-utils/blockdev.c
@@ -178,7 +178,7 @@ static const struct bdc bdcms[] =
 	}
 };
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	size_t i;
 	fprintf(out, _("\nUsage:\n"
diff --git a/disk-utils/delpart.c b/disk-utils/delpart.c
index e940e3b..4c9f6fa 100644
--- a/disk-utils/delpart.c
+++ b/disk-utils/delpart.c
@@ -8,7 +8,7 @@
 #include "partx.h"
 #include "strutils.h"
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s <disk device> <partition number>\n"),
diff --git a/disk-utils/fdformat.c b/disk-utils/fdformat.c
index b50ba30..fd497ee 100644
--- a/disk-utils/fdformat.c
+++ b/disk-utils/fdformat.c
@@ -90,7 +90,7 @@ static void verify_disk(char *name)
 		err(EXIT_FAILURE, "close");
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, _("Usage: %s [options] device\n"),
 		program_invocation_short_name);
diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index caeb638..cfc970d 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -420,7 +420,7 @@ static void fs_interpret_type(struct libmnt_fs *fs)
 	}
 }
 
-static int parser_errcb(struct libmnt_table *tb __attribute__ ((__unused__)),
+static int parser_errcb(struct libmnt_table *tb __attribute__((__unused__)),
 			const char *filename, int line)
 {
 	warnx(_("%s: parse error at line %d -- ignore"), filename, line);
diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index c0ed017..0b9751e 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -208,7 +208,7 @@ usage(void) {
 }
 
 static void die(const char *fmt, ...)
-    __attribute__ ((__format__(__printf__, 1, 2)));
+    __attribute__((__format__(__printf__, 1, 2)));
 
 static void
 die(const char *fmt, ...) {
diff --git a/disk-utils/mkfs.bfs.c b/disk-utils/mkfs.bfs.c
index dcdb098..66f0de7 100644
--- a/disk-utils/mkfs.bfs.c
+++ b/disk-utils/mkfs.bfs.c
@@ -67,7 +67,7 @@ struct bfsde {
 	char d_name[BFS_NAMELEN];
 };
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out,
 		_("Usage: %s [options] device [block-count]\n"),
@@ -86,7 +86,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-static void __attribute__ ((__noreturn__)) print_version(void)
+static void __attribute__((__noreturn__)) print_version(void)
 {
 	printf(UTIL_LINUX_VERSION);
 	exit(EXIT_SUCCESS);
diff --git a/disk-utils/mkfs.c b/disk-utils/mkfs.c
index cb34951..5e67504 100644
--- a/disk-utils/mkfs.c
+++ b/disk-utils/mkfs.c
@@ -33,7 +33,7 @@
 #define PROGNAME	"mkfs.%s"
 
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, _("Usage:\n"));
 	fprintf(out, _(" %s [options] [-t <type>] [fs-options] <device> [<size>]\n"),
@@ -55,7 +55,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-static void __attribute__ ((__noreturn__)) print_version(void)
+static void __attribute__((__noreturn__)) print_version(void)
 {
 	printf(UTIL_LINUX_VERSION);
 	exit(EXIT_SUCCESS);
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 9fdfc63..c0e86ba 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -573,7 +573,7 @@ static size_t do_check(char * buffer, int try, unsigned int current_block) {
 
 static unsigned int currently_testing = 0;
 
-static void alarm_intr(int alnum __attribute__ ((__unused__))) {
+static void alarm_intr(int alnum __attribute__((__unused__))) {
 	unsigned long zones = get_nzones();
 
 	if (currently_testing >= zones)
diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index ae73f80..8cabeb9 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -274,7 +274,7 @@ It is roughly 2GB on i386, PPC, m68k, ARM, 1GB on sparc, 512MB on mips,
 #define MAX_BADPAGES	((pagesize-1024-128*sizeof(int)-10)/sizeof(int))
 #define MIN_GOODPAGES	10
 
-static void __attribute__ ((__noreturn__)) usage(FILE *out)
+static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fprintf(out,
 		_("\nUsage:\n"
diff --git a/disk-utils/raw.c b/disk-utils/raw.c
index 2adbf00..ebdc9fe 100644
--- a/disk-utils/raw.c
+++ b/disk-utils/raw.c
@@ -43,7 +43,7 @@ void open_raw_ctl(void);
 static int query(int minor_raw, const char *raw_name, int quiet);
 static int bind(int minor_raw, int block_major, int block_minor);
 
-static void __attribute__ ((__noreturn__)) usage(int err)
+static void __attribute__((__noreturn__)) usage(int err)
 {
 	FILE *out = err == EXIT_SUCCESS ? stdout : stderr;
 
diff --git a/disk-utils/resizepart.c b/disk-utils/resizepart.c
index 765e3a4..1d3b984 100644
--- a/disk-utils/resizepart.c
+++ b/disk-utils/resizepart.c
@@ -13,7 +13,7 @@
 #include "strutils.h"
 #include "closestream.h"
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s <disk device> <partition number> <length>\n"),
diff --git a/fdisks/cfdisk.c b/fdisks/cfdisk.c
index 1a95c1e..cf9ab1e 100644
--- a/fdisks/cfdisk.c
+++ b/fdisks/cfdisk.c
@@ -2757,7 +2757,7 @@ copyright(void) {
 }
 
 
-static void __attribute__ ((__noreturn__)) usage(FILE *out)
+static void __attribute__((__noreturn__)) usage(FILE *out)
 {
     fputs(USAGE_HEADER, out);
     fprintf(out, _(" %s [options] <device>\n"), program_invocation_short_name);
diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 7afd642..22774ca 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -45,7 +45,7 @@
 # include <linux/blkpg.h>
 #endif
 
-static void __attribute__ ((__noreturn__)) usage(FILE *out)
+static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
 
diff --git a/fdisks/sfdisk.c b/fdisks/sfdisk.c
index 03f3e7f..7ffd28b 100644
--- a/fdisks/sfdisk.c
+++ b/fdisks/sfdisk.c
@@ -1585,26 +1585,26 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
 }
 
 static int
-osf_partition(char *dev __attribute__ ((__unused__)),
-	      int fd __attribute__ ((__unused__)),
-	      unsigned long start __attribute__ ((__unused__)),
-	      struct disk_desc *z __attribute__ ((__unused__))) {
+osf_partition(char *dev __attribute__((__unused__)),
+	      int fd __attribute__((__unused__)),
+	      unsigned long start __attribute__((__unused__)),
+	      struct disk_desc *z __attribute__((__unused__))) {
     return 0;
 }
 
 static int
-sun_partition(char *dev __attribute__ ((__unused__)),
-	      int fd __attribute__ ((__unused__)),
-	      unsigned long start __attribute__ ((__unused__)),
-	      struct disk_desc *z __attribute__ ((__unused__))) {
+sun_partition(char *dev __attribute__((__unused__)),
+	      int fd __attribute__((__unused__)),
+	      unsigned long start __attribute__((__unused__)),
+	      struct disk_desc *z __attribute__((__unused__))) {
     return 0;
 }
 
 static int
-amiga_partition(char *dev __attribute__ ((__unused__)),
-		int fd __attribute__ ((__unused__)),
-		unsigned long start __attribute__ ((__unused__)),
-		struct disk_desc *z __attribute__ ((__unused__))) {
+amiga_partition(char *dev __attribute__((__unused__)),
+		int fd __attribute__((__unused__)),
+		unsigned long start __attribute__((__unused__)),
+		struct disk_desc *z __attribute__((__unused__))) {
     return 0;
 }
 
diff --git a/include/path.h b/include/path.h
index 45da692..2338a07 100644
--- a/include/path.h
+++ b/include/path.h
@@ -5,28 +5,28 @@
 #include <stdint.h>
 
 extern char *path_strdup(const char *path, ...)
-			__attribute__ ((__format__ (__printf__, 1, 2)));
+			__attribute__((__format__(__printf__, 1, 2)));
 extern FILE *path_fopen(const char *mode, int exit_on_err, const char *path, ...)
-			__attribute__ ((__format__ (__printf__, 3, 4)));
+			__attribute__((__format__(__printf__, 3, 4)));
 extern void path_read_str(char *result, size_t len, const char *path, ...)
-			__attribute__ ((__format__ (__printf__, 3, 4)));
+			__attribute__((__format__(__printf__, 3, 4)));
 extern int path_write_str(const char *str, const char *path, ...)
-			 __attribute__ ((__format__ (__printf__, 2, 3)));
+			 __attribute__((__format__(__printf__, 2, 3)));
 extern int path_read_s32(const char *path, ...)
-			__attribute__ ((__format__ (__printf__, 1, 2)));
+			__attribute__((__format__(__printf__, 1, 2)));
 extern uint64_t path_read_u64(const char *path, ...)
-			__attribute__ ((__format__ (__printf__, 1, 2)));
+			__attribute__((__format__(__printf__, 1, 2)));
 
 extern int path_exist(const char *path, ...)
-		      __attribute__ ((__format__ (__printf__, 1, 2)));
+		      __attribute__((__format__(__printf__, 1, 2)));
 
 #ifdef HAVE_CPU_SET_T
 # include "cpuset.h"
 
 extern cpu_set_t *path_read_cpuset(int, const char *path, ...)
-			      __attribute__ ((__format__ (__printf__, 2, 3)));
+			      __attribute__((__format__(__printf__, 2, 3)));
 extern cpu_set_t *path_read_cpulist(int, const char *path, ...)
-			       __attribute__ ((__format__ (__printf__, 2, 3)));
+			       __attribute__((__format__(__printf__, 2, 3)));
 extern void path_set_prefix(const char *);
 #endif /* HAVE_CPU_SET_T */
 
diff --git a/include/xalloc.h b/include/xalloc.h
index 105d713..9eb578a 100644
--- a/include/xalloc.h
+++ b/include/xalloc.h
@@ -78,7 +78,7 @@ static inline char * __attribute__((warn_unused_result)) xstrndup(const char *st
 }
 
 
-static inline int __attribute__ ((__format__(printf, 2, 3)))
+static inline int __attribute__((__format__(printf, 2, 3)))
     xasprintf(char **strp, const char *fmt, ...)
 {
 	int ret;
diff --git a/lib/at.c b/lib/at.c
index f8bfe13..7b209db 100644
--- a/lib/at.c
+++ b/lib/at.c
@@ -15,7 +15,7 @@
 #include "c.h"
 
 #ifdef HAVE_FSTATAT
-int fstat_at(int dir, const char *dirname __attribute__ ((__unused__)),
+int fstat_at(int dir, const char *dirname __attribute__((__unused__)),
 	     const char *filename, struct stat *st, int nofollow)
 {
 	return fstatat(dir, filename, st,
@@ -42,7 +42,7 @@ int fstat_at(int dir, const char *dirname, const char *filename,
 #endif
 
 #ifdef HAVE_FSTATAT
-int open_at(int dir, const char *dirname __attribute__ ((__unused__)),
+int open_at(int dir, const char *dirname __attribute__((__unused__)),
 	    const char *filename, int flags)
 {
 	return openat(dir, filename, flags);
@@ -76,7 +76,7 @@ FILE *fopen_at(int dir, const char *dirname, const char *filename, int flags,
 }
 
 #ifdef HAVE_FSTATAT
-ssize_t readlink_at(int dir, const char *dirname __attribute__ ((__unused__)),
+ssize_t readlink_at(int dir, const char *dirname __attribute__((__unused__)),
 		    const char *pathname, char *buf, size_t bufsiz)
 {
 	return readlinkat(dir, pathname, buf, bufsiz);
diff --git a/lib/loopdev.c b/lib/loopdev.c
index 5153eaa..1491ad2 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -55,7 +55,7 @@
 				} \
 			} while(0)
 
-static inline void __attribute__ ((__format__ (__printf__, 1, 2)))
+static inline void __attribute__((__format__(__printf__, 1, 2)))
 loopdev_debug(const char *mesg, ...)
 {
 	va_list ap;
diff --git a/lib/pager.c b/lib/pager.c
index c6e74e8..286ec99 100644
--- a/lib/pager.c
+++ b/lib/pager.c
@@ -197,8 +197,8 @@ void setup_pager(void)
 
 #define MAX 255
 
-int main(int argc __attribute__ ((__unused__)),
-	 char *argv[] __attribute__ ((__unused__)))
+int main(int argc __attribute__((__unused__)),
+	 char *argv[] __attribute__((__unused__)))
 {
 	int i;
 
diff --git a/lib/randutils.c b/lib/randutils.c
index ed79aad..68bb0e1 100644
--- a/lib/randutils.c
+++ b/lib/randutils.c
@@ -109,8 +109,8 @@ void random_get_bytes(void *buf, size_t nbytes)
 }
 
 #ifdef TEST_PROGRAM
-int main(int argc __attribute__ ((__unused__)),
-         char *argv[] __attribute__ ((__unused__)))
+int main(int argc __attribute__((__unused__)),
+         char *argv[] __attribute__((__unused__)))
 {
 	unsigned int v, i;
 
diff --git a/libblkid/src/blkidP.h b/libblkid/src/blkidP.h
index 4a968d9..2048fbc 100644
--- a/libblkid/src/blkidP.h
+++ b/libblkid/src/blkidP.h
@@ -346,7 +346,7 @@ extern void blkid_debug_dump_tag(blkid_tag tag);
 				} \
 			} while (0)
 
-static inline void __attribute__ ((__format__ (__printf__, 1, 2)))
+static inline void __attribute__((__format__(__printf__, 1, 2)))
 blkid_debug(const char *mesg, ...)
 {
 	va_list ap;
@@ -507,7 +507,7 @@ extern int blkid_probe_vsprintf_value(blkid_probe pr, const char *name,
 extern int blkid_probe_sprintf_value(blkid_probe pr, const char *name,
 				const char *fmt, ...)
 			__attribute__((nonnull))
-			__attribute__ ((__format__ (__printf__, 3, 4)));
+			__attribute__((__format__(__printf__, 3, 4)));
 
 extern int blkid_probe_set_magic(blkid_probe pr, blkid_loff_t offset,
 				size_t len, unsigned char *magic)
diff --git a/libblkid/src/superblocks/btrfs.c b/libblkid/src/superblocks/btrfs.c
index 434be34..a4c07bf 100644
--- a/libblkid/src/superblocks/btrfs.c
+++ b/libblkid/src/superblocks/btrfs.c
@@ -55,9 +55,9 @@ struct btrfs_super_block {
 		uint8_t bandwidth;
 		uint8_t uuid[16];
 		uint8_t fsid[16];
-	} __attribute__ ((__packed__)) dev_item;
+	} __attribute__((__packed__)) dev_item;
 	uint8_t label[256];
-} __attribute__ ((__packed__));
+} __attribute__((__packed__));
 
 static int probe_btrfs(blkid_probe pr, const struct blkid_idmag *mag)
 {
diff --git a/libblkid/src/superblocks/ntfs.c b/libblkid/src/superblocks/ntfs.c
index d767cb4..35f64e0 100644
--- a/libblkid/src/superblocks/ntfs.c
+++ b/libblkid/src/superblocks/ntfs.c
@@ -26,7 +26,7 @@ struct ntfs_bios_parameters {
 	uint16_t	heads;			/* irrelevant */
 	uint32_t	hidden_sectors;		/* zero */
 	uint32_t	large_sectors;		/* zero */
-} __attribute__ ((__packed__));
+} __attribute__((__packed__));
 
 struct ntfs_super_block {
 	uint8_t		jump[3];
diff --git a/libblkid/src/superblocks/superblocks.h b/libblkid/src/superblocks/superblocks.h
index 2cae66a..2044a3c 100644
--- a/libblkid/src/superblocks/superblocks.h
+++ b/libblkid/src/superblocks/superblocks.h
@@ -79,14 +79,14 @@ extern const struct blkid_idinfo bcache_idinfo;
  */
 extern int blkid_probe_set_version(blkid_probe pr, const char *version);
 extern int blkid_probe_sprintf_version(blkid_probe pr, const char *fmt, ...)
-		__attribute__ ((__format__ (__printf__, 2, 3)));
+		__attribute__((__format__(__printf__, 2, 3)));
 
 extern int blkid_probe_set_label(blkid_probe pr, unsigned char *label, size_t len);
 extern int blkid_probe_set_utf8label(blkid_probe pr, unsigned char *label,
                 size_t len, int enc);
 extern int blkid_probe_sprintf_uuid(blkid_probe pr, unsigned char *uuid,
                 size_t len, const char *fmt, ...)
-		__attribute__ ((__format__ (__printf__, 4, 5)));
+		__attribute__((__format__(__printf__, 4, 5)));
 extern int blkid_probe_strncpy_uuid(blkid_probe pr, unsigned char *str, size_t len);
 
 extern int blkid_probe_set_uuid(blkid_probe pr, unsigned char *uuid);
diff --git a/libblkid/src/superblocks/vmfs.c b/libblkid/src/superblocks/vmfs.c
index ead09a8..e1fb1aa 100644
--- a/libblkid/src/superblocks/vmfs.c
+++ b/libblkid/src/superblocks/vmfs.c
@@ -13,14 +13,14 @@ struct vmfs_fs_info {
 	uint8_t uuid[16];
 	uint32_t mode;
 	char label[128];
-} __attribute__ ((__packed__));
+} __attribute__((__packed__));
 
 struct vmfs_volume_info {
 	uint32_t magic;
 	uint32_t ver;
 	uint8_t irrelevant[122];
 	uint8_t uuid[16];
-} __attribute__ ((__packed__));
+} __attribute__((__packed__));
 
 static int probe_vmfs_fs(blkid_probe pr, const struct blkid_idmag *mag)
 {
diff --git a/libfdisk/src/dos.c b/libfdisk/src/dos.c
index 6af061b..24d6a31 100644
--- a/libfdisk/src/dos.c
+++ b/libfdisk/src/dos.c
@@ -1239,7 +1239,7 @@ static int dos_verify_disklabel(struct fdisk_context *cxt)
  */
 static int dos_add_partition(
 			struct fdisk_context *cxt,
-			size_t partnum __attribute__ ((__unused__)),
+			size_t partnum __attribute__((__unused__)),
 			struct fdisk_parttype *t)
 {
 	size_t i, free_primary = 0;
diff --git a/libfdisk/src/fdiskP.h b/libfdisk/src/fdiskP.h
index feaab3d..d6621a0 100644
--- a/libfdisk/src/fdiskP.h
+++ b/libfdisk/src/fdiskP.h
@@ -71,7 +71,7 @@
 					fflush(stderr);			\
 			} while(0)
 
-static inline void __attribute__ ((__format__ (__printf__, 1, 2)))
+static inline void __attribute__((__format__(__printf__, 1, 2)))
 dbgprint(const char *mesg, ...)
 {
 	va_list ap;
diff --git a/libfdisk/src/libfdisk.h b/libfdisk/src/libfdisk.h
index f653b48..ee9f743 100644
--- a/libfdisk/src/libfdisk.h
+++ b/libfdisk/src/libfdisk.h
@@ -264,16 +264,16 @@ extern uint64_t fdisk_ask_yesno_get_result(struct fdisk_ask *ask);
 extern int fdisk_ask_yesno_set_result(struct fdisk_ask *ask, uint64_t result);
 
 extern int fdisk_info(struct fdisk_context *cxt, const char *fmt, ...)
-			__attribute__ ((__format__ (__printf__, 2, 3)));
+			__attribute__((__format__(__printf__, 2, 3)));
 extern int fdisk_colon(struct fdisk_context *cxt, const char *fmt, ...)
-			__attribute__ ((__format__ (__printf__, 2, 3)));
+			__attribute__((__format__(__printf__, 2, 3)));
 extern int fdisk_sinfo(struct fdisk_context *cxt, unsigned int flags, const char *fmt, ...)
-			__attribute__ ((__format__ (__printf__, 3, 4)));
+			__attribute__((__format__(__printf__, 3, 4)));
 
 extern int fdisk_warnx(struct fdisk_context *cxt, const char *fmt, ...)
-			__attribute__ ((__format__ (__printf__, 2, 3)));
+			__attribute__((__format__(__printf__, 2, 3)));
 extern int fdisk_warn(struct fdisk_context *cxt, const char *fmt, ...)
-			__attribute__ ((__format__ (__printf__, 2, 3)));
+			__attribute__((__format__(__printf__, 2, 3)));
 
 extern int fdisk_ask_print_get_errno(struct fdisk_ask *ask);
 extern int fdisk_ask_print_set_errno(struct fdisk_ask *ask, int errnum);
diff --git a/libmount/python/pylibmount.h b/libmount/python/pylibmount.h
index 1a08796..2d86c04 100644
--- a/libmount/python/pylibmount.h
+++ b/libmount/python/pylibmount.h
@@ -26,7 +26,7 @@
 
 extern int pylibmount_debug_mask;
 
-static inline void __attribute__ ((__format__ (__printf__, 1, 2)))
+static inline void __attribute__((__format__(__printf__, 1, 2)))
 pymnt_debug(const char *mesg, ...)
 {
 	va_list ap;
@@ -36,7 +36,7 @@ pymnt_debug(const char *mesg, ...)
 	fputc('\n', stderr);
 }
 
-static inline void __attribute__ ((__format__ (__printf__, 2, 3)))
+static inline void __attribute__((__format__(__printf__, 2, 3)))
 pymnt_debug_h(void *handler, const char *mesg, ...)
 {
 	va_list ap;
diff --git a/libmount/src/mountP.h b/libmount/src/mountP.h
index a580ae4..f01d140 100644
--- a/libmount/src/mountP.h
+++ b/libmount/src/mountP.h
@@ -84,7 +84,7 @@
 
 extern int libmount_debug_mask;
 
-static inline void __attribute__ ((__format__ (__printf__, 1, 2)))
+static inline void __attribute__((__format__(__printf__, 1, 2)))
 mnt_debug(const char *mesg, ...)
 {
 	va_list ap;
@@ -94,7 +94,7 @@ mnt_debug(const char *mesg, ...)
 	fputc('\n', stderr);
 }
 
-static inline void __attribute__ ((__format__ (__printf__, 2, 3)))
+static inline void __attribute__((__format__(__printf__, 2, 3)))
 mnt_debug_h(void *handler, const char *mesg, ...)
 {
 	va_list ap;
diff --git a/libmount/src/optstr.c b/libmount/src/optstr.c
index 2cd5568..a0f92bb 100644
--- a/libmount/src/optstr.c
+++ b/libmount/src/optstr.c
@@ -865,10 +865,10 @@ err:
  * Returns: 0 on success, a negative number in case of error.
  */
 #ifndef HAVE_LIBSELINUX
-int mnt_optstr_fix_secontext(char **optstr __attribute__ ((__unused__)),
-			     char *value   __attribute__ ((__unused__)),
-			     size_t valsz  __attribute__ ((__unused__)),
-			     char **next   __attribute__ ((__unused__)))
+int mnt_optstr_fix_secontext(char **optstr __attribute__((__unused__)),
+			     char *value   __attribute__((__unused__)),
+			     size_t valsz  __attribute__((__unused__)),
+			     char **next   __attribute__((__unused__)))
 {
 	return 0;
 }
diff --git a/login-utils/login.c b/login-utils/login.c
index 89df489..bf9308d 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -157,8 +157,8 @@ static int is_consoletty(int fd)
  * What I did was add a second timeout while trying to write the message, so
  * the process just exits if the second timeout expires.
  */
-static void __attribute__ ((__noreturn__))
-timedout2(int sig __attribute__ ((__unused__)))
+static void __attribute__((__noreturn__))
+timedout2(int sig __attribute__((__unused__)))
 {
 	struct termios ti;
 
@@ -169,7 +169,7 @@ timedout2(int sig __attribute__ ((__unused__)))
 	exit(EXIT_SUCCESS);	/* %% */
 }
 
-static void timedout(int sig __attribute__ ((__unused__)))
+static void timedout(int sig __attribute__((__unused__)))
 {
 	signal(SIGALRM, timedout2);
 	alarm(10);
@@ -202,7 +202,7 @@ static void sig_handler(int signal)
  * Let us delay all exit() calls when the user is not authenticated
  * or the session not fully initialized (loginpam_session()).
  */
-static void __attribute__ ((__noreturn__)) sleepexit(int eval)
+static void __attribute__((__noreturn__)) sleepexit(int eval)
 {
 	sleep((unsigned int)getlogindefs_num("FAIL_DELAY", LOGIN_EXIT_TIMEOUT));
 	exit(eval);
diff --git a/login-utils/newgrp.c b/login-utils/newgrp.c
index 55dad1b..fe3e5a1 100644
--- a/login-utils/newgrp.c
+++ b/login-utils/newgrp.c
@@ -112,7 +112,7 @@ static int allow_setgid(struct passwd *pe, struct group *ge)
 	return FALSE;
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, USAGE_HEADER);
 	fprintf(out, _(" %s <group>\n"), program_invocation_short_name);
diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index 2766a60..88f9108 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -94,7 +94,7 @@ extern char **environ;
 #endif
 
 static void run_shell (char const *, char const *, char **, size_t)
-     __attribute__ ((__noreturn__));
+     __attribute__((__noreturn__));
 
 /* If true, pass the `-f' option to the subshell.  */
 static bool fast_startup;
diff --git a/login-utils/sulogin-consoles.c b/login-utils/sulogin-consoles.c
index 6ceea6b..e71d1fa 100644
--- a/login-utils/sulogin-consoles.c
+++ b/login-utils/sulogin-consoles.c
@@ -73,7 +73,7 @@ static int consoles_debug;
 			} \
 		} while (0)
 
-static inline void __attribute__ ((__format__ (__printf__, 1, 2)))
+static inline void __attribute__((__format__(__printf__, 1, 2)))
 dbgprint(const char *mesg, ...)
 {
 	va_list ap;
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 747694d..9f2e0b5 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -913,7 +913,7 @@ static void center(const char *str, size_t len, int separate)
 	}
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] [[[day] month] year]\n"), program_invocation_short_name);
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index dc1cbb7..ed3ab9a 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -159,7 +159,7 @@ static struct libmnt_cache *cache;
 struct udev *udev;
 #endif
 
-static int match_func(struct libmnt_fs *fs, void *data __attribute__ ((__unused__)));
+static int match_func(struct libmnt_fs *fs, void *data __attribute__((__unused__)));
 
 
 static int get_column_id(int num)
@@ -751,7 +751,7 @@ leave:
 }
 
 /* error callback */
-static int parser_errcb(struct libmnt_table *tb __attribute__ ((__unused__)),
+static int parser_errcb(struct libmnt_table *tb __attribute__((__unused__)),
 			const char *filename, int line)
 {
 	warnx(_("%s: parse error at line %d"), filename, line);
@@ -840,7 +840,7 @@ static int tab_is_tree(struct libmnt_table *tb)
 
 /* filter function for libmount (mnt_table_find_next_fs()) */
 static int match_func(struct libmnt_fs *fs,
-		      void *data __attribute__ ((__unused__)))
+		      void *data __attribute__((__unused__)))
 {
 	int rc = flags & FL_INVERT ? 1 : 0;
 	const char *m;
diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index 7630173..afb16ac 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -212,7 +212,7 @@ static int generate_output(char *argv[], int argc, const char *optstr,
  * Report an error when parsing getopt's own arguments. If message is NULL,
  * we already sent a message, we just exit with a helpful hint.
  */
-static void __attribute__ ((__noreturn__)) parse_error(const char *message)
+static void __attribute__((__noreturn__)) parse_error(const char *message)
 {
 	if (message)
 		warnx("%s", message);
@@ -309,7 +309,7 @@ static void set_shell(const char *new_shell)
 			    ("unknown shell after -s or --shell argument"));
 }
 
-static void __attribute__ ((__noreturn__)) print_help(void)
+static void __attribute__((__noreturn__)) print_help(void)
 {
 	fputs(_("\nUsage:\n"), stderr);
 
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index c07bfac..2f3bef1 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -272,7 +272,7 @@ static void mysyslog(int fd, int logflags, int pri, char *tag, char *msg)
        }
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE *out)
+static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] [<message>]\n"), program_invocation_short_name);
diff --git a/misc-utils/look.c b/misc-utils/look.c
index 502168b..205aa0e 100644
--- a/misc-utils/look.c
+++ b/misc-utils/look.c
@@ -78,7 +78,7 @@ static int compare (char *, char *);
 static char *linear_search (char *, char *);
 static int look (char *, char *);
 static void print_from (char *, char *);
-static void __attribute__ ((__noreturn__)) usage(FILE * out);
+static void __attribute__((__noreturn__)) usage(FILE * out);
 
 int
 main(int argc, char *argv[])
@@ -361,7 +361,7 @@ compare(char *s2, char *s2end) {
 	return ((i > 0) ? LESS : (i < 0) ? GREATER : EQUAL);
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fputs(_("\nUsage:\n"), out),
 	fprintf(out,
diff --git a/misc-utils/lslocks.c b/misc-utils/lslocks.c
index ab85bf7..e9c2c99 100644
--- a/misc-utils/lslocks.c
+++ b/misc-utils/lslocks.c
@@ -489,7 +489,7 @@ done:
 }
 
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	size_t i;
 
diff --git a/misc-utils/mcookie.c b/misc-utils/mcookie.c
index 3761c4b..d7af3c2 100644
--- a/misc-utils/mcookie.c
+++ b/misc-utils/mcookie.c
@@ -63,7 +63,7 @@ static off_t hash_file(struct MD5Context *ctx, int fd)
 	return count;
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fputs(_("\nUsage:\n"), out);
 	fprintf(out,
diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index 9db85fb..0daeb13 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -95,7 +95,7 @@ static int do_rename(char *from, char *to, char *s, int verbose, int symtarget)
 	return 1;
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index dd39963..b9c9129 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -65,7 +65,7 @@ struct uuidd_cxt_t {
 			no_sock: 1;
 };
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fputs(_("\nUsage:\n"), out);
 	fprintf(out,
@@ -470,7 +470,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 	}
 }
 
-static void __attribute__ ((__noreturn__)) unexpected_size(int size)
+static void __attribute__((__noreturn__)) unexpected_size(int size)
 {
 	errx(EXIT_FAILURE, _("Unexpected reply length from server %d"), size);
 }
diff --git a/misc-utils/uuidgen.c b/misc-utils/uuidgen.c
index 450e26a..509fa3c 100644
--- a/misc-utils/uuidgen.c
+++ b/misc-utils/uuidgen.c
@@ -29,7 +29,7 @@ extern int optind;
 #define DO_TYPE_TIME	1
 #define DO_TYPE_RANDOM	2
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fputs(_("\nUsage:\n"), out);
 	fprintf(out,
diff --git a/schedutils/ionice.c b/schedutils/ionice.c
index a3edf55..ef42508 100644
--- a/schedutils/ionice.c
+++ b/schedutils/ionice.c
@@ -98,7 +98,7 @@ static void ioprio_setid(int which, int ioclass, int data, int who)
 		err(EXIT_FAILURE, _("ioprio_set failed"));
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out,
 	       _("\n"
diff --git a/sys-utils/ctrlaltdel.c b/sys-utils/ctrlaltdel.c
index 074f247..5acf3f1 100644
--- a/sys-utils/ctrlaltdel.c
+++ b/sys-utils/ctrlaltdel.c
@@ -15,7 +15,7 @@
 #include "c.h"
 #include "closestream.h"
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, USAGE_HEADER);
 	fprintf(out, _(" %s <hard|soft>\n"), program_invocation_short_name);
diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
index 8a42f96..c5f3ea9 100644
--- a/sys-utils/cytune.c
+++ b/sys-utils/cytune.c
@@ -86,7 +86,7 @@ static char ***global_argv;
 
 #define mvtime(tvpto, tvpfrom)  (((tvpto)->tv_sec = (tvpfrom)->tv_sec),(tvpto)->tv_usec = (tvpfrom)->tv_usec)
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, USAGE_HEADER);
 	fprintf(out, _(" %s [options] <tty> [...]\n"), program_invocation_short_name);
diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 03744c7..2f1c5a6 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -134,7 +134,7 @@ static inline void info(const char *fmt, ...)
 	va_end(va);
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
 
diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
index 7ffbf95..da46c17 100644
--- a/sys-utils/hwclock-cmos.c
+++ b/sys-utils/hwclock-cmos.c
@@ -66,12 +66,12 @@
  * not export that header.
  */
 #undef __i386__
-void outb(int a __attribute__ ((__unused__)),
-	  int b __attribute__ ((__unused__)))
+void outb(int a __attribute__((__unused__)),
+	  int b __attribute__((__unused__)))
 {
 }
 
-int inb(int c __attribute__ ((__unused__)))
+int inb(int c __attribute__((__unused__)))
 {
 	return 0;
 }
@@ -82,12 +82,12 @@ int inb(int c __attribute__ ((__unused__)))
 extern unsigned int inb(unsigned long port);
 extern void outb(unsigned char b, unsigned long port);
 #else
-static void outb(int a __attribute__ ((__unused__)),
-	  int b __attribute__ ((__unused__)))
+static void outb(int a __attribute__((__unused__)),
+	  int b __attribute__((__unused__)))
 {
 }
 
-static int inb(int c __attribute__ ((__unused__)))
+static int inb(int c __attribute__((__unused__)))
 {
 	return 0;
 }
@@ -300,7 +300,7 @@ atomic(const char *name, unsigned long (*op) (unsigned long), unsigned long arg)
  * TODO: optimize the access to CMOS by mlockall(MCL_CURRENT) and SCHED_FIFO
  */
 static unsigned long
-atomic(const char *name __attribute__ ((__unused__)),
+atomic(const char *name __attribute__((__unused__)),
        unsigned long (*op) (unsigned long),
        unsigned long arg)
 {
@@ -610,14 +610,14 @@ static int i386_iopl(const int level)
 	return iopl(level);
 }
 # else
-static int i386_iopl(const int level __attribute__ ((__unused__)))
+static int i386_iopl(const int level __attribute__((__unused__)))
 {
 	extern int ioperm(unsigned long from, unsigned long num, int turn_on);
 	return ioperm(clock_ctl_addr, 2, 1);
 }
 # endif
 #else
-static int i386_iopl(const int level __attribute__ ((__unused__)))
+static int i386_iopl(const int level __attribute__((__unused__)))
 {
 	return -2;
 }
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 395b5c3..ae786a6 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1412,10 +1412,10 @@ manipulate_clock(const bool show, const bool adjust, const bool noadjfile,
  */
 # ifndef __alpha__
 static void
-manipulate_epoch(const bool getepoch __attribute__ ((__unused__)),
-		 const bool setepoch __attribute__ ((__unused__)),
-		 const unsigned long epoch_opt __attribute__ ((__unused__)),
-		 const bool testing __attribute__ ((__unused__)))
+manipulate_epoch(const bool getepoch __attribute__((__unused__)),
+		 const bool setepoch __attribute__((__unused__)),
+		 const unsigned long epoch_opt __attribute__((__unused__)),
+		 const bool testing __attribute__((__unused__)))
 {
 	warnx(_("The kernel keeps an epoch value for the Hardware Clock "
 		"only on an Alpha machine.\nThis copy of hwclock was built for "
diff --git a/sys-utils/ipcmk.c b/sys-utils/ipcmk.c
index 3ff021e..1932f4a 100644
--- a/sys-utils/ipcmk.c
+++ b/sys-utils/ipcmk.c
@@ -60,7 +60,7 @@ static int create_sem(int nsems, int permission)
 	return semget(key, nsems, permission | IPC_CREAT);
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, USAGE_HEADER);
 	fprintf(out, _(" %s [options]\n"), program_invocation_short_name);
diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index 46c2997..a386b4c 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -44,7 +44,7 @@ typedef enum type_id {
 static int verbose = 0;
 
 /* print the new usage */
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, USAGE_HEADER);
 	fprintf(out, " %s [options]\n", program_invocation_short_name);
diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 16e5206..26a83d6 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -47,7 +47,7 @@ static void print_msg (int id, int unit);
 /* we read time as int64_t from /proc, so cast... */
 #define xctime(_x)	ctime((time_t *) (_x))
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, USAGE_HEADER);
 	fprintf(out, " %s [resource ...] [output-format]\n", program_invocation_short_name);
diff --git a/sys-utils/ldattach.c b/sys-utils/ldattach.c
index 5c460fe..d10b2cc 100644
--- a/sys-utils/ldattach.c
+++ b/sys-utils/ldattach.c
@@ -151,7 +151,7 @@ static int parse_iflag(char *str, int *set_iflag, int *clr_iflag)
 }
 
 
-static void __attribute__ ((__noreturn__)) usage(int exitcode)
+static void __attribute__((__noreturn__)) usage(int exitcode)
 {
 	FILE *out = exitcode == EXIT_SUCCESS ? stdout : stderr;
 
diff --git a/sys-utils/pivot_root.c b/sys-utils/pivot_root.c
index 31ceabb..90b62d9 100644
--- a/sys-utils/pivot_root.c
+++ b/sys-utils/pivot_root.c
@@ -27,7 +27,7 @@
 
 #define pivot_root(new_root,put_old) syscall(SYS_pivot_root,new_root,put_old)
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, USAGE_HEADER);
 	fprintf(out, _(" %s [options] new_root put_old\n"),
diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index 5bb99d1..cb5cb7d 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -144,7 +144,7 @@ static int prlimit(pid_t p, int resource,
 }
 #endif
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	size_t i;
 
diff --git a/sys-utils/readprofile.c b/sys-utils/readprofile.c
index 79de7c2..c673d34 100644
--- a/sys-utils/readprofile.c
+++ b/sys-utils/readprofile.c
@@ -97,7 +97,7 @@ static char *boot_uname_r_str(void)
 	return s;
 }
 
-static void __attribute__ ((__noreturn__))
+static void __attribute__((__noreturn__))
     usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
diff --git a/sys-utils/setsid.c b/sys-utils/setsid.c
index 782de82..dbcaf6f 100644
--- a/sys-utils/setsid.c
+++ b/sys-utils/setsid.c
@@ -25,7 +25,7 @@
 #include "nls.h"
 #include "closestream.h"
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(
diff --git a/sys-utils/swapoff.c b/sys-utils/swapoff.c
index 182ce95..ce1aa66 100644
--- a/sys-utils/swapoff.c
+++ b/sys-utils/swapoff.c
@@ -61,7 +61,7 @@ static int swapoff_by_uuid(const char *uuid, int quiet)
 	return special ? do_swapoff(special, quiet, CANONIC) : cannot_find(uuid);
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
 
diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 1691df6..0253bfd 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -675,7 +675,7 @@ static int swapon_all(void)
 	return status;
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	size_t i;
 	fputs(USAGE_HEADER, out);
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 7c0579c..7e6b3ce 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1807,7 +1807,7 @@ static speed_t bcode(char *s)
 	return 0;
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE *out)
+static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %1$s [options] <line> [<baud_rate>,...] [<termtype>]\n"
diff --git a/term-utils/mesg.c b/term-utils/mesg.c
index 12e4e0e..7b21378 100644
--- a/term-utils/mesg.c
+++ b/term-utils/mesg.c
@@ -66,7 +66,7 @@
 #define IS_NOT_ALLOWED    1  /* Receiving messages is not allowed.  */
 #define MESG_EXIT_FAILURE 2  /* An error occurred.  */
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
 	/* TRANSLATORS: this program uses for y and n rpmatch(3),
diff --git a/term-utils/script.c b/term-utils/script.c
index 456958b..a02d787 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -368,7 +368,7 @@ doinput(void) {
 }
 
 void
-finish(int dummy __attribute__ ((__unused__))) {
+finish(int dummy __attribute__((__unused__))) {
 	int status;
 	pid_t pid;
 	int errsv = errno;
@@ -383,7 +383,7 @@ finish(int dummy __attribute__ ((__unused__))) {
 }
 
 void
-resize(int dummy __attribute__ ((__unused__))) {
+resize(int dummy __attribute__((__unused__))) {
 	resized = 1;
 }
 
diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index f179ea8..7f7fded 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -236,7 +236,7 @@ parse_term(int argc, char **argv, int *option, char **ttyname, int *bad_arg) {
 }
 
 static void
-parse_none(int argc, char **argv __attribute__ ((__unused__)), int *option, int *bad_arg) {
+parse_none(int argc, char **argv __attribute__((__unused__)), int *option, int *bad_arg) {
 	/* argc: Number of arguments for this option. */
 	/* argv: Arguments for this option. */
 	/* option: Term flag to set. */
@@ -667,7 +667,7 @@ show_tabs(void) {
 	}
 }
 
-static void __attribute__ ((__noreturn__))
+static void __attribute__((__noreturn__))
 usage(FILE *out) {
 /* Print error message about arguments, and the command's syntax. */
 
diff --git a/term-utils/write.c b/term-utils/write.c
index f5ca341..d90edaa 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -65,17 +65,17 @@
 #include "nls.h"
 #include "xalloc.h"
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out);
+static void __attribute__((__noreturn__)) usage(FILE * out);
 void search_utmp(char *, char *, char *, uid_t);
 void do_write(char *, char *, uid_t);
 void wr_fputs(char *);
-static void __attribute__ ((__noreturn__)) done(int);
+static void __attribute__((__noreturn__)) done(int);
 int term_chk(char *, int *, time_t *, int);
 int utmp_chk(char *, char *);
 
 static gid_t root_access;
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fputs(_("\nUsage:\n"), out);
 	fprintf(out,
@@ -358,8 +358,8 @@ void do_write(char *tty, char *mytty, uid_t myuid)
 /*
  * done - cleanup and exit
  */
-static void __attribute__ ((__noreturn__))
-    done(int dummy __attribute__ ((__unused__)))
+static void __attribute__((__noreturn__))
+    done(int dummy __attribute__((__unused__)))
 {
 	printf("EOF\r\n");
 	_exit(EXIT_SUCCESS);
diff --git a/text-utils/colcrt.c b/text-utils/colcrt.c
index 6c7f636..7b24193 100644
--- a/text-utils/colcrt.c
+++ b/text-utils/colcrt.c
@@ -52,7 +52,7 @@
 int plus(wchar_t c, wchar_t d);
 void move(int l, int m);
 void pflush(int ol);
-static void __attribute__ ((__noreturn__)) usage(FILE * out);
+static void __attribute__((__noreturn__)) usage(FILE * out);
 
 /*
  * colcrt - replaces col for crts with new nroff esp. when using tbl.
@@ -309,7 +309,7 @@ void move(int l, int m)
 	}
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out,
 		_("\nUsage:\n"
diff --git a/text-utils/colrm.c b/text-utils/colrm.c
index 454085e..ecf3b42 100644
--- a/text-utils/colrm.c
+++ b/text-utils/colrm.c
@@ -54,7 +54,7 @@ COLRM removes unwanted columns from a file
 	Jeff Schriebman  UC Berkeley 11-74
 */
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, _("\nUsage:\n"
 		       " %s [startcol [endcol]]\n"),
diff --git a/text-utils/hexdump-parse.c b/text-utils/hexdump-parse.c
index 22e397c..c40daec 100644
--- a/text-utils/hexdump-parse.c
+++ b/text-utils/hexdump-parse.c
@@ -50,22 +50,22 @@
 static void escape(char *p1);
 static struct list_head *color_fmt(char *cfmt, int bcnt);
 
-static void __attribute__ ((__noreturn__)) badcnt(const char *s)
+static void __attribute__((__noreturn__)) badcnt(const char *s)
 {
         errx(EXIT_FAILURE, _("bad byte count for conversion character %s"), s);
 }
 
-static void __attribute__ ((__noreturn__)) badsfmt(void)
+static void __attribute__((__noreturn__)) badsfmt(void)
 {
         errx(EXIT_FAILURE, _("%%s requires a precision or a byte count"));
 }
 
-static void __attribute__ ((__noreturn__)) badfmt(const char *fmt)
+static void __attribute__((__noreturn__)) badfmt(const char *fmt)
 {
         errx(EXIT_FAILURE, _("bad format {%s}"), fmt);
 }
 
-static void __attribute__ ((__noreturn__)) badconv(const char *ch)
+static void __attribute__((__noreturn__)) badconv(const char *ch)
 {
         errx(EXIT_FAILURE, _("bad conversion character %%%s"), ch);
 }
diff --git a/text-utils/rev.c b/text-utils/rev.c
index f1341cb..3b1a3e7 100644
--- a/text-utils/rev.c
+++ b/text-utils/rev.c
@@ -66,13 +66,13 @@
 
 wchar_t *buf;
 
-static void sig_handler(int signo __attribute__ ((__unused__)))
+static void sig_handler(int signo __attribute__((__unused__)))
 {
 	free(buf);
 	_exit(EXIT_SUCCESS);
 }
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, _("Usage: %s [options] [file ...]\n"),
 		program_invocation_short_name);
diff --git a/text-utils/tailf.c b/text-utils/tailf.c
index d2366a6..ec8e9b0 100644
--- a/text-utils/tailf.c
+++ b/text-utils/tailf.c
@@ -191,7 +191,7 @@ watch_file_inotify(const char *filename, off_t *size)
 
 #endif /* HAVE_INOTIFY_INIT */
 
-static void __attribute__ ((__noreturn__)) usage(FILE *out)
+static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fprintf(out,
 		_("\nUsage:\n"
diff --git a/text-utils/ul.c b/text-utils/ul.c
index b3b3dc3..393a169 100644
--- a/text-utils/ul.c
+++ b/text-utils/ul.c
@@ -657,7 +657,7 @@ static void needcol(int acol) {
 	}
 }
 
-static void sig_handler(int signo __attribute__ ((__unused__)))
+static void sig_handler(int signo __attribute__((__unused__)))
 {
 	_exit(EXIT_SUCCESS);
 }
-- 
1.9.0

