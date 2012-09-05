Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:49245 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab2IENMX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 5 Sep 2012 09:12:23 -0400
From: Bernhard Voelker <mail@bernhard-voelker.de>
To: util-linux@vger.kernel.org
Cc: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: [PATCH] sys-utils/ipcrm: avoid 'uninitialized' warning
Date: Wed,  5 Sep 2012 15:12:01 +0200
Message-Id: <1346850721-27107-1-git-send-email-mail@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

GCC 4.1.2 on SLES 10.4:
sys-utils/ipcrm.c: In function ‘main’:
sys-utils/ipcrm.c:297: warning: ‘what_all’ may be used uninitialized in this function

* sys-utils/ipcrm.c: Initialize what_all to ALL.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 sys-utils/ipcrm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index 7807bd4..6a1ac0d 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -294,7 +294,7 @@ int main(int argc, char **argv)
 	int id = -1;
 	int iskey;
 	int rm_all = 0;
-	type_id what_all;
+	type_id what_all = ALL;
 
 	static const struct option longopts[] = {
 		{"shmem-id", required_argument, NULL, 'm'},
-- 
1.7.7

