Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55076 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754565Ab1KNNLH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Nov 2011 08:11:07 -0500
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pAEDB7v6007192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 14 Nov 2011 08:11:07 -0500
From: harald@redhat.com
To: util-linux@vger.kernel.org
Cc: Harald Hoyer <harald@redhat.com>
Subject: [PATCH] switch_root.c: umount mount points we cannot move with MNT_DETACH
Date: Mon, 14 Nov 2011 14:11:01 +0100
Message-Id: <1321276261-9165-1-git-send-email-harald@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Harald Hoyer <harald@redhat.com>

If a mount point cannot be moved to the new root, umount it with
MNT_DETACH, so that it is lazy umounted and does not show up in
/proc/mounts anymore.
---
 sys-utils/switch_root.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/switch_root.c b/sys-utils/switch_root.c
index e50f310..a49a1f7 100644
--- a/sys-utils/switch_root.c
+++ b/sys-utils/switch_root.c
@@ -131,7 +131,7 @@ static int switchroot(const char *newroot)
 
 		if ((stat(newmount, &sb) != 0) || (sb.st_dev != newroot_stat.st_dev)) {
 			/* mount point seems to be mounted already or stat failed */
-			umount(umounts[i]);
+			umount2(umounts[i], MNT_DETACH);
 			continue;
 		}
 
-- 
1.7.7

