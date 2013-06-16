Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37187 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab3FPSyJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Jun 2013 14:54:09 -0400
Received: by mail-wi0-f177.google.com with SMTP id ey16so1578267wid.4
        for <util-linux@vger.kernel.org>; Sun, 16 Jun 2013 11:54:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/15] sfdisk: use libc error printing function, and symbolic exit values
Date: Sun, 16 Jun 2013 19:53:43 +0100
Message-Id: <1371408836-16663-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The commit removes all references to perror(), and replaces them with
either warn() or err().

References: http://marc.info/?l=util-linux-ng&m=137060043804592&w=2
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisks/sfdisk.c | 120 ++++++++++++++++++++------------------------------------
 1 file changed, 43 insertions(+), 77 deletions(-)

diff --git a/fdisks/sfdisk.c b/fdisks/sfdisk.c
index e639dad..cbbdfd5 100644
--- a/fdisks/sfdisk.c
+++ b/fdisks/sfdisk.c
@@ -27,8 +27,6 @@
  * I changed the name to sfdisk to prevent confusion. - aeb, 970501
  */
 
-#define PROGNAME "sfdisk"
-
 #include <stdio.h>
 #include <stdlib.h>		/* atoi, free */
 #include <stdarg.h>		/* varargs */
@@ -108,18 +106,6 @@ my_warn(char *s, ...) {
     va_end(p);
 }
 
-static void
-error(char *s, ...) {
-    va_list p;
-
-    va_start(p, s);
-    fflush(stdout);
-    fprintf(stderr, "\n" PROGNAME ": ");
-    vfprintf(stderr, s, p);
-    fflush(stderr);
-    va_end(p);
-}
-
 /*
  *  A. About seeking
  */
