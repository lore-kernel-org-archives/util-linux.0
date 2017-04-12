Return-Path: util-linux-owner@vger.kernel.org
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:54251 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbdDLJUy (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 12 Apr 2017 05:20:54 -0400
From: Damien Le Moal <damien.lemoal@wdc.com>
To: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Benno Schulenberg <bensberg@justemail.net>
Cc: Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH] blkzone: Fix zone condition strings handling
Date: Wed, 12 Apr 2017 18:20:32 +0900
Message-Id: <20170412092032.7234-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fixed the condition strings for implicit open and explicit open to
match the man page defined strings ("oi" and "oe"). Also while at it,
correct the condition_str array entries adding the reserved "xC" case
so that the read_only, full and offline conditions match the condition
codes. This increases the array size to 16, so also fix the condition
code masking when displaying the result.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 sys-utils/blkzone.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/blkzone.c b/sys-utils/blkzone.c
index 1457225..7713ff3 100644
--- a/sys-utils/blkzone.c
+++ b/sys-utils/blkzone.c
@@ -151,10 +151,10 @@ static const char *type_text[] = {
 static const char *condition_str[] = {
 	"nw", /* Not write pointer */
 	"em", /* Empty */
-	"io", /* Implicitly opened */
-	"eo", /* Explicitly opened */
+	"oi", /* Implicitly opened */
+	"oe", /* Explicitly opened */
 	"cl", /* Closed */
-	"x5", "x6", "x7", "x8", "x9", "xA", "xB", /* xN: reserved */
+	"x5", "x6", "x7", "x8", "x9", "xA", "xB", "xC", /* xN: reserved */
 	"ro", /* Read only */
 	"fu", /* Full */
 	"of"  /* Offline */
@@ -220,7 +220,7 @@ static int blkzone_report(struct blkzone_control *ctl)
 			 	" reset:%u non-seq:%u, zcond:%2u(%s) [type: %u(%s)]\n"),
 				start, len, (type == 0x1) ? 0 : wp - start,
 				entry->reset, entry->non_seq,
-				cond, condition_str[cond & ARRAY_SIZE(condition_str)],
+				cond, condition_str[cond & (ARRAY_SIZE(condition_str) - 1)],
 				type, type_text[type]);
 
 			nr_zones--;
-- 
2.9.3

