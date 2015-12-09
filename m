Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:53445 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752935AbbLIRnY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Dec 2015 12:43:24 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Federico Simoncelli <fsimonce@redhat.com>
Subject: [PATCH 2/5] blkdiscard: fix stats reporting (off by one)
Date: Wed,  9 Dec 2015 18:43:11 +0100
Message-Id: <1449682994-32154-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1449682994-32154-1-git-send-email-sweet_f_a@gmx.de>
References: <1449682994-32154-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

CC: Federico Simoncelli <fsimonce@redhat.com>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/blkdiscard.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/blkdiscard.c b/sys-utils/blkdiscard.c
index a853a35..bb4bae6 100644
--- a/sys-utils/blkdiscard.c
+++ b/sys-utils/blkdiscard.c
@@ -197,18 +197,18 @@ int main(int argc, char **argv)
 				err(EXIT_FAILURE, _("%s: BLKDISCARD ioctl failed"), path);
 		}
 
+		stats[1] += range[1];
+
 		/* reporting progress at most once per second */
 		if (verbose && step) {
 			gettime_monotonic(&now);
 			if (now.tv_sec > last.tv_sec &&
 			    (now.tv_usec >= last.tv_usec || now.tv_sec > last.tv_sec + 1)) {
 				print_stats(path, stats);
-				stats[0] = range[0], stats[1] = 0;
+				stats[0] += stats[1], stats[1] = 0;
 				last = now;
 			}
 		}
-
-		stats[1] += range[1];
 	}
 
 	if (verbose)
-- 
1.8.4.5

