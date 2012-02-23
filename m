Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:39831 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754226Ab2BWPnh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 23 Feb 2012 10:43:37 -0500
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id DEFAF932D7
	for <util-linux@vger.kernel.org>; Thu, 23 Feb 2012 16:43:35 +0100 (CET)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] fdisk.8: update information about GNU Parted
Date: Thu, 23 Feb 2012 16:43:35 +0100
Message-Id: <1330011815-18517-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The support for resizing partitions and filesystems has been
removed from parted since version 3.0.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisk/fdisk.8 |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fdisk/fdisk.8 b/fdisk/fdisk.8
index 2b12f34..fdaa050 100644
--- a/fdisk/fdisk.8
+++ b/fdisk/fdisk.8
@@ -256,10 +256,9 @@ is for hackers only -- the user interface is terrible, but it is
 more correct than fdisk and more powerful than both fdisk and cfdisk.
 Moreover, it can be used noninteractively.)
 .PP
-These days there also is
-.BR parted .
-The cfdisk interface is nicer, but parted does much more: it not only
-resizes partitions, but also the filesystems that live in them.
+There also is
+.BR parted
+which supports many types of different partition table formats.
 .PP
 The IRIX/SGI-type disklabel is currently not supported by the kernel.
 Moreover, IRIX/SGI header directories are not fully supported yet.
-- 
1.7.7

