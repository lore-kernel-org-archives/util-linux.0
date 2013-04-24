Return-Path: util-linux-owner@vger.kernel.org
Received: from g1t0029.austin.hp.com ([15.216.28.36]:43904 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757402Ab3DXD11 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 23 Apr 2013 23:27:27 -0400
Message-ID: <1366774046.3218.1.camel@buesod1.americas.hpqcorp.net>
Subject: [PATCH] libfdisk: gpt: remove leftover comments
From: Davidlohr Bueso <davidlohr.bueso@hp.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Date: Tue, 23 Apr 2013 20:27:26 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I must have left those in some commit.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 libfdisk/src/gpt.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index 735c9d9..482d453 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -1529,12 +1529,6 @@ static int gpt_create_new_partition(struct fdisk_context *cxt,
 
 	gpt_entry_set_type(e, type);
 
-	/* deal with partition name
-	for (i = 0; i < GPT_PART_NAME_LEN; i++)
-		e->partition_name[i] =
-			cpu_to_le16((uint16_t) gpt_sys_types[sys].name[i]);
-	*/
-
 	/*
 	 * Any time a new partition entry is created a new GUID must be
 	 * generated for that partition, and every partition is guaranteed
-- 
1.7.11.7



