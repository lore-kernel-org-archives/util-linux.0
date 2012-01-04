Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdccac.dreamhost.com ([208.97.132.202]:45293 "EHLO
	homiemail-a61.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757099Ab2ADW3F convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 4 Jan 2012 17:29:05 -0500
Subject: [PATCH] lscpu: fix compiler warnings
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 Jan 2012 23:28:59 +0100
Message-ID: <1325716139.7056.1.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

The string format is not being passed triggering:

    lscpu.c: In function ‘read_hypervisor’:
    lscpu.c:545:4: warning: format not a string literal and no format arguments
    lscpu.c: In function ‘get_cell_header’:
    lscpu.c:904:2: warning: format not a string literal and no format arguments
    lscpu.c:904:2: warning: format not a string literal and no format arguments

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 sys-utils/lscpu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 0a7841d..5214a12 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -542,7 +542,7 @@ read_hypervisor(struct lscpu_desc *desc)
 			str = strchr(buf, ':');
 			if (!str)
 				continue;
-			if (asprintf(&str, str + 1) == -1)
+			if (asprintf(&str, "%s", str + 1) == -1)
 				errx(EXIT_FAILURE, _("failed to allocate memory"));
 			/* remove leading, trailing and repeating whitespace */
 			while (*str == ' ')
@@ -901,7 +901,7 @@ get_cell_header(struct lscpu_desc *desc, int col,
 		if (desc->ncaches)
 			return buf;
 	}
-	snprintf(buf, bufsz, coldescs[col].name);
+	snprintf(buf, bufsz, "%s", coldescs[col].name);
 	return buf;
 }
 
-- 
1.7.4.1



