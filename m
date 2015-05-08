Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:63020 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbbEHLj6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 8 May 2015 07:39:58 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Michael Marineau <michael.marineau@coreos.com>
Subject: [PATCH] libfdisk: (gpt) fix attributes endianess
Date: Fri,  8 May 2015 13:39:53 +0200
Message-Id: <1431085193-1509-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

The new libfdisk/gpt test (4a4a0927) discovered that we read and write
partition attributes wrongly on BE systems.

Our temporarily used char[8] bits are always LE and do not need to be
converted.

CC: Michael Marineau <michael.marineau@coreos.com>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libfdisk/src/gpt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index a7ec539..3db81be 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -1415,7 +1415,7 @@ static int gpt_entry_attrs_to_string(struct gpt_entry *e, char **res)
 	assert(res);
 
 	*res = NULL;
-	attrs = le64_to_cpu(e->attrs);
+	attrs = e->attrs;
 	if (!attrs)
 		return 0;	/* no attributes at all */
 
@@ -1530,7 +1530,7 @@ static int gpt_entry_attrs_from_string(
 			p++;
 	}
 
-	e->attrs = cpu_to_le64(attrs);
+	e->attrs = attrs;
 	return 0;
 }
 
@@ -2517,7 +2517,7 @@ static int gpt_toggle_partition_flag(
 	if ((uint32_t) i >= le32_to_cpu(gpt->pheader->npartition_entries))
 		return -EINVAL;
 
-	attrs = le64_to_cpu(gpt->ents[i].attrs);
+	attrs = gpt->ents[i].attrs;
 	bits = (char *) &attrs;
 
 	switch (flag) {
@@ -2558,7 +2558,7 @@ static int gpt_toggle_partition_flag(
 	else
 		clrbit(bits, bit);
 
-	gpt->ents[i].attrs = cpu_to_le64(attrs);
+	gpt->ents[i].attrs = attrs;
 
 	if (flag == GPT_FLAG_GUIDSPECIFIC)
 		fdisk_info(cxt, isset(bits, bit) ?
-- 
1.8.4.5

