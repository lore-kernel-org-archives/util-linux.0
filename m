Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.187]:50504 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755989Ab2DSWYN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 19 Apr 2012 18:24:13 -0400
Message-ID: <4F90908A.1010401@bernhard-voelker.de>
Date: Fri, 20 Apr 2012 00:24:10 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] Fix typos found by misspellings
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On the coreutils mailing list, there was recently a patch
for fixing common typos identified by misspellings:
http://lists.gnu.org/archive/html/coreutils/2012-04/msg00056.html

I ran that nice tool against U-L and fixed all but the following typos:

  Documentation/releases/v2.13-ReleaseNotes[195]: lenght -> "length"
  Documentation/releases/v2.19-ReleaseNotes[321]: managment -> "management"
  Documentation/releases/v2.19-ReleaseNotes[326]: managment -> "management"
  Documentation/releases/v2.20-ReleaseNotes[340]: exmaple -> "example"
  Documentation/releases/v2.21-ReleaseNotes[753]: lenght -> "length"
  NEWS[210]: doesnt -> "doesn't"
  NEWS[1291]: necesarily -> "necessarily"

They are all in old changelogs - are these frozen or also to be changed?

  disk-utils/blockdev.c[289]: larg -> "large"
  disk-utils/blockdev.c[350]: larg -> "large"
  fdisk/sfdisk.c[1284]: ect -> "etc"

These are variable names.

Have a nice day,
Berny



>From 3291dae855d5c437298dedfebd78bf33fbacb67d Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Fri, 20 Apr 2012 00:10:44 +0200
Subject: [PATCH] Fix typos found by misspellings

The tool misspellings (https://github.com/lyda/misspell-check)
detected several typos. Command used:

  $ git ls-files | grep -v ^po/ | misspellings -f -

* isosize: Fix typo in usage string.
* configure.ac: Fix typo in help string of --enable-most-builds option.
* fdisk: Fix typo in man page.
* libblkid, blkid, mount: Likewise.
* Fix various typos in docs and in source code comments.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 Documentation/TODO                     |    2 +-
 Documentation/poeigl.txt               |    2 +-
 Documentation/release-schedule.txt     |    2 +-
 config/texinfo.tex                     |    4 ++--
 configure.ac                           |    2 +-
 disk-utils/isosize.c                   |    2 +-
 fdisk/fdisk.8                          |    2 +-
 fdisk/fdisk.c                          |    2 +-
 getopt/getopt.c                        |    4 ++--
 hwclock/cmos.c                         |    4 ++--
 hwclock/hwclock.c                      |    2 +-
 lib/strutils.c                         |    2 +-
 libblkid/libblkid.3                    |    2 +-
 libblkid/src/encode.c                  |    2 +-
 libblkid/src/partitions/gpt.c          |    4 ++--
 libblkid/src/partitions/partitions.c   |    2 +-
 libblkid/src/superblocks/linux_raid.c  |    4 ++--
 libblkid/src/superblocks/superblocks.c |    4 ++--
 libmount/src/context.c                 |    2 +-
 libmount/src/context_mount.c           |    4 ++--
 libmount/src/context_umount.c          |    4 ++--
 login-utils/login.c                    |    2 +-
 misc-utils/blkid.8                     |    2 +-
 misc-utils/blkid.c                     |    2 +-
 mount/mount.8                          |    2 +-
 sys-utils/dmesg.c                      |    2 +-
 sys-utils/ipcs.c                       |    2 +-
 sys-utils/lscpu.c                      |    2 +-
 sys-utils/mount.8                      |    2 +-
 tests/ts/lscpu/mk-input.sh             |    2 +-
 text-utils/more.c                      |    4 ++--
 text-utils/ul.c                        |    2 +-
 32 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/Documentation/TODO b/Documentation/TODO
index ed7a0c4..1fb1939 100644
--- a/Documentation/TODO
+++ b/Documentation/TODO
@@ -114,7 +114,7 @@ libblkd and libmount
 --------------------

  - use __attribute__((notnull)) and __attribute__((warn_unused_result))
-   Note that the code has to be usefull for non-gcc compilers too.
+   Note that the code has to be useful for non-gcc compilers too.

 partx
 -----
diff --git a/Documentation/poeigl.txt b/Documentation/poeigl.txt
index 00eaa71..94f51a9 100644
--- a/Documentation/poeigl.txt
+++ b/Documentation/poeigl.txt
@@ -274,7 +274,7 @@ Version 1.21 (30-Oct-93): changes since 1.20
 	Rik Faith and Stephen Tweedie inspired this change.

 Version 1.20 (30-Jul-93): changes since 1.17:
-	Versions 1.18 and 1.19 were never made publically available.
+	Versions 1.18 and 1.19 were never made publicly available.
 	Agetty now supports a -L switch that makes it force the CLOCAL flag.
 	This is useful if you have a local terminal attached with a partly
 	wired serial cable that does not pass on the Carrier Detect signal.
diff --git a/Documentation/release-schedule.txt b/Documentation/release-schedule.txt
index 6bdc2a9..6077735 100644
--- a/Documentation/release-schedule.txt
+++ b/Documentation/release-schedule.txt
@@ -11,7 +11,7 @@ Before a release there are few release candidates, which will be
 collectively tested. During test period changes to code base are
 restricted. Usually there are two release candidates.

-  what	 lenght		what will be accepted to upstream
+  what	 length		what will be accepted to upstream
   -------------------------------------------------------
   rc1	 1-2 weeks	bug fixes only
   rc2	 1-2 weeks	translations, fatal/trivial bug fixes
diff --git a/config/texinfo.tex b/config/texinfo.tex
index ff2c406..42e8cb3 100644
--- a/config/texinfo.tex
+++ b/config/texinfo.tex
@@ -415,7 +415,7 @@
 \def\argremovecomment#1\comment#2\ArgTerm{\argremovec #1\c\ArgTerm}
 \def\argremovec#1\c#2\ArgTerm{\argcheckspaces#1\^^M\ArgTerm}

-% Each occurence of `\^^M' or `<space>\^^M' is replaced by a single space.
+% Each occurrence of `\^^M' or `<space>\^^M' is replaced by a single space.
 %
 % \argremovec might leave us with trailing space, e.g.,
 %    @end itemize  @c foo
@@ -4041,7 +4041,7 @@ where each line of input produces a line of output.}
 \chardef\maxseclevel = 3
 %
 % A numbered section within an unnumbered changes to unnumbered too.
