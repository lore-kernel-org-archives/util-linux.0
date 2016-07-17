Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35664 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbcGQNAi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Jul 2016 09:00:38 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so8763800wmg.2
        for <util-linux@vger.kernel.org>; Sun, 17 Jul 2016 06:00:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 08/13] libmount, look: remove dead code [oclint]
Date: Sun, 17 Jul 2016 14:00:10 +0100
Message-Id: <20160717130015.31760-9-kerolasa@iki.fi>
In-Reply-To: <20160717130015.31760-1-kerolasa@iki.fi>
References: <20160717130015.31760-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libmount/src/context_mount.c  | 1 -
 libmount/src/context_umount.c | 1 -
 misc-utils/look.c             | 2 --
 3 files changed, 4 deletions(-)

diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index 7e5128b..91611ef 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -566,7 +566,6 @@ int mnt_context_mount_setopt(struct libmnt_context *cxt, int c, char *arg)
 		break;
 	default:
 		return 1;
-		break;
 	}
 
 	return rc;
diff --git a/libmount/src/context_umount.c b/libmount/src/context_umount.c
index 707665d..d003c5d 100644
--- a/libmount/src/context_umount.c
+++ b/libmount/src/context_umount.c
@@ -620,7 +620,6 @@ int mnt_context_umount_setopt(struct libmnt_context *cxt, int c, char *arg)
 		break;
 	default:
 		return 1;
-		break;
 	}
 
 	return rc;
diff --git a/misc-utils/look.c b/misc-utils/look.c
index f0cc1d7..93c388e 100644
--- a/misc-utils/look.c
+++ b/misc-utils/look.c
@@ -274,10 +274,8 @@ linear_search(char *front, char *back)
 		switch (compare(front, back)) {
 		case EQUAL:		/* Found it. */
 			return (front);
-			break;
 		case LESS:		/* No such string. */
 			return (NULL);
-			break;
 		case GREATER:		/* Keep going. */
 			break;
 		}
-- 
2.9.0

