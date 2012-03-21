Return-Path: util-linux-owner@vger.kernel.org
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:51185 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964794Ab2CUJUx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 21 Mar 2012 05:20:53 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <haodong@linux.vnet.ibm.com>;
	Wed, 21 Mar 2012 14:50:50 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q2L9FpO04432004
	for <util-linux@vger.kernel.org>; Wed, 21 Mar 2012 14:45:52 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q2LEkJJV025711
	for <util-linux@vger.kernel.org>; Thu, 22 Mar 2012 01:46:19 +1100
Received: from [9.115.120.111] (don-thinkpad-t61.cn.ibm.com [9.115.120.111] (may be forged))
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q2LEkHLq025613
	for <util-linux@vger.kernel.org>; Thu, 22 Mar 2012 01:46:18 +1100
Message-ID: <4F699C44.70700@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2012 17:15:48 +0800
From: don <haodong@linux.vnet.ibm.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] Mount: fix recursively propagation mounting
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Dong Hao <haodong@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2012 13:50:14 +0800
Subject: [PATCH] Mount: fix recursively propagation mounting

Provide the recursive flag of propagation mounting. Recursive flag could 
be used together with propagation flag.

Signed-off-by: Dong Hao <haodong@linux.vnet.ibm.com>
---
  mount/mount.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mount/mount.c b/mount/mount.c
index 2ce4829..f10659c 100644
--- a/mount/mount.c
+++ b/mount/mount.c
@@ -603,7 +603,7 @@ parse_opts (const char *options, int *flags, char 
**extra_opts) {

      /* The propagation flags should not be used together with any 
other flags */
      if (*flags & MS_PROPAGATION)
-        *flags &= MS_PROPAGATION;
+        *flags &= (MS_PROPAGATION|MS_REC);
  }

  /* Try to build a canonical options string.  */
-- 
1.7.2.5

