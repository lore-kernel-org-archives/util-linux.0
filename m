Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:35044 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbcGNN2b (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jul 2016 09:28:31 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id B5C0AAC8D
	for <util-linux@vger.kernel.org>; Thu, 14 Jul 2016 13:28:29 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 1/7] libmount: Fix possible crash in
 mnt_context_setup_loopdev()
Message-ID: <7ecbae3a-a39c-630c-4bc1-b67ee218d274@suse.cz>
Date: Thu, 14 Jul 2016 15:28:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If loopcxt_init() fails, Iloopcxt_deinit() should not be called.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libmount/src/context_loopdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libmount/src/context_loopdev.c b/libmount/src/context_loopdev.c
index 836ebc1..7530632 100644
--- a/libmount/src/context_loopdev.c
+++ b/libmount/src/context_loopdev.c
@@ -217,7 +217,7 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 	*/
 	rc = loopcxt_init(&lc, 0);
 	if (rc)
-		goto done;
+		goto done_no_deinit;
 	if (backing_file && !(loopcxt_find_by_backing_file(&lc,
 			backing_file, offset, LOOPDEV_FL_OFFSET))) {
 		DBG(LOOP, ul_debugobj(cxt, "using existing loop device %s",
@@ -234,7 +234,9 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 	loopcxt_deinit(&lc);
 
 	rc = loopcxt_init(&lc, 0);
-	if (rc == 0 && loopval) {
+	if (rc)
+		goto done_no_deinit;
+	if (loopval) {
 		rc = loopcxt_set_device(&lc, loopval);
 		if (rc == 0)
 			loopdev = loopcxt_get_device(&lc);
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
