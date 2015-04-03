Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:34378 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbbDCMAl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 3 Apr 2015 08:00:41 -0400
Received: by wgbdm7 with SMTP id dm7so109606515wgb.1
        for <util-linux@vger.kernel.org>; Fri, 03 Apr 2015 05:00:40 -0700 (PDT)
Received: from clippix.lab.lse.epita.fr (lse.epita.fr. [163.5.55.17])
        by mx.google.com with ESMTPSA id fo9sm2446462wib.16.2015.04.03.05.00.39
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2015 05:00:39 -0700 (PDT)
Date: Fri, 3 Apr 2015 14:00:33 +0200
From: "Jean-Loup 'clippix' Bogalho" <clippix@lse.epita.fr>
To: util-linux@vger.kernel.org
Subject: [PATCH] dos: copy previous bootsector in dos_create_disklabel
Message-ID: <20150403120033.GA12844@clippix.lab.lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Copy the previous (if existing) bootsector for dos mbr after
fdisk_init_firstsector_buffer zeroed it.

Signed-off-by: Jean-Loup 'clippix' Bogalho <clippix@lse.epita.fr>
---
 libfdisk/src/dos.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/libfdisk/src/dos.c b/libfdisk/src/dos.c
index dce9829..91471cc 100644
--- a/libfdisk/src/dos.c
+++ b/libfdisk/src/dos.c
@@ -18,6 +18,7 @@
 
 #define MAXIMUM_PARTS	60
 #define ACTIVE_FLAG     0x80
+#define BOOTSECTOR_SIZE	446
 
 /**
  * SECTION: dos
@@ -636,6 +637,7 @@ static int dos_create_disklabel(struct fdisk_context *cxt)
 	unsigned int id = 0;
 	int rc, has_id = 0;
 	struct fdisk_dos_label *l;
+	unsigned char *bootsector;
 
 	assert(cxt);
 	assert(cxt->label);
@@ -659,9 +661,19 @@ static int dos_create_disklabel(struct fdisk_context *cxt)
 	if (!has_id)
 		random_get_bytes(&id, sizeof(id));
 
-	rc = fdisk_init_firstsector_buffer(cxt);
-	if (rc)
-		return rc;
+	bootsector = malloc(sizeof(char) * BOOTSECTOR_SIZE);
+	if (cxt->firstsector && cxt->firstsector_bufsz == cxt->sector_size &&
+	    bootsector) {
+		memcpy(bootsector, cxt->firstsector, BOOTSECTOR_SIZE);
+		rc = fdisk_init_firstsector_buffer(cxt);
+		memcpy(cxt->firstsector, bootsector, BOOTSECTOR_SIZE);
+		free(bootsector);
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
