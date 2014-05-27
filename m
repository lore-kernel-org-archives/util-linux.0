Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:41423 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753289AbaE0SiT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 27 May 2014 14:38:19 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 12B4AAC4C
	for <util-linux@vger.kernel.org>; Tue, 27 May 2014 18:38:18 +0000 (UTC)
Message-ID: <1401215897.15260.28.camel@oct.suse.cz>
Subject: [PATCH 2/2] Don't ignore EBUSY in losetup when the loop device is
 given
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>
Date: Tue, 27 May 2014 20:38:17 +0200
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

losetup ignores the EBUSY error.  In the loop fo A_CREATE action, it skips
the error handling when errno = EBUSY.  It's OK for the case where no loop
device is specified, but the error has to be handled when the device is given
explicitly.

Author:  Takashi Iwai <tiwai@suse.de>
Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/losetup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index f6b8685..ecba8a5 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -662,7 +662,7 @@ int main(int argc, char **argv)
 			res = loopcxt_setup_device(&lc);
 			if (res == 0)
 				break;			/* success */
-			if (errno == EBUSY)
+			if (errno == EBUSY && !hasdev)
 				continue;
 
 			/* errors */
-- 
1.8.4.5

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

