Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:33069 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757348AbcHBSeD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Aug 2016 14:34:03 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 76550AB07
	for <util-linux@vger.kernel.org>; Tue,  2 Aug 2016 17:58:29 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 5/8] Prevent AUTOCLEAR detach race
Message-ID: <c83ba048-2d5e-da62-4a99-2d05f75add4a@suse.cz>
Date: Tue, 2 Aug 2016 19:58:29 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Kernel needs some time to delete a device after losetup --detach. If the losetup
--find is called just after losetup --delete, it can sometimes attempt to
recycle the device that is just being released. To prevent this race,
clear the AUTOCLEAR flag of the device.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/losetup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 28cde2b..ba096fe 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -720,6 +720,12 @@ int main(int argc, char **argv)
 				/* We found a device to recycle. Do not check
 				 * for conflict. If it is conflicting, then
 				 * user was already warned in past. */
+				lc.info.lo_flags &= !LO_FLAGS_AUTOCLEAR;
+				if (loopcxt_set_status(&lc)) {
+					loopcxt_deinit(&lc);
+					errx(EXIT_FAILURE, _("%s: failed to re-use loop device"),
+					      loopcxt_get_device(&lc));
+				}
 				goto got_device;
 			}
 			loopcxt_deinit(&lc);
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
