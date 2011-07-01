Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:60162 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756475Ab1GANvr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jul 2011 09:51:47 -0400
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Cc: lamont@debian.org
Subject: [PATCH 2/6] mount.8: remove accidental extra word in ext4 documentation
Date: Fri,  1 Jul 2011 15:51:41 +0200
Message-Id: <1309528305-12626-3-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1309528305-12626-1-git-send-email-petr.uzel@suse.cz>
References: <1309528305-12626-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reported-by: Francis Russell <francis+dbts@unchartedbackwaters.co.uk>
Addresses: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=599550

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 mount/mount.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mount/mount.8 b/mount/mount.8
index 767ff51..598280c 100644
--- a/mount/mount.8
+++ b/mount/mount.8
@@ -1487,7 +1487,7 @@ debugging purposes.  This is normally used while
 remounting a filesystem which is already mounted.
 .TP
 .BR auto_da_alloc | noauto_da_alloc
-Many broken applications don't use fsync() when noauto_da_alloc
+Many broken applications don't use fsync() when
 replacing existing files via patterns such as
 
 fd = open("foo.new")/write(fd,..)/close(fd)/ rename("foo.new", "foo")
-- 
1.7.3.4

