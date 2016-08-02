Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:55874 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935920AbcHBRz7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Aug 2016 13:55:59 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 6E9F2AAD1
	for <util-linux@vger.kernel.org>; Tue,  2 Aug 2016 17:55:58 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 2/8] losetup: Re-use loop device with matching parameters
Message-ID: <0a522a2f-71ff-ceb1-357b-d1298d418fbc@suse.cz>
Date: Tue, 2 Aug 2016 19:55:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If losetup --find is called with parameters matching to an existing loop device,
re-use this loop device instead of allocating new one.

If --force is used, fall back to the old behavior.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/losetup.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 0a323a9..ef6f52b 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -682,6 +682,51 @@ int main(int argc, char **argv)
 	{
 		int hasdev = loopcxt_has_device(&lc);
 
+		if (!hasdev && !force) {
+			res = loopcxt_find_by_backing_file(&lc,
+				file, offset, sizelimit,
+				LOOPDEV_FL_OFFSET | LOOPDEV_FL_SIZELIMIT);
+			if (res < 0) {
+				loopcxt_deinit(&lc);
+				errx(EXIT_FAILURE, _("failed to inspect loop devices"));
+			}
+			if (res == 0) {
+				uint32_t lc_encrypt_type;
+
+				res = -1;
+
+				/* Once a loop is initialized RO, there is no
+				   way to change its parameters. */
+				if (loopcxt_is_readonly(&lc) && !(lo_flags & LO_FLAGS_READ_ONLY)) {
+					loopcxt_deinit(&lc);
+					errx(EXIT_FAILURE, _("%s: overlapping read-only loop device exists; use --force to ignore"),
+						loopcxt_get_device(&lc));
+				}
+
+				/* This is no more supported, but check to be
+				 * safe. */
+				if (loopcxt_get_encrypt_type(&lc, &lc_encrypt_type)) {
+					loopcxt_deinit(&lc);
+					errx(EXIT_FAILURE, _("%s: encryption check failed"),
+					      loopcxt_get_device(&lc));
+				}
+				if (lc_encrypt_type != LO_CRYPT_NONE) {
+					loopcxt_deinit(&lc);
+					errx(EXIT_FAILURE, _("%s: encryption check failed"),
+					      loopcxt_get_device(&lc));
+				}
+
+				res = 0;
+				/* We found a device to recycle. Do not check
+				 * for conflict. If it is conflicting, then
+				 * user was already warned in past. */
+				goto got_device;
+			}
+			loopcxt_deinit(&lc);
+			if (loopcxt_init(&lc, 0))
+				err(EXIT_FAILURE, _("failed to initialize loopcxt"));
+		}
+
 		if (hasdev && !is_loopdev(loopcxt_get_device(&lc)))
 			loopcxt_add_device(&lc);
 		do {
@@ -718,6 +763,7 @@ int main(int argc, char **argv)
 			break;
 		} while (hasdev == 0);
 
+	got_device:
 		if (res == 0) {
 			if (showdev)
 				printf("%s\n", loopcxt_get_device(&lc));
-- 
2.9.2

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
