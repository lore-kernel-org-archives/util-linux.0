Return-Path: util-linux-owner@vger.kernel.org
Received: from devils.ext.ti.com ([198.47.26.153]:51912 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab2JVQ6f (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Oct 2012 12:58:35 -0400
From: Venkatraman S <venkat@linaro.org>
To: <kzak@redhat.com>
CC: <util-linux@vger.kernel.org>, <arnd.bergmann@linaro.org>,
        Venkatraman S <venkat@linaro.org>
Subject: [RFC PATCH 2/4] mkswap: refactor header preparation
Date: Mon, 22 Oct 2012 22:27:25 +0530
Message-ID: <1350925048-31084-3-git-send-email-venkat@linaro.org>
In-Reply-To: <1350925048-31084-1-git-send-email-venkat@linaro.org>
References: <1350925048-31084-1-git-send-email-venkat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Move opencoded swap header populating code to a separate
function. No functional changes.

Signed-off-by: Venkatraman S <venkat@linaro.org>
---
 disk-utils/mkswap.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index 0144921..f090121 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -75,6 +75,8 @@ static unsigned long badpages = 0;
 static int check = 0;
 
 #define SELINUX_SWAPFILE_TYPE	"swapfile_t"
+#define MAX_BADPAGES	((pagesize-1024-128*sizeof(int)-10)/sizeof(int))
+#define MIN_GOODPAGES	10
 
 #ifdef __sparc__
 # ifdef __arch64__
@@ -271,8 +273,6 @@ It is roughly 2GB on i386, PPC, m68k, ARM, 1GB on sparc, 512MB on mips,
 128GB on alpha and 3TB on sparc64.
 */
 
-#define MAX_BADPAGES	((pagesize-1024-128*sizeof(int)-10)/sizeof(int))
-#define MIN_GOODPAGES	10
 
 static void __attribute__ ((__noreturn__)) usage(FILE *out)
 {
@@ -362,6 +362,29 @@ new_prober(int fd)
 }
 #endif
 
+static void prepare_header(struct swap_header_v1_2 *hdr,
+	unsigned char *uuid, char *volume_name)
+{
+	unsigned long long goodpages;
+
+	hdr->version = 1;
+	hdr->last_page = PAGES - 1;
+	hdr->nr_badpages = badpages;
+
+	if (badpages > PAGES - MIN_GOODPAGES)
+		errx(EXIT_FAILURE, _("Unable to set up swap-space: unreadable"));
+
+	goodpages = PAGES - badpages - 1;
+	printf(_("Setting up swapspace version 1, size = %llu KiB\n"),
+		goodpages * pagesize / 1024);
+
+	write_signature("SWAPSPACE2");
+	write_uuid_and_label(uuid, volume_name);
+
+}
+
+
+
 static void
 wipe_device(int fd, const char *devname, int force)
 {
@@ -441,7 +464,7 @@ main(int argc, char **argv) {
 	struct swap_header_v1_2 *hdr;
 	int c;
 	unsigned long long maxpages;
-	unsigned long long goodpages;
+
 	unsigned long long sz;
 	off_t offset;
 	int force = 0;
@@ -599,19 +622,8 @@ main(int argc, char **argv) {
 	wipe_device(DEV, device_name, force);
 
 	hdr = (struct swap_header_v1_2 *) signature_page;
-	hdr->version = 1;
-	hdr->last_page = PAGES - 1;
-	hdr->nr_badpages = badpages;
 
-	if (badpages > PAGES - MIN_GOODPAGES)
-		errx(EXIT_FAILURE, _("Unable to set up swap-space: unreadable"));
-
-	goodpages = PAGES - badpages - 1;
-	printf(_("Setting up swapspace version 1, size = %llu KiB\n"),
-		goodpages * pagesize / 1024);
-
-	write_signature("SWAPSPACE2");
-	write_uuid_and_label(uuid, opt_label);
+	prepare_header(hdr, uuid, opt_label);
 
 	offset = 1024;
 	if (lseek(DEV, offset, SEEK_SET) != offset)
-- 
1.7.11.1.25.g0e18bef

