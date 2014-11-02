Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:43322 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbaKBU1Q (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Nov 2014 15:27:16 -0500
Received: by mail-wg0-f41.google.com with SMTP id k14so9785331wgh.14
        for <util-linux@vger.kernel.org>; Sun, 02 Nov 2014 12:27:15 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 5/8] mkswap: add struct mkswap_control to remove global variables
Date: Sun,  2 Nov 2014 20:26:28 +0000
Message-Id: <1414959991-8369-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
References: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkswap.c | 229 ++++++++++++++++++++++++++--------------------------
 1 file changed, 115 insertions(+), 114 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index 14adf0f..7f41428 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -67,71 +67,79 @@
 # include <blkid.h>
 #endif
 
-static char *device_name = NULL;
-static int DEV = -1;
-static unsigned long long PAGES = 0;
-static unsigned long badpages = 0;
-static int check = 0;
+#define MIN_GOODPAGES	10
 
 #define SELINUX_SWAPFILE_TYPE	"swapfile_t"
 
-static unsigned int user_pagesize;
-static unsigned int pagesize;
-static unsigned long *signature_page = NULL;
+struct mkswap_control {
+	struct swap_header_v1_2 *hdr;
+	char *device_name;
+	int fd;
+	unsigned long long nr_pages;
+	unsigned long badpages;
+	int user_pagesize;
+	int pagesize;
+	void *signature_page;
+	char *opt_label;
+	unsigned char *uuid;
+	unsigned int
+		check:1,
+		force:1;
+};
 
 static void
-init_signature_page(void)
+init_signature_page(struct mkswap_control *ctl)
 {
 
-	unsigned int kernel_pagesize = pagesize = getpagesize();
+	int kernel_pagesize = ctl->pagesize = getpagesize();
 
-	if (user_pagesize) {
-		if (!is_power_of_2(user_pagesize) ||
-		    user_pagesize < sizeof(struct swap_header_v1_2) + 10)
+	if (ctl->user_pagesize) {
+		if (ctl->user_pagesize < 0 || !is_power_of_2(ctl->user_pagesize) ||
+		    (size_t) ctl->user_pagesize < sizeof(struct swap_header_v1_2) + 10)
 			errx(EXIT_FAILURE,
 				_("Bad user-specified page size %u"),
-				user_pagesize);
-		pagesize = user_pagesize;
+				ctl->user_pagesize);
+		ctl->pagesize = ctl->user_pagesize;
 	}
 
-	if (user_pagesize && user_pagesize != kernel_pagesize)
+	if (ctl->user_pagesize && ctl->user_pagesize != kernel_pagesize)
 		warnx(_("Using user-specified page size %d, "
 				"instead of the system value %d"),
-				pagesize, kernel_pagesize);
+				ctl->pagesize, kernel_pagesize);
 
-	signature_page = (unsigned long *) xcalloc(1, pagesize);
+	ctl->signature_page = (unsigned long *) xcalloc(1, ctl->pagesize);
 }
 
 static void
-write_signature(char *sig)
+write_signature(const struct mkswap_control *ctl)
 {
-	char *sp = (char *) signature_page;
+	char *sp = (char *) ctl->signature_page;
 
-	strncpy(sp + pagesize - SWAP_SIGNATURE_SZ, sig, SWAP_SIGNATURE_SZ);
+	strncpy(sp + ctl->pagesize - SWAP_SIGNATURE_SZ, SWAP_SIGNATURE, SWAP_SIGNATURE_SZ);
 }
 
 static void
