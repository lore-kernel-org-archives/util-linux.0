Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:64162 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752889AbbLIRnW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Dec 2015 12:43:22 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Federico Simoncelli <fsimonce@redhat.com>
Subject: [PATCH 1/5] blkdiscard: fix timeval comparison inclusive usecs
Date: Wed,  9 Dec 2015 18:43:10 +0100
Message-Id: <1449682994-32154-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1449682994-32154-1-git-send-email-sweet_f_a@gmx.de>
References: <1449682994-32154-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We will see if this makes our "--step" tests reliable.

CC: Federico Simoncelli <fsimonce@redhat.com>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/blkdiscard.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sys-utils/blkdiscard.c b/sys-utils/blkdiscard.c
index 150689a..a853a35 100644
--- a/sys-utils/blkdiscard.c
+++ b/sys-utils/blkdiscard.c
@@ -197,10 +197,11 @@ int main(int argc, char **argv)
 				err(EXIT_FAILURE, _("%s: BLKDISCARD ioctl failed"), path);
 		}
 
-		/* reporting progress */
+		/* reporting progress at most once per second */
 		if (verbose && step) {
 			gettime_monotonic(&now);
-			if (last.tv_sec < now.tv_sec) {
+			if (now.tv_sec > last.tv_sec &&
+			    (now.tv_usec >= last.tv_usec || now.tv_sec > last.tv_sec + 1)) {
 				print_stats(path, stats);
 				stats[0] = range[0], stats[1] = 0;
 				last = now;
-- 
1.8.4.5

