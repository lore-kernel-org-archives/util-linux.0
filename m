Return-Path: util-linux-owner@vger.kernel.org
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:46824 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755944AbaCDEjw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 3 Mar 2014 23:39:52 -0500
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <stewart@linux.vnet.ibm.com>;
	Tue, 4 Mar 2014 10:09:49 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 20D4F394003E
	for <util-linux@vger.kernel.org>; Tue,  4 Mar 2014 10:09:47 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s244dhI28650948
	for <util-linux@vger.kernel.org>; Tue, 4 Mar 2014 10:09:43 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s244dkYO020161
	for <util-linux@vger.kernel.org>; Tue, 4 Mar 2014 10:09:46 +0530
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH] lscpu: read_hypervisor_dmi: only fallback to memory scan on x86/x86_64
Date: Tue,  4 Mar 2014 15:39:41 +1100
Message-Id: <1393907981-24298-1-git-send-email-stewart@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

As the comment in the code says, this method is really only valid
on x86 and x86_64, so add a #ifdef for those architectures around
that code block.

This was causing "Program lscpu tried to access /dev/mem between f0000->100000."
warnings on some ppc64 machines.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 sys-utils/lscpu-dmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sys-utils/lscpu-dmi.c b/sys-utils/lscpu-dmi.c
index c416f8e..c82bfc1 100644
--- a/sys-utils/lscpu-dmi.c
+++ b/sys-utils/lscpu-dmi.c
@@ -258,6 +258,7 @@ int read_hypervisor_dmi(void)
 	free(buf);
 
 memory_scan:
+#if defined(__x86_64__) || defined(__i386__)
 	/* Fallback to memory scan (x86, x86_64) */
 	buf = get_mem_chunk(0xF0000, 0x10000, _PATH_DEV_MEM);
 	if (!buf)
@@ -275,7 +276,7 @@ memory_scan:
 		if (rc >= 0)
 			break;
 	}
-
+#endif
 done:
 	free(buf);
 	return rc;
-- 
1.8.5.3

