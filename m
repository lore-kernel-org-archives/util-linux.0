Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:57161 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbbLIRnW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Dec 2015 12:43:22 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Federico Simoncelli <fsimonce@redhat.com>
Subject: [PATCH 3/5] blkdiscard: don't report "zero range" at the end
Date: Wed,  9 Dec 2015 18:43:12 +0100
Message-Id: <1449682994-32154-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1449682994-32154-1-git-send-email-sweet_f_a@gmx.de>
References: <1449682994-32154-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We want to address the case that we have printed the last useful
stats line already within the loop. Avoiding an additional line
"Discarded 0 bytes ..." at the end.

Note there is a behavior change now for the edge cases "-v -l 0" and
"-v -o blksize" where we don't print any stats line anymore. But actually
it's correct, we never make any BLKDISCARD syscall with zero range.
Perhaps we should return error in these cases to help people who always
want to parse stats output on success.

CC: Federico Simoncelli <fsimonce@redhat.com>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/blkdiscard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/blkdiscard.c b/sys-utils/blkdiscard.c
index bb4bae6..f36e504 100644
--- a/sys-utils/blkdiscard.c
+++ b/sys-utils/blkdiscard.c
@@ -211,7 +211,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (verbose)
+	if (verbose && stats[1])
 		print_stats(path, stats);
 
 	close(fd);
-- 
1.8.4.5

