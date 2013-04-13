Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f175.google.com ([74.125.82.175]:46988 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab3DMTzN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:13 -0400
Received: by mail-we0-f175.google.com with SMTP id t11so2840323wey.34
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/33] blkid, hwclock, ldattach: use program_invocation_short_name
Date: Sat, 13 Apr 2013 20:54:30 +0100
Message-Id: <1365882901-11429-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/blkid.c   | 4 +---
 sys-utils/hwclock.h  | 1 -
 sys-utils/ldattach.c | 3 ---
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index ce712ac..f4a9cf5 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -51,8 +51,6 @@ extern int optind;
 #include "ttyutils.h"
 #include "xalloc.h"
 
-const char *progname = "blkid";
-
 int raw_chars;
 
 static void print_version(FILE *out)
@@ -98,7 +96,7 @@ static void usage(int error)
 		" -O <offset> probe at the given offset\n"
 		" -u <list>   filter by \"usage\" (e.g. -u filesystem,raid)\n"
 		" -n <list>   filter by filesystem type (e.g. -n vfat,ext3)\n"
-		"\n", progname);
+		"\n", program_invocation_short_name);
 
 	exit(error);
 }
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index 175a6d1..69b0ce2 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -24,7 +24,6 @@ extern struct clock_ops *probe_for_kd_clock(void);
 typedef int bool;
 
 /* hwclock.c */
-extern char *progname;
 extern int debug;
 extern unsigned long epoch_option;
 extern double time_diff(struct timeval subtrahend, struct timeval subtractor);
diff --git a/sys-utils/ldattach.c b/sys-utils/ldattach.c
index c06aed2..5c460fe 100644
--- a/sys-utils/ldattach.c
+++ b/sys-utils/ldattach.c
@@ -42,7 +42,6 @@
 # define TIOCSETD   0x5423
 #endif
 
-static const char *progname;
 static int debug = 0;
 
 struct ld_table {
@@ -238,8 +237,6 @@ int main(int argc, char **argv)
 	atexit(close_stdout);
 
 	/* parse options */
-	progname = program_invocation_short_name;
-
 	if (argc == 0)
 		usage(EXIT_SUCCESS);
 	while ((optc =
-- 
1.8.2.1

