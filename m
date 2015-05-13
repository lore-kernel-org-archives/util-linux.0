Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33686 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934073AbbEMDPn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 12 May 2015 23:15:43 -0400
Received: by pacwv17 with SMTP id wv17so35711309pac.0
        for <util-linux@vger.kernel.org>; Tue, 12 May 2015 20:15:43 -0700 (PDT)
From: WANG Chao <wcwxyz@gmail.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] lscpu: add cpu flags entry to summary output
Date: Wed, 13 May 2015 11:15:05 +0800
Message-Id: <1431486905-63291-1-git-send-email-wcwxyz@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It'd be convenient to have unified cpu "Flags: " entry in the summary
output.

Signed-off-by: WANG Chao <wcwxyz@gmail.com>
---
 sys-utils/lscpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index fd94d1a..b36d1da 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1634,6 +1634,9 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		snprintf(buf, sizeof(buf), _("NUMA node%d CPU(s):"), desc->idx2nodenum[i]);
 		print_cpuset(buf, desc->nodemaps[i], mod->hex);
 	}
+
+	if (desc->flags)
+		print_s(_("Flags:"), desc->flags);
 }
 
 static void __attribute__((__noreturn__)) usage(FILE *out)
-- 
2.3.0

