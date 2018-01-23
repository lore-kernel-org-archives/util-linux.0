Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:62969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751412AbeAWP7c (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 23 Jan 2018 10:59:32 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Tobias Stoeckmann <tobias@stoeckmann.org>
Subject: [PATCH 2/7] fsck.cramfs: fix crash when superblock size is too small
Date: Tue, 23 Jan 2018 16:59:23 +0100
Message-Id: <20180123155928.7629-3-sweet_f_a@gmx.de>
In-Reply-To: <20180123155928.7629-1-sweet_f_a@gmx.de>
References: <20180123155928.7629-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This hopefully fixes the original problem addressed by the reverted
patch 7cb962c7.

The bug was introduced by myself in
    f991dbd3 "fsck.cramfs: allow smaller superblock sizes"

CC: Tobias Stoeckmann <tobias@stoeckmann.org>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/fsck.cramfs.c              | 2 +-
 tests/expected/cramfs/fsck-bad-header | 3 +--
 tests/ts/cramfs/fsck-bad-header       | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index 50c7d33b9..820816b14 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -192,7 +192,7 @@ static void test_super(int *start, size_t * length)
 		errx(FSCK_EX_ERROR, _("unsupported filesystem features"));
 
 	/* What are valid superblock sizes? */
-	if (super.size < sizeof(struct cramfs_super))
+	if (super.size < *start + sizeof(struct cramfs_super))
 		errx(FSCK_EX_UNCORRECTED, _("superblock size (%d) too small"),
 		     super.size);
 
diff --git a/tests/expected/cramfs/fsck-bad-header b/tests/expected/cramfs/fsck-bad-header
index ade8a9c3a..41c2c125e 100644
--- a/tests/expected/cramfs/fsck-bad-header
+++ b/tests/expected/cramfs/fsck-bad-header
@@ -1,2 +1 @@
-fsck.cramfs: file extends past end of filesystem
-fsck.cramfs: crc error
+fsck.cramfs: superblock size (76) too small
diff --git a/tests/ts/cramfs/fsck-bad-header b/tests/ts/cramfs/fsck-bad-header
index 8d5309c35..add388577 100755
--- a/tests/ts/cramfs/fsck-bad-header
+++ b/tests/ts/cramfs/fsck-bad-header
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 TS_TOPDIR="${0%/*}/../.."
-TS_DESC="fsck endianness"
+TS_DESC="fsck bad header"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
-- 
2.13.6

