Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:59653 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751045AbdALPd4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 12 Jan 2017 10:33:56 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D78F375011
        for <util-linux@vger.kernel.org>; Thu, 12 Jan 2017 14:45:42 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 2/3] libmount: Fix incorrect detach of reused loop device
Message-ID: <bd9cca05-d884-c86b-9107-74e9f673c2d1@suse.cz>
Date: Thu, 12 Jan 2017 15:45:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If -oloop is used and the loop device is reused, the loop device is detached
after umount. It is incorrect as it could break the another task using the loop
device.

This is caused by mnt_context_enable_loopdel(,TRUE) that is called from
mnt_context_prepare_umount() whenever "loop" option is used, independently on
AUTOCLEAR flag.

Remove the "loop" option for reused devices to prevent detaching of reused loop
device.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libmount/src/context_loopdev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/libmount/src/context_loopdev.c b/libmount/src/context_loopdev.c
index 18eb2cc56..ab80bd110 100644
--- a/libmount/src/context_loopdev.c
+++ b/libmount/src/context_loopdev.c
@@ -10,6 +10,7 @@
  */
 
 #include <blkid.h>
+#include <stdbool.h>
 
 #include "mountP.h"
 #include "loopdev.h"
@@ -142,6 +143,7 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 	struct loopdev_cxt lc;
 	int rc = 0, lo_flags = 0;
 	uint64_t offset = 0, sizelimit = 0;
+	bool reuse = FALSE;
 
 	assert(cxt);
 	assert(cxt->fs);
@@ -263,8 +265,10 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 			if (loopval) {
 				rc = -MNT_ERR_LOOPOVERLAP;
 				goto done;
-			} else
+			} else {
+				reuse = TRUE;
 				goto success;
+			}
 		}
 		default: /* error */
 			goto done;
@@ -339,8 +343,8 @@ success:
 		/* success */
 		cxt->flags |= MNT_FL_LOOPDEV_READY;
 
-		if ((cxt->user_mountflags & MNT_MS_LOOP) &&
-		    loopcxt_is_autoclear(&lc)) {
+		if (reuse || ( (cxt->user_mountflags & MNT_MS_LOOP) &&
+		    loopcxt_is_autoclear(&lc))) {
 			/*
 			 * autoclear flag accepted by the kernel, don't store
 			 * the "loop=" option to mtab.
-- 
2.11.0

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
