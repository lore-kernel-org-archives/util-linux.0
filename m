Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:44087 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753853Ab2DEPuU (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 5 Apr 2012 11:50:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id E833F1B4031
	for <util-linux-ng@vger.kernel.org>; Thu,  5 Apr 2012 15:50:19 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux-ng@vger.kernel.org
Subject: [PATCH 2/3] eject(1): fix typo in mount(1) reference
Date: Thu,  5 Apr 2012 11:50:45 -0400
Message-Id: <1333641046-13125-2-git-send-email-vapier@gentoo.org>
In-Reply-To: <1333641046-13125-1-git-send-email-vapier@gentoo.org>
References: <1333641046-13125-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sys-utils/eject.1 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/eject.1 b/sys-utils/eject.1
index 8b1b11b..22cf1ae 100644
--- a/sys-utils/eject.1
+++ b/sys-utils/eject.1
@@ -59,7 +59,7 @@ This option specifies that the drive should be ejected using a tape drive
 offline command.
 .IP "\fB\-m, \-\-no-unmount\fP"
 This option allows eject to work with device drivers which automatically mount
-removable media and therefore must be always mount()ed.  The option tells eject
+removable media and therefore must be always mount(1)ed.  The option tells eject
 to not try to unmount the given device, even if it is mounted according to
 /etc/mtab or /proc/mounts.
 .IP "\fB\-n, \-\-noop\fP"
-- 
1.7.8.5

