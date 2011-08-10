Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110810083823.754430926@de.ibm.com>
Date: Wed, 10 Aug 2011 10:36:49 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 4/8] [PATCH] lscpu: detect IBM hypervisor
References: <20110810083645.135814950@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Detect if the hypervisor on s390 is from KVM or IBM.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -50,6 +50,7 @@
 #define _PATH_PROC_XENCAP	_PATH_PROC_XEN "/capabilities"
 #define _PATH_PROC_CPUINFO	"/proc/cpuinfo"
 #define _PATH_PROC_PCIDEVS	"/proc/bus/pci/devices"
+#define _PATH_PROC_SYSINFO	"/proc/sysinfo"
 
 /* virtualization types */
 enum {
@@ -69,14 +70,16 @@ enum {
 	HYPER_XEN,
 	HYPER_KVM,
 	HYPER_MSHV,
-	HYPER_VMWARE
+	HYPER_VMWARE,
+	HYPER_IBM
 };
 const char *hv_vendors[] = {
 	[HYPER_NONE]	= NULL,
 	[HYPER_XEN]	= "Xen",
 	[HYPER_KVM]	= "KVM",
 	[HYPER_MSHV]	= "Microsoft",
-	[HYPER_VMWARE]  = "VMware"
+	[HYPER_VMWARE]  = "VMware",
+	[HYPER_IBM]	= "IBM"
 };
 
 /* CPU modes */
@@ -598,6 +601,21 @@ read_hypervisor(struct lscpu_desc *desc)
 		/* Xen full-virt on non-x86_64 */
 		desc->hyper = HYPER_XEN;
 		desc->virtype = VIRT_FULL;
+	} else if (path_exist(_PATH_PROC_SYSINFO)) {
+		FILE *fd = path_fopen("r", 0, _PATH_PROC_SYSINFO);
+		char buf[BUFSIZ];
+
+		desc->hyper = HYPER_IBM;
+		desc->virtype = VIRT_FULL;
+		while (fgets(buf, sizeof(buf), fd) != NULL) {
+			if (!strstr(buf, "Control Program:"))
+				continue;
+			if (!strstr(buf, "KVM"))
+				desc->hyper = HYPER_IBM;
+			else
+				desc->hyper = HYPER_KVM;
+		}
+		fclose(fd);
 	}
 }
 
