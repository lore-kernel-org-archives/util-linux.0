Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f47.google.com ([209.85.215.47]:49921 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932352AbaEENbc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 May 2014 09:31:32 -0400
Received: by mail-la0-f47.google.com with SMTP id e16so1944592lan.34
        for <util-linux@vger.kernel.org>; Mon, 05 May 2014 06:31:31 -0700 (PDT)
From: Alexander <alexsamilovskih@gmail.com>
To: alexander samilovskih <alexsamilovskih@gmail.com>,
        util-linux@vger.kernel.org, kerolasa@iki.fi
Subject: [PATCH 3/3] libmount/lock: add monotonic clock support
Date: Mon, 05 May 2014 20:31:05 +0200
Message-ID: <1915096.fhfZFCZoMz@alexpc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From b8ca74bfdb93034e9d1c52ab8702ff02dab8787c Mon Sep 17 00:00:00 2001
From: Alex Samilovskih <alexsamilovskih@gmail.com>
Date: Fri, 2 May 2014 18:28:31 +0000
Subject: [PATCH 3/3] Add support for monotonic clock in libmount

---
 libmount/src/lock.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/libmount/src/lock.c b/libmount/src/lock.c
index 8667db9..41f8ed1 100644
--- a/libmount/src/lock.c
+++ b/libmount/src/lock.c
@@ -25,6 +25,7 @@
 #include "closestream.h"
 #include "pathnames.h"
 #include "mountP.h"
+#include "timeutils.h"
 
 /*
  * lock handler
@@ -258,7 +259,7 @@ static int mnt_wait_mtab_lock(struct libmnt_lock *ml, struct flock *fl, time_t m
 	struct sigaction sa, osa;
 	int ret = 0;
 
-	gettimeofday(&now, NULL);
+	gettime_monotonic(&now);
 
 	if (now.tv_sec >= maxtime)
 		return 1;		/* timeout */
@@ -408,7 +409,7 @@ static int lock_mtab(struct libmnt_lock *ml)
 	}
 	close(i);
 
-	gettimeofday(&maxtime, NULL);
+	gettime_monotonic(&maxtime);
 	maxtime.tv_sec += MOUNTLOCK_MAXTIME;
 
 	waittime.tv_sec = 0;
@@ -434,7 +435,7 @@ static int lock_mtab(struct libmnt_lock *ml)
 		if (ml->lockfile_fd < 0) {
 			/* Strange... Maybe the file was just deleted? */
 			int errsv = errno;
-			gettimeofday(&now, NULL);
+			gettime_monotonic(&now);
 			if (errsv == ENOENT && now.tv_sec < maxtime.tv_sec) {
 				ml->locked = 0;
 				continue;
@@ -646,7 +647,7 @@ int test_lock(struct libmnt_test *ts, int argc, char *argv[])
 
 	/* start the test in exactly defined time */
 	if (synctime) {
-		gettimeofday(&tv, NULL);
+		gettimeofday(&tv);
 		if (synctime && synctime - tv.tv_sec > 1) {
 			usecs = ((synctime - tv.tv_sec) * 1000000UL) -
 						(1000000UL - tv.tv_usec);
-- 
1.9.2
