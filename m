Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:51761 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbcCRLtX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Mar 2016 07:49:23 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0M3RZI-1ZpskC1tC4-00r180 for
 <util-linux@vger.kernel.org>; Fri, 18 Mar 2016 12:49:20 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] ipcs: --shmems, upward/backward compatibility
Date: Fri, 18 Mar 2016 12:49:18 +0100
Message-Id: <1458301758-21853-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1458301758-21853-1-git-send-email-sweet_f_a@gmx.de>
References: <1458301758-21853-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Re-add backward compatibility which got lost in 058e8154.
Initializing unknown struct members to 0xdead is similar to
the fallback.

For upward compatibility ignore columns > 16 but not the whole
line (in case the kernel would add more columns in future).

Reported-by: Benno Schulenberg <bensberg@justemail.net>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/ipcutils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sys-utils/ipcutils.c b/sys-utils/ipcutils.c
index c763cde..349e855 100644
--- a/sys-utils/ipcutils.c
+++ b/sys-utils/ipcutils.c
@@ -113,6 +113,9 @@ int ipc_shm_get_info(int id, struct shm_data **shmds)
 	while (fgetc(f) != '\n');		/* skip header */
 
 	while (fgets(buf, sizeof(buf), f) != NULL) {
+		/* scan for the first 14-16 columns (e.g. Linux 2.6.32 has 14) */
+		p->shm_rss = 0xdead;
+		p->shm_swp = 0xdead;
 		if (sscanf(buf,
 			  "%d %d  %o %"SCNu64 " %u %u  "
 			  "%"SCNu64 " %u %u %u %u %"SCNi64 " %"SCNi64 " %"SCNi64
@@ -132,7 +135,7 @@ int ipc_shm_get_info(int id, struct shm_data **shmds)
 			   &p->shm_dtim,
 			   &p->shm_ctim,
 			   &p->shm_rss,
-			   &p->shm_swp) != 16)
+			   &p->shm_swp) < 14)
 			continue; /* ivalid line, skipped */
 
 		if (id > -1) {
-- 
1.8.4.5

