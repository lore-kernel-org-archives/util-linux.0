Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34985 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbcCVVUA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Mar 2016 17:20:00 -0400
Received: by mail-wm0-f42.google.com with SMTP id l68so170952936wml.0
        for <util-linux@vger.kernel.org>; Tue, 22 Mar 2016 14:19:59 -0700 (PDT)
From: Romain Naour <romain.naour@gmail.com>
To: util-linux@vger.kernel.org
Cc: Romain Naour <romain.naour@gmail.com>
Subject: [PATCH] lsipc: don't free shm data if no shm id is found
Date: Tue, 22 Mar 2016 22:19:54 +0100
Message-Id: <1458681594-2085-1-git-send-email-romain.naour@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There is a segfault in do_shm_global() when ipc_shm_get_info() return 0 and
ipc_shm_free_info() is called.

When no shm id is found, the memory allocated in shmds by ipc_shm_get_info() is
already free when ipc_shm_free_info() is called.

Move ipc_shm_free_info(shmds) inside the if statement where at least one shm id
is found.

Signed-off-by: Romain Naour <romain.naour@gmail.com>
---
 sys-utils/lsipc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sys-utils/lsipc.c b/sys-utils/lsipc.c
index 938728a..195ee15 100644
--- a/sys-utils/lsipc.c
+++ b/sys-utils/lsipc.c
@@ -1071,14 +1071,13 @@ static void do_shm_global(struct libscols_table *tb)
 			++nsegs;
 			sum_segsz += shmdsp->shm_segsz;
 		}
+		ipc_shm_free_info(shmds);
 	}
 
 	global_set_data(tb, "SHMMNI", _("Shared memory segments"), nsegs, lim.shmmni, 1);
 	global_set_data(tb, "SHMALL", _("Shared memory pages"), sum_segsz / getpagesize(), lim.shmall, 1);
 	global_set_data(tb, "SHMMAX", _("Max size of shared memory segment (bytes)"), 0, lim.shmmax, 0);
 	global_set_data(tb, "SHMMIN", _("Min size of shared memory segment (bytes)"), 0, lim.shmmin, 0);
-
-	ipc_shm_free_info(shmds);
 }
 
 int main(int argc, char *argv[])
-- 
2.5.0

