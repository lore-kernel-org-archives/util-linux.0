Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:44628 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326Ab2EMJIZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 May 2012 05:08:25 -0400
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: Regid Ichira <regid23@yahoo.com>
Subject: [PATCH] lsblk.8: improve wording
Date: Sun, 13 May 2012 11:08:20 +0200
Message-Id: <1336900100-9406-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Cc: Regid Ichira <regid23@yahoo.com>
From: Regid Ichira <regid23@yahoo.com>
Addresses: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=672702

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/lsblk.8 |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index 21d5838..79173da 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -66,8 +66,8 @@ This option is equivalent to "-o NAME,ALIGNMENT,MIN-IO,OPT-IO,PHY-SEC,LOG-SEC,RO
 .IP "\fB\-V, \-\-version\fP"
 Output version information and exit.
 .SH NOTES
-For the partitions are some information (e.g. queue attributes) inherited from
-parental device.
+For partitions, some information (e.g. queue attributes) is inherited from the
+parent device.
 
 The
 .B lsblk
-- 
1.7.7

