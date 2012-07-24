Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:55205 "EHLO
	homiemail-a37.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753726Ab2GXMke (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 08:40:34 -0400
Subject: [PATCH 2/2] fdisk: API: comment labels array
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Jul 2012 14:40:30 +0200
Message-ID: <1343133630.2686.16.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/utils.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fdisks/utils.c b/fdisks/utils.c
index 8de64c2..c4ffe04 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -35,7 +35,9 @@
 int fdisk_debug_mask;
 
 /*
- * label probing functions
+ * Label probing functions.
+ * Must have the same order as fdisk_labeltype as the index
+ * depends on it.
  */
 static const struct fdisk_label *labels[] =
 {
-- 
1.7.4.1



