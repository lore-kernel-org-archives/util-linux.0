Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:52523 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753070AbaFHNcz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 8 Jun 2014 09:32:55 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Tobias Klausmann <klausman@schwarzvogel.de>
Subject: [PATCH] libfdisk: fix bsd_translate_fstype() for alpha
Date: Sun,  8 Jun 2014 15:32:48 +0200
Message-Id: <1402234368-17174-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <20140608104251.GA72528@skade.schwarzvogel.de>
References: <20140608104251.GA72528@skade.schwarzvogel.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Reported-by: Tobias Klausmann <klausman@schwarzvogel.de>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libfdisk/src/bsd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libfdisk/src/bsd.c b/libfdisk/src/bsd.c
index a81afd2..df0fc13 100644
--- a/libfdisk/src/bsd.c
+++ b/libfdisk/src/bsd.c
@@ -773,8 +773,10 @@ static int bsd_translate_fstype (int linux_type)
 	case 0x06: /* DOS 16-bit >=32M */
 	case 0xe1: /* DOS access       */
 	case 0xe3: /* DOS R/O          */
+#if !defined (__alpha__)
 	case 0xf2: /* DOS secondary    */
 		return BSD_FS_MSDOS;
+#endif
 	case 0x07: /* OS/2 HPFS        */
 		return BSD_FS_HPFS;
 	default:
-- 
1.8.4.5

