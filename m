Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:58390 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755827AbcCQKEK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 06:04:10 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0LfHs4-1a0cb11SHo-00onDL for
 <util-linux@vger.kernel.org>; Thu, 17 Mar 2016 11:04:07 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] build-sys: install missing bash completions
Date: Thu, 17 Mar 2016 11:04:06 +0100
Message-Id: <1458209046-18526-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1458209046-18526-1-git-send-email-sweet_f_a@gmx.de>
References: <1458209046-18526-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We haven't installed these files since three years. Hopefully
they will work.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 bash-completion/Makemodule.am | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
index 56fdd32..89ae8dd 100644
--- a/bash-completion/Makemodule.am
+++ b/bash-completion/Makemodule.am
@@ -223,6 +223,10 @@ endif
 if BUILD_LOSETUP
 dist_bashcompletion_DATA += bash-completion/losetup
 endif
+if BUILD_MOUNT
+dist_bashcompletion_DATA += bash-completion/mount
+dist_bashcompletion_DATA += bash-completion/umount
+endif
 if BUILD_MOUNTPOINT
 dist_bashcompletion_DATA += bash-completion/mountpoint
 endif
@@ -237,6 +241,7 @@ dist_bashcompletion_DATA += bash-completion/setpriv
 endif
 if BUILD_SWAPON
 dist_bashcompletion_DATA += bash-completion/swapon
+dist_bashcompletion_DATA += bash-completion/swapoff
 endif
 if BUILD_UNSHARE
 dist_bashcompletion_DATA += bash-completion/unshare
-- 
1.8.4.5

