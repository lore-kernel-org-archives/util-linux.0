Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbhh.dreamhost.com ([208.97.132.177]:50523 "EHLO
	homiemail-a37.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752198Ab2DPJox (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Apr 2012 05:44:53 -0400
Subject: [PATCH 5/8] sfdisk: fix silly mbyte typo
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Apr 2012 11:44:44 +0200
Message-ID: <1334569484.2552.14.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>

---
 fdisk/sfdisk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index 8bd27da..f81a7fa 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -930,7 +930,7 @@ out_partition_header(char *dev, int format, struct geometry G) {
 	printf(_("   Device Boot   Start       End    #blocks   Id  System\n"));
 	break;
     case F_MEGABYTE:
-	printf(_("Units = mebibytes of 1048576 bytes, blocks of 1024 bytes"
+	printf(_("Units = megabytes of 1048576 bytes, blocks of 1024 bytes"
 		 ", counting from %d\n\n"), increment);
 	printf(_("   Device Boot Start   End    MiB    #blocks   Id  System\n"));
 	break;
-- 
1.7.4.1




