Return-Path: svenkatr@ti.com
From: Venkatraman S <venkat@linaro.org>
To: <kzak@redhat.com>
CC: <util-linux@vger.kernel.org>, <arnd.bergmann@linaro.org>,
        Venkatraman S
	<venkat@linaro.org>
Subject: [PATCH 4/4] mkswap: Probe and embed useful block device info into swapheader
Date: Mon, 22 Oct 2012 22:27:27 +0530
Message-ID: <1350925048-31084-5-git-send-email-venkat@linaro.org>
In-Reply-To: <1350925048-31084-1-git-send-email-venkat@linaro.org>
References: <1350925048-31084-1-git-send-email-venkat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <util-linux.vger.kernel.org>

As first step, embed preferred_erase_size into swap header, by probing
the topology.
Not-yet-Signed-off-by: Venkatraman S <venkat@linaro.org>
---
 disk-utils/mkswap.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index f090121..aa61488 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -59,6 +59,7 @@
 #include "c.h"
 #include "closestream.h"
 #include "ismounted.h"
+#include "bitops.h"
 
 #ifdef HAVE_LIBUUID
 # include <uuid.h>
@@ -148,6 +149,7 @@ is_sparc64(void)
  *
  */
 static unsigned int user_pagesize;
+static unsigned int user_ebsize;
 static unsigned int pagesize;
 static unsigned long *signature_page = NULL;
 
@@ -360,6 +362,39 @@ new_prober(int fd)
 		errx(EXIT_FAILURE, _("unable to assign device to libblkid probe"));
 	return pr;
 }
+
+static void
+add_blkdev_info(struct swap_header_v1_2 *hdr, int fd)
+{
+	char *type = NULL;
+	unsigned long eb_size = 0;
+	blkid_probe pr = new_prober(fd);
+
+	if (user_ebsize) {
+		hdr->swp_headerinfo.blkdevinfo.erase_blk_size = user_ebsize;
+		return;
+	}
+
+	blkid_probe_enable_superblocks(pr, 1);
+	blkid_probe_enable_partitions(pr, 1);
+	blkid_probe_set_superblocks_flags(pr, BLKID_SUBLKS_MAGIC);
+	blkid_probe_enable_topology(pr, 1);
+
+	while (blkid_do_probe(pr) == 0) {
+		if (blkid_probe_lookup_value(pr, "ERASE_BLOCK_SIZE",
+			(const char **) &type, NULL) == 0 && type) {
+				eb_size = strtou32_or_err(type, _("Invalid erase blk size"));
+				hdr->swp_headerinfo.blkdevinfo.erase_blk_size =	eb_size;
+				break;
+		}
+	}
+
+}
+
+#else
+static inline void add_blkdev_info(struct swap_header_v1_2 *hdr, int fd)
+{}
+
 #endif
 
 static void prepare_header(struct swap_header_v1_2 *hdr,
@@ -625,6 +660,8 @@ main(int argc, char **argv) {
 
 	prepare_header(hdr, uuid, opt_label);
 
+	add_blkdev_info(hdr, DEV);
+
 	offset = 1024;
 	if (lseek(DEV, offset, SEEK_SET) != offset)
 		errx(EXIT_FAILURE, _("unable to rewind swap-device"));
-- 
1.7.11.1.25.g0e18bef
