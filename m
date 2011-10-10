Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:33418 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754061Ab1JJNMU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Oct 2011 09:12:20 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 06C488F3B5
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 15:12:19 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 2/2] fdisk: plug memory leak
Date: Mon, 10 Oct 2011 15:12:18 +0200
Message-Id: <1318252338-11200-2-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1318252338-11200-1-git-send-email-petr.uzel@suse.cz>
References: <1318252338-11200-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Plugs memory leak in fdisk. Very minor fix, but at least
makes valgrind happy.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisk/fdisk.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index a20a396..4d1b8c0 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1158,6 +1158,14 @@ static void init_mbr_buffer(void)
 	MBRbuffer = xcalloc(1, MAX_SECTOR_SIZE);
 }
 
+static void free_mbr_buffer(void)
+{
+	if (MBRbuffer) {
+		free(MBRbuffer);
+		MBRbuffer = NULL;
+	}
+}
+
 void zeroize_mbr_buffer(void)
 {
 	if (MBRbuffer)
@@ -3028,6 +3036,7 @@ main(int argc, char **argv) {
 #endif
 
 	init_mbr_buffer();
+	atexit(free_mbr_buffer);
 
 	if (optl) {
 		nowarn = 1;
-- 
1.7.3.4

