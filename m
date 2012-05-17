Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:38546 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759952Ab2EQHlX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 May 2012 03:41:23 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 979098FA98
	for <util-linux@vger.kernel.org>; Thu, 17 May 2012 09:41:22 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 3/4] text-utils: use min() from c.h
Date: Thu, 17 May 2012 09:41:08 +0200
Message-Id: <1337240469-24539-3-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1337240469-24539-1-git-send-email-petr.uzel@suse.cz>
References: <1337240469-24539-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 text-utils/display.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/text-utils/display.c b/text-utils/display.c
index ad638e7..84ec5d8 100644
--- a/text-utils/display.c
+++ b/text-utils/display.c
@@ -41,14 +41,11 @@
 #include <string.h>
 #include "hexdump.h"
 #include "xalloc.h"
+#include "c.h"
 
 static void doskip(const char *, int);
 static u_char *get(void);
 
-#ifndef MIN
-#define MIN(a,b) ((a)<(b)?(a):(b))
-#endif
-
 enum _vflag vflag = FIRST;
 
 static off_t address;			/* address/offset in stream */
@@ -262,7 +259,7 @@ get(void)
 			return(curp);
 		}
 		n = fread((char *)curp + nread, sizeof(unsigned char),
-		    length == -1 ? need : MIN(length, need), stdin);
+		    length == -1 ? need : min(length, need), stdin);
 		if (!n) {
 			if (ferror(stdin))
 				warn("%s", _argv[-1]);
-- 
1.7.7

