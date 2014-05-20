Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:55575 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbaETPnI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 May 2014 11:43:08 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Stanislav Brabec <sbrabec@suse.cz>, Petr Uzel <petr.uzel@suse.cz>
Subject: [PATCH 4/5] lscpu: improve vmware detection
Date: Tue, 20 May 2014 15:42:30 +0000
Message-Id: <1400600551-7227-5-git-send-email-sweet_f_a@gmx.de>
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
 sys-utils/lscpu.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index b9e07e6..ee3ad19 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -32,6 +32,15 @@
 #include <stdarg.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <stdint.h>
+#include <signal.h>
+#include <strings.h>
+#include <setjmp.h>
+#if defined(__x86_64__) || defined(__i386__)
+#ifdef HAVE_sys_io_h
+#include <sys/io.h>
+#endif
+#endif
 
 #include <libsmartcols.h>
 
@@ -573,6 +582,57 @@ read_hypervisor_cpuid(struct lscpu_desc *desc)
 		desc->hyper = HYPER_VMWARE;
 }
 
+#define VMWARE_BDOOR_MAGIC          0x564D5868
+#define VMWARE_BDOOR_PORT           0x5658
+#define VMWARE_BDOOR_CMD_GETVERSION 10
+
+#define VMWARE_BDOOR(eax, ebx, ecx, edx)                                  \
+        __asm__("inl (%%dx)" :                                            \
+               "=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :               \
+               "0"(VMWARE_BDOOR_MAGIC), "1"(VMWARE_BDOOR_CMD_GETVERSION), \
+               "2"(VMWARE_BDOOR_PORT), "3"(0) :                           \
+               "memory");
+
+static jmp_buf segv_handler_env;
+
+static void
+segv_handler(int sig, siginfo_t *info, void *ignored)
+{
+	siglongjmp(segv_handler_env, 1);
+}
+
+static int
+is_vmware_platform(void)
+{
+	uint32_t eax, ebx, ecx, edx;
+	struct sigaction act, oact;
+
+	/*
+	 * The assembly routine for vmware detection works
+	 * fine under vmware, even if ran as regular user. But
+	 * on real HW or under other hypervisors, it segfaults (which is
+	 * expected). So we temporarily install SIGSEGV handler to catch
+	 * the signal. All this magic is needed because lscpu
+	 * isn't supposed to require root privileges.
+	 */
+	if (sigsetjmp(segv_handler_env, 1))
+		return 0;
+
+	bzero(&act, sizeof(act));
+	act.sa_sigaction = segv_handler;
+	act.sa_flags = SA_SIGINFO;
+
+	if (sigaction(SIGSEGV, &act, &oact))
+		err(EXIT_FAILURE, _("error: can not set signal handler"));
+
+	VMWARE_BDOOR(eax, ebx, ecx, edx);
+
+	if (sigaction(SIGSEGV, &oact, NULL))
+		err(EXIT_FAILURE, _("error: can not restore signal handler"));
+
+	return eax != (uint32_t)-1 && ebx == VMWARE_BDOOR_MAGIC;
+}
+
 #else	/* ! __x86_64__ */
 static void
 read_hypervisor_cpuid(struct lscpu_desc *desc __attribute__((__unused__)))
@@ -623,6 +683,11 @@ read_hypervisor_cpuid(struct lscpu_desc *desc __attribute__((__unused__)))
 	}
 #endif
 }
+
+static int is_vmware_platform(void)
+{
+	return 0;
+}
 #endif
 
 static void
@@ -659,6 +724,9 @@ read_hypervisor(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 	} else if (has_pci_device( hv_vendor_pci[HYPER_XEN], hv_graphics_pci[HYPER_XEN])) {
 		desc->hyper = HYPER_XEN;
 		desc->virtype = VIRT_FULL;
+	} else if (is_vmware_platform()) {
+		desc->hyper = HYPER_VMWARE;
+		desc->virtype = VIRT_FULL;
 	} else if (has_pci_device( hv_vendor_pci[HYPER_VMWARE], hv_graphics_pci[HYPER_VMWARE])) {
 		desc->hyper = HYPER_VMWARE;
 		desc->virtype = VIRT_FULL;
-- 
1.8.4.5

