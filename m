Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:60410 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754120AbbE1Plm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 28 May 2015 11:41:42 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 24C58AAC1
	for <util-linux@vger.kernel.org>; Thu, 28 May 2015 15:41:40 +0000 (UTC)
Message-ID: <55673733.2000409@suse.cz>
Date: Thu, 28 May 2015 17:41:39 +0200
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] lsblk.8: Fix description of output format
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 misc-utils/lsblk.8 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index 89e1ddd..eac86ac 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -60,7 +60,7 @@ top-level devices only.
 .TP
 .BR \-f , " \-\-fs"
 Output info about filesystems.  This option is equivalent to
-.BR -o\ NAME,FSTYPE,LABEL,MOUNTPOINT .
+.BR -o\ NAME,FSTYPE,LABEL,UUID,MOUNTPOINT .
 The authoritative information about filesystems and raids is provided by the
 .BR blkid (8)
 command.
@@ -116,7 +116,7 @@ Print dependencies in inverse order.
 .BR \-t , " \-\-topology"
 Output info about block-device topology.
 This option is equivalent to
-.BR -o\ NAME,ALIGNMENT,MIN-IO,OPT-IO,PHY-SEC,LOG-SEC,ROTA,SCHED,RQ-SIZE,WSAME .
+.BR -o\ NAME,ALIGNMENT,MIN-IO,OPT-IO,PHY-SEC,LOG-SEC,ROTA,SCHED,RQ-SIZE,RA,WSAME .
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
-- 
2.4.1

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
