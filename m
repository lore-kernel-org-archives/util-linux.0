Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33244 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbbDDQFh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 4 Apr 2015 12:05:37 -0400
Received: by wgin8 with SMTP id n8so42430768wgi.0
        for <util-linux@vger.kernel.org>; Sat, 04 Apr 2015 09:05:36 -0700 (PDT)
Date: Sat, 4 Apr 2015 18:05:26 +0200
From: "Jean-Loup 'clippix' Bogalho" <clippix@lse.epita.fr>
To: util-linux@vger.kernel.org
Cc: gabriel@lse.epita.fr
Subject: [PATCH V2] dos: copy previous bootsector for dos partition table
Message-ID: <20150404160526.GA24261@clippix.lab.lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In order to create a dos partition scheme, libfdisk erase the first disk sector
and then add the needed values (partitions, magic numbers).
In the case the disk already contains code in the bootsection, it will be
erased.  This was not the case in v2.25 of util-linux.
Since fdisk can be used to repair messed partition tables, maybe we don't want
to have to rewrite the boot section.
If you want to keep the precedent behavior, here's a patch that re-copy the old
bootsection after it has been wiped. There is other ways to do it, but this one
doesn't interfere with the rest of the code.

Signed-off-by: Jean-Loup 'clippix' Bogalho <clippix@lse.epita.fr>
---
 libfdisk/src/dos.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/libfdisk/src/dos.c b/libfdisk/src/dos.c
index dce9829..998080a 100644
--- a/libfdisk/src/dos.c
+++ b/libfdisk/src/dos.c
@@ -18,6 +18,7 @@
 
 #define MAXIMUM_PARTS	60
 #define ACTIVE_FLAG     0x80
+#define BOOTSECTOR_SIZE	446
 
 /**
  * SECTION: dos
@@ -659,9 +660,17 @@ static int dos_create_disklabel(struct fdisk_context *cxt)
 	if (!has_id)
 		random_get_bytes(&id, sizeof(id));
 
-	rc = fdisk_init_firstsector_buffer(cxt);
-	if (rc)
-		return rc;
+	if (cxt->firstsector && cxt->firstsector_bufsz == cxt->sector_size) {
+		unsigned char bootsector[BOOTSECTOR_SIZE];
+		memcpy(bootsector, cxt->firstsector, BOOTSECTOR_SIZE);
+		rc = fdisk_init_firstsector_buffer(cxt);
+		memcpy(cxt->firstsector, bootsector, BOOTSECTOR_SIZE);
+	}
+	else {
+		rc = fdisk_init_firstsector_buffer(cxt);
+		if (rc)
+			return rc;
+	}
 	dos_init(cxt);
 
 	l = self_label(cxt);

-- 
Jean-Loup 'clippix' Bogalho
LSE 2016
