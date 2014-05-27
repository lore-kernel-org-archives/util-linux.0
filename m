Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:41421 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616AbaE0SiM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 27 May 2014 14:38:12 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id EC2B3AC4C
	for <util-linux@vger.kernel.org>; Tue, 27 May 2014 18:38:10 +0000 (UTC)
Message-ID: <1401215890.15260.27.camel@oct.suse.cz>
Subject: [PATCH 1/2] Don't clear FD at EBUSY error in loopcxt_setup_device()
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>
Date: Tue, 27 May 2014 20:38:10 +0200
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

loopback lib clears the existing FD unconditionally at error in
loopcxt_setup_device().  This is done even after EBUSY, thus the second call
actually clears the previous setup wrongly.

Author:  Takashi Iwai <tiwai@suse.de>
Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 lib/loopdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/loopdev.c b/lib/loopdev.c
index 1fbb000..988f3d3 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -1294,7 +1294,7 @@ int loopcxt_setup_device(struct loopdev_cxt *lc)
 err:
 	if (file_fd >= 0)
 		close(file_fd);
-	if (dev_fd >= 0)
+	if (dev_fd >= 0 && rc != -EBUSY)
 		ioctl(dev_fd, LOOP_CLR_FD, 0);
 
 	DBG(lc, loopdev_debug("setup failed [rc=%d]", rc));
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

