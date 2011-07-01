Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:60182 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756643Ab1GANvu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jul 2011 09:51:50 -0400
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Cc: lamont@debian.org
Subject: [PATCH 6/6] mount.8: fix typos
Date: Fri,  1 Jul 2011 15:51:45 +0200
Message-Id: <1309528305-12626-7-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1309528305-12626-1-git-send-email-petr.uzel@suse.cz>
References: <1309528305-12626-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Addresses: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=530681#15
From: Nicolas Francois <nicolas.francois@centraliens.net>
Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 mount/mount.8 |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mount/mount.8 b/mount/mount.8
index 886e6b4..b1666cb 100644
--- a/mount/mount.8
+++ b/mount/mount.8
@@ -804,7 +804,7 @@ and
 mount options.
 .TP
 .B noatime
-Do not update inode access times on this filesystem (e.g, for faster
+Do not update inode access times on this filesystem (e.g., for faster
 access on the news spool to speed up news servers).
 .TP
 .B auto
@@ -2408,7 +2408,7 @@ before trying
 .TP
 .B utf8
 UTF8 is the filesystem safe 8-bit encoding of Unicode that is used by the
-console. It can be be enabled for the filesystem with this option or disabled
+console. It can be enabled for the filesystem with this option or disabled
 with utf8=0, utf8=no or utf8=false. If `uni_xlate' gets set, UTF8 gets
 disabled.
 .TP
-- 
1.7.3.4

