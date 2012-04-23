Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:36861 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082Ab2DWInk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Apr 2012 04:43:40 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 5642AA0DFD
	for <util-linux@vger.kernel.org>; Mon, 23 Apr 2012 10:43:39 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] lscpu: fix possibly undefined operation
Date: Mon, 23 Apr 2012 10:43:38 +0200
Message-Id: <1335170618-10133-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

With -Wall -Werror, compilation of lscpu.c fails with:

  Making all in sys-utils
  make[2]: Entering directory `/home/petr/upstream/util-linux/sys-utils'
  gcc -std=gnu99 -DHAVE_CONFIG_H -I. -I..  -include ../config.h -I../include -DLOCALEDIR=\"/usr/share/locale\"  -fsigned-char -Wall -Werror -MT lscpu.o -MD -MP -MF .deps/lscpu.Tpo -c -o lscpu.o lscpu.c
  lscpu.c: In function ‘print_parsable’:
  lscpu.c:971:7: error: operation on ‘p’ may be undefined [-Werror=sequence-point]
  cc1: all warnings being treated as errors

Fix by splitting the pointer increment to separate statement.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 sys-utils/lscpu.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 1c2d9b6..f4a06e6 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -967,8 +967,10 @@ print_parsable(struct lscpu_desc *desc, int cols[], int ncols,
 			 */
 			char *p = data + 1;
 
-			while (p && *p != '\0')
-				*p++ = tolower((unsigned int) *p);
+			while (p && *p != '\0') {
+				*p = tolower((unsigned int) *p);
+				p++;
+			}
 		}
 		fputs(data && *data ? data : "", stdout);
 	}
-- 
1.7.7

