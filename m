Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:35102 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbcGNN3A (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jul 2016 09:29:00 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C9E19AC8D
	for <util-linux@vger.kernel.org>; Thu, 14 Jul 2016 13:28:58 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 3/7] mount: Handle MNT_ERR_LOOPOVERLAP
Message-ID: <0494727d-f78f-725a-935c-828c9344c175@suse.cz>
Date: Thu, 14 Jul 2016 15:28:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use warnx(), as there is no strerror() text associated with it.

There is currently no easy way to report name and type of conflict.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/mount.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 23856c1..92526cf 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -455,6 +455,9 @@ try_readonly:
 		case -MNT_ERR_LOOPDEV:
 			warn(_("%s: failed to setup loop device"), src);
 			return MOUNT_EX_FAIL;
+		case -MNT_ERR_LOOPOVERLAP:
+			warnx(_("%s: overlapping loop device exists"), src);
+			return MOUNT_EX_FAIL;
 		default:
 			return handle_generic_errors(rc, _("%s: mount failed"),
 					     tgt ? tgt : src);
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
