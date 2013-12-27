Return-Path: util-linux-owner@vger.kernel.org
Received: from mailhub.sw.ru ([195.214.232.25]:46104 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753143Ab3L0Ns4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Dec 2013 08:48:56 -0500
From: Andrey Vagin <avagin@openvz.org>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Andrew Vagin <avagin@openvz.org>
Subject: [PATCH] hexdump: initialize hex->skip
Date: Fri, 27 Dec 2013 17:44:48 +0400
Message-Id: <1388151888-8999-1-git-send-email-avagin@openvz.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Andrew Vagin <avagin@openvz.org>

==11097== Conditional jump or move depends on uninitialised value(s)
==11097==    at 0x9588: next (hexdump-display.c:355)
==11097==    by 0x9767: display (hexdump-display.c:280)
==11097==    by 0x9227: main (hexdump.c:198)

Signed-off-by: Andrew Vagin <avagin@openvz.org>
---
 text-utils/hexdump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/text-utils/hexdump.c b/text-utils/hexdump.c
index e9fca02..1806077 100644
--- a/text-utils/hexdump.c
+++ b/text-utils/hexdump.c
@@ -169,6 +169,7 @@ int main(int argc, char **argv)
 
 	struct hexdump *hex = malloc (sizeof (struct hexdump));
 	hex->length = -1;
+	hex->skip = 0;
 	INIT_LIST_HEAD(&hex->fshead);
 
 	setlocale(LC_ALL, "");
-- 
1.8.4.2

