Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35410 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbbHHHOm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Aug 2015 03:14:42 -0400
Received: by wibxm9 with SMTP id xm9so84334957wib.0
        for <util-linux@vger.kernel.org>; Sat, 08 Aug 2015 00:14:41 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/2] misc: fix redundant assignment and reassignments before use [cppcheck]
Date: Sat,  8 Aug 2015 08:14:33 +0100
Message-Id: <1439018073-5592-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1439018073-5592-1-git-send-email-kerolasa@iki.fi>
References: <1439018073-5592-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/procutils.c        | 2 +-
 sys-utils/blkdiscard.c | 2 +-
 sys-utils/fstrim.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/procutils.c b/lib/procutils.c
index 00b977c..48ee7cf 100644
--- a/lib/procutils.c
+++ b/lib/procutils.c
@@ -103,7 +103,7 @@ char *proc_get_command(pid_t pid)
 	char buf[BUFSIZ], *res = NULL;
 	ssize_t sz = 0;
 	size_t i;
-	int fd = -1;
+	int fd;
 
 	snprintf(buf, sizeof(buf), "/proc/%d/cmdline", (int) pid);
 	fd = open(buf, O_RDONLY);
diff --git a/sys-utils/blkdiscard.c b/sys-utils/blkdiscard.c
index 3ee0b5d..150689a 100644
--- a/sys-utils/blkdiscard.c
+++ b/sys-utils/blkdiscard.c
@@ -185,7 +185,7 @@ int main(int argc, char **argv)
 	stats[0] = range[0], stats[1] = 0;
 	gettime_monotonic(&last);
 
-	for (range[0] = range[0]; range[0] < end; range[0] += range[1]) {
+	for (/* nothing */; range[0] < end; range[0] += range[1]) {
 		if (range[0] + range[1] > end)
 			range[1] = end - range[0];
 
diff --git a/sys-utils/fstrim.c b/sys-utils/fstrim.c
index c91141e..6bbf1c9 100644
--- a/sys-utils/fstrim.c
+++ b/sys-utils/fstrim.c
@@ -60,7 +60,7 @@ struct fstrim_range {
 static int fstrim_filesystem(const char *path, struct fstrim_range *rangetpl,
 			    int verbose)
 {
-	int fd = -1, rc;
+	int fd, rc;
 	struct stat sb;
 	struct fstrim_range range;
 
-- 
2.5.0

