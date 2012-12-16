Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:57728 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab2LPKom (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Dec 2012 05:44:42 -0500
Received: by mail-wi0-f180.google.com with SMTP id hj13so1401256wib.1
        for <util-linux@vger.kernel.org>; Sun, 16 Dec 2012 02:44:41 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/14] docs: add missing exit value to fsck.minix(8)
Date: Sun, 16 Dec 2012 10:44:00 +0000
Message-Id: <1355654642-22106-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
References: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And remove references to manual pages which has not been part of commonly
used distributions for a while.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fsck.minix.8 | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/disk-utils/fsck.minix.8 b/disk-utils/fsck.minix.8
index e84b82b..4458f09 100644
--- a/disk-utils/fsck.minix.8
+++ b/disk-utils/fsck.minix.8
@@ -79,14 +79,10 @@ Force a filesystem check even if the filesystem was marked as valid (this
 marking is done by the kernel when the filesystem is unmounted).
 .SH "SEE ALSO"
 .BR fsck (8),
-.BR fsck.ext (8),
 .BR fsck.ext2 (8),
-.BR fsck.xiafs (8),
 .BR mkfs (8),
 .BR mkfs.minix (8),
-.BR mkfs.ext (8),
 .BR mkfs.ext2 (8),
-.BR mkfs.xiafs (8),
 .BR reboot (8)
 .SH DIAGNOSTICS
 There are numerous diagnostic messages.  The ones mentioned here are the
@@ -109,6 +105,8 @@ Filesystem errors corrected, system should be rebooted if filesystem was
 mounted
 .IP 4
 Filesystem errors left uncorrected
+.IP 7
+Combination of exit codes 3 and 4
 .IP 8
 Operational error
 .IP 16
-- 
1.8.0.2

