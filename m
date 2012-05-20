Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:60811 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab2ETAjY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 19 May 2012 20:39:24 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 2/3] findmnt: fallback to mountinfo for polling
Date: Sat, 19 May 2012 20:39:20 -0400
Message-Id: <1337474361-22429-2-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1337474361-22429-1-git-send-email-dreisner@archlinux.org>
References: <1337474361-22429-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If no tabfiles are specified, default to watching /proc/self/mountinfo
rather than exiting silently with EXIT_FAILURE.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 misc-utils/findmnt.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 9005483..eab224a 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -1320,8 +1320,7 @@ int main(int argc, char *argv[])
 	 */
 	if (flags & FL_POLL) {
 		/* poll mode (accept the first tabfile only) */
-		if (tabfiles && ntabfiles > 0)
-			rc = poll_table(tb, *tabfiles, timeout, tt, direction);
+		rc = poll_table(tb, tabfiles ? *tabfiles : _PATH_PROC_MOUNTINFO, timeout, tt, direction);
 
 	} else if ((tt_flags & TT_FL_TREE) && is_listall_mode())
 		/* whole tree */
-- 
1.7.10.2

