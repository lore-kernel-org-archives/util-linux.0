Return-Path: util-linux-owner@vger.kernel.org
Received: from mail1.bemta12.messagelabs.com ([216.82.251.12]:50104 "EHLO
	mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751439AbbBJVMb (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Feb 2015 16:12:31 -0500
From: Benjamin Romer <benjamin.romer@unisys.com>
To: <util-linux@vger.kernel.org>
CC: <sparmaintainer@unisys.com>, Benjamin Romer <benjamin.romer@unisys.com>
Subject: [PATCH] lscpu: add s-Par support
Date: Tue, 10 Feb 2015 16:04:09 -0500
Message-ID: <1423602249-24664-1-git-send-email-benjamin.romer@unisys.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Adds support for the s-Par firmware's hypervisor leaf.

Signed-off-by: Benjamin Romer <benjamin.romer@unisys.com>
---
 sys-utils/lscpu.c | 3 +++
 sys-utils/lscpu.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index c272dc2..6af49d6 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -107,6 +107,7 @@ const char *hv_vendors[] = {
 	[HYPER_VBOX]	= "Oracle",
 	[HYPER_OS400]	= "OS/400",
 	[HYPER_PHYP]	= "pHyp",
+	[HYPER_SPAR]	= "Unisys s-Par"
 };
 
 const int hv_vendor_pci[] = {
@@ -585,6 +586,8 @@ read_hypervisor_cpuid(struct lscpu_desc *desc)
 		desc->hyper = HYPER_MSHV;
 	else if (!strncmp("VMwareVMware", hyper_vendor_id, 12))
 		desc->hyper = HYPER_VMWARE;
+	else if (!strncmp("UnisysSpar64", hyper_vendor_id, 12))
+		desc->hyper = HYPER_SPAR;
 }
 
 #else /* ! (__x86_64__ || __i386__) */
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index e340291..b9aa255 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -17,6 +17,7 @@ enum {
 	HYPER_VBOX,
 	HYPER_OS400,
 	HYPER_PHYP,
+	HYPER_SPAR,
 };
 
 extern int read_hypervisor_dmi(void);
-- 
2.1.0

