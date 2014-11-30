Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36393 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbaK3N6U (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 30 Nov 2014 08:58:20 -0500
Received: by mail-wi0-f175.google.com with SMTP id l15so22207126wiw.14
        for <util-linux@vger.kernel.org>; Sun, 30 Nov 2014 05:58:19 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 10/10] ipcs: fix two data type errors [AddressSanitizer]
Date: Sun, 30 Nov 2014 13:57:42 +0000
Message-Id: <1417355862-16935-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

==3218==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7fffa577e2b0 at pc 0x4501f9 bp 0x7fffa577e130 sp 0x7fffa577e108
WRITE of size 112 at 0x7fffa577e2b0 thread T0
    #0 0x4501f8 in shmctl /home/users/aadgrand/LLVM/releases/ubuntu/final/llvm.src/projects/compiler-rt/lib/sanitizer_common/sanitizer_common_interceptors.inc:2502
    #1 0x48bd13 in ipc_shm_get_info /home/travis/build/kerolasa/lelux-utiliteetit/sys-utils/ipcutils.c:157
    #2 0x488884 in do_shm /home/travis/build/kerolasa/lelux-utiliteetit/sys-utils/ipcs.c:279
    #3 0x4844a8 in main /home/travis/build/kerolasa/lelux-utiliteetit/sys-utils/ipcs.c:175
    #4 0x2afb3f8c176c (/lib/x86_64-linux-gnu/libc.so.6+0x2176c)
    #5 0x48408c in _start (/home/travis/build/kerolasa/lelux-utiliteetit/ipcs+0x48408c)

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcutils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/ipcutils.c b/sys-utils/ipcutils.c
index c45162a..3d5249c 100644
--- a/sys-utils/ipcutils.c
+++ b/sys-utils/ipcutils.c
@@ -98,7 +98,7 @@ int ipc_shm_get_info(int id, struct shm_data **shmds)
 	FILE *f;
 	int i = 0, maxid;
 	struct shm_data *p;
-	struct shm_info dummy;
+	struct shmid_ds dummy;
 
 	p = *shmds = xcalloc(1, sizeof(struct shm_data));
 	p->next = NULL;
@@ -154,7 +154,7 @@ int ipc_shm_get_info(int id, struct shm_data **shmds)
 
 	/* Fallback; /proc or /sys file(s) missing. */
 shm_fallback:
-	maxid = shmctl(0, SHM_INFO, (struct shmid_ds *) &dummy);
+	maxid = shmctl(0, SHM_INFO, &dummy);
 
 	for (int j = 0; j <= maxid; j++) {
 		int shmid;
-- 
2.1.3

