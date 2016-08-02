Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:33070 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757321AbcHBSeD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Aug 2016 14:34:03 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 7A613ABE0
	for <util-linux@vger.kernel.org>; Tue,  2 Aug 2016 17:59:09 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 6/8] losetup: Prevent rare detach race
Message-ID: <53d613e5-fb85-c47f-18e7-05b5086586b8@suse.cz>
Date: Tue, 2 Aug 2016 19:59:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There is still a race risk: Device scheduled to detach is found by
loopcxt_find_by_backing_file(), but released before loopcxt_set_status() is
called, causing error on subsequent calls. To prevent error, retry it once
again.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/losetup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index ba096fe..b156ab6 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -680,13 +680,20 @@ int main(int argc, char **argv)
 	switch (act) {
 	case A_CREATE:
 	{
+		/* If it is a device scheduled for detach, it can be detached
+		 * just in middle of processing. Retry once, if it happens
+		 * again, exit. */
+		int retries_left = 1;
 		int hasdev = loopcxt_has_device(&lc);
 
 		if (!hasdev && !force) {
+	retry:
 			res = loopcxt_find_by_backing_file(&lc,
 				file, offset, sizelimit,
 				LOOPDEV_FL_OFFSET | LOOPDEV_FL_SIZELIMIT);
 			if (res < 0) {
+				if (retries_left--)
+					goto retry;
 				loopcxt_deinit(&lc);
 				errx(EXIT_FAILURE, _("failed to inspect loop devices"));
 			}
@@ -698,6 +705,8 @@ int main(int argc, char **argv)
 				/* Once a loop is initialized RO, there is no
 				   way to change its parameters. */
 				if (loopcxt_is_readonly(&lc) && !(lo_flags & LO_FLAGS_READ_ONLY)) {
+					if (retries_left--)
+						goto retry;
 					loopcxt_deinit(&lc);
 					errx(EXIT_FAILURE, _("%s: overlapping read-only loop device exists; use --force to ignore"),
 						loopcxt_get_device(&lc));
@@ -706,11 +715,15 @@ int main(int argc, char **argv)
 				/* This is no more supported, but check to be
 				 * safe. */
 				if (loopcxt_get_encrypt_type(&lc, &lc_encrypt_type)) {
+					if (retries_left--)
+						goto retry;
 					loopcxt_deinit(&lc);
 					errx(EXIT_FAILURE, _("%s: encryption check failed"),
 					      loopcxt_get_device(&lc));
 				}
 				if (lc_encrypt_type != LO_CRYPT_NONE) {
+					if (retries_left--)
+						goto retry;
 					loopcxt_deinit(&lc);
 					errx(EXIT_FAILURE, _("%s: encryption check failed"),
 					      loopcxt_get_device(&lc));
@@ -722,6 +735,8 @@ int main(int argc, char **argv)
 				 * user was already warned in past. */
 				lc.info.lo_flags &= !LO_FLAGS_AUTOCLEAR;
 				if (loopcxt_set_status(&lc)) {
+					if (retries_left--)
+						goto retry;
 					loopcxt_deinit(&lc);
 					errx(EXIT_FAILURE, _("%s: failed to re-use loop device"),
 					      loopcxt_get_device(&lc));
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
