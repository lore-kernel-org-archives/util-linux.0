Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63725 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712Ab1FFTHh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Jun 2011 15:07:37 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1471009ewy.19
        for <util-linux@vger.kernel.org>; Mon, 06 Jun 2011 12:07:36 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 5/6] sfdisk: fix implicit overflow
Date: Mon,  6 Jun 2011 21:07:18 +0200
Message-Id: <1307387239-9022-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1307387239-9022-1-git-send-email-kerolasa@iki.fi>
References: <1307387239-9022-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

sfdisk.c:1650:6: warning: overflow in implicit constant conversion [-Woverflow]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisk/sfdisk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index d4dbcca..afecb93 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -1647,7 +1647,7 @@ write_partitions(char *dev, int fd, struct disk_desc *z) {
 	if (p->ptype == DOS_TYPE) {
 	    copy_from_part(&(p->p), s->data + p->offset);
 	    s->data[510] = 0x55;
-	    s->data[511] = 0xaa;
+	    s->data[511] = (unsigned char) 0xaa;
 	}
     }
     if (save_sector_file) {
-- 
1.7.5.2