-% To achive this, remember the "biggest" unnum. sec. we are currently in:
+% To achieve this, remember the "biggest" unnum. sec. we are currently in:
 \chardef\unmlevel = \maxseclevel
 %
 % Trace whether the current chapter is an appendix or not:
diff --git a/configure.ac b/configure.ac
index 8ed2e0b..0c203fa 100644
--- a/configure.ac
+++ b/configure.ac
@@ -620,7 +620,7 @@ fi


 AC_ARG_ENABLE([most-builds],
-  AS_HELP_STRING([--enable-most-builds], [build everthing other than experimental code]),
+  AS_HELP_STRING([--enable-most-builds], [build everything other than experimental code]),
   [], enable_most_builds=no
 )
 if test "x$enable_most_builds" = xyes; then
diff --git a/disk-utils/isosize.c b/disk-utils/isosize.c
index 7a8d713..4ba34d5 100644
--- a/disk-utils/isosize.c
+++ b/disk-utils/isosize.c
@@ -158,7 +158,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		program_invocation_short_name);

 	fprintf(out, _("\nOptions:\n"
-		       " -d, --divisor=NUM      devide bytes NUM\n"
+		       " -d, --divisor=NUM      divide bytes NUM\n"
 		       " -x, --sectors          show sector count and size\n"
 		       " -V, --version          output version information and exit\n"
 		       " -H, --help             display this help and exit\n\n"));
diff --git a/fdisk/fdisk.8 b/fdisk/fdisk.8
index fdaa050..2b3c822 100644
--- a/fdisk/fdisk.8
+++ b/fdisk/fdisk.8
@@ -190,7 +190,7 @@ between logical and physical sector size.  This option changes both sector sizes
 .IB sectorsize .
 .TP
 .BI "\-c"[=mode]
-Specify the compatiblity mode, 'dos' or 'nondos'.  The default is non-DOS
+Specify the compatibility mode, 'dos' or 'nondos'.  The default is non-DOS
 mode.  For backward compatibility, it is possible to use the option without
 the <mode> argument -- then the default is used.  Note that the optional
 <mode> argument cannot be separated from the -c option by a space, the correct
diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index cf64fa7..7a944b3 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1833,7 +1833,7 @@ wrong_p_order(int *prev) {
  * The chain is sorted so that sectors increase, and so that
  * starting sectors increase.
  *
- * After this it may still be that cfdisk doesnt like the table.
+ * After this it may still be that cfdisk doesn't like the table.
  * (This is because cfdisk considers expanded parts, from link to
  * end of partition, and these may still overlap.)
  * Now
diff --git a/getopt/getopt.c b/getopt/getopt.c
index 4e5043a..dcc55b6 100644
--- a/getopt/getopt.c
+++ b/getopt/getopt.c
@@ -40,7 +40,7 @@
  */

 /* Exit codes:
- *   0) No errors, succesful operation.
+ *   0) No errors, successful operation.
  *   1) getopt(3) returned an error.
  *   2) A problem with parameter parsing for getopt(1).
  *   3) Internal error, out of memory
@@ -116,7 +116,7 @@ static const char *normalize(const char *arg)
 	}

 	/*
-	 * Each character in arg may take upto four characters in the
+	 * Each character in arg may take up to four characters in the
 	 * result: For a quote we need a closing quote, a backslash, a quote
 	 * and an opening quote! We need also the global opening and closing
 	 * quote, and one extra character for '\0'.
diff --git a/hwclock/cmos.c b/hwclock/cmos.c
index 90da987..0c98fb8 100644
--- a/hwclock/cmos.c
+++ b/hwclock/cmos.c
@@ -116,7 +116,7 @@ int cmos_epoch = 1900;
  * Martin Ostermann writes:
  *
  * The problem with the Jensen is twofold: First, it has the clock at a
- * different address. Secondly, it has a distinction beween "local" and
+ * different address. Secondly, it has a distinction between "local" and
  * normal bus addresses. The local ones pertain to the hardware integrated
  * into the chipset, like serial/parallel ports and of course, the RTC.
  * Those need to be addressed differently. This is handled fine in the
@@ -339,7 +339,7 @@ static inline unsigned long cmos_read(unsigned long reg)
 		 *
 		 * Other docs state that "any write to 0x70 should be
 		 * followed by an action to 0x71 or the RTC wil be left in
-		 * an unknown state". Most docs say that it doesnt matter at
+		 * an unknown state". Most docs say that it doesn't matter at
 		 * all what one does.
 		 */
 		/*
diff --git a/hwclock/hwclock.c b/hwclock/hwclock.c
index 3cedd1d..a19a964 100644
--- a/hwclock/hwclock.c
+++ b/hwclock/hwclock.c
@@ -1799,7 +1799,7 @@ void __attribute__((__noreturn__)) hwaudit_exit(int status)
  * November 1996: Version 2.0.1. Modifications by Nicolai Langfeldt
  * (janl@math.uio.no) to make it compile on linux 1.2 machines as well as
  * more recent versions of the kernel. Introduced the NO_CLOCK access method
- * and wrote feature test code to detect absense of rtc headers.
+ * and wrote feature test code to detect absence of rtc headers.
  *
  ***************************************************************************
  * Maintenance notes
diff --git a/lib/strutils.c b/lib/strutils.c
index 4774614..372558a 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -429,7 +429,7 @@ int string_to_idarray(const char *list, int ary[], size_t arysz,
  * LIST ::= <item> [, <item>]
  *
  * The <item> is translated to 'id' by name2id() function and the 'id' is used
- * as a possition in the 'ary' bit array. It means that the 'id' has to be in
+ * as a position in the 'ary' bit array. It means that the 'id' has to be in
  * range <0..N> where N < sizeof(ary) * NBBY.
  *
  * Returns: 0 on success, <0 on error.
diff --git a/libblkid/libblkid.3 b/libblkid/libblkid.3
index 7f1c045..e6c20b1 100644
--- a/libblkid/libblkid.3
+++ b/libblkid/libblkid.3
@@ -23,7 +23,7 @@ filesystem labels/volume names, unique identifiers/serial numbers.
 A common use is to allow use of LABEL= and UUID= tags instead of hard-coding
 specific block device names into configuration files.
 .P
-The low-level part of the library also allows to extract infomation about
+The low-level part of the library also allows to extract information about
 partitions and block device topology.
 .P
 The high-level part of the library keeps information about block devices in a
diff --git a/libblkid/src/encode.c b/libblkid/src/encode.c
index 03d5f4e..9a0570e 100644
--- a/libblkid/src/encode.c
+++ b/libblkid/src/encode.c
@@ -1,6 +1,6 @@

 /*
- * encode.c - string convertion routines (mostly for compatibility with
+ * encode.c - string conversion routines (mostly for compatibility with
  *            udev/volume_id)
  *
  * Copyright (C) 2008 Kay Sievers <kay.sievers@vrfy.org>
diff --git a/libblkid/src/partitions/gpt.c b/libblkid/src/partitions/gpt.c
index 1a50494..ccade6b 100644
--- a/libblkid/src/partitions/gpt.c
+++ b/libblkid/src/partitions/gpt.c
@@ -48,7 +48,7 @@ typedef struct {
 struct gpt_header {
 	uint64_t	signature;		/* "EFI PART" */
 	uint32_t	revision;
-	uint32_t	header_size;		/* usualy 92 bytes */
+	uint32_t	header_size;		/* usually 92 bytes */
 	uint32_t	header_crc32;		/* checksum of header with this
 						 * field zeroed during calculation */
 	uint32_t	reserved1;
@@ -120,7 +120,7 @@ static inline int guidcmp(efi_guid_t left, efi_guid_t right)
 }

 /*
- * UUID is traditionaly 16 byte big-endian array, except Intel EFI
+ * UUID is traditionally 16 byte big-endian array, except Intel EFI
  * specification where the UUID is a structure of little-endian fields.
  */
 static void swap_efi_guid(efi_guid_t *uid)
