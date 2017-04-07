Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:64728 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932247AbdDGLgF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 7 Apr 2017 07:36:05 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 2/2] chmem: don't use scanf format for printf
Date: Fri,  7 Apr 2017 13:35:59 +0200
Message-Id: <20170407113559.16107-2-sweet_f_a@gmx.de>
In-Reply-To: <20170407113559.16107-1-sweet_f_a@gmx.de>
References: <20170407113559.16107-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

The compiler had not complained here because both macros are
probably the same.

But gettext issued a funny warning:
sys-utils/chmem.c:67: warning: Although being used in a format string position, the msgid is not a valid C format string. Reason: The string ends in the middle of a directive.

CC: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/chmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/chmem.c b/sys-utils/chmem.c
index ad394ac4c..44733bf76 100644
--- a/sys-utils/chmem.c
+++ b/sys-utils/chmem.c
@@ -64,7 +64,7 @@ static void idxtostr(struct chmem_desc *desc, uint64_t idx, char *buf, size_t bu
 	start = idx * desc->block_size;
 	end = start + desc->block_size - 1;
 	snprintf(buf, bufsz,
-		 _("Memory Block %"SCNu64" (0x%016"PRIx64"-0x%016"PRIx64")"),
+		 _("Memory Block %"PRIu64" (0x%016"PRIx64"-0x%016"PRIx64")"),
 		 idx, start, end);
 }
 
-- 
2.12.0

