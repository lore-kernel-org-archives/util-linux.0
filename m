Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:44018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753649AbdA3QDP (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 30 Jan 2017 11:03:15 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 89288ABD3
        for <util-linux@vger.kernel.org>; Mon, 30 Jan 2017 16:01:50 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] lscpu: Detect Windows Subsystem for Linux
Message-ID: <be1b17c6-5d87-a40d-e5a0-344282e21119@suse.cz>
Date: Mon, 30 Jan 2017 17:01:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Windows 10 implements Windows Subsystem for Linux (WSL).

WSL does not implement support for SIGSEGV handler, which is used inside
is_vmware_platform(). As a result, lscpu crashes there.

Implement WSL detection, and as a side effect, work around the crash.
Note that none of existing virtualization types exactly matches.
But the the closest would be "container".

References:

Provide a way to positively detect WSL from an app compiled on Linux.
https://github.com/Microsoft/BashOnWindows/issues/423

missing support for SIGSEGV handler
https://github.com/Microsoft/BashOnWindows/issues/1637

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/lscpu.c | 20 +++++++++++++++++++-
 sys-utils/lscpu.h |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 94cc00cf6..0ba815428 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -86,6 +86,7 @@
 #define _PATH_PROC_BC	"/proc/bc"
 #define _PATH_PROC_DEVICETREE	"/proc/device-tree"
 #define _PATH_DEV_MEM 		"/dev/mem"
+#define _PATH_PROC_OSRELEASE	"/proc/sys/kernel/osrelease"
 
 /* Xen Domain feature flag used for /sys/hypervisor/properties/features */
 #define XENFEAT_supervisor_mode_kernel		3
@@ -125,7 +126,8 @@ const char *hv_vendors[] = {
 	[HYPER_VBOX]	= "Oracle",
 	[HYPER_OS400]	= "OS/400",
 	[HYPER_PHYP]	= "pHyp",
-	[HYPER_SPAR]	= "Unisys s-Par"
+	[HYPER_SPAR]	= "Unisys s-Par",
+	[HYPER_WSL]	= "Windows Subsystem for Linux"
 };
 
 const int hv_vendor_pci[] = {
@@ -914,6 +916,22 @@ read_hypervisor(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 {
 	FILE *fd;
 
+	/* We have to detect WSL first. is_vmware_platform() crashes on Windows 10. */
+
+	if ((fd = path_fopen("r", 1, _PATH_PROC_OSRELEASE))) {
+		char buf[256];
+
+		if (fgets(buf, sizeof(buf), fd) != NULL) {
+			if (strstr(buf, "Microsoft")) {
+				desc->hyper = HYPER_WSL;
+				desc->virtype = VIRT_CONT;
+			}
+		}
+		fclose(fd);
+		if (desc->virtype)
+			return;
+	}
+
 	if (mod->system != SYSTEM_SNAPSHOT) {
 		read_hypervisor_cpuid(desc);
 		if (!desc->hyper)
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index b9aa25562..4906c2636 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -18,6 +18,7 @@ enum {
 	HYPER_OS400,
 	HYPER_PHYP,
 	HYPER_SPAR,
+	HYPER_WSL,
 };
 
 extern int read_hypervisor_dmi(void);
-- 
2.11.0

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
