Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f182.google.com ([74.125.82.182]:57351 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab3FPSy0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Jun 2013 14:54:26 -0400
Received: by mail-we0-f182.google.com with SMTP id p60so1741043wes.41
        for <util-linux@vger.kernel.org>; Sun, 16 Jun 2013 11:54:24 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/15] sfdisk: remove --unhide and related functions
Date: Sun, 16 Jun 2013 19:53:47 +0100
Message-Id: <1371408836-16663-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The --unhide was never implemented, and did not do anything.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisks/sfdisk.c | 70 +--------------------------------------------------------
 1 file changed, 1 insertion(+), 69 deletions(-)

diff --git a/fdisks/sfdisk.c b/fdisks/sfdisk.c
index 2b4969b..ae17e8d 100644
--- a/fdisks/sfdisk.c
+++ b/fdisks/sfdisk.c
@@ -2391,7 +2391,6 @@ static void usage(FILE * out)
 	fputs(_(" -g, --show-geometry       print the kernel's idea of the geometry\n"
 		" -G, --show-pt-geometry    print geometry guessed from the partition table\n"), out);
 	fputs(_(" -A, --activate[=<device>] activate bootable flag\n"
-		" -U, --unhide[=<dev>]      set partition unhidden\n"
 		" -x, --show-extended       also list extended partitions in the output,\n"
 		"                             or expect descriptors for them in the input\n"), out);
 	fputs(_("     --leave-last          do not allocate the last cylinder\n"
@@ -2430,7 +2429,7 @@ activate_usage(void) {
     exit(EXIT_FAILURE);
 }
 
-static const char short_opts[] = "cdfghilnqsu:vx1A::C:DGH:I:LN:O:RS:TU::V";
+static const char short_opts[] = "cdfghilnqsu:vx1A::C:DGH:I:LN:O:RS:TV";
 
 #define PRINT_ID 0400
 #define CHANGE_ID 01000
@@ -2473,7 +2472,6 @@ static const struct option long_opts[] = {
     { "Linux",            no_argument, NULL, 'L' },
     { "re-read",          no_argument, NULL, 'R' },
     { "list-types",       no_argument, NULL, 'T' },
-    { "unhide",           optional_argument, NULL, 'U' },
     { "no-reread",        no_argument, NULL, OPT_NO_REREAD },
     { "IBM",              no_argument, NULL, OPT_LEAVE_LAST },
     { "leave-last",       no_argument, NULL, OPT_LEAVE_LAST },
@@ -2528,7 +2526,6 @@ static void do_pt_geom(char *dev, int silent);
 static void do_fdisk(char *dev);
 static void do_reread(char *dev);
 static void do_change_id(char *dev, char *part, char *id);
-static void do_unhide(char **av, int ac, char *arg);
 static void do_activate(char **av, int ac, char *arg);
 
 unsigned long long total_size;
@@ -2543,9 +2540,7 @@ main(int argc, char **argv) {
     int opt_reread = 0;
     int activate = 0;
     int do_id = 0;
-    int unhide = 0;
     char *activatearg = 0;
-    char *unhidearg = 0;
 
     setlocale(LC_ALL, "");
     bindtextdomain(PACKAGE, LOCALEDIR);
@@ -2556,10 +2551,6 @@ main(int argc, char **argv) {
 	errx(EXIT_FAILURE, _("no command?"));
     if (!strcmp(program_invocation_short_name, "activate"))
 	activate = 1;		/* equivalent to `sfdisk -A' */
-#if 0				/* not important enough to deserve a name */
-    else if (!strcmp(program_invocation_short_name, "unhide"))
-	unhide = 1;		/* equivalent to `sfdisk -U' */
-#endif
 
     while ((c = getopt_long(argc, argv, short_opts, long_opts, NULL)) != -1) {
 	switch (c) {
@@ -2643,10 +2634,6 @@ main(int argc, char **argv) {
 	case 'T':
 	    list_types();
 	    return EXIT_SUCCESS;
-	case 'U':
-	    unhidearg = optarg;
-	    unhide = 1;
-	    break;
 	case 'V':
 	    verify = 1;
 	    break;
@@ -2746,10 +2733,6 @@ main(int argc, char **argv) {
 	do_activate(argv + optind, argc - optind, activatearg);
 	return exit_status;
     }
-    if (unhide) {
-	do_unhide(argv + optind, argc - optind, unhidearg);
-	return exit_status;
-    }
     if (do_id) {
 	if ((do_id & PRINT_ID) != 0 && optind != argc - 2)
 	    errx(EXIT_FAILURE, _("usage: sfdisk --print-id device partition-number"));
@@ -3003,57 +2986,6 @@ do_activate(char **av, int ac, char *arg) {
 }
 
 static void
-set_unhidden(struct disk_desc *z, char *pnam) {
-    int pno;
-    unsigned char id;
-
-    pno = asc_to_index(pnam, z);
-    id = z->partitions[pno].p.sys_type;
-    if (id == 0x11 || id == 0x14 || id == 0x16 || id == 0x17)
-	id -= 0x10;
-    else
-	errx(EXIT_FAILURE, _("partition %s has id %x and is not hidden"), pnam, id);
-    z->partitions[pno].p.sys_type = id;
-}
-
-/*
- * maybe remove and make part of --change-id
- */
-static void
-do_unhide(char **av, int ac, char *arg) {
-    char *dev = av[0];
-    int fd, rw, i;
-    struct disk_desc *z;
-
-    z = &oldp;
-
-    rw = !no_write;
-    fd = my_open(dev, rw, 0);
-
-    free_sectors();
-    get_cylindersize(dev, fd, 1);
-    get_partitions(dev, fd, z);
-
-    /* unhide where desired */
-    if (ac == 1)
-	set_unhidden(z, arg);
-    else
-	for (i = 1; i < ac; i++)
-	    set_unhidden(z, av[i]);
-
-    /* then write to disk */
-    if (write_partitions(dev, fd, z))
-	my_warn(_("Done\n\n"));
-    else
-	exit_status = 1;
-
-    if (close_fd(fd) != 0) {
-	my_warn(_("write failed"));
-	exit_status = 1;
-    }
-}
-
-static void
 do_change_id(char *dev, char *pnam, char *id) {
     int fd, rw, pno;
     struct disk_desc *z;
-- 
1.8.3.1

