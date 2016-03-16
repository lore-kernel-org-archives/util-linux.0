Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:57801 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111AbcCPMSX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Mar 2016 08:18:23 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MDyFr-1aaygN39kF-00HN0b for
 <util-linux@vger.kernel.org>; Wed, 16 Mar 2016 13:18:20 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/3] lscpu: fix memleak because of ambiguous tags
Date: Wed, 16 Mar 2016 13:18:19 +0100
Message-Id: <1458130699-25464-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1458130699-25464-1-git-send-email-sweet_f_a@gmx.de>
References: <1458130699-25464-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Now the first one of certain ambiguous tags wins. Alternatively to
this patch we could have called free() before xstrdup().

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/lscpu.c                            | 3 ++-
 tests/expected/lscpu/lscpu-x86_64-64cpu      | 2 +-
 tests/expected/lscpu/lscpu-x86_64-dell_e4310 | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 3b338aa..36e36c9 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -353,7 +353,8 @@ lookup(char *line, char *pattern, char **value)
 	char *p, *v;
 	int len = strlen(pattern);
 
-	if (!*line)
+	/* don't re-fill already found tags, first one wins */
+	if (!*line || *value)
 		return 0;
 
 	/* pattern */
diff --git a/tests/expected/lscpu/lscpu-x86_64-64cpu b/tests/expected/lscpu/lscpu-x86_64-64cpu
index 17350e3..07990ea 100644
--- a/tests/expected/lscpu/lscpu-x86_64-64cpu
+++ b/tests/expected/lscpu/lscpu-x86_64-64cpu
@@ -13,7 +13,7 @@ Stepping:              6
 CPU MHz:               1064.000
 CPU max MHz:           1996.0000
 CPU min MHz:           1064.0000
-BogoMIPS:              3989.44
+BogoMIPS:              3990.31
 Virtualization:        VT-x
 L1d cache:             32K
 L1i cache:             32K
diff --git a/tests/expected/lscpu/lscpu-x86_64-dell_e4310 b/tests/expected/lscpu/lscpu-x86_64-dell_e4310
index 929cdf9..39ec32c 100644
--- a/tests/expected/lscpu/lscpu-x86_64-dell_e4310
+++ b/tests/expected/lscpu/lscpu-x86_64-dell_e4310
@@ -13,7 +13,7 @@ Stepping:              5
 CPU MHz:               1199.000
 CPU max MHz:           2667.0000
 CPU min MHz:           1199.0000
-BogoMIPS:              5319.97
+BogoMIPS:              5319.92
 Virtualization:        VT-x
 L1d cache:             32K
 L1i cache:             32K
-- 
1.8.4.5

