Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:53794 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbaETPnB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 May 2014 11:43:01 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Stanislav Brabec <sbrabec@suse.cz>, Petr Uzel <petr.uzel@suse.cz>
Subject: [PATCH 3/5] lscpu: detect OS/400 and pHyp hypervisors
Date: Tue, 20 May 2014 15:42:29 +0000
Message-Id: <1400600551-7227-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de>
References: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This patch comes from openSUSE / SLE. Original author was probably
Petr Uzel.
Internal SUSE references: fate310255, sr226509

CC: Stanislav Brabec <sbrabec@suse.cz>
CC: Petr Uzel <petr.uzel@suse.cz>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/lscpu.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 sys-utils/lscpu.h |  4 +++-
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 0203916..b9e07e6 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -60,6 +60,7 @@
 #define _PATH_PROC_STATUS	"/proc/self/status"
 #define _PATH_PROC_VZ	"/proc/vz"
 #define _PATH_PROC_BC	"/proc/bc"
+#define _PATH_PROC_DEVICETREE	"/proc/device-tree"
 #define _PATH_DEV_MEM 		"/dev/mem"
 
 /* virtualization types */
@@ -88,7 +89,9 @@ const char *hv_vendors[] = {
 	[HYPER_INNOTEK]	= "Innotek GmbH",
 	[HYPER_HITACHI]	= "Hitachi",
 	[HYPER_PARALLELS] = "Parallels",
-	[HYPER_VBOX]	= "Oracle"
+	[HYPER_VBOX]	= "Oracle",
+	[HYPER_OS400]	= "OS/400",
+	[HYPER_PHYP]	= "pHyp"
 };
 
 const int hv_vendor_pci[] = {
@@ -574,6 +577,51 @@ read_hypervisor_cpuid(struct lscpu_desc *desc)
 static void
 read_hypervisor_cpuid(struct lscpu_desc *desc __attribute__((__unused__)))
 {
+#ifdef __powerpc__
+	/* powerpc:
+	 * IBM iSeries: legacy, if /proc/iSeries exists, its para-virtualized on top of OS/400
+	 * IBM pSeries: always has a hypervisor
+	 *              if partition-name is "full", its kind of "bare-metal": full-system-partition
+	 *              otherwise its some partition created by Hardware Management Console
+	 *              in any case, its always some sort of HVM
+	 * KVM: "linux,kvm" in /hypervisor/compatible indicates a KVM guest
+	 * Xen: not in use, not detected
+	 */
+	if (path_exist("/proc/iSeries")) {
+		desc->hyper = HYPER_OS400;
+		desc->virtype = VIRT_FULL;
+	} else if (path_exist(_PATH_PROC_DEVICETREE "/ibm,partition-name")) {
+		FILE *fd;
+		desc->hyper = HYPER_PHYP;
+		desc->virtype = VIRT_FULL;
+		fd = fopen(_PATH_PROC_DEVICETREE "/ibm,partition-name", "r");
+		if (fd) {
+			char buf[256];
+			if (fscanf(fd, "%s", buf) == 1 && !strcmp(buf, "full"))
+				desc->virtype = VIRT_NONE;
+			fclose(fd);
+		}
+	} else if (path_exist(_PATH_PROC_DEVICETREE "/hypervisor/compatible")) {
+		FILE *fd;
+		fd = fopen(_PATH_PROC_DEVICETREE "/hypervisor/compatible", "r");
+		if (fd) {
+			char buf[256];
+			int i;
+			memset(buf, 0, sizeof(buf));
+			fread(buf, sizeof(buf) - 1, 1, fd);
+			fclose(fd);
+			for (i = 0; i < sizeof(buf);) {
+				if (!strcmp(&buf[i], "linux,kvm")) {
+					desc->hyper = HYPER_KVM;
+					desc->virtype = VIRT_FULL;
+					break;
+				}
+				i += strlen(&buf[i]);
+				i++;
+			}
+		}
+	}
+#endif
 }
 #endif
 
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index 7bb538d..6c25c4f 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -14,7 +14,9 @@ enum {
 	HYPER_INNOTEK,		/* VBOX */
 	HYPER_HITACHI,
 	HYPER_PARALLELS,	/* OpenVZ/VIrtuozzo */
-	HYPER_VBOX
+	HYPER_VBOX,
+	HYPER_OS400,
+	HYPER_PHYP
 };
 
 extern int read_hypervisor_dmi(void);
-- 
1.8.4.5

