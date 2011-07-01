Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:60176 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756475Ab1GANvt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jul 2011 09:51:49 -0400
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Cc: lamont@debian.org
Subject: [PATCH 5/6] mount: make the error message clear
Date: Fri,  1 Jul 2011 15:51:44 +0200
Message-Id: <1309528305-12626-6-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1309528305-12626-1-git-send-email-petr.uzel@suse.cz>
References: <1309528305-12626-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reported-by: Micah Anderson <micah@debian.org>
Addresses: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=558653

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 mount/mount.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mount/mount.c b/mount/mount.c
index 00637f5..cb04d9d 100644
--- a/mount/mount.c
+++ b/mount/mount.c
@@ -1765,7 +1765,7 @@ try_mount_one (const char *spec0, const char *node0, const char *types0,
       unsigned long long size = 0;
 
       if (flags & MS_REMOUNT) {
-	error (_("mount: %s not mounted already, or bad option"), node);
+	error (_("mount: %s not mounted or bad option"), node);
       } else {
 	error (_("mount: wrong fs type, bad option, bad superblock on %s,\n"
 	       "       missing codepage or helper program, or other error"),
-- 
1.7.3.4

