Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:35193 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbcGNN3q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jul 2016 09:29:46 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C8AF5AC8D
	for <util-linux@vger.kernel.org>; Thu, 14 Jul 2016 13:29:44 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 6/7] libmout: Reuse loop device safely
Message-ID: <ff4cfcfd-077e-e2eb-8e42-18e025895960@suse.cz>
Date: Thu, 14 Jul 2016 15:29:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add a safety check to mnt_context_setup_loopdev(). Only a loop device with equal
offset and sizelimit will be reused. If any overlapping loop device exists,
MNT_ERR_LOOPOVERLAP is returned.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libmount/src/context_loopdev.c | 65 +++++++++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 13 deletions(-)

diff --git a/libmount/src/context_loopdev.c b/libmount/src/context_loopdev.c
index 8a5706a..37e49b0 100644
--- a/libmount/src/context_loopdev.c
+++ b/libmount/src/context_loopdev.c
@@ -215,23 +215,62 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 	 * mechanism to detect it. To prevent data corruption, the same loop
 	 * device has to be recycled.
 	*/
-	rc = loopcxt_init(&lc, 0);
-	if (rc)
-		goto done_no_deinit;
-	if (backing_file && !(loopcxt_find_by_backing_file(&lc,
-			backing_file, offset, sizelimit, LOOPDEV_FL_OFFSET))) {
-		DBG(LOOP, ul_debugobj(cxt, "using existing loop device %s",
+	if (backing_file) {
+		rc = loopcxt_init(&lc, 0);
+		if (rc)
+			goto done_no_deinit;
+
+		rc = loopcxt_find_by_backing_file(&lc,
+				backing_file, offset, sizelimit,
+				LOOPDEV_FL_OFFSET | LOOPDEV_FL_SIZELIMIT);
+		if (rc < 0)
+			goto done;
+		if (rc == 0) {
+			uint32_t lc_encrypt_type;
+
+			DBG(LOOP, ul_debugobj(cxt, "using existing loop device %s",
+				loopcxt_get_device(&lc)));
+
+			/* Once a loop is initialized RO, there is no
+			   way to change its parameters. */
+			if (loopcxt_is_readonly(&lc) && !(lo_flags & LO_FLAGS_READ_ONLY)) {
+				rc = -EROFS;
+				goto done;
+			}
+
+			/* This is no more supported, but check to be
+			 * safe. */
+			if (loopcxt_get_encrypt_type(&lc, &lc_encrypt_type)) {
+				DBG(LOOP, ul_debugobj(cxt, "failed to get crypt type for device %s",
 					loopcxt_get_device(&lc)));
-		/* Once a loop is initialized RO, there is no way to safely
-		   mount that file in R/W mode. */
-		if (loopcxt_is_readonly(&lc) && !(lo_flags & LO_FLAGS_READ_ONLY)) {
-			rc = -EROFS;
+				rc = -MNT_ERR_LOOPDEV;
+				goto done;
+			}
+			if (lc_encrypt_type != LO_CRYPT_NONE) {
+				DBG(LOOP, ul_debugobj(cxt, "encryption no longer supported for device %s",
+					loopcxt_get_device(&lc)));
+				rc = -MNT_ERR_LOOPOVERLAP;
+				goto done;
+			}
+			goto success;
+		}
+		loopcxt_deinit(&lc);
+		/* No existing loop device matches. Now we need to
+		 * check that no loop device overlaps our target range
+		 * inside the backing file. */
+		rc = loopcxt_init(&lc, 0);
+		if (rc)
+			goto done_no_deinit;
+		rc = loopcxt_check_conflict(&lc,
+			backing_file, offset, sizelimit);
+		if (rc < 0)
+			goto done;
+		if (rc == 0) {
+			rc = -MNT_ERR_LOOPOVERLAP;
 			goto done;
 		}
-
-		goto success;
+		loopcxt_deinit(&lc);
 	}
-	loopcxt_deinit(&lc);
 
 	rc = loopcxt_init(&lc, 0);
 	if (rc)
-- 
2.9.0

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
