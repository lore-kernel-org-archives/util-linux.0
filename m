Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f174.google.com ([209.85.216.174]:36096 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760Ab2C0MyD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Mar 2012 08:54:03 -0400
Received: by qcqw6 with SMTP id w6so3991136qcq.19
        for <util-linux@vger.kernel.org>; Tue, 27 Mar 2012 05:54:02 -0700 (PDT)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] fsck: don't free fstab table on parse failure
Date: Tue, 27 Mar 2012 08:53:58 -0400
Message-Id: <1332852838-6188-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Even if we fail parsing, fstab gets referenced later in the code (and
will subsequently crash via heap corruption). Take the easy way out and
simply avoid deallocating this table, as it will be freed for us on
program exit regardless.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
Crash reproducible with 'FSTAB_FILE=/dev/null fsck <any-blockdev>'

 disk-utils/fsck.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index a019a69..44200d0 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -430,7 +430,6 @@ static void load_fs_info(void)
 	path = getenv("FSTAB_FILE");
 
 	if (mnt_table_parse_fstab(fstab, path)) {
-		mnt_free_table(fstab);
 		if (!path)
 			path = mnt_get_fstab_path();
 		if (errno)
-- 
1.7.9.4

