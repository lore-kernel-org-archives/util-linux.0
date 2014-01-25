Return-Path: util-linux-owner@vger.kernel.org
Received: from alerce.vps.bitfolk.com ([85.119.82.134]:45068 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbaAYTU5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 25 Jan 2014 14:20:57 -0500
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: util-linux@vger.kernel.org
Cc: Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH 3/3] fallocate: Add "--dig-holes" option
Date: Sat, 25 Jan 2014 19:17:28 +0000
Message-Id: <1390677448-7173-4-git-send-email-rodrigo@sdfg.com.ar>
In-Reply-To: <1390677448-7173-1-git-send-email-rodrigo@sdfg.com.ar>
References: <1390677448-7173-1-git-send-email-rodrigo@sdfg.com.ar>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This option tries to detect chunk of '\0's and punch a hole, making the file
sparse in-place.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
---
 bash-completion/fallocate |   2 +-
 sys-utils/fallocate.1     |  19 +++++++-
 sys-utils/fallocate.c     | 114 ++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 120 insertions(+), 15 deletions(-)

diff --git a/bash-completion/fallocate b/bash-completion/fallocate
index 2c6e4cb..5fc58c0 100644
--- a/bash-completion/fallocate
+++ b/bash-completion/fallocate
@@ -15,7 +15,7 @@ _fallocate_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="--keep-size --punch-hole --offset --length --help --version"
+			OPTS="--keep-size --punch-hole --detect-holes --offset --length --help --version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/sys-utils/fallocate.1 b/sys-utils/fallocate.1
index efa42c1..ac8e61d 100644
--- a/sys-utils/fallocate.1
+++ b/sys-utils/fallocate.1
@@ -11,6 +11,12 @@ fallocate \- preallocate or deallocate space to a file
 .B \-l
 .IR length
 .I filename
+.PP
+.B fallocate
+.RB \-d
+.RB [ \-l
+.IR length ]
+.I filename
 .SH DESCRIPTION
 .B fallocate
 is used to manipulate the allocated disk space for a file, either to deallocate
@@ -20,7 +26,8 @@ uninitialized, requiring no IO to the data blocks. This is much faster than
 creating a file by filling it with zeros.
 .PP
 As of the Linux Kernel v2.6.31, the fallocate system call is supported by the
-btrfs, ext4, ocfs2, and xfs filesystems.
+btrfs, ext4, ocfs2, and xfs filesystems. Support for options needed to run with
+\fI\-\-punch-hole\fR or \fI\-\-detect-holes\fR was added in Linux 2.6.38.
 .PP
 The exit code returned by
 .B fallocate
@@ -36,6 +43,16 @@ Do not modify the apparent length of the file.  This may effectively allocate
 blocks past EOF, which can be removed with a truncate.
 .IP "\fB\-p, \-\-punch-hole\fP"
 Punch holes in the file, the range should not exceed the length of the file.
+.IP "\fB\-d, \-\-dig-holes\fP"
+Detect and dig holes of, at least, \fIlength\fR size. If \fIlength\fR is not
+specified, it defaults to 32k. Makes the file sparse in-place, without using
+extra disk space. You can think of this as doing a "\fBcp --sparse\fP" and
+renaming the dest file as the original, without the need for extra disk space.
+.PP
+.IP
+Note that too small values for \fIlength\fR might be ignored. And too big values
+might use lot of RAM and not detect many holes. Also, when using this option, 
+\fI\-\-keep-size\fP is implied.
 .IP "\fB\-o, \-\-offset\fP \fIoffset\fP
 Specifies the beginning offset of the allocation, in bytes.
 .IP "\fB\-l, \-\-length\fP \fIlength\fP
diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index 5c66553..72aaef4 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -23,6 +23,7 @@
  */
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <sys/mman.h>
 #include <ctype.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -31,6 +32,7 @@
 #include <unistd.h>
 #include <getopt.h>
 #include <limits.h>
+#include <string.h>
 
 #ifndef HAVE_FALLOCATE
 # include <sys/syscall.h>
@@ -62,6 +64,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -n, --keep-size     don't modify the length of the file\n"
 		" -p, --punch-hole    punch holes in the file\n"
+		" -d, --dig-holes     detect and dig holes\n"
 		" -o, --offset <num>  offset of the (de)allocation, in bytes\n"
 		" -l, --length <num>  length of the (de)allocation, in bytes\n"), out);
 	fputs(USAGE_SEPARATOR, out);
@@ -106,6 +109,76 @@ static int xfallocate(int fd, int mode, off_t offset, off_t length)
 	return error;
 }
 
