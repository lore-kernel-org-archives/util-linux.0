Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:60172 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756606Ab1GANvt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jul 2011 09:51:49 -0400
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Cc: lamont@debian.org
Subject: [PATCH 4/6] mount.8: fix typo
Date: Fri,  1 Jul 2011 15:51:43 +0200
Message-Id: <1309528305-12626-5-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1309528305-12626-1-git-send-email-petr.uzel@suse.cz>
References: <1309528305-12626-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reported-by: Reuben Thomas <rrt@sc3d.org>
Addresses: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=603096

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 mount/mount.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mount/mount.8 b/mount/mount.8
index 4259824..886e6b4 100644
--- a/mount/mount.8
+++ b/mount/mount.8
@@ -150,7 +150,7 @@ udev symlinks in the /etc/fstab file. The tags are
 more readable, robust and portable. The
 .BR mount (8)
 command internally uses udev
-symlinks, so use the symlinks in /etc/fstab is not advantage over LABEL=/UUID=.
+symlinks, so use the symlinks in /etc/fstab has no advantage over LABEL=/UUID=.
 For more details see
 .BR libblkid (3).
 
-- 
1.7.3.4

