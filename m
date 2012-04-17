Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.8]:61460 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593Ab2DQInS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 17 Apr 2012 04:43:18 -0400
Message-ID: <4F8D2D12.8070206@bernhard-voelker.de>
Date: Tue, 17 Apr 2012 10:42:58 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH] sfdisk (out_partition_header): improve F_MEGABYTE header
 [WAS: [PATCH 5/8] sfdisk: fix silly mbyte typo]
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:

> On Mon, Apr 16, 2012 at 12:22:12PM +0200, Voelker, Bernhard wrote:
> > Maybe this is better?
> > 
> > -	printf(_("Units = mebibytes of 1048576 bytes, blocks of 1024 bytes"
> > +	printf(_("Units = 1MiB, blocks of 1024*1024 bytes"
> 
>  +1


>From d54cd212b7ac410669ed61e75717acdb67de2fa3 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Tue, 17 Apr 2012 10:37:21 +0200
Subject: [PATCH] sfdisk (out_partition_header): improve F_MEGABYTE header

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 fdisk/sfdisk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index 95e5828..a2684fb 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -929,7 +929,7 @@ out_partition_header(char *dev, int format, struct geometry G) {
 	printf(_("   Device Boot   Start       End    #blocks   Id  System\n"));
 	break;
     case F_MEGABYTE:
-	printf(_("Units = mebibytes of 1048576 bytes, blocks of 1024 bytes"
+	printf(_("Units = 1MiB, blocks of 1024*1024 bytes"
 		 ", counting from %d\n\n"), increment);
 	printf(_("   Device Boot Start   End    MiB    #blocks   Id  System\n"));
 	break;
-- 
1.7.7

