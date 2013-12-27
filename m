Return-Path: util-linux-owner@vger.kernel.org
Received: from mailhub.sw.ru ([195.214.232.25]:37323 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753143Ab3L0NtM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Dec 2013 08:49:12 -0500
From: Andrey Vagin <avagin@openvz.org>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Andrew Vagin <avagin@openvz.org>
Subject: [PATCH] hexdump: don't access hex after freeing it
Date: Fri, 27 Dec 2013 17:45:06 +0400
Message-Id: <1388151906-9057-1-git-send-email-avagin@openvz.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Andrew Vagin <avagin@openvz.org>

==20209== Invalid read of size 4
==20209==    at 0x923C: main (hexdump.c:202)
==20209==  Address 0x49af034 is 12 bytes inside a block of size 32 free'd
==20209==    at 0x48348B8: free (vg_replace_malloc.c:427)
==20209==    by 0x923B: main (hexdump.c:200)

Signed-off-by: Andrey Vagin <avagin@openvz.org>
---
 text-utils/hexdump.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/text-utils/hexdump.c b/text-utils/hexdump.c
index 1806077..cebd676 100644
--- a/text-utils/hexdump.c
+++ b/text-utils/hexdump.c
@@ -165,11 +165,13 @@ int main(int argc, char **argv)
 {
 	struct list_head *p;
 	struct hexdump_fs *tfs;
+	int ret;
 	char *c;
 
 	struct hexdump *hex = malloc (sizeof (struct hexdump));
 	hex->length = -1;
 	hex->skip = 0;
+	hex->exitval = 0;
 	INIT_LIST_HEAD(&hex->fshead);
 
 	setlocale(LC_ALL, "");
@@ -197,8 +199,9 @@ int main(int argc, char **argv)
 
 	next(argv, hex);
 	display(hex);
+	ret = hex->exitval;
 	hex_free(hex);
-	return hex->exitval;
+	return ret;
 }
 
 void hex_free(struct hexdump *hex)
-- 
1.8.4.2

