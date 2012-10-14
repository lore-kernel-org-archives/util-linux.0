Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41556 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355Ab2JNUVh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:37 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3908218wgb.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 15/19] libmount, eject: replace index() and rindex() with strrch() or strrchr()
Date: Sun, 14 Oct 2012 21:21:06 +0100
Message-Id: <1350246070-10544-16-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Both index() and rindex() are legacy functions which may be withdrawn in
a future.

Reference: http://pubs.opengroup.org/onlinepubs/009695399/functions/index.html
Reference: http://pubs.opengroup.org/onlinepubs/009695399/functions/rindex.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libmount/src/tab_parse.c | 4 ++--
 sys-utils/eject.c        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libmount/src/tab_parse.c b/libmount/src/tab_parse.c
index 463c884..2cae750 100644
--- a/libmount/src/tab_parse.c
+++ b/libmount/src/tab_parse.c
@@ -362,14 +362,14 @@ next_line:
 		if (fgets(buf, sizeof(buf), f) == NULL)
 			return -EINVAL;
 		++*nlines;
-		s = index (buf, '\n');
+		s = strchr (buf, '\n');
 		if (!s) {
 			/* Missing final newline?  Otherwise extremely */
 			/* long line - assume file was corrupted */
 			if (feof(f)) {
 				DBG(TAB, mnt_debug_h(tb,
 					"%s: no final newline",	filename));
-				s = index (buf, '\0');
+				s = strchr (buf, '\0');
 			} else {
 				DBG(TAB, mnt_debug_h(tb,
 					"%s:%d: missing newline at line",
diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 1a5b834..5d5d7b1 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -499,7 +499,7 @@ static int read_speed(const char *devname)
 	if (!f)
 		err(EXIT_FAILURE, _("cannot open %s"), _PATH_PROC_CDROMINFO);
 
-	name = rindex(devname, '/') + 1;
+	name = strrchr(devname, '/') + 1;
 
 	while (name && !feof(f)) {
 		char line[512];
-- 
1.7.12.2

