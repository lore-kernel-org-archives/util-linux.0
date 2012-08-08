Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbhh.dreamhost.com ([208.97.132.177]:51343 "EHLO
	homiemail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754825Ab2HHLsx convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 8 Aug 2012 07:48:53 -0400
Subject: [PATCH] fdisk: aix: fix warning
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 08 Aug 2012 13:48:28 +0200
Message-ID: <1344426508.2623.0.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Fixes:
 warning: no previous prototype for ‘aix_nolabel’

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/fdiskaixlabel.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/fdisks/fdiskaixlabel.c b/fdisks/fdiskaixlabel.c
index 0f249a4..6fe7b59 100644
--- a/fdisks/fdiskaixlabel.c
+++ b/fdisks/fdiskaixlabel.c
@@ -38,8 +38,7 @@ aix_info( void ) {
     );
 }
 
-void
-aix_nolabel(struct fdisk_context *cxt)
+static void aix_nolabel(struct fdisk_context *cxt)
 {
     struct aix_partition *aixlabel = (struct aix_partition *) cxt->firstsector;
 
-- 
1.7.4.1



