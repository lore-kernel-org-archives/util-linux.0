Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f182.google.com ([209.85.212.182]:60927 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843AbaEDPux (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 May 2014 11:50:53 -0400
Received: by mail-wi0-f182.google.com with SMTP id r20so1145758wiv.9
        for <util-linux@vger.kernel.org>; Sun, 04 May 2014 08:50:52 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/15] cytune: add filename to struct cyclades_control
Date: Sun,  4 May 2014 16:49:53 +0100
Message-Id: <1399218596-21321-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This allows point to single structure rather than constantly worry if the
index variable to list is referring to correct location.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/cytune.c | 59 ++++++++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
index 0f97e28..dde793e 100644
--- a/sys-utils/cytune.c
+++ b/sys-utils/cytune.c
@@ -60,6 +60,7 @@
 
 struct cyclades_control {
 	struct cyclades_monitor c;
+	char *filename;
 	int cfile;
 	int maxmax;
 	double maxtran;
@@ -71,7 +72,6 @@ struct cyclades_control *cmon;
 struct cytune_modifiers {
 	int global_argc;
 	int global_optind;
-	char ***global_argv;
 	int cmon_index;
 	unsigned int interval;
 	unsigned long threshold_value;
@@ -124,33 +124,26 @@ static void signal_handler(int sig __attribute__((__unused__)))
 {
 	struct cyclades_control *cc;
 	int argc, local_optind;
-	char **argv;
 	int i, j = 0;
 
 	argc = mod.global_argc;
-	argv = *mod.global_argv;
 	local_optind = mod.global_optind;
 
 	for (i = local_optind; i < argc; i++, j++) {
 		cc = &cmon[j];
 		warnx(_("File %s, For threshold value %lu, Maximum characters in fifo were %d,\n"
 			"and the maximum transfer rate in characters/second was %f"),
-		      argv[i], cc->threshold_value, cc->maxmax, cc->maxtran);
+		      cc->filename, cc->threshold_value, cc->maxmax, cc->maxtran);
 	}
 	exit(EXIT_SUCCESS);
 }
 
-static void print_statistics(struct cyclades_control *mon, struct cytune_modifiers *mod, int init)
+static void print_statistics(struct cyclades_control *cc, int init)
 {
-	struct cyclades_control *cc;
-
-	cc = &mon[mod->cmon_index];
-	if (0 < cc->threshold_value && !init) {
+	if (0 < cc->threshold_value && !init)
 		warnx(_("File %s, For threshold value %lu and timeout value %lu, Maximum characters in fifo were %d,\n"
 			"and the maximum transfer rate in characters/second was %f"),
-		      *mod->global_argv[mod->cmon_index + optind], cc->threshold_value, cc->timeout_value, cc->maxmax,
-		      cc->maxtran);
-	}
+		      cc->filename, cc->threshold_value, cc->timeout_value, cc->maxmax, cc->maxtran);
 	cc->maxmax = 0;
 	cc->maxtran = 0.0;
 	cc->threshold_value = 0;
@@ -171,6 +164,7 @@ static void cyg_get_mon(int fd, struct cyclades_monitor *mon, char *file,
 static void query_tty_stats(int argc, char **argv, struct cytune_modifiers *mod)
 {
 	struct cyclades_monitor cywork;
+	struct cyclades_control *cc;
 	struct timeval lasttime, thistime;
 	int i;
 	double diff;
@@ -191,12 +185,13 @@ static void query_tty_stats(int argc, char **argv, struct cytune_modifiers *mod)
 		err(EXIT_FAILURE, _("gettimeofday failed"));
 
 	for (i = optind; i < argc; i++) {
-		mod->cmon_index = i - optind;
-		cmon[mod->cmon_index].cfile = open(argv[i], O_RDONLY);
-		if (cmon[mod->cmon_index].cfile == -1)
-			err(EXIT_FAILURE, _("cannot open %s"), argv[i]);
-		cyg_get_mon(cmon[mod->cmon_index].cfile, &cmon[mod->cmon_index].c, argv[i], mod);
-		print_statistics(&cmon[mod->cmon_index], mod, 1);
+		cc = &cmon[i - optind];
+		cc->filename = argv[i];
+		cc->cfile = open(cc->filename, O_RDONLY);
+		if (cc->cfile == -1)
+			err(EXIT_FAILURE, _("cannot open %s"), cc->filename);
+		cyg_get_mon(cc->cfile, &cc->c, cc->filename, mod);
+		print_statistics(cc, 1);
 	}
 	while (1) {
 		sleep(mod->interval);
@@ -208,24 +203,24 @@ static void query_tty_stats(int argc, char **argv, struct cytune_modifiers *mod)
 		lasttime.tv_usec = thistime.tv_usec;
 
 		for (i = optind; i < argc; i++) {
-			mod->cmon_index = i - optind;
-			cyg_get_mon(cmon[mod->cmon_index].cfile, &cywork, argv[i], mod);
+			cc = &cmon[i - optind];
+			cyg_get_mon(cc->cfile, &cywork, cc->filename, mod);
 			xfer_rate = cywork.char_count / diff;
 
-			if (mod->threshold_value != cmon[mod->cmon_index].threshold_value ||
-			    mod->timeout_value != cmon[mod->cmon_index].timeout_value) {
-				print_statistics(&cmon[mod->cmon_index], mod, 0);
+			if (mod->threshold_value != cc->threshold_value ||
+			    mod->timeout_value != cc->timeout_value) {
+				print_statistics(cc, 0);
 				/* Note that the summary must come before the
 				 * setting of threshold_value */
-				cmon[mod->cmon_index].threshold_value = mod->threshold_value;
-				cmon[mod->cmon_index].timeout_value = mod->timeout_value;
+				cc->threshold_value = mod->threshold_value;
+				cc->timeout_value = mod->timeout_value;
 			} else {
 				/* Don't record this first cycle after change */
-				if (cmon[mod->cmon_index].maxtran < xfer_rate)
-					cmon[mod->cmon_index].maxtran = xfer_rate;
-				if (cmon[mod->cmon_index].maxmax < 0 ||
-				    (unsigned long)cmon[mod->cmon_index].maxmax < cywork.char_max)
-					cmon[mod->cmon_index].maxmax = cywork.char_max;
+				if (cc->maxtran < xfer_rate)
+					cc->maxtran = xfer_rate;
+				if (cc->maxmax < 0 ||
+				    (unsigned long)cc->maxmax < cywork.char_max)
+					cc->maxmax = cywork.char_max;
 			}
 			printf(_("%s: %lu ints, %lu chars; fifo: %lu thresh, %lu tmout, "
 				 "%lu max, %lu now\n"), argv[i],
@@ -235,8 +230,7 @@ static void query_tty_stats(int argc, char **argv, struct cytune_modifiers *mod)
 			printf(_("   %f int/sec; %f rec (char/sec)\n"),
 			       cywork.int_count / diff, xfer_rate);
 
-			memcpy(&cmon[mod->cmon_index].c, &cywork,
-			       sizeof(struct cyclades_monitor));
+			memcpy(&cc->c, &cywork, sizeof(struct cyclades_monitor));
 		}
 	}
 
@@ -277,7 +271,6 @@ int main(int argc, char **argv)
 
 	/* For signal routine. */
 	mod.global_argc = argc;
-	mod.global_argv = &argv;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
-- 
1.9.2

