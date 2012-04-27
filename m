Return-Path: util-linux-owner@vger.kernel.org
Received: from damascus.uab.es ([158.109.168.135]:19554 "EHLO damascus.uab.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759923Ab2D0LXr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Apr 2012 07:23:47 -0400
Received: from damascus.uab.es ([127.0.0.1])
 by damascus.uab.es (Sun Java System Messaging Server 6.1 HotFix 0.10 (built
 Jan  6 2005)) with ESMTP id <0M34007GRYBLT100@damascus.uab.es> for
 util-linux@vger.kernel.org; Fri, 27 Apr 2012 13:23:45 +0200 (CEST)
Received: from aomail.uab.es ([158.109.65.1])
 by damascus.uab.es (Sun Java	System Messaging Server 6.1 HotFix 0.10 (builtJan
 6 2005)) with ESMTP id	<0M3400FHNYBLNG40@damascus.uab.es>
 forutil-linux@vger.kernel.org; Fri, 27 Apr 2012 13:23:45 +0200 (CEST)
Date: Fri, 27 Apr 2012 13:23:56 +0200
From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH 4/4] fdisk: remove dummy function
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1335525836.11068.7.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index a16b672..f603a31 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -2740,8 +2740,6 @@ print_all_partition_table_from_option(void)
 	fclose(procpt);
 }
 
-static void dummy(int *kk __attribute__ ((__unused__))) {}
-
 static void
 unknown_command(int c) {
 	printf(_("%c: unknown command\n"), c);
-- 
1.7.4.1




