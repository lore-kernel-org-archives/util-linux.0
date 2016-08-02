Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:56029 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934752AbcHBR5L (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Aug 2016 13:57:11 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 32E44AB07
	for <util-linux@vger.kernel.org>; Tue,  2 Aug 2016 17:57:10 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 3/8] losetup: Check for loop device conflicts
Message-ID: <057a3e40-b633-10c0-bab1-9a7146441b17@suse.cz>
Date: Tue, 2 Aug 2016 19:57:10 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

To prevent data loss, check for conflicting loop devices.

Return error if a conflicting loop device exists. This behavior can be overridden
by --force.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/losetup.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index ef6f52b..28cde2b 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -732,6 +732,30 @@ int main(int argc, char **argv)
 		do {
 			const char *errpre;
 
+			if (!force) {
+				struct loopdev_cxt lc2;
+
+				if (loopcxt_init(&lc2, 0)) {
+					loopcxt_deinit(&lc);
+					err(EXIT_FAILURE, _("failed to initialize loopcxt"));
+				}
+				res = loopcxt_check_conflict(&lc2, file,
+					offset, sizelimit);
+				if (res < 0) {
+					loopcxt_deinit(&lc2);
+					loopcxt_deinit(&lc);
+					err(EXIT_FAILURE, _("failed to check for conflicting loop devices"));
+				}
+				if (res == 0) {
+					loopcxt_deinit(&lc2);
+					loopcxt_deinit(&lc);
+					errx(EXIT_FAILURE, _("%s: overlapping loop device exists; use --force to ignore"),
+						file);
+				}
+				res = 0;
+				loopcxt_deinit(&lc2);
+			}
+
 			/* Note that loopcxt_{find_unused,set_device}() resets
 			 * loopcxt struct.
 			 */
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
