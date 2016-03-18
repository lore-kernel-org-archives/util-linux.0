Return-Path: util-linux-owner@vger.kernel.org
Received: from userp1040.oracle.com ([156.151.31.81]:16451 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbcCRGwf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Mar 2016 02:52:35 -0400
From: Dongli Zhang <dongli.zhang@oracle.com>
To: util-linux@vger.kernel.org, qcai@redhat.com
Cc: dongli.zhang@oracle.com
Subject: [PATCH 1/1] lscpu: correct the Virtualization type on Xen DomU PV guest
Date: Fri, 18 Mar 2016 14:53:24 +0800
Message-Id: <1458284004-17357-1-git-send-email-dongli.zhang@oracle.com>
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
nowadays.  The bit 10 (XENFEAT_hvm_pirqs) of
/sys/hypervisor/properties/features will be set only when it's running on
Xen HVM domain.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 sys-utils/lscpu.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 36e36c9..faa86bc 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -73,6 +73,7 @@
 
 /* /sys paths */
 #define _PATH_SYS_SYSTEM	"/sys/devices/system"
+#define _PATH_SYS_HYP_FEATURES "/sys/hypervisor/properties/features"
 #define _PATH_SYS_CPU		_PATH_SYS_SYSTEM "/cpu"
 #define _PATH_SYS_NODE		_PATH_SYS_SYSTEM "/node"
 #define _PATH_PROC_XEN		"/proc/xen"
@@ -86,6 +87,9 @@
 #define _PATH_PROC_DEVICETREE	"/proc/device-tree"
 #define _PATH_DEV_MEM 		"/dev/mem"
 
+/* Xen Domain feature flag used for /sys/hypervisor/properties/features */
+#define XENFEAT_hvm_pirqs	10
+
 /* virtualization types */
 enum {
 	VIRT_NONE	= 0,
@@ -811,10 +815,20 @@ read_hypervisor(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 			desc->hyper = HYPER_VMWARE;
 	}
 
-	if (desc->hyper)
+	if (desc->hyper) {
 		desc->virtype = VIRT_FULL;
-
-	else if (read_hypervisor_powerpc(desc) > 0) {}
+		if (desc->hyper == HYPER_XEN) {
+			unsigned int features;
+
+			fd = path_fopen("r", 0, _PATH_SYS_HYP_FEATURES);
+			if (fd && fscanf(fd, "%x", &features) == 1) {
+				/* Xen para-virt (or pvh) */
+				if (!(features & (1U << XENFEAT_hvm_pirqs)))
+					desc->virtype = VIRT_PARA;
+				fclose(fd);
+			}
+		}
+	} else if (read_hypervisor_powerpc(desc) > 0) {}
 
 	/* Xen para-virt or dom0 */
 	else if (path_exist(_PATH_PROC_XEN)) {
-- 
1.9.1

