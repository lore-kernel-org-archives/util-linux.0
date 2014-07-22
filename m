Return-Path: davidlohr@hp.com
From: Davidlohr Bueso <davidlohr@hp.com>
To: kzak@redhat.com
Cc: davidlohr@hp.com, aswin@hp.com, util-linux@vger.kernel.org
Subject: [PATCH 07/13] sfdisk: remove 'exit_status' global variable
Date: Tue, 22 Jul 2014 16:44:51 -0700
Message-Id: <1406072697-20912-8-git-send-email-davidlohr@hp.com>
In-Reply-To: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
References: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
List-ID: <util-linux.vger.kernel.org>

This variable determines the overall exit code sfdisk(8) uses, from
main(). Simplify this atrocity by returning the value from the callers
that modify it to 1, including: do_list, do_activate, do_unhide,
do_change_id and do_fork.

Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
---
 disk-utils/sfdisk.c | 97 +++++++++++++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 48 deletions(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 96f4d82..7e0b081 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -74,7 +74,6 @@ static struct systypes i386_sys_types[] = {
  *  H. Listing the current situation
  *  I. Writing the new situation
  */
-int exit_status = 0;
 
 int force = 0;			/* 1: do what I say, even if it is stupid ... */
 int quiet = 0;			/* 1: suppress all warnings */
@@ -2458,21 +2457,21 @@ static char *nextproc(FILE *f)
 	return NULL;
 }
 
-static void do_list(char *dev, int silent);
+static int do_list(char *dev, int silent);
 static void do_size(char *dev, int silent);
 static void do_geom(char *dev, int silent);
 static void do_pt_geom(char *dev, int silent);
-static void do_fdisk(char *dev);
+static int do_fdisk(char *dev);
 static void do_reread(char *dev);
-static void do_change_id(char *dev, char *part, char *id);
-static void do_unhide(char **av, int ac, char *arg);
-static void do_activate(char **av, int ac, char *arg);
+static int do_change_id(char *dev, char *part, char *id);
+static int do_unhide(char **av, int ac, char *arg);
+static int do_activate(char **av, int ac, char *arg);
 
 unsigned long long total_size;
 
-int
-main(int argc, char **argv) {
-	int c;
+int main(int argc, char **argv)
+{
+	int c, ret = 0;
 	char *dev;
 	int opt_size = 0;
 	int opt_out_geom = 0;
@@ -2637,7 +2636,7 @@ main(int argc, char **argv) {
 					if (opt_size)
 						do_size(dev, 1);
 					if (opt_list || verify)
-						do_list(dev, 1);
+						ret = do_list(dev, 1);
 				}
 				free(dev);
 			}
@@ -2647,7 +2646,7 @@ main(int argc, char **argv) {
 		if (opt_size)
 			printf(_("total: %llu blocks\n"), total_size);
 
-		return exit_status;
+		goto done;
 	}
 
 	if (optind == argc) {
@@ -2666,19 +2665,17 @@ main(int argc, char **argv) {
 			if (opt_size)
 				do_size(argv[optind], 0);
 			if (opt_list || verify)
-				do_list(argv[optind], 0);
+				ret = do_list(argv[optind], 0);
 			optind++;
 		}
-		return exit_status;
+		goto done;
 	}
 
 	if (activate) {
-		do_activate(argv + optind, argc - optind, activatearg);
-		return exit_status;
+		return do_activate(argv + optind, argc - optind, activatearg);
 	}
 	if (unhide) {
-		do_unhide(argv + optind, argc - optind, unhidearg);
-		return exit_status;
+		return do_unhide(argv + optind, argc - optind, unhidearg);
 	}
 	if (do_id) {
 		if ((do_id & PRINT_ID) != 0 && optind != argc - 2)
@@ -2687,9 +2684,8 @@ main(int argc, char **argv) {
 			errx(EXIT_FAILURE, _("usage: sfdisk --change-id device partition-number Id"));
 		else if (optind != argc - 3 && optind != argc - 2)
 			errx(EXIT_FAILURE, _("usage: sfdisk --id device partition-number [Id]"));
-		do_change_id(argv[optind], argv[optind + 1],
-			     (optind == argc - 2) ? 0 : argv[optind + 2]);
-		return exit_status;
+		return do_change_id(argv[optind], argv[optind + 1],
+				    (optind == argc - 2) ? 0 : argv[optind + 2]);
 	}
 
 	if (optind != argc - 1)
@@ -2701,9 +2697,9 @@ main(int argc, char **argv) {
 	else if (restore_sector_file)
 		restore_sectors(dev);
 	else
-		do_fdisk(dev);
-
-	return exit_status;
+		ret = do_fdisk(dev);
+done:
+	return ret;
 }
 
 /*
@@ -2725,14 +2721,14 @@ my_open(char *dev, int rw, int silent) {
 	return fd;
 }
 
-static void
-do_list(char *dev, int silent) {
-	int fd;
+static int do_list(char *dev, int silent)
+{
+	int fd, ret = 0;
 	struct disk_desc *z;
 
 	fd = my_open(dev, 0, silent);
 	if (fd < 0)
-		return;
+		return ret;
 
 	z = &oldp;
 
@@ -2747,10 +2743,11 @@ do_list(char *dev, int silent) {
 		if (partitions_ok(fd, z))
 			printf(_("%s: OK"), dev);
 		else
-			exit_status = 1;
+			ret = 1;
 	}
 
 	close(fd);
+	return ret;
 }
 
 static void
@@ -2868,10 +2865,10 @@ set_active(struct disk_desc *z, char *pnam) {
 		z->partitions[pno].p.bootable = 0x80;
 }
 
-static void
-do_activate(char **av, int ac, char *arg) {
+static int do_activate(char **av, int ac, char *arg)
+{
 	char *dev = av[0];
-	int fd;
+	int fd, ret = 0;
 	int rw, i, pno, lpno;
 	struct disk_desc *z;
 
@@ -2915,7 +2912,7 @@ do_activate(char **av, int ac, char *arg) {
 		if (write_partitions(dev, fd, z))
 			warnx(_("Done"));
 		else
-			exit_status = 1;
+			ret = 1;
 	}
 	i = 0;
 	for (pno = 0; pno < z->partno && pno < 4; pno++)
@@ -2928,8 +2925,9 @@ do_activate(char **av, int ac, char *arg) {
 
 	if (close_fd(fd) != 0) {
 		warnx(_("write failed"));
-		exit_status = 1;
+		ret = 1;
 	}
+	return ret;
 }
 
 static void
@@ -2950,10 +2948,10 @@ set_unhidden(struct disk_desc *z, char *pnam) {
 /*
  * maybe remove and make part of --change-id
  */
-static void
-do_unhide(char **av, int ac, char *arg) {
+static int do_unhide(char **av, int ac, char *arg)
+{
 	char *dev = av[0];
-	int fd, rw, i;
+	int fd, rw, i, ret = 0;
 	struct disk_desc *z;
 
 	z = &oldp;
@@ -2976,17 +2974,18 @@ do_unhide(char **av, int ac, char *arg) {
 	if (write_partitions(dev, fd, z))
 		warn(_("Done"));
 	else
-		exit_status = 1;
+		ret = 1;
 
 	if (close_fd(fd) != 0) {
 		warn(_("write failed"));
-		exit_status = 1;
+		ret = 1;
 	}
+	return ret;
 }
 
-static void
-do_change_id(char *dev, char *pnam, char *id) {
-	int fd, rw, pno;
+static int do_change_id(char *dev, char *pnam, char *id)
+{
+	int fd, rw, pno, ret = 0;
 	struct disk_desc *z;
 	unsigned long i;
 
@@ -3012,13 +3011,14 @@ do_change_id(char *dev, char *pnam, char *id) {
 	if (write_partitions(dev, fd, z))
 		warnx(_("Done"));
 	else
-		exit_status = 1;
+		ret = 1;
 
 done:
 	if (close_fd(fd) != 0) {
 		warnx(_("write failed"));
-		exit_status = 1;
+		ret = 1;
 	}
+	return ret;
 }
 
 static void
@@ -3038,9 +3038,9 @@ do_reread(char *dev) {
  *  I. Writing the new situation
  */
 
-static void
-do_fdisk(char *dev) {
-	int fd;
+static int do_fdisk(char *dev)
+{
+	int fd, ret = 0;
 	char answer[32];
 	struct stat statbuf;
 	int interactive = isatty(0);
@@ -3120,15 +3120,16 @@ do_fdisk(char *dev) {
 	if (write_partitions(dev, fd, z))
 		printf(_("Successfully wrote the new partition table\n\n"));
 	else
-		exit_status = 1;
+		ret = 1;
 
 	if (!reread_disk_partition(dev, fd)) {	/* close fd on success */
 		close(fd);
-		exit_status = 1;
+		ret = 1;
 	}
 	warnx(_("If you created or changed a DOS partition, /dev/foo7, say, then use dd(1)\n"
 		"to zero the first 512 bytes:  dd if=/dev/zero of=/dev/foo7 bs=512 count=1\n"
 		"(See fdisk(8).)"));
 
 	sync();			/* superstition */
+	return ret;
 }
-- 
1.8.1.4
