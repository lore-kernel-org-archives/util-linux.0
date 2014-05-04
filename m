Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:51536 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbaEDPuk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 May 2014 11:50:40 -0400
Received: by mail-wi0-f175.google.com with SMTP id f8so651378wiw.2
        for <util-linux@vger.kernel.org>; Sun, 04 May 2014 08:50:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/15] cytune: add structure to hold run time configuration
Date: Sun,  4 May 2014 16:49:49 +0100
Message-Id: <1399218596-21321-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/cytune.c | 220 +++++++++++++++++++++++++++--------------------------
 1 file changed, 113 insertions(+), 107 deletions(-)

diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
index bdaad2e..8dd566d 100644
--- a/sys-utils/cytune.c
+++ b/sys-utils/cytune.c
@@ -67,10 +67,29 @@ struct cyclades_control {
 	unsigned long timeout_value;
 };
 struct cyclades_control *cmon;
-int cmon_index;
 
-static int global_argc, global_optind;
-static char ***global_argv;
+struct cytune_modifiers {
+	int global_argc;
+	int global_optind;
+	char ***global_argv;
+	int cmon_index;
+	unsigned int interval;
+	unsigned long threshold_value;
+	unsigned long timeout_value;
+	int threshold_val;
+	int threshold_def_val;
+	int timeout_val;
+	int timeout_def_val;
+	unsigned int
+	    query:1,
+	    get_current:1,
+	    get_defaults:1,
+	    set_threshold:1,
+	    set_threshold_def:1,
+	    set_timeout:1,
+	    set_timeout_def:1;
+};
+struct cytune_modifiers mod;
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
@@ -108,13 +127,13 @@ static void summary(int sig)
 	char **argv;
 	int i;
 
-	argc = global_argc;
-	argv = *global_argv;
-	local_optind = global_optind;
+	argc = mod.global_argc;
+	argv = *mod.global_argv;
+	local_optind = mod.global_optind;
 
 	if (sig > 0) {
 		for (i = local_optind; i < argc; i++) {
-			cc = &cmon[cmon_index];
+			cc = &cmon[mod.cmon_index];
 			warnx(_("File %s, For threshold value %lu, Maximum characters in fifo were %d,\n"
 				"and the maximum transfer rate in characters/second was %f"),
 			      argv[i], cc->threshold_value, cc->maxmax,
@@ -122,11 +141,11 @@ static void summary(int sig)
 		}
 		exit(EXIT_SUCCESS);
 	}
-	cc = &cmon[cmon_index];
+	cc = &cmon[mod.cmon_index];
 	if (cc->threshold_value > 0 && sig != -1) {
 		warnx(_("File %s, For threshold value %lu and timeout value %lu, Maximum characters in fifo were %d,\n"
 			"and the maximum transfer rate in characters/second was %f"),
-		      argv[cmon_index + local_optind], cc->threshold_value,
+		      argv[mod.cmon_index + local_optind], cc->threshold_value,
 		      cc->timeout_value, cc->maxmax, cc->maxtran);
 	}
 	cc->maxmax = 0;
@@ -136,19 +155,17 @@ static void summary(int sig)
 }
 
 static void cyg_get_mon(int fd, struct cyclades_monitor *mon, char *file,
-			unsigned long *threshold_value, unsigned long *timeout_value)
+			struct cytune_modifiers *mod)
 {
 	if (ioctl(fd, CYGETMON, &mon))
 		err(EXIT_FAILURE, _("cannot issue CYGETMON on %s"), file);
-	if (ioctl(fd, CYGETTHRESH, &threshold_value))
+	if (ioctl(fd, CYGETTHRESH, &mod->threshold_value))
 		err(EXIT_FAILURE, _("cannot get threshold for %s"), file);
-	if (ioctl(fd, CYGETTIMEOUT, &timeout_value))
+	if (ioctl(fd, CYGETTIMEOUT, &mod->timeout_value))
 		err(EXIT_FAILURE, _("cannot get timeout for %s"), file);
 }
 
