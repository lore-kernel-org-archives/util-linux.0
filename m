Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:43004 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935672Ab3DHTdr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Apr 2013 15:33:47 -0400
Received: by mail-wg0-f44.google.com with SMTP id z12so6235379wgg.35
        for <util-linux@vger.kernel.org>; Mon, 08 Apr 2013 12:33:46 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/14] libmount, col: remove redundant null checks [smatch scan]
Date: Mon,  8 Apr 2013 20:32:51 +0100
Message-Id: <1365449579-13238-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
References: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

libmount/src/context_umount.c:174 mnt_context_find_umount_fs() info: redundant null check on loopdev calling free()
libmount/src/context_umount.c:179 mnt_context_find_umount_fs() info: redundant null check on loopdev calling free()
text-utils/col.c:406 flush_lines() info: redundant null check on l->l_line calling free()

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libmount/src/context_umount.c | 6 ++----
 text-utils/col.c              | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/libmount/src/context_umount.c b/libmount/src/context_umount.c
index 96ae87a..b948459 100644
--- a/libmount/src/context_umount.c
+++ b/libmount/src/context_umount.c
@@ -170,13 +170,11 @@ try_loopdev:
 	}
 
 	*pfs = fs;
-	if (loopdev)
-		free(loopdev);
+	free(loopdev);
 
 	return fs ? 0 : 1;
 err:
-	if (loopdev)
-		free(loopdev);
+	free(loopdev);
 	return rc;
 }
 
diff --git a/text-utils/col.c b/text-utils/col.c
index 474b33f..9aa6a41 100644
--- a/text-utils/col.c
+++ b/text-utils/col.c
@@ -402,8 +402,7 @@ void flush_lines(int nflush)
 			flush_line(l);
 		}
 		nblank_lines++;
-		if (l->l_line)
-			free((void *)l->l_line);
+		free((void *)l->l_line);
 		free_line(l);
 	}
 	if (lines)
-- 
1.8.2.1

