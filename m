Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:62293 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753470AbaETPmt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 May 2014 11:42:49 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Stanislav Brabec <sbrabec@suse.cz>, Petr Uzel <petr.uzel@suse.cz>
Subject: [PATCH 1/5] lscpu: minor cleanup and improve hypervisor detection
Date: Tue, 20 May 2014 15:42:27 +0000
Message-Id: <1400600551-7227-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de>
References: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

- add HYPER_VBOX
- improve HYPER_VMWARE

This patch comes from openSUSE / SLE. Original author was probably
Petr Uzel.
Internal SUSE references: fate310255, sr226509

CC: Stanislav Brabec <sbrabec@suse.cz>
CC: Petr Uzel <petr.uzel@suse.cz>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/lscpu.c | 29 +++++++++++++++++++++++++++--
 sys-utils/lscpu.h |  3 ++-
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index ad1a6b3..0203916 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -87,7 +87,26 @@ const char *hv_vendors[] = {
 	[HYPER_UML]	= "User-mode Linux",
 	[HYPER_INNOTEK]	= "Innotek GmbH",
 	[HYPER_HITACHI]	= "Hitachi",
-	[HYPER_PARALLELS] = "Parallels"
+	[HYPER_PARALLELS] = "Parallels",
+	[HYPER_VBOX]	= "Oracle"
+};
+
+const int hv_vendor_pci[] = {
+	[HYPER_NONE]	= 0x0000,
+	[HYPER_XEN]	= 0x5853,
+	[HYPER_KVM]	= 0x0000,
+	[HYPER_MSHV]	= 0x1414,
+	[HYPER_VMWARE]	= 0x15ad,
+	[HYPER_VBOX]	= 0x80ee
+};
+
+const int hv_graphics_pci[] = {
+	[HYPER_NONE]	= 0x0000,
+	[HYPER_XEN]	= 0x0001,
+	[HYPER_KVM]	= 0x0000,
+	[HYPER_MSHV]	= 0x5353,
+	[HYPER_VMWARE]	= 0x0710,
+	[HYPER_VBOX]	= 0xbeef
 };
 
 /* CPU modes */
@@ -589,9 +608,15 @@ read_hypervisor(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		desc->hyper = HYPER_XEN;
 
 	/* Xen full-virt on non-x86_64 */
-	} else if (has_pci_device(0x5853, 0x0001)) {
+	} else if (has_pci_device( hv_vendor_pci[HYPER_XEN], hv_graphics_pci[HYPER_XEN])) {
 		desc->hyper = HYPER_XEN;
 		desc->virtype = VIRT_FULL;
+	} else if (has_pci_device( hv_vendor_pci[HYPER_VMWARE], hv_graphics_pci[HYPER_VMWARE])) {
+		desc->hyper = HYPER_VMWARE;
+		desc->virtype = VIRT_FULL;
+	} else if (has_pci_device( hv_vendor_pci[HYPER_VBOX], hv_graphics_pci[HYPER_VBOX])) {
+		desc->hyper = HYPER_VBOX;
+		desc->virtype = VIRT_FULL;
 
 	/* IBM PR/SM */
 	} else if (path_exist(_PATH_PROC_SYSINFO)) {
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index 312038f..7bb538d 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -13,7 +13,8 @@ enum {
 	HYPER_UML,
 	HYPER_INNOTEK,		/* VBOX */
 	HYPER_HITACHI,
-	HYPER_PARALLELS		/* OpenVZ/VIrtuozzo */
+	HYPER_PARALLELS,	/* OpenVZ/VIrtuozzo */
+	HYPER_VBOX
 };
 
 extern int read_hypervisor_dmi(void);
-- 
1.8.4.5

