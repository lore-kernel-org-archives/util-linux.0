Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f54.google.com ([74.125.82.54]:45797 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbbBVOl7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:41:59 -0500
Received: by mail-wg0-f54.google.com with SMTP id y19so21118387wgg.13
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:41:58 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 03/16] flock: improve timeout handling
Date: Sun, 22 Feb 2015 14:41:33 +0000
Message-Id: <1424616106-580-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signal ALRM raised by the timer, and the timer only, will be considered
as a timeout criteria.

Secondly time interval is made to use monotonic clock.  Documentation of
ITIMER_REAL is unclear whether that time is affected various sources of
clock skew, or does it even tick when system is suspended.

This code is moved from libcommon.la to flock.c because of two reasons.
This is the only utility using the function, and setup_timer() along with
cancel_timer() need to be linked with -lrt option.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/Makemodule.am   |  1 -
 include/timer.h         | 31 -------------------------------
 sys-utils/Makemodule.am |  2 +-
 sys-utils/flock.c       | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 43 insertions(+), 40 deletions(-)
 delete mode 100644 include/timer.h

diff --git a/include/Makemodule.am b/include/Makemodule.am
index c4a52e4..8d7c881 100644
--- a/include/Makemodule.am
+++ b/include/Makemodule.am
@@ -44,7 +44,6 @@ dist_noinst_HEADERS += \
 	include/swapprober.h \
 	include/swapheader.h \
 	include/sysfs.h \
-	include/timer.h \
 	include/timeutils.h \
 	include/ttyutils.h \
 	include/widechar.h \
diff --git a/include/timer.h b/include/timer.h
deleted file mode 100644
index 79ef649..0000000
--- a/include/timer.h
+++ /dev/null
@@ -1,31 +0,0 @@
-#ifndef UTIL_LINUX_TIMER_H
-#define UTIL_LINUX_TIMER_H
-
-#include <signal.h>
-#include <sys/time.h>
-
-static inline int setup_timer(
-			struct itimerval *timer,
-			struct itimerval *old_timer,
-			struct sigaction *old_sa,
-			void (*timeout_handler)(int))
-{
-	struct sigaction sa;
-
-	memset(&sa, 0, sizeof sa);
-	sa.sa_handler = timeout_handler;
-	sa.sa_flags = SA_RESETHAND;
-	sigaction(SIGALRM, &sa, old_sa);
-
-	return setitimer(ITIMER_REAL, timer, old_timer);
-}
-
-static inline void cancel_timer(
-			struct itimerval *old_timer,
-			struct sigaction *old_sa)
-{
-	setitimer(ITIMER_REAL, old_timer, NULL);
-	sigaction(SIGALRM, old_sa, NULL);
-}
-
-#endif
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index d3f77b4..14d0773 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -2,7 +2,7 @@ if BUILD_FLOCK
 usrbin_exec_PROGRAMS += flock
 dist_man_MANS += sys-utils/flock.1
 flock_SOURCES = sys-utils/flock.c lib/monotonic.c
-flock_LDADD = $(LDADD) libcommon.la $(CLOCKGETTIME_LIBS)
+flock_LDADD = $(LDADD) libcommon.la -lrt
 endif
 
 if BUILD_IPCMK
diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index cb8a82b..97e7325 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -43,7 +43,6 @@
 #include "nls.h"
 #include "strutils.h"
 #include "closestream.h"
-#include "timer.h"
 #include "monotonic.h"
 
 static void __attribute__((__noreturn__)) usage(int ex)
@@ -77,9 +76,12 @@ static void __attribute__((__noreturn__)) usage(int ex)
 
 static sig_atomic_t timeout_expired = 0;
 
-static void timeout_handler(int sig __attribute__((__unused__)))
+static void timeout_handler(int sig __attribute__((__unused__)),
+			    siginfo_t *info,
+			    void *context __attribute__((__unused__)))
 {
-	timeout_expired = 1;
+	if (info->si_code == SI_TIMER)
+		timeout_expired = 1;
 }
 
 static int open_file(const char *filename, int *flags)
@@ -111,9 +113,42 @@ static int open_file(const char *filename, int *flags)
 	return fd;
 }
 
+static int setup_timer(timer_t *t_id, struct itimerval *timeout)
+{
+	struct sigaction sig_a;
+	static struct sigevent sig_e = {
+		.sigev_notify = SIGEV_SIGNAL,
+		.sigev_signo = SIGALRM
+	};
+	struct itimerspec val = {
+		.it_value.tv_sec = timeout->it_value.tv_sec,
+		.it_value.tv_nsec = timeout->it_value.tv_usec * 1000,
+		.it_interval.tv_sec = 0,
+		.it_interval.tv_nsec = 0
+	};
+
+	if (sigemptyset(&sig_a.sa_mask))
+		return 1;
+	sig_a.sa_flags = SA_SIGINFO;
+	sig_a.sa_handler = (void (*)(int))timeout_handler;
+	if (sigaction(SIGALRM, &sig_a, 0))
+		return 1;
+	if (timer_create(CLOCK_MONOTONIC, &sig_e, t_id))
+		return 1;
+	if (timer_settime(*t_id, SA_SIGINFO, &val, NULL))
+		return 1;
+	return 0;
+}
+
+static void cancel_timer(timer_t *t_id)
+{
+	timer_delete(*t_id);
+}
+
 int main(int argc, char *argv[])
 {
-	struct itimerval timeout, old_timer;
+	static timer_t t_id;
+	struct itimerval timeout;
 	int have_timeout = 0;
 	int type = LOCK_EX;
 	int block = 0;
@@ -131,7 +166,6 @@ int main(int argc, char *argv[])
 	int conflict_exit_code = 1;
 	char **cmd_argv = NULL, *sh_c_argv[4];
 	const char *filename = NULL;
-	struct sigaction old_sa;
 	enum {
 		OPT_VERBOSE = CHAR_MAX + 1
 	};
@@ -246,7 +280,8 @@ int main(int argc, char *argv[])
 			have_timeout = 0;
 			block = LOCK_NB;
 		} else
-			setup_timer(&timeout, &old_timer, &old_sa, timeout_handler);
+			if (setup_timer(&t_id, &timeout))
+				err(EX_OSERR, _("cannot not setup timer"));
 	}
 
 	if (verbose)
@@ -298,7 +333,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (have_timeout)
-		cancel_timer(&old_timer, &old_sa);
+		cancel_timer(&t_id);
 	if (verbose) {
 		struct timeval delta;
 
-- 
2.3.0