-static void query_tty_stats(int argc, char **argv, unsigned int interval, int numfiles,
-		     unsigned long *threshold_value,
-		     unsigned long *timeout_value)
+static void query_tty_stats(int argc, char **argv, struct cytune_modifiers *mod)
 {
 	struct cyclades_monitor cywork;
 	struct timeval lasttime, thistime;
@@ -157,7 +174,7 @@ static void query_tty_stats(int argc, char **argv, unsigned int interval, int nu
 	double xfer_rate;
 	struct sigaction sigact;
 
-	cmon = xmalloc(sizeof(struct cyclades_control) * numfiles);
+	cmon = xmalloc(sizeof(struct cyclades_control) * (argc - mod->global_optind));
 
 	sigemptyset(&sigact.sa_mask);
 	sigact.sa_handler = &summary;
@@ -171,15 +188,15 @@ static void query_tty_stats(int argc, char **argv, unsigned int interval, int nu
 		err(EXIT_FAILURE, _("gettimeofday failed"));
 
 	for (i = optind; i < argc; i++) {
-		cmon_index = i - optind;
-		cmon[cmon_index].cfile = open(argv[i], O_RDONLY);
-		if (cmon[cmon_index].cfile == -1)
+		mod->cmon_index = i - optind;
+		cmon[mod->cmon_index].cfile = open(argv[i], O_RDONLY);
+		if (cmon[mod->cmon_index].cfile == -1)
 			err(EXIT_FAILURE, _("cannot open %s"), argv[i]);
-		cyg_get_mon(cmon[cmon_index].cfile, &cmon[cmon_index].c, argv[i], threshold_value, timeout_value);
+		cyg_get_mon(cmon[mod->cmon_index].cfile, &cmon[mod->cmon_index].c, argv[i], mod);
 		summary(-1);
 	}
 	while (1) {
-		sleep(interval);
+		sleep(mod->interval);
 
 		if (gettimeofday(&thistime, NULL))
 			err(EXIT_FAILURE, _("gettimeofday failed"));
@@ -188,41 +205,41 @@ static void query_tty_stats(int argc, char **argv, unsigned int interval, int nu
 		lasttime.tv_usec = thistime.tv_usec;
 
 		for (i = optind; i < argc; i++) {
-			cmon_index = i - optind;
-			cyg_get_mon(cmon[cmon_index].cfile, &cywork, argv[i], threshold_value, timeout_value);
+			mod->cmon_index = i - optind;
+			cyg_get_mon(cmon[mod->cmon_index].cfile, &cywork, argv[i], mod);
 			xfer_rate = cywork.char_count / diff;
 
-			if ((*threshold_value) !=
-			    cmon[cmon_index].threshold_value
-			    || (*timeout_value) !=
-			    cmon[cmon_index].timeout_value) {
+			if (mod->threshold_value !=
+			    cmon[mod->cmon_index].threshold_value
+			    || mod->timeout_value !=
+			    cmon[mod->cmon_index].timeout_value) {
 				summary(-2);
 				/* Note that the summary must come before the
 				 * setting of threshold_value */
-				cmon[cmon_index].threshold_value =
-				    (*threshold_value);
-				cmon[cmon_index].timeout_value =
-				    (*timeout_value);
+				cmon[mod->cmon_index].threshold_value =
+				    mod->threshold_value;
+				cmon[mod->cmon_index].timeout_value =
+				    mod->timeout_value;
 			} else {
 				/* Don't record this first cycle after change */
-				if (xfer_rate > cmon[cmon_index].maxtran)
-					cmon[cmon_index].maxtran = xfer_rate;
-				if (cmon[cmon_index].maxmax < 0 ||
+				if (xfer_rate > cmon[mod->cmon_index].maxtran)
+					cmon[mod->cmon_index].maxtran = xfer_rate;
+				if (cmon[mod->cmon_index].maxmax < 0 ||
 				    cywork.char_max >
-				    (unsigned long)cmon[cmon_index].maxmax)
-					cmon[cmon_index].maxmax =
+				    (unsigned long)cmon[mod->cmon_index].maxmax)
+					cmon[mod->cmon_index].maxmax =
 					    cywork.char_max;
 			}
 
 			printf(_("%s: %lu ints, %lu chars; fifo: %lu thresh, %lu tmout, "
 				 "%lu max, %lu now\n"), argv[i],
 			       cywork.int_count, cywork.char_count,
-			       *threshold_value, *timeout_value, cywork.char_max,
+			       mod->threshold_value, mod->timeout_value, cywork.char_max,
 			       cywork.char_last);
 			printf(_("   %f int/sec; %f rec (char/sec)\n"),
 			       cywork.int_count / diff, xfer_rate);
 
-			memcpy(&cmon[cmon_index].c, &cywork,
+			memcpy(&cmon[mod->cmon_index].c, &cywork,
 			       sizeof(struct cyclades_monitor));
 		}
 	}
@@ -233,25 +250,10 @@ static void query_tty_stats(int argc, char **argv, unsigned int interval, int nu
 
 int main(int argc, char **argv)
 {
-	int query = 0;
-	unsigned int interval = 1;
 	int file;
 	int i;
-
-	int get_current = 0;
-	int get_defaults = 0;
-	unsigned long threshold_value;
-	unsigned long timeout_value;
-
-	int set_threshold = 0;
-	int threshold_val = -1;
-	int set_threshold_def = 0;
-	int threshold_def_val = -1;
-
-	int set_timeout = 0;
-	int timeout_val = -1;
-	int set_timeout_def = 0;
-	int timeout_def_val = -1;
+	int intention_expressed = 0;
+	struct cytune_modifiers mod;
 
 	static const struct option longopts[] = {
 		{"set-threshold", required_argument, NULL, 's'},
@@ -268,63 +270,71 @@ int main(int argc, char **argv)
 	};
 
 	/* For signal routine. */
-	global_argc = argc;
-	global_argv = &argv;
+	mod.global_argc = argc;
+	mod.global_argv = &argv;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	atexit(close_stdout);
+	mod.interval = 1;
 
 	while ((i =
 		getopt_long(argc, argv, "qs:S:t:T:gGi:Vh", longopts,
 			    NULL)) != -1) {
 		switch (i) {
 		case 'q':
-			query = 1;
+			mod.query = 1;
+			intention_expressed = 1;
 			break;
 		case 'i':
-			interval = strtou32_or_err(optarg,
+			mod.interval = strtou32_or_err(optarg,
 						_("Invalid interval value"));
-			if (interval < 1)
+			if (mod.interval < 1)
 				errx(EXIT_FAILURE, _("Invalid interval value: %d"),
-						     interval);
+						     mod.interval);
 			break;
 		case 's':
-			++set_threshold;
-			threshold_val = strtou32_or_err(optarg, _("Invalid threshold value"));
-			if (threshold_val < 1 || 12 < threshold_val)
-				errx(EXIT_FAILURE, _("Invalid threshold value: %d"), threshold_val);
+			mod.set_threshold = 1;
+			intention_expressed = 1;
+			mod.threshold_val = strtou32_or_err(optarg, _("Invalid threshold value"));
+			if (mod.threshold_val < 1 || 12 < mod.threshold_val)
+				errx(EXIT_FAILURE, _("Invalid threshold value: %d"), mod.threshold_val);
 			break;
 		case 'S':
-			++set_threshold_def;
-			threshold_def_val = strtou32_or_err(optarg,
+			mod.set_threshold_def = 1;
+			intention_expressed = 1;
+			mod.threshold_def_val = strtou32_or_err(optarg,
 						_("Invalid threshold default value"));
-			if (threshold_def_val < 0 || 12 < threshold_def_val)
+			if (mod.threshold_def_val < 0 || 12 < mod.threshold_def_val)
 				errx(EXIT_FAILURE, ("Invalid threshold default value: %d"),
-						    threshold_def_val);
+						    mod.threshold_def_val);
 			break;
 		case 't':
-			++set_timeout;
-			timeout_val = strtou32_or_err(optarg,
+			mod.set_timeout = 1;
+			intention_expressed = 1;
+			mod.timeout_val = strtou32_or_err(optarg,
 						_("Invalid set timeout value"));
-			if (timeout_val < 1 || 255 < timeout_val)
+			if (mod.timeout_val < 1 || 255 < mod.timeout_val)
 				errx(EXIT_FAILURE, _("Invalid set timeout value: %d"),
-						     timeout_val);
+						     mod.timeout_val);
 			break;
 		case 'T':
-			++set_threshold_def;
-			timeout_def_val = strtou32_or_err(optarg,
+			mod.set_threshold_def = 1;
+			intention_expressed = 1;
+			mod.timeout_def_val = strtou32_or_err(optarg,
 						_("Invalid default timeout value"));
-			if (timeout_def_val < 0 || 255 < timeout_def_val)
+			if (mod.timeout_def_val < 0 || 255 < mod.timeout_def_val)
 				errx(EXIT_FAILURE, _("Invalid default time value: %d"),
-						     timeout_def_val);
+						     mod.timeout_def_val);
 			break;
 		case 'g':
-			++get_current;
+			mod.get_current = 1;
+			intention_expressed = 1;
 			break;
 		case 'G':
-			++get_defaults;
+			mod.get_defaults = 1;
+			intention_expressed = 1;
 			break;
 		case 'V':
 			printf(_("%s from %s\n"), program_invocation_short_name,
@@ -337,60 +347,56 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (argc - optind == 0
-	    || (!query && !set_threshold && !set_threshold_def && !get_defaults && !get_current && !set_timeout && !set_timeout_def)
-	    || (set_threshold && set_threshold_def)
-	    || (set_timeout && set_timeout_def)
-	    || (get_defaults && get_current))
+	if (argc - optind == 0 || !intention_expressed)
 		usage(stderr);
 
 	/* For signal routine. */
-	global_optind = optind;
+	mod.global_optind = optind;
 
 	for (i = optind; i < argc; i++) {
 		file = open(argv[i], O_RDONLY);
 		if (file == -1)
 			err(EXIT_FAILURE, _("cannot open %s"), argv[i]);
 
-		if (set_threshold)
-			if (ioctl(file, CYSETTHRESH, threshold_val))
-				err(EXIT_FAILURE, _("cannot set %s to threshold %d"), argv[i], threshold_val);
+		if (mod.set_threshold)
+			if (ioctl(file, CYSETTHRESH, mod.threshold_val))
+				err(EXIT_FAILURE, _("cannot set %s to threshold %d"), argv[i], mod.threshold_val);
 
-		if (set_threshold_def)
-			if (ioctl(file, CYSETDEFTHRESH, threshold_def_val))
-				err(EXIT_FAILURE, _("cannot set %s to threshold %d"), argv[i], threshold_def_val);
+		if (mod.set_threshold_def)
+			if (ioctl(file, CYSETDEFTHRESH, mod.threshold_def_val))
+				err(EXIT_FAILURE, _("cannot set %s to threshold %d"), argv[i], mod.threshold_def_val);
 
-		if (set_timeout)
-			if (ioctl(file, CYSETTIMEOUT, timeout_val))
-				err(EXIT_FAILURE, _("cannot set %s to time threshold %d"), argv[i], timeout_val);
+		if (mod.set_timeout)
+			if (ioctl(file, CYSETTIMEOUT, mod.timeout_val))
+				err(EXIT_FAILURE, _("cannot set %s to time threshold %d"), argv[i], mod.timeout_val);
 
-		if (set_timeout_def)
-			if (ioctl(file, CYSETDEFTIMEOUT, timeout_def_val))
-				err(EXIT_FAILURE, _("cannot set %s to time threshold %d"), argv[i], timeout_def_val);
+		if (mod.set_timeout_def)
+			if (ioctl(file, CYSETDEFTIMEOUT, mod.timeout_def_val))
+				err(EXIT_FAILURE, _("cannot set %s to time threshold %d"), argv[i], mod.timeout_def_val);
 
-		if (get_defaults) {
-			if (ioctl(file, CYGETDEFTHRESH, &threshold_value))
+		if (mod.get_defaults) {
+			if (ioctl(file, CYGETDEFTHRESH, &mod.threshold_value))
 				err(EXIT_FAILURE, _("cannot get threshold for %s"), argv[i]);
-			if (ioctl(file, CYGETDEFTIMEOUT, &timeout_value))
+			if (ioctl(file, CYGETDEFTIMEOUT, &mod.timeout_value))
 				err(EXIT_FAILURE, _("cannot get timeout for %s"), argv[i]);
 			printf(_("%s: %ld default threshold and %ld default timeout\n"),
-			       argv[i], threshold_value, timeout_value);
+			       argv[i], mod.threshold_value, mod.timeout_value);
 		}
 
-		if (get_current) {
-			if (ioctl(file, CYGETTHRESH, &threshold_value))
+		if (mod.get_current) {
+			if (ioctl(file, CYGETTHRESH, &mod.threshold_value))
 				err(EXIT_FAILURE, _("cannot get threshold for %s"), argv[i]);
-			if (ioctl(file, CYGETTIMEOUT, &timeout_value))
+			if (ioctl(file, CYGETTIMEOUT, &mod.timeout_value))
 				err(EXIT_FAILURE, _("cannot get timeout for %s"), argv[i]);
 			printf(_("%s: %ld current threshold and %ld current timeout\n"),
-			       argv[i], threshold_value, timeout_value);
+			       argv[i], mod.threshold_value, mod.timeout_value);
 		}
 
 		close(file);
 	}
 
-	if (query)
-		query_tty_stats(argc, argv, interval, argc - optind, &threshold_value, &timeout_value);
+	if (mod.query)
+		query_tty_stats(argc, argv, &mod);
 
 	return EXIT_SUCCESS;
 }
-- 
1.9.2

