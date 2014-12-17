Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:60485 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751011AbaLQUUw (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Dec 2014 15:20:52 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: RFC [patch] adding docstrings
Date: Wed, 17 Dec 2014 21:20:31 +0100
Message-Id: <1418847631-8317-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch adds a docstring (a one-line description) to each of the
utilities.  It was first proposed some months ago by Steven Honeyman
(see (http://www.spinics.net/lists/util-linux-ng/msg09994.html).

(The utilities cal, su and runuser already had a two- or three-line
docstring.  For mkfs.cramfs, mkfs.minix, blkid and chrt I've had to
improvise -- putting the docstring before the synopis -- in order to
avoid making extensive changes to the usage text; those changes will
come later.)

If you have a favourite tool, please check below and see if you
can improve its description.  Other improvements and comments are
welcome too.

Benno

---
 disk-utils/addpart.c      |    4 ++++
 disk-utils/blockdev.c     |    1 +
 disk-utils/cfdisk.c       |    4 +++-
 disk-utils/delpart.c      |    4 ++++
 disk-utils/fdformat.c     |    3 +++
 disk-utils/fdisk.c        |    3 +++
 disk-utils/fsck.c         |    3 +++
 disk-utils/fsck.cramfs.c  |    4 ++++
 disk-utils/fsck.minix.c   |    4 ++++
 disk-utils/isosize.c      |    4 ++++
 disk-utils/mkfs.bfs.c     |    4 ++++
 disk-utils/mkfs.c         |    4 ++++
 disk-utils/mkfs.cramfs.c  |    1 +
 disk-utils/mkfs.minix.c   |    1 +
 disk-utils/mkswap.c       |    3 +++
 disk-utils/partx.c        |    3 +++
 disk-utils/raw.c          |    4 ++++
 disk-utils/resizepart.c   |    4 ++++
 disk-utils/sfdisk.c       |    3 +++
 disk-utils/swaplabel.c    |    4 ++++
 login-utils/chfn.c        |    4 ++++
 login-utils/chsh.c        |    4 ++++
 login-utils/last.c        |    3 +++
 login-utils/login.c       |    2 ++
 login-utils/lslogins.c    |    3 +++
 login-utils/newgrp.c      |    4 ++++
 login-utils/nologin.c     |    4 +++-
 login-utils/sulogin.c     |    3 +++
 login-utils/utmpdump.c    |    3 +++
 login-utils/vipw.c        |    4 ++++
 misc-utils/blkid.c        |    1 +
 misc-utils/findfs.c       |    4 ++++
 misc-utils/findmnt.c      |    3 +++
 misc-utils/getopt.c       |    3 +++
 misc-utils/kill.c         |    3 +++
 misc-utils/logger.c       |    3 +++
 misc-utils/look.c         |    4 ++++
 misc-utils/lsblk.c        |    4 ++++
 misc-utils/lslocks.c      |    3 +++
 misc-utils/mcookie.c      |    3 +++
 misc-utils/namei.c        |    4 ++++
 misc-utils/rename.c       |    4 ++++
 misc-utils/uuidd.c        |    3 +++
 misc-utils/uuidgen.c      |    3 +++
 misc-utils/whereis.c      |    3 +++
 misc-utils/wipefs.c       |    4 ++++
 schedutils/chrt.c         |    2 +-
 schedutils/ionice.c       |    3 +++
 schedutils/taskset.c      |    4 ++++
 sys-utils/blkdiscard.c    |    4 ++++
 sys-utils/chcpu.c         |    3 +++
 sys-utils/ctrlaltdel.c    |    4 ++++
 sys-utils/dmesg.c         |    4 ++++
 sys-utils/eject.c         |    4 +++-
 sys-utils/fallocate.c     |    5 ++++-
 sys-utils/flock.c         |    4 ++++
 sys-utils/fsfreeze.c      |    4 ++++
 sys-utils/fstrim.c        |    4 ++++
 sys-utils/hwclock.c       |    3 +++
 sys-utils/ipcmk.c         |    5 ++++-
 sys-utils/ipcrm.c         |    6 +++++-
 sys-utils/ipcs.c          |    6 +++++-
 sys-utils/ldattach.c      |    5 ++++-
 sys-utils/losetup.c       |    3 +++
 sys-utils/lscpu.c         |    3 +++
 sys-utils/mount.c         |    3 +++
 sys-utils/mountpoint.c    |    3 +++
 sys-utils/nsenter.c       |    3 +++
 sys-utils/pivot_root.c    |    4 ++++
 sys-utils/prlimit.c       |    3 +++
 sys-utils/readprofile.c   |    5 ++++-
 sys-utils/renice.c        |    4 ++++
 sys-utils/rtcwake.c       |    3 +++
 sys-utils/setarch.c       |    4 ++++
 sys-utils/setpriv.c       |    3 +++
 sys-utils/setsid.c        |    3 +++
 sys-utils/swapoff.c       |    4 +++-
 sys-utils/swapon.c        |    4 +++-
 sys-utils/switch_root.c   |    4 ++++
 sys-utils/tunelp.c        |    3 +++
 sys-utils/umount.c        |    3 +++
 sys-utils/unshare.c       |    3 +++
 sys-utils/wdctl.c         |    4 +++-
 sys-utils/zramctl.c       |    3 +++
 term-utils/agetty.c       |    4 ++++
 term-utils/mesg.c         |    4 ++++
 term-utils/script.c       |    3 +++
 term-utils/scriptreplay.c |    3 +++
 term-utils/setterm.c      |    4 ++++
 term-utils/wall.c         |    4 ++++
 term-utils/write.c        |    3 +++
 text-utils/col.c          |    3 +++
 text-utils/colcrt.c       |    4 ++++
 text-utils/colrm.c        |    4 ++++
 text-utils/column.c       |    4 ++++
 text-utils/hexdump.c      |    4 ++++
 text-utils/line.c         |    4 ++++
 text-utils/more.c         |    4 ++++
 text-utils/pg.c           |    4 ++++
 text-utils/rev.c          |    4 ++++
 text-utils/tailf.c        |    3 +++
 text-utils/ul.c           |    5 ++++-
 102 files changed, 347 insertions(+), 14 deletions(-)

diff --git a/disk-utils/addpart.c b/disk-utils/addpart.c
index c0f25a5..135489b 100644
--- a/disk-utils/addpart.c
+++ b/disk-utils/addpart.c
@@ -13,6 +13,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s <disk device> <partition number> <start> <length>\n"),
 		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Tell the kernel about the existence of a specified partition.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
diff --git a/disk-utils/blockdev.c b/disk-utils/blockdev.c
index 43aaef6..925fa2e 100644
--- a/disk-utils/blockdev.c
+++ b/disk-utils/blockdev.c
@@ -181,6 +181,7 @@ static const struct bdc bdcms[] =
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	size_t i;
+	fputs("Call block-device ioctls from the command line.\n", out);
 	fprintf(out, _("\nUsage:\n"
 		       " %1$s -V\n"
 		       " %1$s --report [devices]\n"
diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 14a75c5..641d0ec 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -2156,10 +2156,12 @@ static int ui_run(struct cfdisk *cf)
 static void __attribute__ ((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
-
 	fprintf(out,
 	      _(" %1$s [options] <disk>\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Display or manipulate a disk partition table.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -L --color[=<when>]     colorize output (auto, always or never)\n"), out);
 	fputs(_(" -z --zero               start with zeroed partition table\n"), out);
diff --git a/disk-utils/delpart.c b/disk-utils/delpart.c
index e940e3b..9e35b47 100644
--- a/disk-utils/delpart.c
+++ b/disk-utils/delpart.c
@@ -13,6 +13,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s <disk device> <partition number>\n"),
 		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Tell the kernel to forget about a specified partition.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
diff --git a/disk-utils/fdformat.c b/disk-utils/fdformat.c
index c6a98e1..eca2b1d 100644
--- a/disk-utils/fdformat.c
+++ b/disk-utils/fdformat.c
@@ -143,6 +143,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fprintf(out, _(" %s [options] <device>\n"),
 		program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Do a low-level formatting of a floppy disk.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -f, --from <N>    start at the track N (default 0)\n"), out);
 	fputs(_(" -t, --to <N>      stop at the track N\n"), out);
diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index cf86281..201d143 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -636,6 +636,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	        " %1$s [options] -l [<disk>] list partition table(s)\n"),
 	       program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Display or manipulate a disk partition table.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -b, --sector-size <size>      physical and logical sector size\n"), out);
 	fputs(_(" -c, --compatibility[=<mode>]  mode is 'dos' or 'nondos' (default)\n"), out);
diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index a0f9db1..6128d99 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -1355,6 +1355,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fprintf(out, _(" %s [options] -- [fs-options] [<filesystem> ...]\n"),
 			 program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Check and repair a Linux filesystem.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -A         check all filesystems\n"), out);
 	fputs(_(" -C [<fd>]  display progress bar; file descriptor is for GUIs\n"), out);
diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index 0a1c6f2..caa2cbb 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -106,6 +106,10 @@ static void __attribute__((__noreturn__)) usage(int status)
 	fputs(USAGE_HEADER, stream);
 	fprintf(stream,
 		_(" %s [options] <file>\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, stream);
+	fputs("Check and repair a compressed ROM filesystem.\n", stream);
+
 	fputs(USAGE_OPTIONS, stream);
 	fputs(_(" -a                       for compatibility only, ignored\n"), stream);
 	fputs(_(" -v, --verbose            be more verbose\n"), stream);
diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index c0ed017..b2d140b 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -193,6 +193,10 @@ usage(void) {
 	fputs(USAGE_HEADER, stderr);
 	fprintf(stderr,
 		_(" %s [options] <device>\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, stderr);
+	fputs("Check the consistency of a Minix filesystem.\n", stderr);
+
 	fputs(USAGE_OPTIONS, stderr);
 	fputs(_(" -l  list all filenames\n"), stderr);
 	fputs(_(" -a  automatic repair\n"), stderr);
diff --git a/disk-utils/isosize.c b/disk-utils/isosize.c
index 5030a50..6447368 100644
--- a/disk-utils/isosize.c
+++ b/disk-utils/isosize.c
@@ -169,6 +169,10 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fprintf(out,
 		_(" %s [options] <iso9660_image_file>\n"),
 		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Show the length of an ISO-9660 filesystem.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -d, --divisor=<number>  divide the amount of bytes by <number>\n"), out);
 	fputs(_(" -x, --sectors           show sector count and size\n"), out);
diff --git a/disk-utils/mkfs.bfs.c b/disk-utils/mkfs.bfs.c
index c2c2389..b1f2bed 100644
--- a/disk-utils/mkfs.bfs.c
+++ b/disk-utils/mkfs.bfs.c
@@ -72,6 +72,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fprintf(out,
 		_("Usage: %s [options] device [block-count]\n"),
 		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Make an SCO bfs filesystem.\n", out);
+
 	fprintf(out, _("\nOptions:\n"
 		       " -N, --inodes=NUM    specify desired number of inodes\n"
 		       " -V, --vname=NAME    specify volume name\n"
diff --git a/disk-utils/mkfs.c b/disk-utils/mkfs.c
index 8ad6065..1c6c6f3 100644
--- a/disk-utils/mkfs.c
+++ b/disk-utils/mkfs.c
@@ -47,6 +47,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] [-t <type>] [fs-options] <device> [<size>]\n"),
 		     program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Make a Linux filesystem.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fprintf(out, _(" -t, --type=<type>  filesystem type; when unspecified, ext2 is used\n"));
 	fprintf(out, _("     fs-options     parameters for the real filesystem builder\n"));
diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index 509b50b..66ed01c 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -118,6 +118,7 @@ static void
 usage(int status) {
 	FILE *stream = status ? stderr : stdout;
 
+	fputs("Make a compressed ROM filesystem.\n", stream);
 	fprintf(stream,
 		_("usage: %s [-h] [-v] [-b blksize] [-e edition] [-N endian] [-i file] "
 		  "[-n name] dirname outfile\n"
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 81b7ae3..40508b6 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -148,6 +148,7 @@ static void __attribute__((__noreturn__))
 usage(void) {
 	errx(MKFS_EX_USAGE, _("Usage: %s [-c | -l filename] [-nXX] [-iXX] /dev/name [blocks]"),
 	     program_name);
+	/*fputs("Make a Minix filesystem.", out);*/
 }
 
 /*
diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index d34e2fd..9719c61 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -149,6 +149,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 		  " %s [options] device [size]\n"),
 		program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Set up a Linux swap area.\n", out);
+
 	fprintf(out, _(
 		"\nOptions:\n"
 		" -c, --check               check bad blocks before creating the swap area\n"
diff --git a/disk-utils/partx.c b/disk-utils/partx.c
index bf5a4ab..3873a0a 100644
--- a/disk-utils/partx.c
+++ b/disk-utils/partx.c
@@ -713,6 +713,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	      _(" %s [-a|-d|-s|-u] [--nr <n:m> | <partition>] <disk>\n"),
 		program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Tell the kernel about the presence and numbering of partitions.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --add            add specified partitions or all of them\n"), out);
 	fputs(_(" -d, --delete         delete specified partitions or all of them\n"), out);
diff --git a/disk-utils/raw.c b/disk-utils/raw.c
index 2adbf00..d1a6171 100644
--- a/disk-utils/raw.c
+++ b/disk-utils/raw.c
@@ -54,6 +54,10 @@ static void __attribute__ ((__noreturn__)) usage(int err)
 		  " %1$s -q %2$srawN\n"
 		  " %1$s -qa\n"), program_invocation_short_name,
 		_PATH_RAWDEVDIR);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Bind a raw character device to a block device.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -q, --query    set query mode\n"), out);
 	fputs(_(" -a, --all      query all raw devices\n"), out);
diff --git a/disk-utils/resizepart.c b/disk-utils/resizepart.c
index 765e3a4..2db99ac 100644
--- a/disk-utils/resizepart.c
+++ b/disk-utils/resizepart.c
@@ -18,6 +18,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s <disk device> <partition number> <length>\n"),
 		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Tell the kernel about the new size of a partition.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index cff8664..401a41f 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -1310,6 +1310,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	      _(" %1$s [options] <dev> [[-N] <part>]\n"
 		" %1$s [options] <command>\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Display or manipulate a disk partition table.\n", out);
+
 	fputs(_("\nCommands:\n"), out);
 	fputs(_(" -a, --activate <dev> [<part> ...] list or set bootable MBR partitions\n"), out);
 	fputs(_(" -d, --dump <dev>                  dump partition table (usable for later input)\n"), out);
diff --git a/disk-utils/swaplabel.c b/disk-utils/swaplabel.c
index a7498a4..e0bb670 100644
--- a/disk-utils/swaplabel.c
+++ b/disk-utils/swaplabel.c
@@ -116,6 +116,10 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] <device>\n"),
 		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Display or change the label or UUID of a swap area.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -L, --label <label> specify a new label\n"
 		" -U, --uuid <uuid>   specify a new uuid\n"), out);
diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 25f7e91..c7a0def 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -81,6 +81,10 @@ static void __attribute__((__noreturn__)) usage(FILE *fp)
 {
 	fputs(USAGE_HEADER, fp);
 	fprintf(fp, _(" %s [options] [<username>]\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, fp);
+	fputs("Change your finger information.\n", fp);
+
 	fputs(USAGE_OPTIONS, fp);
 	fputs(_(" -f, --full-name <full-name>  real name\n"), fp);
 	fputs(_(" -o, --office <office>        office number\n"), fp);
diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index 76c3d21..e632671 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -70,6 +70,10 @@ static void __attribute__((__noreturn__)) usage (FILE *fp)
 {
 	fputs(USAGE_HEADER, fp);
 	fprintf(fp, _(" %s [options] [<username>]\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, fp);
+	fputs("Change your login shell.", fp);
+
 	fputs(USAGE_OPTIONS, fp);
 	fputs(_(" -s, --shell <shell>  specify login shell\n"), fp);
 	fputs(_(" -l, --list-shells    print list of shells and exit\n"), fp);
diff --git a/login-utils/last.c b/login-utils/last.c
index bf2c2da..756af2b 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -555,6 +555,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fprintf(out, _(
 		" %s [options] [<username>...] [<tty>...]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Show a listing of last logged in users.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -<number>            how many lines to show\n"), out);
 	fputs(_(" -a, --hostlast       display hostnames in the last column\n"), out);
diff --git a/login-utils/login.c b/login-utils/login.c
index 540554e..d8f412f 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -1188,6 +1188,8 @@ int main(int argc, char **argv)
 		case '?':
 		default:
 			fprintf(stderr, _("Usage: login [-p] [-h <host>] [-H] [[-f] <username>]\n"));
+			fputs(USAGE_SEPARATOR, stderr);
+			fputs("Begin a session on the system.\n", stderr);
 			exit(EXIT_FAILURE);
 		}
 	argc -= optind;
diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 9929b14..818c163 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -1193,6 +1193,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Display information about known users in the system.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --acc-expiration     display info about passwords expiration\n"), out);
 	fputs(_(" -c, --colon-separate     display data in a format similar to /etc/passwd\n"), out);
diff --git a/login-utils/newgrp.c b/login-utils/newgrp.c
index 58c9078..d8e7494 100644
--- a/login-utils/newgrp.c
+++ b/login-utils/newgrp.c
@@ -164,6 +164,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, USAGE_HEADER);
 	fprintf(out, _(" %s <group>\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Log in to a new group.\n", out);
+
 	fprintf(out, USAGE_OPTIONS);
 	fprintf(out, USAGE_HELP);
 	fprintf(out, USAGE_VERSION);
diff --git a/login-utils/nologin.c b/login-utils/nologin.c
index a4fb82d..6cf77a7 100644
--- a/login-utils/nologin.c
+++ b/login-utils/nologin.c
@@ -21,10 +21,12 @@
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
-
 	fprintf(out,
 		_(" %s [options]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Politely refuse a login.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index f0e88a4..05f8fb2 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -821,6 +821,9 @@ static void usage(FILE *out)
 	fprintf(out, _(
 		" %s [options] [tty device]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Single-user login.", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -p, --login-shell        start a login shell\n"
 		" -t, --timeout <seconds>  max time to wait for a password (default: no limit)\n"
diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index e1fefc6..c0dddda 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -297,6 +297,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fprintf(out,
 		_(" %s [options] [filename]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Dump UTMP and WTMP files in raw format.", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -f, --follow         output appended data as the file grows\n"), out);
 	fputs(_(" -r, --reverse        write back dumped data into utmp file\n"), out);
diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index ca90f65..0449646 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -297,6 +297,10 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out, " %s\n", program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Edit the password or group file.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 1bd8646..857dac4 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -65,6 +65,7 @@ static void usage(int error)
 	FILE *out = error ? stderr : stdout;
 
 	print_version(out);
+	fputs("Find and show block-device attributes.", out);
 	fprintf(out,
 		"Usage:\n"
 		" %1$s -L <label> | -U <uuid>\n\n"
diff --git a/misc-utils/findfs.c b/misc-utils/findfs.c
index 59f9ce0..f139a2d 100644
--- a/misc-utils/findfs.c
+++ b/misc-utils/findfs.c
@@ -27,6 +27,10 @@ static void __attribute__((__noreturn__)) usage(int rc)
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] {LABEL,UUID,PARTUUID,PARTLABEL}=<value>\n"),
 		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Find a filesystem by label or UUID.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 75099d9..bfa43d2 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -1176,6 +1176,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	" %1$s [options] [--source <device>] [--target <mountpoint>]\n"),
 		program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Find a (mounted) filesystem.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -s, --fstab            search in static table of filesystems\n"), out);
 	fputs(_(" -m, --mtab             search in table of mounted filesystems\n"), out);
diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index 197bae7..91d76d3 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -319,6 +319,9 @@ static void __attribute__ ((__noreturn__)) print_help(void)
 		" %1$s [options] -o|--options optstring [options] [--] parameters\n"),
 		program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, stderr);
+	fputs("Parse command options.\n", stderr);
+
 	fputs(USAGE_OPTIONS, stderr);
 	fputs(_(" -a, --alternative            Allow long options starting with single -\n"), stderr);
 	fputs(_(" -l, --longoptions <longopts> Long options to be recognized\n"), stderr);
diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index f8cb7dd..74742e8 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -305,6 +305,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] <pid>|<name>...\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Terminate a process.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --all              do not restrict the name-to-pid conversion to processes\n"
 		"                          with the same uid as the present process\n"), out);
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 2994dc0..fb1931a 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -510,6 +510,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] [<message>]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Enter messages into the system log.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -i, --id[=<id>]       log <id> (default is PID)\n"), out);
 	fputs(_(" -f, --file <file>     log the contents of this file\n"), out);
diff --git a/misc-utils/look.c b/misc-utils/look.c
index 51938f2..029b341 100644
--- a/misc-utils/look.c
+++ b/misc-utils/look.c
@@ -366,6 +366,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %s [options] string [file]\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Display lines beginning with a specified string.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --alternative      use alternative dictionary\n"
 		" -d, --alphanum         compare only alphanumeric characters\n"
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index e29901f..133d8eb 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -1523,6 +1523,10 @@ static void __attribute__((__noreturn__)) help(FILE *out)
 
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] [<device> ...]\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("List information about block devices.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --all            print all devices\n"), out);
 	fputs(_(" -b, --bytes          print SIZE in bytes rather than in human readable format\n"), out);
diff --git a/misc-utils/lslocks.c b/misc-utils/lslocks.c
index 83d7b90..f2c7dbe 100644
--- a/misc-utils/lslocks.c
+++ b/misc-utils/lslocks.c
@@ -506,6 +506,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fprintf(out,
 		_(" %s [options]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("List local system locks.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -p, --pid <pid>        process id\n"
 		" -o, --output <list>    define which output columns to use\n"
diff --git a/misc-utils/mcookie.c b/misc-utils/mcookie.c
index c370c2a..49c4413 100644
--- a/misc-utils/mcookie.c
+++ b/misc-utils/mcookie.c
@@ -81,6 +81,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Generate magic cookies for xauth.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -f, --file <file>     use file as a cookie seed\n"), out);
 	fputs(_(" -m, --max-size <num>  limit how much is read from seed files\n"), out);
diff --git a/misc-utils/namei.c b/misc-utils/namei.c
index ff58c9b..780a1d7 100644
--- a/misc-utils/namei.c
+++ b/misc-utils/namei.c
@@ -427,6 +427,10 @@ static void usage(int rc)
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %s [options] <pathname>...\n"), p);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Follow a pathname until a terminal point is found.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -h, --help          displays this help text\n"
 		" -V, --version       output version information and exit\n"
diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index 1bb23cd..17ee3b1 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -116,6 +116,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fprintf(out,
 	      _(" %s [options] <expression> <replacement> <file>...\n"),
 		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Rename files.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -v, --verbose    explain what is being done\n"), out);
 	fputs(_(" -s, --symlink    act on the target of symlinks\n"), out);
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 55aac35..ed2b728 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -72,6 +72,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fprintf(out,
 	      _(" %s [options]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("A daemon for generating UUIDs.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -p, --pid <path>        path to pid file\n"
 		" -s, --socket <path>     path to socket\n"
diff --git a/misc-utils/uuidgen.c b/misc-utils/uuidgen.c
index 48c6562..31730ec 100644
--- a/misc-utils/uuidgen.c
+++ b/misc-utils/uuidgen.c
@@ -32,6 +32,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fprintf(out,
 	      _(" %s [options]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Create a new UUID value.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -r, --random     generate random-based uuid\n"
 		" -t, --time       generate time-based uuid\n"
diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index 5ae6de1..cc6ee7a 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -187,6 +187,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] <file>\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Locate the binary, source, and manual-page files for a command.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -b         search only for binaries\n"), out);
 	fputs(_(" -B <dirs>  define binaries lookup path\n"), out);
diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index 70c3f23..9f7e1bf 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -451,6 +451,10 @@ usage(FILE *out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %s [options] <device>\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Wipe signatures from a device.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --all           wipe all magic strings (BE CAREFUL!)\n"
 		" -b, --backup        create a signature backup in $HOME\n"
diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 7988b2a..b2fcc58 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -57,8 +57,8 @@ static void __attribute__((__noreturn__)) show_usage(int rc)
 {
 	FILE *out = rc == EXIT_SUCCESS ? stdout : stderr;
 
+	fputs("Show or change the real-time scheduling attributes of a process.\n", out);
 	fprintf(out, _(
-	"\nchrt - manipulate real-time attributes of a process\n"
 	"\nSet policy:\n"
 	"  chrt [options] [<policy>] <priority> [-p <pid> | <command> [<arg>...]]\n"
 	"\nGet policy:\n"
diff --git a/schedutils/ionice.c b/schedutils/ionice.c
index fa43e48..ef3b4dc 100644
--- a/schedutils/ionice.c
+++ b/schedutils/ionice.c
@@ -108,6 +108,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 			" %1$s [options] -u <uid>...\n"
 			" %1$s [options] <command>\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Show or change the I/O-scheduling class and priority of a process.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -c, --class <class>    name or number of scheduling class,\n"
 		"                          0: none, 1: realtime, 2: best-effort, 3: idle\n"), out);
diff --git a/schedutils/taskset.c b/schedutils/taskset.c
index 1bf1291..dc7aaaf 100644
--- a/schedutils/taskset.c
+++ b/schedutils/taskset.c
@@ -51,6 +51,10 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		_("Usage: %s [options] [mask | cpu-list] [pid|cmd [args...]]\n\n"),
 		program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Show or change the CPU affinity of a process.\n", out);
+	fputs(USAGE_SEPARATOR, out);
+
 	fprintf(out, _(
 		"Options:\n"
 		" -a, --all-tasks         operate on all the tasks (threads) for a given pid\n"
diff --git a/sys-utils/blkdiscard.c b/sys-utils/blkdiscard.c
index 6075d86..eddb757 100644
--- a/sys-utils/blkdiscard.c
+++ b/sys-utils/blkdiscard.c
@@ -61,6 +61,10 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %s [options] <device>\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Discard the content of sectors on a device.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -o, --offset <num>  offset in bytes to discard from\n"
 		" -l, --length <num>  length of bytes to discard from the offset\n"
diff --git a/sys-utils/chcpu.c b/sys-utils/chcpu.c
index aba9d6b..6ee9e41 100644
--- a/sys-utils/chcpu.c
+++ b/sys-utils/chcpu.c
@@ -238,6 +238,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		"\nUsage:\n"
 		" %s [options]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Configure CPUs in a multi-processor system.\n", out);
+
 	puts(_(	"\nOptions:\n"
 		"  -h, --help                    print this help\n"
 		"  -e, --enable <cpu-list>       enable cpus\n"
diff --git a/sys-utils/ctrlaltdel.c b/sys-utils/ctrlaltdel.c
index 863632f..8f646e5 100644
--- a/sys-utils/ctrlaltdel.c
+++ b/sys-utils/ctrlaltdel.c
@@ -19,6 +19,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, USAGE_HEADER);
 	fprintf(out, _(" %s hard|soft\n"), program_invocation_short_name);
+
+	fprintf(out, USAGE_SEPARATOR);
+	fprintf(out, "Set the function of the Ctrl-Alt-Del combination.\n");
+
 	fprintf(out, USAGE_OPTIONS);
 	fprintf(out, USAGE_HELP);
 	fprintf(out, USAGE_VERSION);
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index c6152d4..d373a3e 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -261,6 +261,10 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options]\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Display or control the kernel ring buffer.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -C, --clear                 clear the kernel ring buffer\n"), out);
 	fputs(_(" -c, --read-clear            read and clear all messages\n"), out);
diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index a816b20..4553924 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -130,10 +130,12 @@ static inline void info(const char *fmt, ...)
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
-
 	fprintf(out,
 		_(" %s [options] [<device>|<mountpoint>]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Eject removable media.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --auto <on|off>         turn auto-eject feature on or off\n"
 		" -c, --changerslot <slot>    switch discs on a CD-ROM changer\n"
diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index 0e06524..8240148 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -76,8 +76,11 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %s [options] <filename>\n"), program_invocation_short_name);
-	fputs(USAGE_OPTIONS, out);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Preallocate space to, or deallocate space from a file.\n", out);
+
+	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -c, --collapse-range remove a range from the file\n"), out);
 	fputs(_(" -d, --dig-holes      detect zeroes and replace with holes\n"), out);
 	fputs(_(" -l, --length <num>   length for range operations, in bytes\n"), out);
diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index 2550a5b..d2bf744 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -53,6 +53,10 @@ static void __attribute__((__noreturn__)) usage(int ex)
 		  " %1$s [options] <file>|<directory> -c <command>\n"
 		  " %1$s [options] <file descriptor number>\n"),
 		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, stderr);
+	fputs("Manage file locks from shell scripts.\n", stderr);
+
 	fputs(USAGE_OPTIONS, stderr);
 	fputs(_(  " -s, --shared             get a shared lock\n"), stderr);
 	fputs(_(  " -x, --exclusive          get an exclusive lock (default)\n"), stderr);
diff --git a/sys-utils/fsfreeze.c b/sys-utils/fsfreeze.c
index 961f8c1..bc754e3 100644
--- a/sys-utils/fsfreeze.c
+++ b/sys-utils/fsfreeze.c
@@ -48,6 +48,10 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fprintf(out, USAGE_HEADER);
 	fprintf(out,
 	      _(" %s [options] <mountpoint>\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Suspend access to a filesystem (ext3/4, ReiserFS, JFS, XFS).\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -f, --freeze      freeze the filesystem\n"), out);
 	fputs(_(" -u, --unfreeze    unfreeze the filesystem\n"), out);
diff --git a/sys-utils/fstrim.c b/sys-utils/fstrim.c
index b18cdb2..ee398b2 100644
--- a/sys-utils/fstrim.c
+++ b/sys-utils/fstrim.c
@@ -228,6 +228,10 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %s [options] <mount point>\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Discard unused blocks on a mounted filesystem.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --all           trim all mounted filesystems that are supported\n"), out);
 	fputs(_(" -o, --offset <num>  the offset in bytes to start discarding from\n"), out);
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 008b20a..4b20605 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1566,6 +1566,9 @@ static void usage(const char *fmt, ...)
 	fputs(USAGE_HEADER, usageto);
 	fputs(_(" hwclock [function] [option...]\n"), usageto);
 
+	fputs(USAGE_SEPARATOR, usageto);
+	fputs("Query or set the hardware clock.\n", usageto);
+
 	fputs(_("\nFunctions:\n"), usageto);
 	fputs(_(" -h, --help           show this help text and exit\n"
 		" -r, --show           read hardware clock and print result\n"
diff --git a/sys-utils/ipcmk.c b/sys-utils/ipcmk.c
index 3ff021e..c037b6e 100644
--- a/sys-utils/ipcmk.c
+++ b/sys-utils/ipcmk.c
@@ -64,8 +64,11 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, USAGE_HEADER);
 	fprintf(out, _(" %s [options]\n"), program_invocation_short_name);
-	fprintf(out, USAGE_OPTIONS);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Create various IPC resources.\n", out);
+
+	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -M, --shmem <size>       create shared memory segment of size <size>\n"), out);
 	fputs(_(" -S, --semaphore <nsems>  create semaphore array with <nsems> elements\n"), out);
 	fputs(_(" -Q, --queue              create message queue\n"), out);
diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index 6443f48..ca4cf31 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -49,7 +49,11 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fprintf(out, USAGE_HEADER);
 	fprintf(out, " %s [options]\n", program_invocation_short_name);
 	fprintf(out, " %s shm|msg|sem <id>...\n", program_invocation_short_name);
-	fprintf(out, USAGE_OPTIONS);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Remove certain IPC resources.\n", out);
+
+	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -m, --shmem-id <id>        remove shared memory segment by id\n"), out);
 	fputs(_(" -M, --shmem-key <key>      remove shared memory segment by key\n"), out);
 	fputs(_(" -q, --queue-id <id>        remove message queue by id\n"), out);
diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 9ce5366..20ac1a0 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -52,7 +52,11 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fprintf(out, USAGE_HEADER);
 	fprintf(out, " %s [resource ...] [output-format]\n", program_invocation_short_name);
 	fprintf(out, " %s [resource] -i <id>\n", program_invocation_short_name);
-	fprintf(out, USAGE_OPTIONS);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Show information on IPC facilities.\n", out);
+
+	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -i, --id <id>  print details on resource identified by <id>\n"), out);
 	fprintf(out, USAGE_HELP);
 	fprintf(out, USAGE_VERSION);
diff --git a/sys-utils/ldattach.c b/sys-utils/ldattach.c
index 853a3ed..e200c70 100644
--- a/sys-utils/ldattach.c
+++ b/sys-utils/ldattach.c
@@ -193,8 +193,11 @@ static void __attribute__ ((__noreturn__)) usage(int exitcode)
 
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] <ldisc> <device>\n"), program_invocation_short_name);
-	fputs(USAGE_OPTIONS, out);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Attach a line discipline to a serial line.\n", out);
+
+	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -d, --debug             print verbose messages to stderr\n"), out);
 	fputs(_(" -s, --speed <value>     set serial line speed\n"), out);
 	fputs(_(" -c, --intro-command <string> intro sent before ldattach\n"), out);
diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 95e99bb..c655f67 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -368,6 +368,9 @@ static void usage(FILE *out)
 		" %1$s [options] -f | <loopdev> <file>\n"),
 		program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Set up and control loop devices.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --all                     list all used devices\n"), out);
 	fputs(_(" -d, --detach <loopdev>...     detach one or more devices\n"), out);
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index c272dc2..aea7758 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1629,6 +1629,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Display information about the CPU architecture.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --all               print both online and offline CPUs (default for -e)\n"), out);
 	fputs(_(" -b, --online            print online CPUs only (default for -p)\n"), out);
diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 14a5e5c..c0aef77 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -718,6 +718,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		" %1$s <operation> <mountpoint> [<target>]\n"),
 		program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Mount a filesystem.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fprintf(out, _(
 	" -a, --all               mount all filesystems mentioned in fstab\n"
diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
index 0aaa290..2c5abcc 100644
--- a/sys-utils/mountpoint.c
+++ b/sys-utils/mountpoint.c
@@ -118,6 +118,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	      _(" %1$s [-qd] /path/to/directory\n"
 		" %1$s -x /dev/device\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Check whether a directory or file is a mountpoint.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -q, --quiet        quiet mode - don't print anything\n"
 		" -d, --fs-devno     print maj:min device number of the filesystem\n"
diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index c54d63f..3f219c0 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -65,6 +65,9 @@ static void usage(int status)
 	fprintf(out, _(" %s [options] <program> [<argument>...]\n"),
 		program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Run a program with namespaces of other processes.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -t, --target <pid>     target process to get namespaces from\n"), out);
 	fputs(_(" -m, --mount[=<file>]   enter mount namespace\n"), out);
diff --git a/sys-utils/pivot_root.c b/sys-utils/pivot_root.c
index 31ceabb..2ee1a6f 100644
--- a/sys-utils/pivot_root.c
+++ b/sys-utils/pivot_root.c
@@ -32,6 +32,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fprintf(out, USAGE_HEADER);
 	fprintf(out, _(" %s [options] new_root put_old\n"),
 		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Change the root filesystem.\n", out);
+
 	fprintf(out, USAGE_OPTIONS);
 	fprintf(out, USAGE_HELP);
 	fprintf(out, USAGE_VERSION);
diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index 8d0a110..f733c30 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -162,6 +162,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fprintf(out,
 		_(" %s [options] COMMAND\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Show or change the resource limits of a process.\n", out);
+
 	fputs(_("\nGeneral Options:\n"), out);
 	fputs(_(" -p, --pid <pid>        process id\n"
 		" -o, --output <list>    define which output columns to use\n"
diff --git a/sys-utils/readprofile.c b/sys-utils/readprofile.c
index 79de7c2..3cb36db 100644
--- a/sys-utils/readprofile.c
+++ b/sys-utils/readprofile.c
@@ -102,8 +102,11 @@ static void __attribute__ ((__noreturn__))
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options]\n"), program_invocation_short_name);
-	fputs(USAGE_OPTIONS, out);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Display kernel profiling information.\n", out);
+
+	fputs(USAGE_OPTIONS, out);
 	fprintf(out,
 	      _(" -m, --mapfile <mapfile>   (defaults: \"%s\" and\n"), defaultmap);
 	fprintf(out,
diff --git a/sys-utils/renice.c b/sys-utils/renice.c
index c96e39a..4b3ae8b 100644
--- a/sys-utils/renice.c
+++ b/sys-utils/renice.c
@@ -62,6 +62,10 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		" %1$s [-n] <priority>  -g|--pgrp <pgid>...\n"
 		" %1$s [-n] <priority>  -u|--user <user>...\n"),
 		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Alter the priority of running processes.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -n, --priority <num>   specify the nice increment value\n"), out);
 	fputs(_(" -p, --pid <id>         interpret argument as process ID (default)\n"), out);
diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index e1cd41d..894b61e 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -71,6 +71,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fprintf(out,
 	      _(" %s [options]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Enter a system sleep state until a specified wakeup time.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --auto               reads the clock mode from adjust file (default)\n"), out);
 	fprintf(out,
diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index ed2a6a6..531c0bd 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -94,6 +94,10 @@ static void __attribute__((__noreturn__)) show_help(void)
 	printf(_(" %s%s [options] [program [program arguments]]\n"),
 	       program_invocation_short_name,
 	       !strcmp(program_invocation_short_name, "setarch") ? " <arch>" : "");
+
+	fputs(USAGE_SEPARATOR, stdout);
+	fputs("Change the reported architecture and set personality flags.\n", stdout);
+
 	fputs(USAGE_OPTIONS, stdout);
 	fputs(_(" -v, --verbose            says what options are being switched on\n"), stdout);
 	fputs(_(" -R, --addr-no-randomize  disables randomization of the virtual address space\n"), stdout);
diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 06d9fe4..9ab933a 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -93,6 +93,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fprintf(out, _(" %s [options] <program> [<argument>...]\n"),
 		program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Run a program with different privilege settings.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -d, --dump               show current state (and do not exec anything)\n"), out);
 	fputs(_(" --nnp, --no-new-privs    disallow granting new privileges\n"), out);
diff --git a/sys-utils/setsid.c b/sys-utils/setsid.c
index 782de82..93a0f9d 100644
--- a/sys-utils/setsid.c
+++ b/sys-utils/setsid.c
@@ -32,6 +32,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		" %s [options] <program> [arguments ...]\n"),
 		program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Run a program in a new session.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -c, --ctty     set the controlling terminal to the current one\n"), out);
 	fputs(_(" -w, --wait     wait program to exit, and use the same return\n"), out);
diff --git a/sys-utils/swapoff.c b/sys-utils/swapoff.c
index b725462..de63800 100644
--- a/sys-utils/swapoff.c
+++ b/sys-utils/swapoff.c
@@ -116,9 +116,11 @@ static int swapoff_by(const char *name, const char *value, int quiet)
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
-
 	fprintf(out, _(" %s [options] [<spec>]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Disable devices and files for paging and swapping.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --all              disable all swaps from /proc/swaps\n"
 		" -v, --verbose          verbose mode\n"), out);
diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index a457607..0a186f4 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -724,9 +724,11 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	size_t i;
 	fputs(USAGE_HEADER, out);
-
 	fprintf(out, _(" %s [options] [<spec>]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Enable devices and files for paging and swapping.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --all                enable all swaps from /etc/fstab\n"), out);
 	fputs(_(" -d, --discard[=<policy>] enable swap discards, if supported by device\n"), out);
diff --git a/sys-utils/switch_root.c b/sys-utils/switch_root.c
index 534d44a..f53062e 100644
--- a/sys-utils/switch_root.c
+++ b/sys-utils/switch_root.c
@@ -200,6 +200,10 @@ static void __attribute__((__noreturn__)) usage(FILE *output)
 	fputs(USAGE_HEADER, output);
 	fprintf(output, _(" %s [options] <newrootdir> <init> <args to init>\n"),
 		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, output);
+	fputs("Switch to another filesystem as the root of the mount tree.\n", output);
+
 	fputs(USAGE_OPTIONS, output);
 	fputs(USAGE_HELP, output);
 	fputs(USAGE_VERSION, output);
diff --git a/sys-utils/tunelp.c b/sys-utils/tunelp.c
index 08cef5c..b7fe761 100644
--- a/sys-utils/tunelp.c
+++ b/sys-utils/tunelp.c
@@ -88,6 +88,9 @@ static void __attribute__((__noreturn__)) print_usage(FILE *out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] <device>\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Set various parameters for the line printer.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -i, --irq <num>              specify parallel port irq\n"), out);
 	fputs(_(" -t, --time <ms>              driver wait time in milliseconds\n"), out);
diff --git a/sys-utils/umount.c b/sys-utils/umount.c
index 8bc6655..9c2fa7e 100644
--- a/sys-utils/umount.c
+++ b/sys-utils/umount.c
@@ -78,6 +78,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		" %1$s [options] <source> | <directory>\n"),
 		program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Unmount filesystems.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --all               unmount all filesystems\n"), out);
 	fputs(_(" -A, --all-targets       unmount all mountpoints for the given device in the\n"
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 933f621..497a02f 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -63,6 +63,9 @@ static void usage(int status)
 	fprintf(out, _(" %s [options] <program> [<argument>...]\n"),
 		program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Run a program with some namespaces unshared from the parent.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -m, --mount               unshare mounts namespace\n"), out);
 	fputs(_(" -u, --uts                 unshare UTS namespace (hostname etc)\n"), out);
diff --git a/sys-utils/wdctl.c b/sys-utils/wdctl.c
index 0628c8e..d6edef0 100644
--- a/sys-utils/wdctl.c
+++ b/sys-utils/wdctl.c
@@ -173,8 +173,10 @@ static void usage(FILE *out)
 	fprintf(out,
 	      _(" %s [options] [<device> ...]\n"), program_invocation_short_name);
 
-	fputs(USAGE_OPTIONS, out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Show the status of the hardware watchdog.\n", out);
 
+	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -f, --flags <list>     print selected flags only\n"
 		" -F, --noflags          don't print information about flags\n"
 		" -I, --noident          don't print watchdog identity information\n"
diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index 786be06..a775a5d 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -378,6 +378,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 			" %1$s [options] -f | <device> -s <size>\n"),
 			program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Set up and control zram devices.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --algorithm lzo|lz4   compression algorithm to use\n"), out);
 	fputs(_(" -b, --bytes               print sizes in bytes rather than in human readable format\n"), out);
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 9871a36..dd8a83f 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1982,6 +1982,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %1$s [options] <line> [<baud_rate>,...] [<termtype>]\n"
 		       " %1$s [options] <baud_rate>,... <line> [<termtype>]\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Open a terminal and set its mode.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -8, --8bits                assume 8-bit tty\n"), out);
 	fputs(_(" -a, --autologin <user>     login the specified user automatically\n"), out);
diff --git a/term-utils/mesg.c b/term-utils/mesg.c
index 12e4e0e..2c19038 100644
--- a/term-utils/mesg.c
+++ b/term-utils/mesg.c
@@ -73,6 +73,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	 * which means they can be translated.  */
 	fprintf(out,
 	      _(" %s [options] [y | n]\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Control write access of other users to your terminal.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -v, --verbose  explain what is being done\n"), out);
 	fputs(USAGE_HELP, out);
diff --git a/term-utils/script.c b/term-utils/script.c
index 78d7a30..551a8ea 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -143,6 +143,9 @@ usage(FILE *out)
 	fprintf(out,
 	      _(" %s [options] [file]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Make a typescript of a terminal session.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --append            append the output\n"
 		" -c, --command <command> run command rather than interactive shell\n"
diff --git a/term-utils/scriptreplay.c b/term-utils/scriptreplay.c
index fb5ded3..1c61fa0 100644
--- a/term-utils/scriptreplay.c
+++ b/term-utils/scriptreplay.c
@@ -42,6 +42,9 @@ usage(FILE *out)
 	      _(" %s [-t] timingfile [typescript] [divisor]\n"),
 	      program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Play back terminal typescripts, using timing information.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -t, --timing <file>     script timing output file\n"
 		" -s, --typescript <file> script terminal session output file\n"
diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index fefb0a9..2b65eea 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -402,6 +402,10 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %s [options]\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Set the attributes of a terminal.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" --term          <terminal_name>   override TERM environment variable\n"), out);
 	fputs(_(" --reset                           reset terminal to power-on state\n"), out);
diff --git a/term-utils/wall.c b/term-utils/wall.c
index 598e9f2..cf90953 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -81,6 +81,10 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %s [options] [<file> | <message>]\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Write a message to all users.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -n, --nobanner          do not print banner, works only for root\n"), out);
 	fputs(_(" -t, --timeout <timeout> write timeout in seconds\n"), out);
diff --git a/term-utils/write.c b/term-utils/write.c
index ca40354..627eacc 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -82,6 +82,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	      _(" %s [options] <user> [<ttyname>]\n"),
 	      program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Send a message to another user.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
diff --git a/text-utils/col.c b/text-utils/col.c
index 1218f25..3a9f97b 100644
--- a/text-utils/col.c
+++ b/text-utils/col.c
@@ -130,6 +130,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		"\nUsage:\n"
 		" %s [options]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Filter out reverse line feeds.\n", out);
+
 	fprintf(out, _(
 		"\nOptions:\n"
 		" -b, --no-backspaces    do not output backspaces\n"
diff --git a/text-utils/colcrt.c b/text-utils/colcrt.c
index c39c8b6..24113cf 100644
--- a/text-utils/colcrt.c
+++ b/text-utils/colcrt.c
@@ -313,6 +313,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 		_("\nUsage:\n"
 		  " %s [options] [file ...]\n"), program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Filter nroff output for CRT previewing\n.", out);
+
+	fputs(USAGE_OPTIONS, out);
 	fprintf(out,
 		_(" -,  --no-underlining  suppress all underlining\n"
 		  " -2, --half-lines      print all half-lines\n"
diff --git a/text-utils/colrm.c b/text-utils/colrm.c
index 4264fe6..ce61cc2 100644
--- a/text-utils/colrm.c
+++ b/text-utils/colrm.c
@@ -59,6 +59,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fprintf(out, _("\nUsage:\n"
 		       " %s [startcol [endcol]]\n"),
 		       program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Filter out the specified columns.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
diff --git a/text-utils/column.c b/text-utils/column.c
index e583dba..3ca11e2 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -90,6 +90,10 @@ static void __attribute__((__noreturn__)) usage(int rc)
 
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] [<file>...]\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Columnate lists.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -c, --columns <width>    width of output in number of characters\n"), out);
 	fputs(_(" -t, --table              create a table\n"), out);
diff --git a/text-utils/hexdump.c b/text-utils/hexdump.c
index afae334..3963846 100644
--- a/text-utils/hexdump.c
+++ b/text-utils/hexdump.c
@@ -153,6 +153,10 @@ void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] <file>...\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Display file contents in hexadecimal, decimal, octal, or ascii.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -b, --one-byte-octal      one-byte octal display\n"), out);
 	fputs(_(" -c, --one-byte-char       one-byte character display\n"), out);
diff --git a/text-utils/line.c b/text-utils/line.c
index 80daa34..46d2799 100644
--- a/text-utils/line.c
+++ b/text-utils/line.c
@@ -28,6 +28,10 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options]\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Read one line.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
diff --git a/text-utils/more.c b/text-utils/more.c
index 8c0853c..cb7e636 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -317,6 +317,10 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] <file>...\n"), program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("A file perusal filter for CRT viewing.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -d          display help instead of ringing bell\n"), out);
 	fputs(_(" -f          count logical rather than screen lines\n"), out);
diff --git a/text-utils/pg.c b/text-utils/pg.c
index 9ada00c..90a803f 100644
--- a/text-utils/pg.c
+++ b/text-utils/pg.c
@@ -222,6 +222,10 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fprintf(out,
 		_(" %s [options] [+line] [+/pattern/] [files]\n"),
 		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Browse pagewise through text files.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -number      lines per page\n"), out);
 	fputs(_(" -c           clear screen before displaying\n"), out);
diff --git a/text-utils/rev.c b/text-utils/rev.c
index bda31d2..0dd706c 100644
--- a/text-utils/rev.c
+++ b/text-utils/rev.c
@@ -76,6 +76,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, _("Usage: %s [options] [file ...]\n"),
 		program_invocation_short_name);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Reverse lines characterwise.\n", out);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
diff --git a/text-utils/tailf.c b/text-utils/tailf.c
index bd38da2..1e73b25 100644
--- a/text-utils/tailf.c
+++ b/text-utils/tailf.c
@@ -198,6 +198,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 		  " %s [option] file\n"),
 		program_invocation_short_name);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Follow the growth of a log file.\n", out);
+
 	fprintf(out, _(
 		"\nOptions:\n"
 		" -n, --lines NUMBER  output the last NUMBER lines\n"
diff --git a/text-utils/ul.c b/text-utils/ul.c
index 20a0551..3ca324a 100644
--- a/text-utils/ul.c
+++ b/text-utils/ul.c
@@ -134,8 +134,11 @@ usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] [<file> ...]\n"), program_invocation_short_name);
-	fputs(USAGE_OPTIONS, out);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs("Do underlining.\n", out);
+
+	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -t, -T, --terminal TERMINAL  override the TERM environment variable\n"), out);
 	fputs(_(" -i, --indicated              underlining is indicated via a separate line\n"), out);
 	fputs(USAGE_SEPARATOR, out);
-- 
1.7.0.4

