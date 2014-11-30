Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:61579 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbaK3N6O (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 30 Nov 2014 08:58:14 -0500
Received: by mail-wg0-f50.google.com with SMTP id k14so11978572wgh.23
        for <util-linux@vger.kernel.org>; Sun, 30 Nov 2014 05:58:13 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 09/10] lscpu: blacklist vmware_bdoor() AddressSanitizer check
Date: Sun, 30 Nov 2014 13:57:41 +0000
Message-Id: <1417355862-16935-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

AddressSanitizer is identifying the __asm__ segment as suspicious.

==1215==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000
(pc 0x0000004ccffd bp 0x7fff9b7184f0 sp 0x7fff9b7184e0 T0)
    #0 0x4ccffc in vmware_bdoor /home/src/util-linux/sys-utils/lscpu.c:660

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/lscpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index c272dc2..c7d6f9f 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -655,7 +655,7 @@ read_hypervisor_powerpc(struct lscpu_desc *desc)
 #define VMWARE_BDOOR_PORT           0x5658
 #define VMWARE_BDOOR_CMD_GETVERSION 10
 
-static inline
+static inline UL_ASAN_BLACKLIST
 void vmware_bdoor(uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx)
 {
 	__asm__(
-- 
2.1.3

