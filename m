Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:40426 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbbBCSvL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 3 Feb 2015 13:51:11 -0500
Received: by mail-wg0-f48.google.com with SMTP id x12so46236491wgg.7
        for <util-linux@vger.kernel.org>; Tue, 03 Feb 2015 10:51:09 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] fsck: use monotonic time to fsck run time measurement
Date: Tue,  3 Feb 2015 18:51:03 +0000
Message-Id: <1422989463-906-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier use of gettimeofday() resulted to wrong measurement if system
administrator did manual time changes, or NTP or adjtime(3) adjusment
happen during fsck run.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/Makemodule.am |  4 ++--
 disk-utils/fsck.c        | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/disk-utils/Makemodule.am b/disk-utils/Makemodule.am
index 2280b9d..b4606a1 100644
--- a/disk-utils/Makemodule.am
+++ b/disk-utils/Makemodule.am
@@ -83,8 +83,8 @@ endif #BUILD_SWAPLABEL
 if BUILD_FSCK
 sbin_PROGRAMS += fsck
 dist_man_MANS += disk-utils/fsck.8
-fsck_SOURCES = disk-utils/fsck.c
-fsck_LDADD = $(LDADD) libmount.la libblkid.la libcommon.la
+fsck_SOURCES = disk-utils/fsck.c lib/monotonic.c
+fsck_LDADD = $(LDADD) libmount.la libblkid.la libcommon.la $(CLOCKGETTIME_LIBS)
 fsck_CFLAGS = $(AM_CFLAGS) -I$(ul_libmount_incdir) -I$(ul_libblkid_incdir)
 endif
 
diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index 277d041..78ad43e 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -54,6 +54,7 @@
 #include "c.h"
 #include "closestream.h"
 #include "fileutils.h"
+#include "monotonic.h"
 
 #define XALLOC_EXIT_CODE	FSCK_EX_ERROR
 #include "xalloc.h"
@@ -577,20 +578,19 @@ static int progress_active(void)
  */
 static void print_stats(struct fsck_instance *inst)
 {
-	double time_diff;
+	struct timeval delta;
 
 	if (!inst || !report_stats || noexecute)
 		return;
 
-	time_diff = (inst->end_time.tv_sec  - inst->start_time.tv_sec)
-		  + (inst->end_time.tv_usec - inst->start_time.tv_usec) / 1E6;
+	timersub(&inst->end_time, &inst->start_time, &delta);
 
 	fprintf(stdout, "%s: status %d, rss %ld, "
-			"real %f, user %d.%06d, sys %d.%06d\n",
+			"real %ld.%06ld, user %d.%06d, sys %d.%06d\n",
 		fs_get_device(inst->fs),
 		inst->exit_status,
 		inst->rusage.ru_maxrss,
-		time_diff,
+		delta.tv_sec, delta.tv_usec,
 		(int)inst->rusage.ru_utime.tv_sec,
 		(int)inst->rusage.ru_utime.tv_usec,
 		(int)inst->rusage.ru_stime.tv_sec,
@@ -676,7 +676,7 @@ static int execute(const char *progname, const char *progpath,
 	inst->pid = pid;
 	inst->prog = xstrdup(progname);
 	inst->type = xstrdup(type);
-	gettimeofday(&inst->start_time, NULL);
+	gettime_monotonic(&inst->start_time);
 	inst->next = NULL;
 
 	/*
@@ -789,7 +789,7 @@ static struct fsck_instance *wait_one(int flags)
 
 	inst->exit_status = status;
 	inst->flags |= FLAG_DONE;
-	gettimeofday(&inst->end_time, NULL);
+	gettime_monotonic(&inst->end_time);
 	memcpy(&inst->rusage, &rusage, sizeof(struct rusage));
 
 	if (progress && (inst->flags & FLAG_PROGRESS) &&
-- 
2.2.2