+/*
+ * Look for chunks of '\0's with size hole_size and when we find them, dig a
+ * hole on that offset with that size
+ */
+static int detect_holes(int fd, size_t hole_size)
+{
+	int ret = 0;
+	int err;
+
+	if (hole_size >= 100 * 1024 * 1024) {
+		size_t ram_mb = hole_size / 1024 / 1024;
+		printf("WARNING: %zu MB RAM will be used\n", ram_mb);
+		sleep(3);
+	}
+
+	/* Create a buffer of '\0's to compare against */
+	/* XXX: Use mmap() with MAP_PRIVATE so Linux can avoid this allocation */
+	void *zeros = mmap(NULL, hole_size, PROT_READ,
+	                   MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+	if (zeros == MAP_FAILED) {
+		perror("mmap");
+		return -1;
+	}
+
+	/* buffer to read the file */
+	ssize_t buf_len = hole_size;
+	void *buf = malloc(buf_len);
+	if (buf == NULL) {
+		fputs(_("not enough memory\n"), stderr);
+		ret = -1;
+		goto out;
+	}
+
+	off_t end = lseek(fd, 0, SEEK_END);
+	if (end == -1) {
+		perror("lseek");
+		ret = -1;
+		goto out;
+	}
+
+	for (off_t offset = 0; offset + hole_size <= end; offset += buf_len) {
+
+		/* Try to read hole_size bytes */
+		buf_len = pread(fd, buf, hole_size, offset);
+		if (buf_len == -1) {
+			perror("pread");
+			ret = -1;
+			goto out;
+		}
+
+		/* Always use buf_len, as we may read less than hole_size bytes */
+		int not_zeros = memcmp(buf, zeros, buf_len);
+		if (not_zeros)
+			continue;
+
+		int ret = xfallocate(fd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE,
+		                     offset, buf_len);
+		if (ret)
+			goto out;
+	}
+out:
+	err = munmap(zeros, hole_size);
+	if (err) {
+		perror("munmap");
+		ret = 1;
+	}
+	free(buf);
+	return ret;
+}
+
 int main(int argc, char **argv)
 {
 	char	*fname;
@@ -113,17 +186,19 @@ int main(int argc, char **argv)
 	int	error;
 	int	fd;
 	int	mode = 0;
+	int	dig_holes = 0;
 	loff_t	length = -2LL;
 	loff_t	offset = 0;
 
 	static const struct option longopts[] = {
-	    { "help",      0, 0, 'h' },
-	    { "version",   0, 0, 'V' },
-	    { "keep-size", 0, 0, 'n' },
+	    { "help",       0, 0, 'h' },
+	    { "version",    0, 0, 'V' },
+	    { "keep-size",  0, 0, 'n' },
 	    { "punch-hole", 0, 0, 'p' },
-	    { "offset",    1, 0, 'o' },
-	    { "length",    1, 0, 'l' },
-	    { NULL,        0, 0, 0 }
+	    { "dig-holes",  0, 0, 'd' },
+	    { "offset",     1, 0, 'o' },
+	    { "length",     1, 0, 'l' },
+	    { NULL,         0, 0, 0 }
 	};
 
 	setlocale(LC_ALL, "");
@@ -131,7 +206,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "hVnpl:o:", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "hVnpdl:o:", longopts, NULL)) != -1) {
 		switch(c) {
 		case 'h':
 			usage(stdout);
@@ -145,6 +220,9 @@ int main(int argc, char **argv)
 		case 'n':
 			mode |= FALLOC_FL_KEEP_SIZE;
 			break;
+		case 'd':
+			dig_holes = 1;
+			break;
 		case 'l':
 			length = cvtnum(optarg);
 			break;
@@ -156,8 +234,13 @@ int main(int argc, char **argv)
 			break;
 		}
 	}
-
-	if (length == -2LL)
+	if (dig_holes && mode != 0)
+		errx(EXIT_FAILURE, _("Can't use -p or -n with --dig-holes"));
+	if (dig_holes && offset != 0)
+		errx(EXIT_FAILURE, _("Can't use -o with --dig-holes"));
+	if (length == -2LL && dig_holes)
+		length = 32 * 1024;
+	if (length == -2LL && !dig_holes)
 		errx(EXIT_FAILURE, _("no length argument specified"));
 	if (length <= 0)
 		errx(EXIT_FAILURE, _("invalid length value specified"));
@@ -173,16 +256,21 @@ int main(int argc, char **argv)
 		usage(stderr);
 	}
 
-	fd = open(fname, O_WRONLY|O_CREAT, 0644);
+	fd = open(fname, O_RDWR|O_CREAT, 0644);
 	if (fd < 0)
 		err(EXIT_FAILURE, _("cannot open %s"), fname);
 
-	error = xfallocate(fd, mode, offset, length);
+	if (dig_holes)
+		error = detect_holes(fd, length);
+	else
+		error = xfallocate(fd, mode, offset, length);
+
+	/* Close before checking for errors, as we might have written it */
+	if (close_fd(fd) != 0)
+		err(EXIT_FAILURE, _("write failed: %s"), fname);
 
 	if (error < 0)
 		exit(EXIT_FAILURE);
 
-	if (close_fd(fd) != 0)
-		err(EXIT_FAILURE, _("write failed: %s"), fname);
 	return EXIT_SUCCESS;
 }
-- 
1.8.5.2

