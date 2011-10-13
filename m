Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50366 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752847Ab1JMMkd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 13 Oct 2011 08:40:33 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id D6AA28E857
	for <util-linux@vger.kernel.org>; Thu, 13 Oct 2011 14:40:31 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] rtcwake: fix crash (invalid free)
Date: Thu, 13 Oct 2011 14:40:31 +0200
Message-Id: <1318509631-10977-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

~ $ rtcwake -d X -s 10
*** glibc detected *** rtcwake: munmap_chunk(): invalid pointer: 0x00007fff839253c3 ***
======= Backtrace: =========
/lib64/libc.so.6(+0x733b6)[0x7f582677a3b6]
rtcwake[0x4022d5]
/lib64/libc.so.6(__libc_start_main+0xfd)[0x7f5826725bfd]
rtcwake[0x4016b9]
======= Memory map: ========
<SNIP>

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 sys-utils/rtcwake.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index 2f17400..591ef8b 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -495,7 +495,6 @@ int main(int argc, char **argv)
 
 		strcpy(new_devname, "/dev/");
 		strcat(new_devname, devname);
-		free(devname);
 		devname = new_devname;
 	}
 
-- 
1.7.3.4

