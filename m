Return-Path: dave@gnu.org
Message-ID: <1351358616.2842.2.camel@offbook>
Subject: [PATCH 1/2] fdisk: gpt: write entire first sector
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Date: Sat, 27 Oct 2012 19:23:36 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

We were writing only 1 byte in LBA0, and GPT requires dealing with an entire
sector. This bug wasn't affecting when dealing with already existing devices
with GPT as we weren't writing an important part of the first sector, thus
leaving it unchanged. Also use write_all() wrapper from all-io.h

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/gpt.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fdisks/gpt.c b/fdisks/gpt.c
index 40cadb1..48397f3 100644
--- a/fdisks/gpt.c
+++ b/fdisks/gpt.c
@@ -44,6 +44,7 @@
 #include "blkdev.h"
 #include "bitops.h"
 #include "strutils.h"
+#include "all-io.h"
 
 #define GPT_HEADER_SIGNATURE 0x5452415020494645LL /* EFI PART */
 #define GPT_HEADER_REVISION_V1_02 0x00010200
@@ -1057,8 +1058,10 @@ static int gpt_write_pmbr(struct fdisk_context *cxt)
 	if (offset != lseek(cxt->dev_fd, offset, SEEK_SET))
 		goto fail;
 
-	if (1 == write(cxt->dev_fd, pmbr, 1))
-		return 0;
+	/* pMBR covers the first sector (LBA) of the disk */
+	if (write_all(cxt->dev_fd, pmbr, cxt->sector_size))
+		goto fail;
+	return 0;
 fail:
 	return -errno;
 }
-- 
1.7.9.5