diff --git a/libblkid/src/partitions/partitions.c b/libblkid/src/partitions/partitions.c
index 99ec5d1..c9f7ff6 100644
--- a/libblkid/src/partitions/partitions.c
+++ b/libblkid/src/partitions/partitions.c
@@ -910,7 +910,7 @@ blkid_partition blkid_partlist_get_partition(blkid_partlist ls, int n)
  * This function tries to get start and size for @devno from sysfs and
  * returns a partition from @ls which matches with the values from sysfs.
  *
- * This funtion is necessary when you want to make a relation between an entry
+ * This function is necessary when you want to make a relation between an entry
  * in the partition table (@ls) and block devices in your system.
  *
  * Returns: partition object or NULL in case or error.
diff --git a/libblkid/src/superblocks/linux_raid.c b/libblkid/src/superblocks/linux_raid.c
index 609d24b..a3f9d67 100644
--- a/libblkid/src/superblocks/linux_raid.c
+++ b/libblkid/src/superblocks/linux_raid.c
@@ -82,7 +82,7 @@ struct mdp1_super_block {
 	uint64_t	utime;		/* 40 bits second, 24 btes microseconds */
 	uint64_t	events;		/* incremented when superblock updated */
 	uint64_t	resync_offset;	/* data before this offset (from data_offset) known to be in sync */
-	uint32_t	sb_csum;	/* checksum upto dev_roles[max_dev] */
+	uint32_t	sb_csum;	/* checksum up to dev_roles[max_dev] */
 	uint32_t	max_dev;	/* size of dev_roles[] array to consider */
 	uint8_t		pad3[64-32];	/* set to 0 when writing */

@@ -160,7 +160,7 @@ static int probe_raid0(blkid_probe pr, blkid_loff_t off)
 	 * Check for collisions between RAID and partition table
 	 *
 	 * For example the superblock is at the end of the last partition, it's
-	 * the same possition as at the end of the disk...
+	 * the same position as at the end of the disk...
 	 */
 	if ((S_ISREG(pr->mode) || blkid_probe_is_wholedisk(pr)) &&
 	    blkid_probe_is_covered_by_pt(pr,
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index d985adc..91f4f88 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -26,13 +26,13 @@
  * @title: Superblocks probing
  * @short_description: filesystems and raids superblocks probing.
  *
- * The library API has been originaly designed for superblocks probing only.
+ * The library API has been originally designed for superblocks probing only.
  * This is reason why some *deprecated* superblock specific functions don't use
  * '_superblocks_' namespace in the function name. Please, don't use these
  * functions in new code.
  *
  * The 'superblocks' probers support NAME=value (tags) interface only. The
- * superblocks probing is enabled by default (and controled by
+ * superblocks probing is enabled by default (and controlled by
  * blkid_probe_enable_superblocks()).
  *
  * Currently supported tags:
diff --git a/libmount/src/context.c b/libmount/src/context.c
index 0d0282d..7f53a96 100644
--- a/libmount/src/context.c
+++ b/libmount/src/context.c
@@ -1778,7 +1778,7 @@ int mnt_context_fstab_applied(struct libmnt_context *cxt)
  * mnt_context_get_helper_status(). The mnt_context_get_status() only inform
  * that exec() has been sucessful.
  *
- * Returns: 1 if mount.type or mount(2) syscall has been succesfully called.
+ * Returns: 1 if mount.type or mount(2) syscall has been successfully called.
  */
 int mnt_context_get_status(struct libmnt_context *cxt)
 {
diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index 976f459..1f28753 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -612,7 +612,7 @@ int mnt_context_prepare_mount(struct libmnt_context *cxt)
  * again mnt_context_do_mount().
  *
  * WARNING: non-zero return code does not mean that mount(2) syscall or
- *          mount.type helper wasn't sucessfully called.
+ *          mount.type helper wasn't successfully called.
  *
  *          Check mnt_context_get_status() after error!
 *
@@ -720,7 +720,7 @@ int mnt_context_finalize_mount(struct libmnt_context *cxt)
  * once, whole context has to be reseted.
  *
  * WARNING: non-zero return code does not mean that mount(2) syscall or
- *          mount.type helper wasn't sucessfully called.
+ *          mount.type helper wasn't successfully called.
  *
  *          Check mnt_context_get_status() after error!
  *
diff --git a/libmount/src/context_umount.c b/libmount/src/context_umount.c
index 7daa913..3443da1 100644
--- a/libmount/src/context_umount.c
+++ b/libmount/src/context_umount.c
@@ -643,7 +643,7 @@ int mnt_context_prepare_umount(struct libmnt_context *cxt)
  * See also mnt_context_disable_helpers().
  *
  * WARNING: non-zero return code does not mean that umount(2) syscall or
- *          umount.type helper wasn't sucessfully called.
+ *          umount.type helper wasn't successfully called.
  *
  *          Check mnt_context_get_status() after error!
 *
@@ -733,7 +733,7 @@ int mnt_context_finalize_umount(struct libmnt_context *cxt)
  * See also mnt_context_disable_helpers().
  *
  * WARNING: non-zero return code does not mean that umount(2) syscall or
- *          umount.type helper wasn't sucessfully called.
+ *          umount.type helper wasn't successfully called.
  *
  *          Check mnt_context_get_status() after error!
  *
diff --git a/login-utils/login.c b/login-utils/login.c
index 6c3b6f7..bb977e5 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -1102,7 +1102,7 @@ static void fork_session(struct login_context *cxt)
 		exit(EXIT_FAILURE);

 	/*
-	 * Problem: if the user's shell is a shell like ash that doesnt do
+	 * Problem: if the user's shell is a shell like ash that doesn't do
 	 * setsid() or setpgrp(), then a ctrl-\, sending SIGQUIT to every
 	 * process in the pgrp, will kill us.
 	 */
diff --git a/misc-utils/blkid.8 b/misc-utils/blkid.8
index f5f4f9d..37042d0 100644
--- a/misc-utils/blkid.8
+++ b/misc-utils/blkid.8
@@ -85,7 +85,7 @@ devices previously scanned but not necessarily available at this time), specify
 .B \-d
 Don't encode non-printing characters. The non-printing characters are encoded
 by ^ and M- notation by default. Note that \fB-o udev\fR output format uses
-a diffrent encoding and this encoding cannot be disabled.
+a different encoding and this encoding cannot be disabled.
 .TP
 .B \-g
 Perform a garbage collection pass on the blkid cache to remove
diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 3793c52..6a7991f 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -580,7 +580,7 @@ done:
 	if (!nvals)
 		return 2;	/* nothing detected */

-	return 0;		/* sucess */
+	return 0;		/* success */
 }

 /* converts comma separated list to BLKID_USAGE_* mask */
diff --git a/mount/mount.8 b/mount/mount.8
index 223ab7a..b4c4286 100644
--- a/mount/mount.8
+++ b/mount/mount.8
@@ -860,7 +860,7 @@ filesystem that supports xattr labeling.
 The
 .BR rootcontext=
 option allows you to explicitly label the root inode of a FS being mounted
-before that FS or inode because visable to userspace. This was found to be
+before that FS or inode because visible to userspace. This was found to be
 useful for things like stateless linux.

 Note that kernel rejects any remount request that includes the context
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index de4b3ab..b47fede 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -113,7 +113,7 @@ struct dmesg_control {
 	/*
 	 * For the --file option we mmap whole file. The unnecessary (already
 	 * printed) pages are always unmapped. The result is that we have in
-	 * memory only the currenly used page(s).
+	 * memory only the currently used page(s).
 	 */
 	char		*mmap_buff;
 	size_t		pagesize;
diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index fc41648..2fbca08 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -301,7 +301,7 @@ void do_shm (char format)
 	case STATUS:
 		printf (_("------ Shared Memory Status --------\n"));
 		/*
-		 * TRANSLATORS: This output format is mantained for backward
+		 * TRANSLATORS: This output format is maintained for backward
 		 * compatibility as ipcs is used in scripts. For consistency
 		 * with the rest, the translated form can follow this model:
 		 *
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 1c2d9b6..a4994b0 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -560,7 +560,7 @@ read_hypervisor(struct lscpu_desc *desc)
 	}
 }

-/* add @set to the @ary, unnecesary set is deallocated. */
+/* add @set to the @ary, unnecessary set is deallocated. */
 static int add_cpuset_to_array(cpu_set_t **ary, int *items, cpu_set_t *set)
 {
 	int i;
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 73fa367..c964f8f 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -880,7 +880,7 @@ filesystem that supports xattr labeling.
 The
 .BR rootcontext=
 option allows you to explicitly label the root inode of a FS being mounted
-before that FS or inode because visable to userspace. This was found to be
+before that FS or inode because visible to userspace. This was found to be
 useful for things like stateless linux.

 Note that kernel rejects any remount request that includes the context
diff --git a/tests/ts/lscpu/mk-input.sh b/tests/ts/lscpu/mk-input.sh
index 299ac08..65e3d20 100644
--- a/tests/ts/lscpu/mk-input.sh
+++ b/tests/ts/lscpu/mk-input.sh
@@ -3,7 +3,7 @@
 # Copyright (C) 2008-2009 Karel Zak <kzak@redhat.com>
 #
 # This script makes a copy of relevant files from /sys and /proc.
-# The files are usefull for lscpu(1) regression tests.
+# The files are useful for lscpu(1) regression tests.
 #
 progname=$(basename $0)

diff --git a/text-utils/more.c b/text-utils/more.c
index aa1e4cc..5196791 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1574,7 +1574,7 @@ void do_shell (char *filename)
 }

 /*
-** Search for nth ocurrence of regular expression contained in buf in the file
+** Search for nth occurrence of regular expression contained in buf in the file
 */

 void search(char buf[], FILE *file, register int n)
@@ -2128,7 +2128,7 @@ reset_tty () {
     if (no_tty)
 	return;
     if (pstate) {
-	tputs(ULexit, fileno(stdout), ourputch);	/* putchar - if that isnt a macro */
+	tputs(ULexit, fileno(stdout), ourputch);	/* putchar - if that isn't a macro */
 	fflush(stdout);
 	pstate = 0;
     }
diff --git a/text-utils/ul.c b/text-utils/ul.c
index c15e480..d08ca9a 100644
--- a/text-utils/ul.c
+++ b/text-utils/ul.c
@@ -173,7 +173,7 @@ int main(int argc, char **argv)
 	/*
 	 * FIXME: why terminal type is lpr when command begins with c and has
 	 * no terminal? If this behavior can be explained please insert
-	 * refrence or remove the code. In case this truly is desired command
+	 * reference or remove the code. In case this truly is desired command
 	 * behavior this should be mentioned in manual page.
 	 */
 	if (termtype == NULL || (argv[0][0] == 'c' && !isatty(STDOUT_FILENO)))
-- 
1.7.7

