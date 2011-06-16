Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.vyatta.com ([76.74.103.46]:57461 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758080Ab1FPUyD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 16 Jun 2011 16:54:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.vyatta.com (Postfix) with ESMTP id 4FADB182970D
	for <util-linux@vger.kernel.org>; Thu, 16 Jun 2011 13:54:02 -0700 (PDT)
Received: from mail.vyatta.com ([127.0.0.1])
	by localhost (mail.vyatta.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AJbUq-xViyhF for <util-linux@vger.kernel.org>;
	Thu, 16 Jun 2011 13:54:01 -0700 (PDT)
Received: from s6510.ftrdhcpuser.net (static-50-53-80-93.bvtn.or.frontiernet.net [50.53.80.93])
	by mail.vyatta.com (Postfix) with ESMTPSA id 85CDE1829118
	for <util-linux@vger.kernel.org>; Thu, 16 Jun 2011 13:54:01 -0700 (PDT)
Date: Thu, 16 Jun 2011 16:54:07 -0400
From: Stephen Hemminger <shemminger@vyatta.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] lscpu: detect VMware hypervisor
Message-ID: <20110616165407.00c4d7ab@s6510.ftrdhcpuser.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add detection of VMware.
Tested on VMware Workstation 7.1.4
---
 sys-utils/lscpu.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 0d94883..8edf997 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -66,13 +66,15 @@ enum {
 	HYPER_NONE	= 0,
 	HYPER_XEN,
 	HYPER_KVM,
-	HYPER_MSHV
+	HYPER_MSHV,
+	HYPER_VMWARE
 };
 const char *hv_vendors[] = {
 	[HYPER_NONE]	= NULL,
 	[HYPER_XEN]	= "Xen",
 	[HYPER_KVM]	= "KVM",
-	[HYPER_MSHV]	= "Microsoft"
+	[HYPER_MSHV]	= "Microsoft",
+	[HYPER_VMWARE]  = "VMware"
 };
 
 /* CPU modes */
@@ -511,6 +513,8 @@ read_hypervisor_cpuid(struct lscpu_desc *desc)
 		desc->hyper = HYPER_KVM;
 	else if (!strncmp("Microsoft Hv", hyper_vendor_id, 12))
 		desc->hyper = HYPER_MSHV;
+	else if (!strncmp("VMwareVMware", hyper_vendor_id, 12))
+		desc->hyper = HYPER_VMWARE;
 }
 
 #else	/* ! __x86_64__ */
-- 
1.7.2.5


