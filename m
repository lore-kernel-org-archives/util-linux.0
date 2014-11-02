Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:46534 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbaKBUch (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Nov 2014 15:32:37 -0500
Received: by mail-wi0-f177.google.com with SMTP id ex7so4900750wid.16
        for <util-linux@vger.kernel.org>; Sun, 02 Nov 2014 12:32:36 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 8/8] mkswap: various minor improvement
Date: Sun,  2 Nov 2014 20:26:31 +0000
Message-Id: <1414959991-8369-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
References: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use correct data type in page_bad(), and add information to error message
how many bad pages were seen.

In check_blocks() move initialization to variable introduction, fix typo,
and avoid memset() when array initializer can do the job.

In main() use correct initializer for pointer.  Move swap file specific
actions to same location, and add warning when request too --check is
dismissed by command.  At the end remove momory leak.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkswap.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index 280d890..71f62b4 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -167,13 +167,13 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 }
 
 static void
-page_bad(struct mkswap_control *ctl, int page)
+page_bad(struct mkswap_control *ctl, unsigned int page)
 {
 	struct swap_header_v1_2 *p = (struct swap_header_v1_2 *)ctl->signature_page;
 	const unsigned long max_badpages = (ctl->pagesize - 1024 - 128 * sizeof(int) - 10) / sizeof(int);
 
 	if (ctl->badpages == max_badpages)
-		errx(EXIT_FAILURE, _("too many bad pages"));
+		errx(EXIT_FAILURE, _("too many bad pages: %lu"), max_badpages);
 	p->badpages[ctl->badpages] = page;
 	ctl->badpages++;
 }
@@ -181,12 +181,11 @@ page_bad(struct mkswap_control *ctl, int page)
 static void
 check_blocks(struct mkswap_control *ctl)
 {
-	unsigned int current_page;
+	unsigned int current_page = 0;
 	int do_seek = 1;
 	char *buffer;
 
 	buffer = xmalloc(ctl->pagesize);
-	current_page = 0;
 	while (current_page < ctl->nr_pages) {
 		ssize_t rc;
 
@@ -265,14 +264,13 @@ wipe_device(struct mkswap_control *ctl)
 
 	if (zap) {
 		/*
-		 * Wipe boodbits
+		 * Wipe bootbits
 		 */
-		char buf[1024];
+		char buf[1024] = { '\0' };
 
 		if (lseek(ctl->fd, 0, SEEK_SET) != 0)
 			errx(EXIT_FAILURE, _("unable to rewind swap-device"));
 
-		memset(buf, 0, sizeof(buf));
 		if (write_all(ctl->fd, buf, sizeof(buf)))
 			errx(EXIT_FAILURE, _("unable to erase bootbits sectors"));
 #ifdef HAVE_LIBBLKID
@@ -317,7 +315,7 @@ main(int argc, char **argv) {
 	unsigned long long sz;
 	off_t offset;
 	int version = SWAP_VERSION;
-	char *block_count = 0;
+	char *block_count = NULL;
 #ifdef HAVE_LIBUUID
 	const char *opt_uuid = NULL;
 	uuid_t uuid_dat;
@@ -435,16 +433,19 @@ main(int argc, char **argv) {
 		err(EXIT_FAILURE, _("stat failed %s"), ctl.device_name);
 	if (S_ISBLK(statbuf.st_mode))
 		ctl.fd = open(ctl.device_name, O_RDWR | O_EXCL);
-	else
+	else {
+		if (ctl.check) {
+			ctl.check = 0;
+			warnx(_("warning: checking bad blocks from swap file is not supported: %s"),
+				ctl.device_name);
+		}
 		ctl.fd = open(ctl.device_name, O_RDWR);
+	}
 	if (ctl.fd < 0)
 		err(EXIT_FAILURE, _("cannot open %s"), ctl.device_name);
-
-	if (!S_ISBLK(statbuf.st_mode))
-		ctl.check = 0;
-	else if (blkdev_is_misaligned(ctl.fd))
-		warnx(_("warning: %s is misaligned"), ctl.device_name);
-
+	if (S_ISBLK(statbuf.st_mode))
+		if (blkdev_is_misaligned(ctl.fd))
+			warnx(_("warning: %s is misaligned"), ctl.device_name);
 	if (ctl.check)
 		check_blocks(&ctl);
 
@@ -473,7 +474,7 @@ main(int argc, char **argv) {
 		err(EXIT_FAILURE,
 			_("%s: unable to write signature page"),
 			ctl.device_name);
-
+	free(ctl.signature_page);
 #ifdef HAVE_LIBSELINUX
 	if (S_ISREG(statbuf.st_mode) && is_selinux_enabled() > 0) {
 		security_context_t context_string;
-- 
2.1.3

