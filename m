Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:52417 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaGMUZd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jul 2014 16:25:33 -0400
Received: by mail-wg0-f41.google.com with SMTP id z12so3219685wgg.12
        for <util-linux@vger.kernel.org>; Sun, 13 Jul 2014 13:25:32 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/14] setpriv: avoid alloca() use xmalloc() instead
Date: Sun, 13 Jul 2014 21:24:49 +0100
Message-Id: <1405283093-28182-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
References: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The getgroups() can return up to NGROUPS_MAX supplementary groups, that
is (since kernel 2.6.3) 65536 in total.  The git_t is 4 bytes, so maximum
request is 256 kilobytes.  When a system happen to have memory preasure
alloca() may not be able to allocate enough memory, making debugging
unnecessarily difficult.  IMHO 64 pages is significant enough amount of
memory to be properly error checked at a time of allocation.

Reference: http://www.gnu.org/software/libc/manual/html_node/Disadvantages-of-Alloca.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/setpriv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 65921be..ccfa993 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -254,9 +254,10 @@ static void dump_groups(void)
 		return;
 	}
 
-	groups = alloca(n * sizeof(gid_t));
+	groups = xmalloc(n * sizeof(gid_t));
 	n = getgroups(n, groups);
 	if (n < 0) {
+		free(groups);
 		warn("getgroups failed");
 		return;
 	}
@@ -273,6 +274,7 @@ static void dump_groups(void)
 		}
 	}
 	printf("\n");
+	free(groups);
 }
 
 static void dump(int dumplevel)
-- 
2.0.1

