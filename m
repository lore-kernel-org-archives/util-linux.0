Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:37749 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbaD0UGF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Apr 2014 16:06:05 -0400
Received: by mail-we0-f174.google.com with SMTP id w62so4282144wes.19
        for <util-linux@vger.kernel.org>; Sun, 27 Apr 2014 13:06:04 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/12] mkswap, swaplabel: move version number to header
Date: Sun, 27 Apr 2014 21:05:31 +0100
Message-Id: <1398629138-31718-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Corrently only the swap version 1 is supported, which is a magic value so
move it to header.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkswap.c    | 10 +++++-----
 disk-utils/swaplabel.c |  4 ++--
 include/swapheader.h   |  1 +
 sys-utils/swapon.c     | 10 ++++------
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index ae73f80..cd96ad5 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -449,7 +449,7 @@ main(int argc, char **argv) {
 	unsigned long long sz;
 	off_t offset;
 	int force = 0;
-	int version = 1;
+	int version = SWAP_VERSION;
 	char *block_count = 0;
 	char *opt_label = NULL;
 	unsigned char *uuid = NULL;
@@ -517,7 +517,7 @@ main(int argc, char **argv) {
 		usage(stderr);
 	}
 
-	if (version != 1)
+	if (version != SWAP_VERSION)
 		errx(EXIT_FAILURE,
 			_("swapspace version %d is not supported"), version);
 
@@ -601,7 +601,7 @@ main(int argc, char **argv) {
 	wipe_device(DEV, device_name, force);
 
 	hdr = (struct swap_header_v1_2 *) signature_page;
-	hdr->version = 1;
+	hdr->version = version;
 	hdr->last_page = PAGES - 1;
 	hdr->nr_badpages = badpages;
 
@@ -609,8 +609,8 @@ main(int argc, char **argv) {
 		errx(EXIT_FAILURE, _("Unable to set up swap-space: unreadable"));
 
 	goodpages = PAGES - badpages - 1;
-	printf(_("Setting up swapspace version 1, size = %llu KiB\n"),
-		goodpages * pagesize / 1024);
+	printf(_("Setting up swapspace version %d, size = %llu KiB\n"),
+		version, goodpages * pagesize / 1024);
 
 	write_signature("SWAPSPACE2");
 	write_uuid_and_label(uuid, opt_label);
diff --git a/disk-utils/swaplabel.c b/disk-utils/swaplabel.c
index 5d048aa..8d5b260 100644
--- a/disk-utils/swaplabel.c
+++ b/disk-utils/swaplabel.c
@@ -67,10 +67,10 @@ static blkid_probe get_swap_prober(const char *devname)
 		warnx(_("%s: not a valid swap partition"), devname);
 
 	if (rc == 0) {
-		/* supported is SWAPSPACE2 only */
+		/* Only the SWAPSPACE2 is supported. */
 		if (blkid_probe_lookup_value(pr, "VERSION", &version, NULL) == 0
 		    && version
-		    && strcmp(version, "1"))
+		    && strcmp(version, stringify_value(SWAP_VERSION)))
 			warnx(_("%s: unsupported swap version '%s'"),
 						devname, version);
 		else
diff --git a/include/swapheader.h b/include/swapheader.h
index 42d521a..80fa36b 100644
--- a/include/swapheader.h
+++ b/include/swapheader.h
@@ -11,6 +11,7 @@ struct swap_header_v1 {
 };
 
 
+#define SWAP_VERSION 1
 #define SWAP_UUID_LENGTH 16
 #define SWAP_LABEL_LENGTH 16
 
diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 3866ee7..6c422ce 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -402,21 +402,19 @@ static unsigned long long swap_get_size(const char *hdr, const char *devname,
 					unsigned int pagesize)
 {
 	unsigned int last_page = 0;
-	int swap_version = 0;
+	const unsigned int swap_version = SWAP_VERSION;
 	int flip = 0;
 	struct swap_header_v1_2 *s;
 
 	s = (struct swap_header_v1_2 *) hdr;
-	if (s->version == 1) {
-		swap_version = 1;
+	if (s->version == swap_version) {
 		last_page = s->last_page;
-	} else if (swab32(s->version) == 1) {
+	} else if (swab32(s->version) == swap_version) {
 		flip = 1;
-		swap_version = 1;
 		last_page = swab32(s->last_page);
 	}
 	if (verbose)
-		warnx(_("%s: found swap signature: version %d, "
+		warnx(_("%s: found swap signature: version %ud, "
 			"page-size %d, %s byte order"),
 			devname,
 			swap_version,
-- 
1.9.2

