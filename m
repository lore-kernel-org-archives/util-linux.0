Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:39122 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755958Ab2DXIVE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Apr 2012 04:21:04 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 50B75910A1
	for <util-linux@vger.kernel.org>; Tue, 24 Apr 2012 10:21:03 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 5/9] build-sys: add fsprobe.h to dist
Date: Tue, 24 Apr 2012 10:20:57 +0200
Message-Id: <1335255661-10611-5-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1335255661-10611-1-git-send-email-petr.uzel@suse.cz>
References: <1335255661-10611-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 mount/Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mount/Makefile.am b/mount/Makefile.am
index d250fcd..40f30f0 100644
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

