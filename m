Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f53.google.com ([74.125.82.53]:39888 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650Ab3G1VL1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Jul 2013 17:11:27 -0400
Received: by mail-wg0-f53.google.com with SMTP id c11so4276259wgh.8
        for <util-linux@vger.kernel.org>; Sun, 28 Jul 2013 14:11:26 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/7] lscpu: fix shadow declaration [smatch scan]
Date: Sun, 28 Jul 2013 22:11:15 +0100
Message-Id: <1375045881-11978-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

sys-utils/lscpu.c:572:22: warning: symbol 'fd' shadows an earlier one

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/lscpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index fbaaa31..98cee16 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -569,15 +569,15 @@ read_hypervisor(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 
 	/* IBM PR/SM */
 	} else if (path_exist(_PATH_PROC_SYSINFO)) {
-		FILE *fd = path_fopen("r", 0, _PATH_PROC_SYSINFO);
+		FILE *sysinfo_fd = path_fopen("r", 0, _PATH_PROC_SYSINFO);
 		char buf[BUFSIZ];
 
-		if (!fd)
+		if (!sysinfo_fd)
 			return;
 		desc->hyper = HYPER_IBM;
 		desc->hypervisor = "PR/SM";
 		desc->virtype = VIRT_FULL;
-		while (fgets(buf, sizeof(buf), fd) != NULL) {
+		while (fgets(buf, sizeof(buf), sysinfo_fd) != NULL) {
 			char *str;
 
 			if (!strstr(buf, "Control Program:"))
@@ -601,7 +601,7 @@ read_hypervisor(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 			while ((str = strstr(desc->hypervisor, "  ")))
 				memmove(str, str + 1, strlen(str));
 		}
-		fclose(fd);
+		fclose(sysinfo_fd);
 	}
 
 	/* OpenVZ/Virtuozzo - /proc/vz dir should exist
-- 
1.8.3.4

