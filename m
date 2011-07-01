Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:60160 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756475Ab1GANvr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jul 2011 09:51:47 -0400
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Cc: lamont@debian.org
Subject: [PATCH 1/6] mount.8: fix reference to sharedsubtree documentation
Date: Fri,  1 Jul 2011 15:51:40 +0200
Message-Id: <1309528305-12626-2-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1309528305-12626-1-git-send-email-petr.uzel@suse.cz>
References: <1309528305-12626-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Mike Hommey <mh+reportbug@glandium.org>
Addresses: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=508572
Addresses: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=572403
Addresses: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=508412

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 mount/mount.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mount/mount.8 b/mount/mount.8
index e9a52dd..767ff51 100644
--- a/mount/mount.8
+++ b/mount/mount.8
@@ -439,7 +439,7 @@ of that mount such that mounts and umounts within any of the mirrors propagate
 to the other mirror. A slave mount receives propagation from its master, but
 any not vice-versa.  A private mount carries no propagation abilities.  A
 unbindable mount is a private mount which cannot be cloned through a bind
-operation. Detailed semantics is documented in Documentation/sharedsubtree.txt
+operation. Detailed semantics is documented in Documentation/filesystems/sharedsubtree.txt
 file in the kernel source tree.
 
 .RS
-- 
1.7.3.4

