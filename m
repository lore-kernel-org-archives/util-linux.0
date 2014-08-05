Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:58411 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753607AbaHEW7w (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 5 Aug 2014 18:59:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 2BE8F3401CF
	for <util-linux@vger.kernel.org>; Tue,  5 Aug 2014 22:59:47 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] lscpu: clean up vmware inline asm
Date: Tue,  5 Aug 2014 18:59:50 -0400
Message-Id: <1407279590-4224-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This code is not PIC clean which means it fails to build on hardened
32bit x86 systems (i.e. building as PIE).

While here, optimize the existing cpuid logic slightly.

URL: https://bugs.gentoo.org/518936
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sys-utils/lscpu.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 062dff5..9965eeb 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -546,10 +546,9 @@ cpuid(unsigned int op, unsigned int *eax, unsigned int *ebx,
 	__asm__(
 #if defined(__PIC__) && defined(__i386__)
 		/* x86 PIC cannot clobber ebx -- gcc bitches */
-		"pushl %%ebx;"
+		"xchg %%ebx, %%esi;"
 		"cpuid;"
-		"movl %%ebx, %%esi;"
-		"popl %%ebx;"
+		"xchg %%esi, %%ebx;"
 		: "=S" (*ebx),
 #else
 		"cpuid;"
@@ -656,12 +655,29 @@ read_hypervisor_powerpc(struct lscpu_desc *desc)
 #define VMWARE_BDOOR_PORT           0x5658
 #define VMWARE_BDOOR_CMD_GETVERSION 10
 
-#define VMWARE_BDOOR(eax, ebx, ecx, edx)                                  \
-        __asm__("inl (%%dx), %%eax" :                                     \
-               "=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :               \
-               "0"(VMWARE_BDOOR_MAGIC), "1"(VMWARE_BDOOR_CMD_GETVERSION), \
-               "2"(VMWARE_BDOOR_PORT), "3"(0) :                           \
-               "memory");
+static inline
+void vmware_bdoor(uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx)
+{
+	__asm__(
+#if defined(__PIC__) && defined(__i386__)
+		/* x86 PIC cannot clobber ebx -- gcc bitches */
+		"xchg %%ebx, %%esi;"
+		"inl (%%dx), %%eax;"
+		"xchg %%esi, %%ebx;"
+		: "=S" (*ebx),
+#else
+		"inl (%%dx), %%eax;"
+		: "=b" (*ebx),
+#endif
+		  "=a" (*eax),
+		  "=c" (*ecx),
+		  "=d" (*edx)
+		: "0" (VMWARE_BDOOR_MAGIC),
+		  "1" (VMWARE_BDOOR_CMD_GETVERSION),
+		  "2" (VMWARE_BDOOR_PORT),
+		  "3" (0)
+		: "memory");
+}
 
 static jmp_buf segv_handler_env;
 
@@ -697,7 +713,7 @@ is_vmware_platform(void)
 	if (sigaction(SIGSEGV, &act, &oact))
 		err(EXIT_FAILURE, _("error: can not set signal handler"));
 
-	VMWARE_BDOOR(eax, ebx, ecx, edx);
+	vmware_bdoor(&eax, &ebx, &ecx, &edx);
 
 	if (sigaction(SIGSEGV, &oact, NULL))
 		err(EXIT_FAILURE, _("error: can not restore signal handler"));
-- 
2.0.0

