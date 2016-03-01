Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:53567 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430AbcCALoS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 1 Mar 2016 06:44:18 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0Lmwpk-1Zy7BM2jvg-00h2zm for
 <util-linux@vger.kernel.org>; Tue, 01 Mar 2016 12:44:16 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/4] fdisk: remove unused include sysfs.h
Date: Tue,  1 Mar 2016 12:44:13 +0100
Message-Id: <1456832654-11268-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456832654-11268-1-git-send-email-sweet_f_a@gmx.de>
References: <1456832654-11268-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/fdisk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index 0b22983..f748079 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -37,7 +37,6 @@
 #include "canonicalize.h"
 #include "strutils.h"
 #include "closestream.h"
-#include "sysfs.h"
 
 #include "fdisk.h"
 
-- 
1.8.4.5

