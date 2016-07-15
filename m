Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:53899 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbcGONHk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Jul 2016 09:07:40 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 0C6E8ACBB
	for <util-linux@vger.kernel.org>; Fri, 15 Jul 2016 13:07:39 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 8/7] mount.8: Update loop device documentation
Message-ID: <301c1859-76e9-3901-37ab-8ad3d9ccc72d@suse.cz>
Date: Fri, 15 Jul 2016 15:07:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

New code checks both offset and sizelimit before re-using loop device.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/mount.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 0c04a65..f182ef9 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -2933,7 +2933,7 @@ You can also free a loop device by hand, using
 
 Since util-linux v2.29 mount command re-uses the loop device rather than
 initialize a new device if the same backing file is already mounted with the
-same offset.
+same offset and sizelimit.
 
 .SH RETURN CODES
 .B mount
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
