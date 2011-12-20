Return-Path: util-linux-owner@vger.kernel.org
Received: from mailbigip.dreamhost.com ([208.97.132.5]:39832 "EHLO
	homiemail-a38.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752141Ab1LTNmG (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 20 Dec 2011 08:42:06 -0500
Subject: [PATCH 1/5] sfdisk: remove fatal
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Dec 2011 14:42:00 +0100
Message-ID: <1324388520.3316.7.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Since fatal() exists with a standard 1 code, it can easily be replaced by errx(3).
The xalloc lib is also introduced in this patch.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/sfdisk.c |   65 ++++++++++++++++++++++---------------------------------
 1 files changed, 26 insertions(+), 39 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index db1a6d7..bd26896 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -50,6 +50,7 @@
 
 #include "c.h"
 #include "nls.h"
+#include "xalloc.h"
 #include "blkdev.h"
 #include "linux_version.h"
 #include "common.h"
@@ -124,19 +125,6 @@ error(char *s, ...) {
     va_end(p);
 }
 
-static void
-fatal(char *s, ...) {
-    va_list p;
-
-    va_start(p, s);
-    fflush(stdout);
-    fprintf(stderr, "\n" PROGNAME ": ");
-    vfprintf(stderr, s, p);
-    fflush(stderr);
-    va_end(p);
-    exit(1);
-}
-
 /*
  * arm needs PACKED - use it everywhere?
  */
@@ -214,8 +202,7 @@ get_sector(char *dev, int fd, unsigned long long sno) {
     if (!sseek(dev, fd, sno))
 	return 0;
 
-    if (!(s = (struct sector *)malloc(sizeof(struct sector))))
-	fatal(_("out of memory - giving up\n"));
+    s = xmalloc(sizeof(struct sector));
 
     if (read(fd, s->data, sizeof(s->data)) != sizeof(s->data)) {
 	if (errno)		/* 0 in case we read past end-of-disk */
@@ -870,7 +857,7 @@ asc_to_index(char *pnam, struct disk_desc *z) {
 	pno = linux_to_index(pnum, z);
     }
     if (!(pno >= 0 && pno < z->partno))
-	fatal(_("%s: no such partition\n"), pnam);
+	    errx(EXIT_FAILURE, _("%s: no such partition\n"), pnam);
     return pno;
 }
 
@@ -1205,9 +1192,9 @@ partitions_ok(int fd, struct disk_desc *z) {
     /* Have at least 4 partitions been defined? */
     if (partno < 4) {
 	if (!partno)
-	    fatal(_("no partition table present.\n"));
+		errx(EXIT_FAILURE, _("no partition table present."));
 	else
-	    fatal(_("strange, only %d partitions defined.\n"), partno);
+		errx(EXIT_FAILURE, _("strange, only %d partitions defined."), partno);
 	return 0;
     }
 
@@ -1704,7 +1691,7 @@ write_partitions(char *dev, int fd, struct disk_desc *z) {
     }
     if (save_sector_file) {
 	if (!save_sectors(dev, fd)) {
-	    fatal(_("Failed saving the old sectors - aborting\n"));
+		errx(EXIT_FAILURE, _("Failed saving the old sectors - aborting\n"));
 	    return 0;
 	}
     }
@@ -1792,7 +1779,7 @@ read_stdin(char **fields, char *line, int fieldssize, int linesize) {
 	return RD_EOF;
     }
     if (!(lp = strchr(lp, '\n')))
-	fatal(_("long or incomplete input line - quitting\n"));
+	    errx(EXIT_FAILURE, _("long or incomplete input line - quitting"));
     *lp = 0;
 
     /* remove comments, if any */
@@ -1828,20 +1815,20 @@ read_stdin(char **fields, char *line, int fieldssize, int linesize) {
 		    while (isalnum(*ip))	/* 0x07FF */
 			ip++;
 		} else
-		    fatal(_("input error: `=' expected after %s field\n"),
+			errx(EXIT_FAILURE, _("input error: `=' expected after %s field"),
 			  d->fldname);
 		if (fno <= d->fldno)
 		    fno = d->fldno + 1;
 		if (*ip == 0)
 		    return fno;
 		if (*ip != ',' && *ip != ';')
-		    fatal(_("input error: unexpected character %c after %s field\n"),
+			errx(EXIT_FAILURE, _("input error: unexpected character %c after %s field"),
 			  *ip, d->fldname);
 		*ip = 0;
 		goto nxtfld;
 	    }
 	}
-	fatal(_("unrecognized input: %s\n"), ip);
+	errx(EXIT_FAILURE, _("unrecognized input: %s"), ip);
     }
 
     /* split line into fields */
@@ -2326,7 +2313,7 @@ read_partition(char *dev, int interactive, int pno, struct part_desc *ep,
 
     while (!(i = read_line(pno, ep, dev, interactive, z)))
 	if (!interactive)
-	    fatal(_("bad input\n"));
+		errx(EXIT_FAILURE, _("bad input"));
     if (i < 0) {
 	p->ep = ep;
 	return 0;
@@ -2637,7 +2624,7 @@ main(int argc, char **argv) {
     textdomain(PACKAGE);
 
     if (argc < 1)
-	fatal(_("no command?\n"));
+	    errx(EXIT_FAILURE, _("no command?"));
     if ((progn = strrchr(argv[0], '/')) == NULL)
 	progn = argv[0];
     else
@@ -2850,18 +2837,18 @@ main(int argc, char **argv) {
     }
     if (do_id) {
 	if ((do_id & PRINT_ID) != 0 && optind != argc - 2)
-	    fatal(_("usage: sfdisk --print-id device partition-number\n"));
+		errx(EXIT_FAILURE, _("usage: sfdisk --print-id device partition-number"));
 	else if ((do_id & CHANGE_ID) != 0 && optind != argc - 3)
-	    fatal(_("usage: sfdisk --change-id device partition-number Id\n"));
+		errx(EXIT_FAILURE, _("usage: sfdisk --change-id device partition-number Id"));
 	else if (optind != argc - 3 && optind != argc - 2)
-	    fatal(_("usage: sfdisk --id device partition-number [Id]\n"));
+		errx(EXIT_FAILURE, _("usage: sfdisk --id device partition-number [Id]"));
 	do_change_id(argv[optind], argv[optind + 1],
 		     (optind == argc - 2) ? 0 : argv[optind + 2]);
 	exit(exit_status);
     }
 
     if (optind != argc - 1)
-	fatal(_("can specify only one device (except with -l or -s)\n"));
+	    errx(EXIT_FAILURE, _("can specify only one device (except with -l or -s)"));
     dev = argv[optind];
 
     if (opt_reread)
@@ -2887,9 +2874,9 @@ my_open(char *dev, int rw, int silent) {
     if (fd < 0 && !silent) {
 	perror(dev);
 	if (rw)
-	    fatal(_("cannot open %s read-write\n"), dev);
+		errx(EXIT_FAILURE, _("cannot open %s read-write"), dev);
 	else
-	    fatal(_("cannot open %s for reading\n"), dev);
+		errx(EXIT_FAILURE, _("cannot open %s for reading"), dev);
     }
     return fd;
 }
@@ -2984,7 +2971,7 @@ do_size(char *dev, int silent) {
     if (blkdev_get_sectors(fd, &size) == -1) {
 	if (!silent) {
 	    perror(dev);
-	    fatal(_("Cannot get size of %s\n"), dev);
+	    errx(EXIT_FAILURE, _("Cannot get size of %s"), dev);
 	}
 	return;
     }
@@ -3109,7 +3096,7 @@ set_unhidden(struct disk_desc *z, char *pnam) {
     if (id == 0x11 || id == 0x14 || id == 0x16 || id == 0x17)
 	id -= 0x10;
     else
-	fatal(_("partition %s has id %x and is not hidden\n"), pnam, id);
+	    errx(EXIT_FAILURE, _("partition %s has id %x and is not hidden"), pnam, id);
     z->partitions[pno].p.sys_type = id;
 }
 
@@ -3169,7 +3156,7 @@ do_change_id(char *dev, char *pnam, char *id) {
     }
     i = strtoul(id, NULL, 16);
     if (i > 255)
-	fatal(_("Bad Id %lx\n"), i);
+	    errx(EXIT_FAILURE, _("Bad Id %lx"), i);
     z->partitions[pno].p.sys_type = i;
 
     if (write_partitions(dev, fd, z))
@@ -3207,7 +3194,7 @@ do_fdisk(char *dev) {
 
     if (stat(dev, &statbuf) < 0) {
 	perror(dev);
-	fatal(_("Fatal error: cannot find %s\n"), dev);
+	errx(EXIT_FAILURE, _("Fatal error: cannot find %s"), dev);
     }
     if (!S_ISBLK(statbuf.st_mode)) {
 	do_warn(_("Warning: %s is not a block device\n"), dev);
@@ -3239,7 +3226,7 @@ do_fdisk(char *dev) {
     out_partitions(dev, z);
 
     if (one_only && (one_only_pno = linux_to_index(one_only, z)) < 0)
-	fatal(_("Partition %d does not exist, cannot change it\n"), one_only);
+	    errx(EXIT_FAILURE, _("Partition %d does not exist, cannot change it"), one_only);
 
     z = &newp;
 
@@ -3252,8 +3239,8 @@ do_fdisk(char *dev) {
 
 	if (!partitions_ok(fd, z) && !force) {
 	    if (!interactive)
-		fatal(_("I don't like these partitions - nothing changed.\n"
-			"(If you really want this, use the --force option.)\n"));
+		    errx(EXIT_FAILURE, _("I don't like these partitions - nothing changed.\n"
+					 "(If you really want this, use the --force option.)"));
 	    else
 		do_warn(_("I don't like this - probably you should answer No\n"));
 	}
@@ -3269,7 +3256,7 @@ do_fdisk(char *dev) {
 	    if (c == EOF)
 		printf(_("\nsfdisk: premature end of input\n"));
 	    if (c == EOF || answer == 'q' || answer == 'Q') {
-		fatal(_("Quitting - nothing changed\n"));
+		    errx(EXIT_FAILURE, _("Quitting - nothing changed"));
 	    } else if (answer == 'n' || answer == 'N') {
 		continue;
 	    } else if (answer == 'y' || answer == 'Y') {
-- 
1.7.4.1