@@ -136,13 +122,12 @@ sseek(char *dev, int fd, unsigned long s) {
     in = ((off_t) s << 9);
 
     if ((out = lseek(fd, in, SEEK_SET)) != in) {
-	perror("lseek");
-	error(_("seek error on %s - cannot seek to %lu\n"), dev, s);
+	warn(_("seek error on %s - cannot seek to %lu"), dev, s);
 	return 0;
     }
 
     if (in != out) {
-	error(_("seek error: wanted 0x%08x%08x, got 0x%08x%08x\n"),
+	warnx(_("seek error: wanted 0x%08x%08x, got 0x%08x%08x"),
 	      (unsigned int)(in >> 32), (unsigned int)(in & 0xffffffff),
 	      (unsigned int)(out >> 32), (unsigned int)(out & 0xffffffff));
 	return 0;
@@ -190,9 +175,7 @@ get_sector(char *dev, int fd, unsigned long long sno) {
     s = xmalloc(sizeof(struct sector));
 
     if (read(fd, s->data, sizeof(s->data)) != sizeof(s->data)) {
-	if (errno)		/* 0 in case we read past end-of-disk */
-	    perror("read");
-	error(_("read error on %s - cannot read sector %lu\n"), dev, sno);
+	warn(_("read error on %s - cannot read sector %llu"), dev, sno);
 	free(s);
 	return 0;
     }
@@ -222,9 +205,8 @@ write_sectors(char *dev, int fd) {
 	    if (!sseek(dev, fd, s->sectornumber))
 		return 0;
 	    if (write(fd, s->data, sizeof(s->data)) != sizeof(s->data)) {
-		perror("write");
-		error(_("write error on %s - cannot write sector %lu\n"),
-		      dev, s->sectornumber);
+		warn(_("write error on %s - cannot write sector %llu"),
+		     dev, s->sectornumber);
 		return 0;
 	    }
 	    s->to_be_written = 0;
@@ -260,9 +242,8 @@ save_sectors(char *dev, int fdin) {
 
     fdout = open(save_sector_file, O_WRONLY | O_CREAT, 0444);
     if (fdout < 0) {
-	perror(save_sector_file);
-	error(_("cannot open partition sector save file (%s)\n"),
-	      save_sector_file);
+	warn(_("cannot open partition sector save file (%s)"),
+	     save_sector_file);
 	goto err;
     }
 
@@ -272,14 +253,12 @@ save_sectors(char *dev, int fdin) {
 	    if (!sseek(dev, fdin, s->sectornumber))
 		goto err;
 	    if (read(fdin, ss + 4, 512) != 512) {
-		perror("read");
-		error(_("read error on %s - cannot read sector %lu\n"),
-		      dev, s->sectornumber);
+		warn(_("read error on %s - cannot read sector %llu"),
+		     dev, s->sectornumber);
 		goto err;
 	    }
 	    if (write(fdout, ss, sizeof(ss)) != sizeof(ss)) {
-		perror("write");
-		error(_("write error on %s\n"), save_sector_file);
+		warn(_("write error on %s"), save_sector_file);
 		goto err;
 	    }
 	}
@@ -308,13 +287,12 @@ restore_sectors(char *dev) {
     unsigned long sno;
 
     if (stat(restore_sector_file, &statbuf) < 0) {
-	perror(restore_sector_file);
-	error(_("cannot stat partition restore file (%s)\n"),
-	      restore_sector_file);
+	warn(_("cannot stat partition restore file (%s)"),
+	     restore_sector_file);
 	goto err;
     }
     if (statbuf.st_size % 516) {
-	error(_("partition restore file has wrong size - not restoring\n"));
+	warnx(_("partition restore file has wrong size - not restoring"));
 	goto err;
     }
 
@@ -323,21 +301,18 @@ restore_sectors(char *dev) {
 
     fdin = open(restore_sector_file, O_RDONLY);
     if (fdin < 0) {
-	perror(restore_sector_file);
-	error(_("cannot open partition restore file (%s)\n"),
-	      restore_sector_file);
+	warn(_("cannot open partition restore file (%s)"),
+	     restore_sector_file);
 	goto err;
     }
     if (read(fdin, ss, statbuf.st_size) != statbuf.st_size) {
-	perror("read");
-	error(_("error reading %s\n"), restore_sector_file);
+	warn(_("error reading %s"), restore_sector_file);
 	goto err;
     }
 
     fdout = open(dev, O_WRONLY);
     if (fdout < 0) {
-	perror(dev);
-	error(_("cannot open device %s for writing\n"), dev);
+	warn(_("cannot open device %s for writing"), dev);
 	goto err;
     }
 
@@ -347,8 +322,7 @@ restore_sectors(char *dev) {
 	if (!sseek(dev, fdout, sno))
 	    goto err;
 	if (write(fdout, ss + 4, 512) != 512) {
-	    perror(dev);
-	    error(_("error writing sector %lu on %s\n"), sno, dev);
+	    warn(_("error writing sector %lu on %s"), sno, dev);
 	    goto err;
 	}
 	ss += 516;
@@ -360,7 +334,7 @@ restore_sectors(char *dev) {
 	goto err;
     close(fdin);
     if (close_fd(fdout) != 0) {
-	error(_("write failed: %s"), dev);
+	warnx(_("write failed: %s"), dev);
 	return 0;
     }
     return 1;
@@ -472,7 +446,7 @@ get_cylindersize(char *dev, int fd, int silent) {
 		  "the entire disk. Using fdisk on it is probably meaningless.\n"
 		  "[Use the --force option if you really want this]\n"),
 		R.start);
-	exit(1);
+	exit(EXIT_FAILURE);
     }
 #if 0
     if (R.heads && B.heads != R.heads)
@@ -775,7 +749,7 @@ reread_ioctl(int fd) {
 	/* perror might change errno */
 	int err = errno;
 
-	perror("BLKRRPART");
+	warn("BLKRRPART");
 
 	/* 2.6.8 returns EIO for a zero table */
 	if (err == EBUSY)
@@ -801,8 +775,7 @@ reread_disk_partition(char *dev, int fd) {
     }
 
     if (close_fd(fd) != 0) {
-	perror(dev);
-	warnx(_("Error closing %s\n"), dev);
+	warn(_("Error closing %s\n"), dev);
 	return 0;
     }
     printf("\n");
@@ -1436,7 +1409,7 @@ extended_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z)
 	    break;
 
 	if (!msdos_signature(s)) {
-	    error(_("ERROR: sector %lu does not have an msdos signature\n"),
+	    warnx(_("ERROR: sector %llu does not have an msdos signature"),
 	          s->sectornumber);
 	    break;
 	}
@@ -1670,7 +1643,7 @@ write_partitions(char *dev, int fd, struct disk_desc *z) {
 
     if (no_write) {
 	warnx(_("-n flag was given: Nothing changed\n"));
-	exit(0);
+	exit(EXIT_SUCCESS);
     }
 
     for (p = partitions; p < partitions + pno; p++) {
@@ -1691,12 +1664,11 @@ write_partitions(char *dev, int fd, struct disk_desc *z) {
 	}
     }
     if (!write_sectors(dev, fd)) {
-	error(_("Failed writing the partition on %s\n"), dev);
+	warnx(_("Failed writing the partition on %s"), dev);
 	return 0;
     }
     if (fsync(fd)) {
-	perror(dev);
-	error(_("Failed writing the partition on %s\n"), dev);
+	warn(_("Failed writing the partition on %s"), dev);
 	return 0;
     }
     return 1;
@@ -2447,8 +2419,8 @@ activate_usage(char *progn) {
     printf(_("%s device n1 n2 ... activate partitions n1 ..., inactivate the rest\n"),
 	   progn);
     printf(_("%s -An device	 activate partition n, inactivate the other ones\n"),
-	   PROGNAME);
-    exit(1);
+	   program_invocation_short_name);
+    exit(EXIT_FAILURE);
 }
 
 static void
@@ -2676,7 +2648,7 @@ main(int argc, char **argv) {
 	    break;
 	case 'T':
 	    list_types();
-	    exit(0);
+	    return EXIT_SUCCESS;
 	case 'U':
 	    unhidearg = optarg;
 	    unhide = 1;
@@ -2751,7 +2723,7 @@ main(int argc, char **argv) {
 	if (opt_size)
 	    printf(_("total: %llu blocks\n"), total_size);
 
-	exit(exit_status);
+	return exit_status;
     }
 
     if (optind == argc) {
@@ -2775,16 +2747,16 @@ main(int argc, char **argv) {
 		do_list(argv[optind], 0);
 	    optind++;
 	}
-	exit(exit_status);
+	return exit_status;
     }
 
     if (activate) {
 	do_activate(argv + optind, argc - optind, activatearg);
-	exit(exit_status);
+	return exit_status;
     }
     if (unhide) {
 	do_unhide(argv + optind, argc - optind, unhidearg);
-	exit(exit_status);
+	return exit_status;
     }
     if (do_id) {
 	if ((do_id & PRINT_ID) != 0 && optind != argc - 2)
@@ -2795,7 +2767,7 @@ main(int argc, char **argv) {
 	    errx(EXIT_FAILURE, _("usage: sfdisk --id device partition-number [Id]"));
 	do_change_id(argv[optind], argv[optind + 1],
 		     (optind == argc - 2) ? 0 : argv[optind + 2]);
-	exit(exit_status);
+	return exit_status;
     }
 
     if (optind != argc - 1)
@@ -2809,7 +2781,7 @@ main(int argc, char **argv) {
     else
 	do_fdisk(dev);
 
-    return 0;
+    return exit_status;
 }
 
 /*
@@ -2823,11 +2795,10 @@ my_open(char *dev, int rw, int silent) {
     mode = (rw ? O_RDWR : O_RDONLY);
     fd = open(dev, mode);
     if (fd < 0 && !silent) {
-	perror(dev);
 	if (rw)
-	    errx(EXIT_FAILURE, _("cannot open %s read-write"), dev);
+	    err(EXIT_FAILURE, _("cannot open %s read-write"), dev);
 	else
-	    errx(EXIT_FAILURE, _("cannot open %s for reading"), dev);
+	    err(EXIT_FAILURE, _("cannot open %s for reading"), dev);
     }
     return fd;
 }
@@ -2920,10 +2891,8 @@ do_size(char *dev, int silent) {
 	return;
 
     if (blkdev_get_sectors(fd, &size) == -1) {
-	if (!silent) {
-	    perror(dev);
-	    errx(EXIT_FAILURE, _("Cannot get size of %s"), dev);
-	}
+	if (!silent)
+	    err(EXIT_FAILURE, _("Cannot get size of %s"), dev);
 	goto done;
     }
 
@@ -3136,7 +3105,7 @@ do_reread(char *dev) {
     fd = my_open(dev, 0, 0);
     if (reread_ioctl(fd)) {
 	warnx(_("This disk is currently in use.\n"));
-	exit(1);
+	exit(EXIT_FAILURE);
     }
 
     close(fd);
@@ -3154,10 +3123,8 @@ do_fdisk(char *dev) {
     int interactive = isatty(0);
     struct disk_desc *z;
 
-    if (stat(dev, &statbuf) < 0) {
-	perror(dev);
-	errx(EXIT_FAILURE, _("Fatal error: cannot find %s"), dev);
-    }
+    if (stat(dev, &statbuf) < 0)
+	err(EXIT_FAILURE, _("Fatal error: cannot find %s"), dev);
     if (!S_ISBLK(statbuf.st_mode)) {
 	warnx(_("Warning: %s is not a block device\n"), dev);
 	no_reread = 1;
@@ -3172,7 +3139,7 @@ do_fdisk(char *dev) {
 		      "Use the --no-reread flag to suppress this check.\n"));
 	    if (!force) {
 		warnx(_("Use the --force flag to overrule all checks.\n"));
-		exit(1);
+		exit(EXIT_FAILURE);
 	    }
 	} else
 	    my_warn(_("OK\n"));
@@ -3243,5 +3210,4 @@ do_fdisk(char *dev) {
 	      "(See fdisk(8).)\n"));
 
     sync();			/* superstition */
-    exit(exit_status);
 }
-- 
1.8.3.1

