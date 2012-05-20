Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdccac.dreamhost.com ([208.97.132.202]:34626 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753777Ab2ETQLg (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 20 May 2012 12:11:36 -0400
Subject: [PATCH 4/6] fdisk: use BSD label header
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 20 May 2012 18:11:33 +0200
Message-ID: <1337530293.2677.15.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Move bsd specific function definitions into its own header file and include it in fdisk code.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c         |    1 +
 fdisk/fdisk.h         |    6 ------
 fdisk/fdiskbsdlabel.h |    5 +++++
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 08afb45..b6c5758 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -39,6 +39,7 @@
 #include "fdiskaixlabel.h"
 #include "fdiskmaclabel.h"
 #include "fdiskdoslabel.h"
+#include "fdiskbsdlabel.h"
 
 #ifdef HAVE_LINUX_COMPILER_H
 #include <linux/compiler.h>
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index 0dafbf8..82888dc 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -185,9 +185,3 @@ static inline int is_cleared_partition(struct partition *p)
 		 p->sys_ind || p->end_head || p->end_sector || p->end_cyl ||
 		 get_start_sect(p) || get_nr_sects(p));
 }
-
-/* prototypes for fdiskbsdlabel.c */
-extern void bsd_command_prompt(void);
-extern int check_osf_label(void);
-extern int btrydev(char * dev);
-extern void xbsd_print_disklabel(int);
diff --git a/fdisk/fdiskbsdlabel.h b/fdisk/fdiskbsdlabel.h
index e58e2ff..9bea7cf 100644
--- a/fdisk/fdiskbsdlabel.h
+++ b/fdisk/fdiskbsdlabel.h
@@ -238,4 +238,9 @@ static struct systypes xbsd_fstypes[] = {
 #define	BSD_D_CHAIN    	0x10		/* can do back-back transfers */
 #define	BSD_D_DOSPART	0x20		/* within MSDOS partition */
 
+extern void bsd_command_prompt(void);
+extern int check_osf_label(void);
+extern int btrydev(char * dev);
+extern void xbsd_print_disklabel(int);
+
 #endif /* FDISK_BSD_LABEL_H */
-- 
1.7.4.1




