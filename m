Return-Path: util-linux-owner@vger.kernel.org
Received: from mailbigip.dreamhost.com ([208.97.132.5]:38619 "EHLO
	homiemail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757509Ab2FQQK1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 17 Jun 2012 12:10:27 -0400
Subject: [PATCH 6/9] fdisk: sgi: remove unused function
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 17 Jun 2012 18:10:22 +0200
Message-ID: <1339949422.2668.18.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisksgilabel.c |    6 ------
 fdisk/fdisksgilabel.h |    1 -
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/fdisk/fdisksgilabel.c b/fdisk/fdisksgilabel.c
index eee86c0..b7c1db2 100644
--- a/fdisk/fdisksgilabel.c
+++ b/fdisk/fdisksgilabel.c
@@ -116,12 +116,6 @@ sgi_get_ntrks(struct fdisk_context *cxt) {
 	return SSWAP16(sgilabel->devparam.ntrks);
 }
 
-void
-sgi_nolabel(struct fdisk_context *cxt) {
-	sgilabel->magic = 0;
-	partitions = 4;
-}
-
 static unsigned int
 two_s_complement_32bit_sum(unsigned int *base, int size /* in bytes */) {
 	int i = 0;
diff --git a/fdisk/fdisksgilabel.h b/fdisk/fdisksgilabel.h
index dff32b1..0c76edb 100644
--- a/fdisk/fdisksgilabel.h
+++ b/fdisk/fdisksgilabel.h
@@ -111,7 +111,6 @@ typedef struct {
 
 /* fdisksgilabel.c */
 extern struct	systypes sgi_sys_types[];
-extern void	sgi_nolabel(struct fdisk_context *cxt);
 extern int	check_sgi_label(struct fdisk_context *cxt);
 extern void	sgi_list_table( struct fdisk_context *cxt, int xtra );
 extern int  sgi_change_sysid(struct fdisk_context *cxt, int i, int sys);
-- 
1.7.4.1




