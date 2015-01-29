Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:56796 "EHLO
	cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755855AbbA2UV4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Jan 2015 15:21:56 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] textual: grammarize and harmonize the stat error message
Date: Thu, 29 Jan 2015 21:21:48 +0100
Message-Id: <1422562908-2103-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The message "stat failed %s" seems to say that stat() failed to
do something, or failed to pass a test, but of course it means
that the statting of something failed.  So say so.  Also make
two very similar messages equal to this one.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/fdformat.c    |    2 +-
 disk-utils/fsck.cramfs.c |    2 +-
 disk-utils/mkfs.bfs.c    |    2 +-
 disk-utils/mkfs.cramfs.c |    6 +++---
 disk-utils/mkfs.minix.c  |    2 +-
 disk-utils/mkswap.c      |    2 +-
 disk-utils/partx.c       |    2 +-
 login-utils/last.c       |    2 +-
 login-utils/utmpdump.c   |    2 +-
 misc-utils/namei.c       |    2 +-
 misc-utils/rename.c      |    2 +-
 sys-utils/blkdiscard.c   |    2 +-
 sys-utils/dmesg.c        |    2 +-
 sys-utils/fallocate.c    |    2 +-
 sys-utils/fsfreeze.c     |    2 +-
 sys-utils/fstrim.c       |    2 +-
 sys-utils/swapon.c       |    2 +-
 sys-utils/switch_root.c  |    4 ++--
 term-utils/mesg.c        |    2 +-
 text-utils/more.c        |    2 +-
 text-utils/tailf.c       |    4 ++--
 21 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/disk-utils/fdformat.c b/disk-utils/fdformat.c
index ad9a863..e7d43da 100644
--- a/disk-utils/fdformat.c
+++ b/disk-utils/fdformat.c
@@ -217,7 +217,7 @@ int main(int argc, char **argv)
 	if (argc < 1)
 		usage(stderr);
 	if (stat(argv[0], &st) < 0)
-		err(EXIT_FAILURE, _("stat failed %s"), argv[0]);
+		err(EXIT_FAILURE, _("stat of %s failed"), argv[0]);
 	if (!S_ISBLK(st.st_mode))
 		/* do not test major - perhaps this was an USB floppy */
 		errx(EXIT_FAILURE, _("%s: not a block device"), argv[0]);
diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index 419b9ac..0a375f1 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -143,7 +143,7 @@ static void test_super(int *start, size_t * length)
 
 	/* find the physical size of the file or block device */
 	if (stat(filename, &st) < 0)
-		err(FSCK_EX_ERROR, _("stat failed %s"), filename);
+		err(FSCK_EX_ERROR, _("stat of %s failed"), filename);
 
 	fd = open(filename, O_RDONLY);
 	if (fd < 0)
diff --git a/disk-utils/mkfs.bfs.c b/disk-utils/mkfs.bfs.c
index 98e4b05..2a22364 100644
--- a/disk-utils/mkfs.bfs.c
+++ b/disk-utils/mkfs.bfs.c
@@ -182,7 +182,7 @@ int main(int argc, char **argv)
 	device = argv[optind++];
 
 	if (stat(device, &statbuf) < 0)
-		err(EXIT_FAILURE, _("stat failed %s"), device);
+		err(EXIT_FAILURE, _("stat of %s failed"), device);
 
 	if (!S_ISBLK(statbuf.st_mode))
 		errx(EXIT_FAILURE, _("%s is not a block special device"), device);
diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index 509b50b..5b64ad8 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -328,7 +328,7 @@ static unsigned int parse_directory(struct entry *root_entry, const char *name,
 		memcpy(endpath, dirent->d_name, namelen + 1);
 
 		if (lstat(path, &st) < 0) {
-			warn(_("stat failed %s"), endpath);
+			warn(_("stat of %s failed"), endpath);
 			warn_skip = 1;
 			continue;
 		}
@@ -748,7 +748,7 @@ int main(int argc, char **argv)
 		case 'i':
 			opt_image = optarg;
 			if (lstat(opt_image, &st) < 0)
-				err(MKFS_EX_USAGE, _("stat failed %s"), opt_image);
+				err(MKFS_EX_USAGE, _("stat of %s failed"), opt_image);
 			image_length = st.st_size; /* may be padded later */
 			fslen_ub += (image_length + 3); /* 3 is for padding */
 			break;
@@ -785,7 +785,7 @@ int main(int argc, char **argv)
 		blksize = getpagesize();
 
 	if (stat(dirname, &st) < 0)
-		err(MKFS_EX_USAGE, _("stat failed %s"), dirname);
+		err(MKFS_EX_USAGE, _("stat of %s failed"), dirname);
 	fd = open(outfile, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 	if (fd < 0)
 		err(MKFS_EX_USAGE, _("cannot open %s"), outfile);
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 81b7ae3..c84aed2 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -747,7 +747,7 @@ int main(int argc, char ** argv) {
 		strcpy(tmp+2, ".badblocks");
 	}
 	if (stat(device_name, &statbuf) < 0)
-		err(MKFS_EX_ERROR, _("stat failed %s"), device_name);
+		err(MKFS_EX_ERROR, _("stat of %s failed"), device_name);
 	if (S_ISBLK(statbuf.st_mode))
 		DEV = open(device_name,O_RDWR | O_EXCL);
 	else
diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index b22c73f..c7166f7 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -239,7 +239,7 @@ static void open_device(struct mkswap_control *ctl)
 	assert(ctl->devname);
 
 	if (stat(ctl->devname, &ctl->devstat) < 0)
-		err(EXIT_FAILURE, _("stat failed %s"), ctl->devname);
+		err(EXIT_FAILURE, _("stat of %s failed"), ctl->devname);
 
 	if (S_ISBLK(ctl->devstat.st_mode))
 		ctl->fd = open(ctl->devname, O_RDWR | O_EXCL);
diff --git a/disk-utils/partx.c b/disk-utils/partx.c
index 1ba5315..f21c388 100644
--- a/disk-utils/partx.c
+++ b/disk-utils/partx.c
@@ -888,7 +888,7 @@ int main(int argc, char **argv)
 		device = argv[optind];
 
 		if (stat(device, &sb))
-			err(EXIT_FAILURE, _("stat failed %s"), device);
+			err(EXIT_FAILURE, _("stat of %s failed"), device);
 
 		part_devno = sb.st_rdev;
 
diff --git a/login-utils/last.c b/login-utils/last.c
index e646cab..d6d8d96 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -670,7 +670,7 @@ static void process_wtmp_file(const struct last_control *ctl)
 		begintime = ut.UL_UT_TIME;
 	else {
 		if (fstat(fileno(fp), &st) != 0)
-			err(EXIT_FAILURE, _("stat failed %s"), ctl->altv[ctl->alti]);
+			err(EXIT_FAILURE, _("stat of %s failed"), ctl->altv[ctl->alti]);
 		begintime = st.st_ctime;
 		quit = 1;
 	}
diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index 79bdf33..60752af 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -126,7 +126,7 @@ static void roll_file(const char *filename, off_t *size, FILE *out)
 		err(EXIT_FAILURE, _("cannot open %s"), filename);
 
 	if (fstat(fileno(in), &st) == -1)
-		err(EXIT_FAILURE, _("%s: stat failed"), filename);
+		err(EXIT_FAILURE, _("stat of %s failed"), filename);
 
 	if (st.st_size == *size)
 		goto done;
diff --git a/misc-utils/namei.c b/misc-utils/namei.c
index 3af0380..15bec99 100644
--- a/misc-utils/namei.c
+++ b/misc-utils/namei.c
@@ -228,7 +228,7 @@ dotdot_stat(const char *dirname, struct stat *st)
 	memcpy(path + len, DOTDOTDIR, sizeof(DOTDOTDIR));
 
 	if (stat(path, st))
-		err(EXIT_FAILURE, _("stat failed %s"), path);
+		err(EXIT_FAILURE, _("stat of %s failed"), path);
 	free(path);
 	return st;
 }
diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index 5ecf86c..f9cc3a5 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -60,7 +60,7 @@ static int do_symlink(char *from, char *to, char *s, int verbose)
 	struct stat sb;
 
 	if (lstat(s, &sb) == -1) {
-		warn(_("%s: lstat failed"), s);
+		warn(_("stat of %s failed"), s);
 		return 2;
 	}
 	if (!S_ISLNK(sb.st_mode)) {
diff --git a/sys-utils/blkdiscard.c b/sys-utils/blkdiscard.c
index e33f9b9..3ee0b5d 100644
--- a/sys-utils/blkdiscard.c
+++ b/sys-utils/blkdiscard.c
@@ -154,7 +154,7 @@ int main(int argc, char **argv)
 		err(EXIT_FAILURE, _("cannot open %s"), path);
 
 	if (fstat(fd, &sb) == -1)
-		err(EXIT_FAILURE, _("stat failed %s"), path);
+		err(EXIT_FAILURE, _("stat of %s failed"), path);
 	if (!S_ISBLK(sb.st_mode))
 		errx(EXIT_FAILURE, _("%s: not a block device"), path);
 
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index a3da2b2..8360fa3 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -519,7 +519,7 @@ static ssize_t mmap_file_buffer(struct dmesg_control *ctl, char **buf)
 	if (fd < 0)
 		err(EXIT_FAILURE, _("cannot open %s"), ctl->filename);
 	if (fstat(fd, &st))
-		err(EXIT_FAILURE, _("stat failed %s"), ctl->filename);
+		err(EXIT_FAILURE, _("stat of %s failed"), ctl->filename);
 
 	*buf = mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
 	if (*buf == MAP_FAILED)
diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index 84b06b9..d7e591c 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -195,7 +195,7 @@ static void dig_holes(int fd, off_t off, off_t len)
 #endif
 
 	if (fstat(fd, &st) != 0)
-		err(EXIT_FAILURE, _("stat failed %s"), filename);
+		err(EXIT_FAILURE, _("stat of %s failed"), filename);
 
 	bufsz = st.st_blksize;
 
diff --git a/sys-utils/fsfreeze.c b/sys-utils/fsfreeze.c
index d8b0a68..d4d5bd3 100644
--- a/sys-utils/fsfreeze.c
+++ b/sys-utils/fsfreeze.c
@@ -128,7 +128,7 @@ int main(int argc, char **argv)
 		err(EXIT_FAILURE, _("cannot open %s"), path);
 
 	if (fstat(fd, &sb) == -1) {
-		warn(_("stat failed %s"), path);
+		warn(_("stat of %s failed"), path);
 		goto done;
 	}
 
diff --git a/sys-utils/fstrim.c b/sys-utils/fstrim.c
index fca7482..847b819 100644
--- a/sys-utils/fstrim.c
+++ b/sys-utils/fstrim.c
@@ -73,7 +73,7 @@ static int fstrim_filesystem(const char *path, struct fstrim_range *rangetpl,
 		return -1;
 	}
 	if (fstat(fd, &sb) == -1) {
-		warn(_("stat failed %s"), path);
+		warn(_("stat of %s failed"), path);
 		return -1;
 	}
 	if (!S_ISDIR(sb.st_mode)) {
diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index bcceb7c..645a01d 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -479,7 +479,7 @@ static int swapon_checks(const char *special)
 	int permMask;
 
 	if (stat(special, &st) < 0) {
-		warn(_("stat failed %s"), special);
+		warn(_("stat of %s failed"), special);
 		goto err;
 	}
 
diff --git a/sys-utils/switch_root.c b/sys-utils/switch_root.c
index be23fd8..dc55a6d 100644
--- a/sys-utils/switch_root.c
+++ b/sys-utils/switch_root.c
@@ -90,7 +90,7 @@ static int recursiveRemove(int fd)
 			struct stat sb;
 
 			if (fstatat(dfd, d->d_name, &sb, AT_SYMLINK_NOFOLLOW)) {
-				warn(_("stat failed %s"), d->d_name);
+				warn(_("stat of %s failed"), d->d_name);
 				continue;
 			}
 
@@ -130,7 +130,7 @@ static int switchroot(const char *newroot)
 	struct stat newroot_stat, sb;
 
 	if (stat(newroot, &newroot_stat) != 0) {
-		warn(_("stat failed %s"), newroot);
+		warn(_("stat of %s failed"), newroot);
 		return -1;
 	}
 
diff --git a/term-utils/mesg.c b/term-utils/mesg.c
index a389287..3cb1d24 100644
--- a/term-utils/mesg.c
+++ b/term-utils/mesg.c
@@ -125,7 +125,7 @@ int main(int argc, char *argv[])
 		err(MESG_EXIT_FAILURE, _("ttyname failed"));
 
 	if (stat(tty, &sb) < 0)
-		err(MESG_EXIT_FAILURE, _("stat failed %s"), tty);
+		err(MESG_EXIT_FAILURE, _("stat of %s failed"), tty);
 
 	if (!*argv) {
 		if (sb.st_mode & (S_IWGRP | S_IWOTH)) {
diff --git a/text-utils/more.c b/text-utils/more.c
index 94b0455..4602cba 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -595,7 +595,7 @@ FILE *checkf(register char *fs, int *clearfirst)
 		fflush(stdout);
 		if (clreol)
 			cleareol();
-		warn(_("stat failed %s"), fs);
+		warn(_("stat of %s failed"), fs);
 		return ((FILE *)NULL);
 	}
 	if ((stbuf.st_mode & S_IFMT) == S_IFDIR) {
diff --git a/text-utils/tailf.c b/text-utils/tailf.c
index 6adb050..38df99f 100644
--- a/text-utils/tailf.c
+++ b/text-utils/tailf.c
@@ -98,7 +98,7 @@ roll_file(const char *filename, off_t *size)
 		err(EXIT_FAILURE, _("cannot open %s"), filename);
 
 	if (fstat(fd, &st) == -1)
-		err(EXIT_FAILURE, _("stat failed %s"), filename);
+		err(EXIT_FAILURE, _("stat of %s failed"), filename);
 
 	if (st.st_size == *size) {
 		close(fd);
@@ -278,7 +278,7 @@ int main(int argc, char **argv)
 	filename = argv[optind];
 
 	if (stat(filename, &st) != 0)
-		err(EXIT_FAILURE, _("stat failed %s"), filename);
+		err(EXIT_FAILURE, _("stat of %s failed"), filename);
 
 	size = st.st_size;;
 	tailf(filename, lines);
-- 
1.7.0.4

