Return-Path: util-linux-owner@vger.kernel.org
Received: from lb1.openmailbox.org ([5.79.108.160]:56926 "EHLO
        mail.openmailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752064AbdFOIfC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 15 Jun 2017 04:35:02 -0400
From: Alex Ivanov <yourbestfriend@openmailbox.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] fstrim: prefer earlier mounted filesystems
Date: Thu, 15 Jun 2017 11:26:25 +0300
Message-Id: <20170615082625.11219-1-yourbestfriend@openmailbox.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

fstrim --all is broken in a way that if there is a bind mount for some filesystem, 
that filesystem will not be trimmed. This is especially critical for e.g. 
NixOS distribution, which needs bind mount within root fs: 
https://github.com/NixOS/nixos/blob/master/modules/system/boot/stage-2-init.sh#L55

Currently for a given filesystem during "de-duplication by source and root" phase,
an early mounted fs path is filtered (e.g. "/"), while later mounted fs path is kept 
(e.g. "/nix/store") though anyway discarded later (since it's an overlaying mount). 
This leads to skipped trimming.

So flip this behaviour. Should also help for other types of overlaying mounts.

Reference: 
https://github.com/karelzak/util-linux/blob/stable/v2.29/libmount/src/tab.c#L715

Signed-off-by: Alex Ivanov <yourbestfriend@openmailbox.org>
---
 sys-utils/fstrim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/fstrim.c b/sys-utils/fstrim.c
index b884af6d0..be3cd34a3 100644
--- a/sys-utils/fstrim.c
+++ b/sys-utils/fstrim.c
@@ -194,7 +194,7 @@ static int fstrim_all(struct fstrim_range *rangetpl, int verbose)
 	mnt_table_uniq_fs(tab, 0, uniq_fs_target_cmp);
 
 	/* de-duplicate by source and root */
-	mnt_table_uniq_fs(tab, 0, uniq_fs_source_cmp);
+	mnt_table_uniq_fs(tab, MNT_UNIQ_FORWARD, uniq_fs_source_cmp);
 
 	while (mnt_table_next_fs(tab, itr, &fs) == 0) {
 		const char *src = mnt_fs_get_srcpath(fs),
-- 
2.12.2

