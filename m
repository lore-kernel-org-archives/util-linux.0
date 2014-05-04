Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:59087 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbaEDPue (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 May 2014 11:50:34 -0400
Received: by mail-wg0-f50.google.com with SMTP id x12so389284wgg.33
        for <util-linux@vger.kernel.org>; Sun, 04 May 2014 08:50:33 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/15] cytune: prefer sigaction(), and remove unnecessary abstractions
Date: Sun,  4 May 2014 16:49:47 +0100
Message-Id: <1399218596-21321-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The signal(3) system call is not exactly deprecated, but it should not be
used in new code.  The gettimeofday() does not require timezone to be
real variable, so get rid of it.  The mvtime #define was in use only
which make literal expression more readable.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/cytune.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
index 7ca39c7..4cc7db6 100644
--- a/sys-utils/cytune.c
+++ b/sys-utils/cytune.c
@@ -72,8 +72,6 @@ int cmon_index;
 static int global_argc, global_optind;
 static char ***global_argv;
 
-#define mvtime(tvpto, tvpfrom)  (((tvpto)->tv_sec = (tvpfrom)->tv_sec),(tvpto)->tv_usec = (tvpfrom)->tv_usec)
-
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, USAGE_HEADER);
@@ -143,17 +141,22 @@ static void query_tty_stats(int argc, char **argv, unsigned int interval, int nu
 {
 	struct cyclades_monitor cywork;
 	struct timeval lasttime, thistime;
-	struct timezone tz = { 0, 0 };
 	int i;
 	double diff;
 	double xfer_rate;
+	struct sigaction sigact;
 
 	cmon = xmalloc(sizeof(struct cyclades_control) * numfiles);
 
-	if (signal(SIGINT, summary) ||
-	    signal(SIGQUIT, summary) || signal(SIGTERM, summary))
+	sigemptyset(&sigact.sa_mask);
+	sigact.sa_handler = &summary;
+	sigact.sa_flags = SA_RESTART;
+	if (sigaction(SIGINT, &sigact, NULL) ||
+	    sigaction(SIGQUIT, &sigact, NULL) ||
+	    sigaction(SIGTERM, &sigact, NULL))
 		err(EXIT_FAILURE, _("cannot set signal handler"));
-	if (gettimeofday(&lasttime, &tz))
+
+	if (gettimeofday(&lasttime, NULL))
 		err(EXIT_FAILURE, _("gettimeofday failed"));
 
 	for (i = optind; i < argc; i++) {
@@ -177,10 +180,11 @@ static void query_tty_stats(int argc, char **argv, unsigned int interval, int nu
 	while (1) {
 		sleep(interval);
 
-		if (gettimeofday(&thistime, &tz))
+		if (gettimeofday(&thistime, NULL))
 			err(EXIT_FAILURE, _("gettimeofday failed"));
 		diff = dtime(&thistime, &lasttime);
-		mvtime(&lasttime, &thistime);
+		lasttime.tv_sec = thistime.tv_sec;
+		lasttime.tv_usec = thistime.tv_usec;
 
 		for (i = optind; i < argc; i++) {
 			cmon_index = i - optind;
-- 
1.9.2

