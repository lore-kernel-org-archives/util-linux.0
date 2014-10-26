Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.187]:62163 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbaJZRla (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 26 Oct 2014 13:41:30 -0400
Received: from fungi.pizza.local (localhost [127.0.0.1])
	by fungi.pizza.local (8.14.8/8.14.8) with ESMTP id s9QHfPEQ000518
	for <util-linux@vger.kernel.org>; Sun, 26 Oct 2014 18:41:25 +0100 (CET)
Received: (from tobias@localhost)
	by fungi.pizza.local (8.14.8/8.14.8/Submit) id s9QHfOQU003440
	for util-linux@vger.kernel.org; Sun, 26 Oct 2014 18:41:24 +0100 (CET)
Date: Sun, 26 Oct 2014 18:41:24 +0100
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: lscpu: theoretical buffer overflow
Message-ID: <20141026174124.GA22563@fungi.pizza.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

there is a theoretical buffer overflow possible in the hypervisor
parsing code of lscpu.  It would require a proc entry to return way more
than expected so it's no high priority.  But better be safe than sorry.

At first I thought about switching to fgets but there is another
code file that adds a format specifier.  The diff is less intrusive
that way, too.


Tobias

---
 sys-utils/lscpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index ef59410..c272dc2 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -621,7 +621,7 @@ read_hypervisor_powerpc(struct lscpu_desc *desc)
 		fd = path_fopen("r", 0, _PATH_PROC_DEVICETREE "/ibm,partition-name");
 		if (fd) {
 			char buf[256];
-			if (fscanf(fd, "%s", buf) == 1 && !strcmp(buf, "full"))
+			if (fscanf(fd, "%255s", buf) == 1 && !strcmp(buf, "full"))
 				desc->virtype = VIRT_NONE;
 			fclose(fd);
 		}
@@ -757,7 +757,7 @@ read_hypervisor(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		if (fd) {
 			char buf[256];
 
-			if (fscanf(fd, "%s", buf) == 1 &&
+			if (fscanf(fd, "%255s", buf) == 1 &&
 			    !strcmp(buf, "control_d"))
 				dom0 = 1;
 			fclose(fd);
-- 
2.1.1

