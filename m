Return-Path: util-linux-owner@vger.kernel.org
Received: from aserp1040.oracle.com ([141.146.126.69]:33926 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbcCVFhU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Mar 2016 01:37:20 -0400
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u2M5bJ1D007930
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 22 Mar 2016 05:37:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u2M5bI09004476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <util-linux@vger.kernel.org>; Tue, 22 Mar 2016 05:37:19 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id u2M5bIdj031440
	for <util-linux@vger.kernel.org>; Tue, 22 Mar 2016 05:37:18 GMT
From: Dongli Zhang <dongli.zhang@oracle.com>
To: util-linux@vger.kernel.org
Cc: dongli.zhang@oracle.com
Subject: [PATCH v2 1/1] lscpu: correct the Virtualization type on Xen DomU PV guest
Date: Tue, 22 Mar 2016 13:38:14 +0800
Message-Id: <1458625094-13267-1-git-send-email-dongli.zhang@oracle.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Nowadays, most Intel CPUs have "cpuid faulting" available which could trap
the execution of "cpuid" instruction when CPL>0  with GP fault. Thus,
"cpuid" instruction could trap to Xen hypervisor on the paravirtualized PV
guest on most servers today, except on old CPUs prior to 2011. On CPU after
2011, Xen will put "XenVMMXenVMM" on both HVM and PV guests, which could
have lscpu command erroneously classify the guest as type "full".  The
current lscpu command, which is based on "cpuid" instruction, still assumes
that it will not cause the trap to Xen hypervisor on Xen PV guest and uses
/proc/xen to identify whether it's running on PV DomU or not.  To identify
this kind of information under the help of
/sys/hypervisor/properties/features would be more accurate for the CPU
nowadays. The bit 5 (XENFEAT_mmu_pt_update_preserve_ad) of the features
will be set only when it's running on Xen PV domain. The combo of bit 3 and
8 (XENFEAT_supervisor_mode_kernel and XENFEAT_hvm_callback_vector) will be
set simultaneously only when it's running on Xen PVH domain.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 sys-utils/lscpu.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 36e36c9..0df8af9 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -73,6 +73,7 @@
 
 /* /sys paths */
 #define _PATH_SYS_SYSTEM	"/sys/devices/system"
+#define _PATH_SYS_HYP_FEATURES "/sys/hypervisor/properties/features"
 #define _PATH_SYS_CPU		_PATH_SYS_SYSTEM "/cpu"
 #define _PATH_SYS_NODE		_PATH_SYS_SYSTEM "/node"
 #define _PATH_PROC_XEN		"/proc/xen"
@@ -86,6 +87,15 @@
 #define _PATH_PROC_DEVICETREE	"/proc/device-tree"
 #define _PATH_DEV_MEM 		"/dev/mem"
 
+/* Xen Domain feature flag used for /sys/hypervisor/properties/features */
+#define XENFEAT_supervisor_mode_kernel		3
+#define XENFEAT_mmu_pt_update_preserve_ad	5
+#define XENFEAT_hvm_callback_vector			8
+
+#define XEN_FEATURES_PV_MASK	(1U << XENFEAT_mmu_pt_update_preserve_ad)
+#define XEN_FEATURES_PVH_MASK	( (1U << XENFEAT_supervisor_mode_kernel) \
+								| (1U << XENFEAT_hvm_callback_vector) )
+
 /* virtualization types */
 enum {
 	VIRT_NONE	= 0,
@@ -811,10 +821,28 @@ read_hypervisor(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 			desc->hyper = HYPER_VMWARE;
 	}
 
-	if (desc->hyper)
+	if (desc->hyper) {
 		desc->virtype = VIRT_FULL;
 
-	else if (read_hypervisor_powerpc(desc) > 0) {}
+		if (desc->hyper == HYPER_XEN) {
+			uint32_t features;
+
+			fd = path_fopen("r", 0, _PATH_SYS_HYP_FEATURES);
+			if (fd && fscanf(fd, "%x", &features) == 1) {
+				/* Xen PV domain */
+				if (features & XEN_FEATURES_PV_MASK)
+					desc->virtype = VIRT_PARA;
+				/* Xen PVH domain */
+				else if ((features & XEN_FEATURES_PVH_MASK)
+								== XEN_FEATURES_PVH_MASK)
+					desc->virtype = VIRT_PARA;
+				fclose(fd);
+			} else {
+				err(EXIT_FAILURE, _("failed to read from: %s"),
+						_PATH_SYS_HYP_FEATURES);
+			}
+		}
+	} else if (read_hypervisor_powerpc(desc) > 0) {}
 
 	/* Xen para-virt or dom0 */
 	else if (path_exist(_PATH_PROC_XEN)) {
-- 
1.9.1

