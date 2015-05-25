Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:43007 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903AbbEYTRy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 25 May 2015 15:17:54 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 2DE09AC50
	for <util-linux@vger.kernel.org>; Mon, 25 May 2015 19:17:53 +0000 (UTC)
Message-ID: <55637560.4060207@suse.cz>
Date: Mon, 25 May 2015 21:17:52 +0200
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] Use correct partition names for /dev/mapper
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The default configuration of multipath-tools appends "-partN" to
partition nodes. Follow this conventions and do the same.

It fixes for example fdisk -l /dev/mapper/name_of_the_device.

Note that the current implementation only partially fixes the problem. It
does not reflect any udev configuration changes, as udev does not provide
any function to return names of future (or current) partitions of a
particular device. It also does not fix fdisk -l /dev/dm-0.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libfdisk/src/utils.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libfdisk/src/utils.c b/libfdisk/src/utils.c
index cc470d9..928c59b 100644
--- a/libfdisk/src/utils.c
+++ b/libfdisk/src/utils.c
@@ -139,9 +139,11 @@ char *fdisk_partname(const char *dev, size_t partno)
 	}
 
 	/* udev names partitions by appending -partN
-	   e.g. ata-SAMSUNG_SV8004H_0357J1FT712448-part1 */
+	   e.g. ata-SAMSUNG_SV8004H_0357J1FT712448-part1
+	   multipath-tools kpartx.rules also append -partN */
 	if ((strncmp(dev, _PATH_DEV_BYID, sizeof(_PATH_DEV_BYID) - 1) == 0) ||
-	     strncmp(dev, _PATH_DEV_BYPATH, sizeof(_PATH_DEV_BYPATH) - 1) == 0) {
+	     strncmp(dev, _PATH_DEV_BYPATH, sizeof(_PATH_DEV_BYPATH) - 1) == 0 ||
+	     strncmp(dev, "/dev/mapper", sizeof("/dev/mapper") - 1) == 0) {
 	       p = "-part";
 	}
 
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
