Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f181.google.com ([74.125.82.181]:57515 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbaEDPum (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 May 2014 11:50:42 -0400
Received: by mail-we0-f181.google.com with SMTP id q58so6325652wes.26
        for <util-linux@vger.kernel.org>; Sun, 04 May 2014 08:50:41 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/15] cytune: pull signal handling and statistic priting apart
Date: Sun,  4 May 2014 16:49:50 +0100
Message-Id: <1399218596-21321-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Combination of these two functions made the code to rely to global
variables, and cmon_index was seemingly invalid if signal was sent at a
time when query_tty_stats() was half done with a statistics printout.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/cytune.c | 60 +++++++++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
index 8dd566d..4f0ddc7 100644
--- a/sys-utils/cytune.c
+++ b/sys-utils/cytune.c
@@ -120,33 +120,36 @@ static inline double dtime(struct timeval *tvpnew, struct timeval *tvpold)
 	return diff;
 }
 
-static void summary(int sig)
+static void signal_handler(int sig __attribute__((__unused__)))
 {
 	struct cyclades_control *cc;
 	int argc, local_optind;
 	char **argv;
-	int i;
+	int i, j = 0;
 
 	argc = mod.global_argc;
 	argv = *mod.global_argv;
 	local_optind = mod.global_optind;
 
-	if (sig > 0) {
-		for (i = local_optind; i < argc; i++) {
-			cc = &cmon[mod.cmon_index];
-			warnx(_("File %s, For threshold value %lu, Maximum characters in fifo were %d,\n"
-				"and the maximum transfer rate in characters/second was %f"),
-			      argv[i], cc->threshold_value, cc->maxmax,
-			      cc->maxtran);
-		}
-		exit(EXIT_SUCCESS);
+	for (i = local_optind; i < argc; i++, j++) {
+		cc = &cmon[j];
+		warnx(_("File %s, For threshold value %lu, Maximum characters in fifo were %d,\n"
+			"and the maximum transfer rate in characters/second was %f"),
+		      argv[i], cc->threshold_value, cc->maxmax, cc->maxtran);
 	}
-	cc = &cmon[mod.cmon_index];
-	if (cc->threshold_value > 0 && sig != -1) {
+	exit(EXIT_SUCCESS);
+}
+
+static void print_statistics(struct cyclades_control *mon, struct cytune_modifiers *mod, int init)
+{
+	struct cyclades_control *cc;
+
+	cc = &mon[mod->cmon_index];
+	if (0 < cc->threshold_value && !init) {
 		warnx(_("File %s, For threshold value %lu and timeout value %lu, Maximum characters in fifo were %d,\n"
 			"and the maximum transfer rate in characters/second was %f"),
-		      argv[mod.cmon_index + local_optind], cc->threshold_value,
-		      cc->timeout_value, cc->maxmax, cc->maxtran);
+		      *mod->global_argv[mod->cmon_index + optind], cc->threshold_value, cc->timeout_value, cc->maxmax,
+		      cc->maxtran);
 	}
 	cc->maxmax = 0;
 	cc->maxtran = 0.0;
@@ -177,7 +180,7 @@ static void query_tty_stats(int argc, char **argv, struct cytune_modifiers *mod)
 	cmon = xmalloc(sizeof(struct cyclades_control) * (argc - mod->global_optind));
 
 	sigemptyset(&sigact.sa_mask);
-	sigact.sa_handler = &summary;
+	sigact.sa_handler = &signal_handler;
 	sigact.sa_flags = SA_RESTART;
 	if (sigaction(SIGINT, &sigact, NULL) ||
 	    sigaction(SIGQUIT, &sigact, NULL) ||
@@ -193,7 +196,7 @@ static void query_tty_stats(int argc, char **argv, struct cytune_modifiers *mod)
 		if (cmon[mod->cmon_index].cfile == -1)
 			err(EXIT_FAILURE, _("cannot open %s"), argv[i]);
 		cyg_get_mon(cmon[mod->cmon_index].cfile, &cmon[mod->cmon_index].c, argv[i], mod);
-		summary(-1);
+		print_statistics(&cmon[mod->cmon_index], mod, 1);
 	}
 	while (1) {
 		sleep(mod->interval);
@@ -209,28 +212,21 @@ static void query_tty_stats(int argc, char **argv, struct cytune_modifiers *mod)
 			cyg_get_mon(cmon[mod->cmon_index].cfile, &cywork, argv[i], mod);
 			xfer_rate = cywork.char_count / diff;
 
-			if (mod->threshold_value !=
-			    cmon[mod->cmon_index].threshold_value
-			    || mod->timeout_value !=
-			    cmon[mod->cmon_index].timeout_value) {
-				summary(-2);
+			if (mod->threshold_value != cmon[mod->cmon_index].threshold_value ||
+			    mod->timeout_value != cmon[mod->cmon_index].timeout_value) {
+				print_statistics(&cmon[mod->cmon_index], mod, 0);
 				/* Note that the summary must come before the
 				 * setting of threshold_value */
-				cmon[mod->cmon_index].threshold_value =
-				    mod->threshold_value;
-				cmon[mod->cmon_index].timeout_value =
-				    mod->timeout_value;
+				cmon[mod->cmon_index].threshold_value = mod->threshold_value;
+				cmon[mod->cmon_index].timeout_value = mod->timeout_value;
 			} else {
 				/* Don't record this first cycle after change */
-				if (xfer_rate > cmon[mod->cmon_index].maxtran)
+				if (cmon[mod->cmon_index].maxtran < xfer_rate)
 					cmon[mod->cmon_index].maxtran = xfer_rate;
 				if (cmon[mod->cmon_index].maxmax < 0 ||
-				    cywork.char_max >
-				    (unsigned long)cmon[mod->cmon_index].maxmax)
-					cmon[mod->cmon_index].maxmax =
-					    cywork.char_max;
+				    (unsigned long)cmon[mod->cmon_index].maxmax < cywork.char_max)
+					cmon[mod->cmon_index].maxmax = cywork.char_max;
 			}
-
 			printf(_("%s: %lu ints, %lu chars; fifo: %lu thresh, %lu tmout, "
 				 "%lu max, %lu now\n"), argv[i],
 			       cywork.int_count, cywork.char_count,
-- 
1.9.2