-write_uuid_and_label(unsigned char *uuid, char *volume_name)
+write_uuid_and_label(const struct mkswap_control *ctl)
 {
 	struct swap_header_v1_2 *h;
 
-	h = (struct swap_header_v1_2 *) signature_page;
-	if (uuid)
-		memcpy(h->uuid, uuid, sizeof(h->uuid));
-	if (volume_name) {
-		xstrncpy(h->volume_name, volume_name, sizeof(h->volume_name));
-		if (strlen(volume_name) > strlen(h->volume_name))
+	h = (struct swap_header_v1_2 *) ctl->signature_page;
+	if (ctl->uuid)
+		memcpy(h->uuid, ctl->uuid, sizeof(h->uuid));
+	if (ctl->opt_label) {
+		xstrncpy(h->volume_name, ctl->opt_label, sizeof(h->volume_name));
+		if (strlen(ctl->opt_label) > strlen(h->volume_name))
 			warnx(_("Label was truncated."));
 	}
-	if (uuid || volume_name) {
-		if (volume_name)
+	if (ctl->uuid || ctl->opt_label) {
+		if (ctl->opt_label)
 			printf("LABEL=%s, ", h->volume_name);
 		else
 			printf(_("no label, "));
 #ifdef HAVE_LIBUUID
-		if (uuid) {
+		if (ctl->uuid) {
 			char uuid_string[37];
-			uuid_unparse(uuid, uuid_string);
+			uuid_unparse(ctl->uuid, uuid_string);
 			printf("UUID=%s\n", uuid_string);
 		} else
 #endif
@@ -139,9 +147,6 @@ write_uuid_and_label(unsigned char *uuid, char *volume_name)
 	}
 }
 
-#define MAX_BADPAGES	((pagesize-1024-128*sizeof(int)-10)/sizeof(int))
-#define MIN_GOODPAGES	10
-
 static void __attribute__ ((__noreturn__)) usage(FILE *out)
 {
 	fprintf(out,
@@ -164,55 +169,55 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 }
 
 static void
-page_bad(int page)
+page_bad(struct mkswap_control *ctl, int page)
 {
-	struct swap_header_v1_2 *p = (struct swap_header_v1_2 *) signature_page;
+	struct swap_header_v1_2 *p = (struct swap_header_v1_2 *)ctl->signature_page;
+	const unsigned long max_badpages = (ctl->pagesize - 1024 - 128 * sizeof(int) - 10) / sizeof(int);
 
-	if (badpages == MAX_BADPAGES)
+	if (ctl->badpages == max_badpages)
 		errx(EXIT_FAILURE, _("too many bad pages"));
-	p->badpages[badpages] = page;
-	badpages++;
+	p->badpages[ctl->badpages] = page;
+	ctl->badpages++;
 }
 
 static void
-check_blocks(void)
+check_blocks(struct mkswap_control *ctl)
 {
 	unsigned int current_page;
 	int do_seek = 1;
 	char *buffer;
 
-	buffer = xmalloc(pagesize);
+	buffer = xmalloc(ctl->pagesize);
 	current_page = 0;
-	while (current_page < PAGES) {
-
+	while (current_page < ctl->nr_pages) {
 		ssize_t rc;
 
-		if (do_seek && lseek(DEV,current_page*pagesize,SEEK_SET) !=
-		    current_page*pagesize)
+		if (do_seek && lseek(ctl->fd, current_page * ctl->pagesize, SEEK_SET) !=
+		    current_page * ctl->pagesize)
 			errx(EXIT_FAILURE, _("seek failed in check_blocks"));
 
-		rc = read(DEV, buffer, pagesize);
-		do_seek = (rc < 0 || (size_t) rc != pagesize);
+		rc = read(ctl->fd, buffer, ctl->pagesize);
+		do_seek = (rc < 0 || rc != ctl->pagesize);
 		if (do_seek)
-			page_bad(current_page);
+			page_bad(ctl, current_page);
 		current_page++;
 	}
-	printf(P_("%lu bad page\n", "%lu bad pages\n", badpages), badpages);
+	printf(P_("%lu bad page\n", "%lu bad pages\n", ctl->badpages), ctl->badpages);
 	free(buffer);
 }
 
 /* return size in pages */
 static unsigned long long
-get_size(const char *file)
+get_size(const struct mkswap_control *ctl)
 {
 	int fd;
 	unsigned long long size;
 
-	fd = open(file, O_RDONLY);
+	fd = open(ctl->device_name, O_RDONLY);
 	if (fd < 0)
-		err(EXIT_FAILURE, _("cannot open %s"), file);
+		err(EXIT_FAILURE, _("cannot open %s"), ctl->device_name);
 	if (blkdev_get_size(fd, &size) == 0)
-		size /= pagesize;
+		size /= ctl->pagesize;
 
 	close(fd);
 	return size;
@@ -307,17 +312,14 @@ wipe_device(int fd, const char *devname, int force)
 
 int
 main(int argc, char **argv) {
+	struct mkswap_control ctl = { .fd = -1, 0 };
 	struct stat statbuf;
-	struct swap_header_v1_2 *hdr;
 	int c;
 	unsigned long long goodpages;
 	unsigned long long sz;
 	off_t offset;
-	int force = 0;
 	int version = SWAP_VERSION;
 	char *block_count = 0;
-	char *opt_label = NULL;
-	unsigned char *uuid = NULL;
 #ifdef HAVE_LIBUUID
 	const char *opt_uuid = NULL;
 	uuid_t uuid_dat;
@@ -342,19 +344,22 @@ main(int argc, char **argv) {
 	while((c = getopt_long(argc, argv, "cfp:L:v:U:Vh", longopts, NULL)) != -1) {
 		switch (c) {
 		case 'c':
-			check=1;
+			ctl.check = 1;
 			break;
 		case 'f':
-			force=1;
+			ctl.force = 1;
 			break;
 		case 'p':
-			user_pagesize = strtou32_or_err(optarg, _("parsing page size failed"));
+			ctl.user_pagesize = strtou32_or_err(optarg, _("parsing page size failed"));
 			break;
 		case 'L':
-			opt_label = optarg;
+			ctl.opt_label = optarg;
 			break;
 		case 'v':
 			version = strtos32_or_err(optarg, _("parsing version number failed"));
+			if (version != SWAP_VERSION)
+				errx(EXIT_FAILURE,
+					_("swapspace version %d is not supported"), version);
 			break;
 		case 'U':
 #ifdef HAVE_LIBUUID
@@ -374,7 +379,7 @@ main(int argc, char **argv) {
 		}
 	}
 	if (optind < argc)
-		device_name = argv[optind++];
+		ctl.device_name = argv[optind++];
 	if (optind < argc)
 		block_count = argv[optind++];
 	if (optind != argc) {
@@ -382,22 +387,18 @@ main(int argc, char **argv) {
 		usage(stderr);
 	}
 
-	if (version != SWAP_VERSION)
-		errx(EXIT_FAILURE,
-			_("swapspace version %d is not supported"), version);
-
 #ifdef HAVE_LIBUUID
 	if(opt_uuid) {
 		if (uuid_parse(opt_uuid, uuid_dat) != 0)
 			errx(EXIT_FAILURE, _("error: parsing UUID failed"));
 	} else
 		uuid_generate(uuid_dat);
-	uuid = uuid_dat;
+	ctl.uuid = uuid_dat;
 #endif
 
-	init_signature_page();	/* get pagesize */
+	init_signature_page(&ctl);	/* get pagesize and allocate signature page */
 
-	if (!device_name) {
+	if (!ctl.device_name) {
 		warnx(_("error: Nowhere to set up swap on?"));
 		usage(stderr);
 	}
@@ -405,75 +406,75 @@ main(int argc, char **argv) {
 		/* this silly user specified the number of blocks explicitly */
 		uint64_t blks = strtou64_or_err(block_count,
 					_("invalid block count argument"));
-		PAGES = blks / (pagesize / 1024);
+		ctl.nr_pages = blks / (ctl.pagesize / 1024);
 	}
-	sz = get_size(device_name);
-	if (!PAGES)
-		PAGES = sz;
-	else if (PAGES > sz && !force)
+	sz = get_size(&ctl);
+	if (!ctl.nr_pages)
+		ctl.nr_pages = sz;
+	else if (ctl.nr_pages > sz && !ctl.force)
 		errx(EXIT_FAILURE,
 			_("error: "
 			  "size %llu KiB is larger than device size %llu KiB"),
-			PAGES*(pagesize/1024), sz*(pagesize/1024));
+			ctl.nr_pages * (ctl.pagesize / 1024), sz * (ctl.pagesize / 1024));
 
-	if (PAGES < MIN_GOODPAGES)
+	if (ctl.nr_pages < MIN_GOODPAGES)
 		errx(EXIT_FAILURE,
 		     _("error: swap area needs to be at least %ld KiB"),
-		     (long)(MIN_GOODPAGES * pagesize / 1024));
-	if (PAGES > UINT32_MAX) {
+		     (long)(MIN_GOODPAGES * ctl.pagesize / 1024));
+	if (ctl.nr_pages > UINT32_MAX) {
 		/* true when swap is bigger than 17.59 terabytes */
-		PAGES = UINT32_MAX;
+		ctl.nr_pages = UINT32_MAX;
 		warnx(_("warning: truncating swap area to %llu KiB"),
-			PAGES * pagesize / 1024);
+			ctl.nr_pages * ctl.pagesize / 1024);
 	}
 
-	if (is_mounted(device_name))
+	if (is_mounted(ctl.device_name))
 		errx(EXIT_FAILURE, _("error: "
 			"%s is mounted; will not make swapspace"),
-			device_name);
+			ctl.device_name);
 
-	if (stat(device_name, &statbuf) < 0)
-		err(EXIT_FAILURE, _("stat failed %s"), device_name);
+	if (stat(ctl.device_name, &statbuf) < 0)
+		err(EXIT_FAILURE, _("stat failed %s"), ctl.device_name);
 	if (S_ISBLK(statbuf.st_mode))
-		DEV = open(device_name, O_RDWR | O_EXCL);
+		ctl.fd = open(ctl.device_name, O_RDWR | O_EXCL);
 	else
-		DEV = open(device_name, O_RDWR);
-	if (DEV < 0)
-		err(EXIT_FAILURE, _("cannot open %s"), device_name);
+		ctl.fd = open(ctl.device_name, O_RDWR);
+	if (ctl.fd < 0)
+		err(EXIT_FAILURE, _("cannot open %s"), ctl.device_name);
 
 	if (!S_ISBLK(statbuf.st_mode))
-		check=0;
-	else if (blkdev_is_misaligned(DEV))
-		warnx(_("warning: %s is misaligned"), device_name);
+		ctl.check = 0;
+	else if (blkdev_is_misaligned(ctl.fd))
+		warnx(_("warning: %s is misaligned"), ctl.device_name);
 
-	if (check)
-		check_blocks();
+	if (ctl.check)
+		check_blocks(&ctl);
 
-	wipe_device(DEV, device_name, force);
+	wipe_device(ctl.fd, ctl.device_name, ctl.force);
 
-	hdr = (struct swap_header_v1_2 *) signature_page;
-	hdr->version = version;
-	hdr->last_page = PAGES - 1;
-	hdr->nr_badpages = badpages;
+	ctl.hdr = (struct swap_header_v1_2 *) ctl.signature_page;
+	ctl.hdr->version = version;
+	ctl.hdr->last_page = ctl.nr_pages - 1;
+	ctl.hdr->nr_badpages = ctl.badpages;
 
-	if (badpages > PAGES - MIN_GOODPAGES)
+	if ((ctl.nr_pages - MIN_GOODPAGES) < ctl.badpages)
 		errx(EXIT_FAILURE, _("Unable to set up swap-space: unreadable"));
 
-	goodpages = PAGES - badpages - 1;
+	goodpages = ctl.nr_pages - ctl.badpages - 1;
 	printf(_("Setting up swapspace version %d, size = %llu KiB\n"),
-		version, goodpages * pagesize / 1024);
+		version, goodpages * ctl.pagesize / 1024);
 
-	write_signature(SWAP_SIGNATURE);
-	write_uuid_and_label(uuid, opt_label);
+	write_signature(&ctl);
+	write_uuid_and_label(&ctl);
 
 	offset = 1024;
-	if (lseek(DEV, offset, SEEK_SET) != offset)
+	if (lseek(ctl.fd, offset, SEEK_SET) != offset)
 		errx(EXIT_FAILURE, _("unable to rewind swap-device"));
-	if (write_all(DEV, (char *) signature_page + offset,
-				    pagesize - offset) == -1)
+	if (write_all(ctl.fd, (char *) ctl.signature_page + offset,
+				    ctl.pagesize - offset) == -1)
 		err(EXIT_FAILURE,
 			_("%s: unable to write signature page"),
-			device_name);
+			ctl.device_name);
 
 #ifdef HAVE_LIBSELINUX
 	if (S_ISREG(statbuf.st_mode) && is_selinux_enabled() > 0) {
@@ -481,12 +482,12 @@ main(int argc, char **argv) {
 		security_context_t oldcontext;
 		context_t newcontext;
 
-		if (fgetfilecon(DEV, &oldcontext) < 0) {
+		if (fgetfilecon(ctl.fd, &oldcontext) < 0) {
 			if (errno != ENODATA)
 				err(EXIT_FAILURE,
 					_("%s: unable to obtain selinux file label"),
-					device_name);
-			if (matchpathcon(device_name, statbuf.st_mode, &oldcontext))
+					ctl.device_name);
+			if (matchpathcon(ctl.device_name, statbuf.st_mode, &oldcontext))
 				errx(EXIT_FAILURE, _("unable to matchpathcon()"));
 		}
 		if (!(newcontext = context_new(oldcontext)))
@@ -497,9 +498,9 @@ main(int argc, char **argv) {
 		context_string = context_str(newcontext);
 
 		if (strcmp(context_string, oldcontext)!=0) {
-			if (fsetfilecon(DEV, context_string))
+			if (fsetfilecon(ctl.fd, context_string))
 				err(EXIT_FAILURE, _("unable to relabel %s to %s"),
-						device_name, context_string);
+						ctl.device_name, context_string);
 		}
 		context_free(newcontext);
 		freecon(oldcontext);
@@ -510,7 +511,7 @@ main(int argc, char **argv) {
 	 * is not actually on disk. (This is a kernel bug.)
 	 * The fsync() in close_fd() will take care of writing.
 	 */
-	if (close_fd(DEV) != 0)
+	if (close_fd(ctl.fd) != 0)
 		err(EXIT_FAILURE, _("write failed"));
 	return EXIT_SUCCESS;
 }
-- 
2.1.3

