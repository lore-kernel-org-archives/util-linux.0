Return-Path: util-linux-owner@vger.kernel.org
Received: from mailbigip.dreamhost.com ([208.97.132.5]:38608 "EHLO
	homiemail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757509Ab2FQQKX (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 17 Jun 2012 12:10:23 -0400
Subject: [PATCH 5/9] fdisk: sgi: remove unused code
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 17 Jun 2012 18:10:15 +0200
Message-ID: <1339949415.2668.17.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisksgilabel.c |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/fdisk/fdisksgilabel.c b/fdisk/fdisksgilabel.c
index 7db28d9..eee86c0 100644
--- a/fdisk/fdisksgilabel.c
+++ b/fdisk/fdisksgilabel.c
@@ -116,23 +116,6 @@ sgi_get_ntrks(struct fdisk_context *cxt) {
 	return SSWAP16(sgilabel->devparam.ntrks);
 }
 
-#if 0
-static int
-sgi_get_head_vol0(void) {
-	return SSWAP16(sgilabel->devparam.head_vol0);
-}
-
-static int
-sgi_get_bytes(void) {
-	return SSWAP16(sgilabel->devparam.bytes);
-}
-
-static int
-sgi_get_pcylcount(void) {
-	return SSWAP16(sgilabel->devparam.pcylcount);
-}
-#endif
-
 void
 sgi_nolabel(struct fdisk_context *cxt) {
 	sgilabel->magic = 0;
-- 
1.7.4.1




