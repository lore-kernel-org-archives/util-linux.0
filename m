Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50644 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759596Ab2C2Qpw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Mar 2012 12:45:52 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 02B8F8FB75
	for <util-linux@vger.kernel.org>; Thu, 29 Mar 2012 18:45:52 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 19/20] build-sys: add fsprobe.h to dist
Date: Thu, 29 Mar 2012 18:45:27 +0200
Message-Id: <1333039528-24784-20-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 mount/Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mount/Makefile.am b/mount/Makefile.am
index 3bd6da4..2591f23 100644
--- a/mount/Makefile.am
+++ b/mount/Makefile.am
@@ -10,7 +10,7 @@ srcs_common = \
 	sundries.h
 
 # generic header for mount and umount
-hdrs_mount = fstab.h mount_mntent.h mount_constants.h getusername.h
+hdrs_mount = fstab.h mount_mntent.h mount_constants.h getusername.h fsprobe.h
 
 # generic sources for mount and umount
 srcs_mount = \
-- 
1.7.7

