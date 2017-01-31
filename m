Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:47561 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751448AbdAaQm6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 31 Jan 2017 11:42:58 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E120EAAA3
        for <util-linux@vger.kernel.org>; Tue, 31 Jan 2017 16:42:56 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] lscpu: Fix regression caused by WSL detection
Message-ID: <39000ad3-20c6-0388-3fac-d96327df3793@suse.cz>
Date: Tue, 31 Jan 2017 17:42:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Commit 7572fb2b8cb69512ca230b7fcfa11577526843f4 introduced a failure on missing
/proc/sys/kernel/osrelease. Make it non-fatal to prevent crash in some chroot
environments.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/lscpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 318e93b43..1770872d5 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -917,9 +917,8 @@ read_hypervisor(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 	FILE *fd;
 
 	/* We have to detect WSL first. is_vmware_platform() crashes on Windows 10. */
-
 	if (path_exist(_PATH_PROC_OSRELEASE)
-	    && (fd = path_fopen("r", 1, _PATH_PROC_OSRELEASE))) {
+	    && (fd = path_fopen("r", 0, _PATH_PROC_OSRELEASE))) {
 		char buf[256];
 
 		if (fgets(buf, sizeof(buf), fd) != NULL) {
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
