Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:49279 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253Ab2JNUV1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:27 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so1315606wib.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:27 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/19] libmount: replace usleep with nanosleep
Date: Sun, 14 Oct 2012 21:20:59 +0100
Message-Id: <1350246070-10544-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

POSIX.1-2001 declares usleep is obsolete.

Reference: http://pubs.opengroup.org/onlinepubs/009695399/functions/usleep.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libmount/src/lock.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/libmount/src/lock.c b/libmount/src/lock.c
index b149b6f..5245720 100644
--- a/libmount/src/lock.c
+++ b/libmount/src/lock.c
@@ -597,7 +597,6 @@ void __attribute__((__noreturn__)) sig_handler(int sig)
 int test_lock(struct libmnt_test *ts, int argc, char *argv[])
 {
 	time_t synctime = 0;
-	unsigned int usecs;
 	struct timeval tv;
 	const char *datafile = NULL;
 	int verbose = 0, loops = 0, l, idx = 1;
@@ -645,9 +644,10 @@ int test_lock(struct libmnt_test *ts, int argc, char *argv[])
 	if (synctime) {
 		gettimeofday(&tv, NULL);
 		if (synctime && synctime - tv.tv_sec > 1) {
-			usecs = ((synctime - tv.tv_sec) * 1000000UL) -
-						(1000000UL - tv.tv_usec);
-			usleep(usecs);
+			struct timespec waittime;
+			waittime.tv_sec = synctime - tv.tv_sec;
+			waittime.tv_nsec =  1000000000L - (1000 * tv.tv_usec);
+			nanosleep(&waittime, NULL);
 		}
 	}
 
@@ -672,8 +672,12 @@ int test_lock(struct libmnt_test *ts, int argc, char *argv[])
 		 * simulate this via short sleep -- it's also enough to make
 		 * concurrent processes happy.
 		 */
-		if (synctime)
-			usleep(25000);
+		if (synctime) {
+			struct timespec waittime;
+			waittime.tv_sec = 0;
+			waittime.tv_nsec = 25000000;
+			nanosleep(&waittime, NULL);
+		}
 	}
 
 	return 0;
-- 
1.7.12.2

