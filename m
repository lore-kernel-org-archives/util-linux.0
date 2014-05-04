Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36353 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbaEDPuT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 May 2014 11:50:19 -0400
Received: by mail-wi0-f176.google.com with SMTP id n15so1705973wiw.15
        for <util-linux@vger.kernel.org>; Sun, 04 May 2014 08:50:17 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/15] cytune: rename threshold and timeout variables
Date: Sun,  4 May 2014 16:49:42 +0100
Message-Id: <1399218596-21321-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Especially the treshold was difficult to read, as the variable name had
no reference what it was setting.  Effect of the variables
s/get/get_current/ and s/get_def/get_defaults/ seem to documented wrong
way, that became apparent after looking into this name space.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/cytune.c | 101 +++++++++++++++++++++++++++--------------------------
 1 file changed, 52 insertions(+), 49 deletions(-)

diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
index 8a42f96..544865f 100644
--- a/sys-utils/cytune.c
+++ b/sys-utils/cytune.c
@@ -274,23 +274,26 @@ int main(int argc, char **argv)
 {
 	int query = 0;
 	int interval = 1;
-	int set = 0;
-	int set_val = -1;
-	int get = 0;
-	int set_def = 0;
-	int set_def_val = -1;
-	int get_def = 0;
-	int set_time = 0;
-	int set_time_val = -1;
-	int set_def_time = 0;
-	int set_def_time_val = -1;
 	int errflg = 0;
 	int file;
 	int numfiles;
 	int i;
+
+	int get_current = 0;
+	int get_defaults = 0;
 	unsigned long threshold_value;
 	unsigned long timeout_value;
 
+	int set_threshold = 0;
+	int threshold_val = -1;
+	int set_threshold_def = 0;
+	int threshold_def_val = -1;
+
+	int set_timeout = 0;
+	int timeout_val = -1;
+	int set_timeout_def = 0;
+	int timeout_def_val = -1;
+
 	static const struct option longopts[] = {
 		{"set-threshold", required_argument, NULL, 's'},
 		{"get-threshold", no_argument, NULL, 'g'},
@@ -331,48 +334,48 @@ int main(int argc, char **argv)
 			}
 			break;
 		case 's':
-			++set;
-			set_val = strtou32_or_err(optarg, _("Invalid set value"));
-			if (set_val < 1 || 12 < set_val) {
-				warnx(_("Invalid set value: %d"), set_val);
+			++set_threshold;
+			threshold_val = strtou32_or_err(optarg, _("Invalid threshold value"));
+			if (threshold_val < 1 || 12 < threshold_val) {
+				warnx(_("Invalid threshold value: %d"), threshold_val);
 				errflg++;
 			}
 			break;
 		case 'S':
-			++set_def;
-			set_def_val = strtou32_or_err(optarg,
-						_("Invalid default value"));
-			if (set_def_val < 0 || 12 < set_def_val) {
-				warnx(_("Invalid default value: %d"),
-				      set_def_val);
+			++set_threshold_def;
+			threshold_def_val = strtou32_or_err(optarg,
+						_("Invalid threshold default value"));
+			if (threshold_def_val < 0 || 12 < threshold_def_val) {
+				warnx(_("Invalid threshold default value: %d"),
+				      threshold_def_val);
 				errflg++;
 			}
 			break;
 		case 't':
-			++set_time;
-			set_time_val = strtou32_or_err(optarg,
-						_("Invalid set time value"));
-			if (set_time_val < 1 || 255 < set_time_val) {
-				warnx(_("Invalid set time value: %d"),
-				      set_time_val);
+			++set_timeout;
+			timeout_val = strtou32_or_err(optarg,
+						_("Invalid set timeout value"));
+			if (timeout_val < 1 || 255 < timeout_val) {
+				warnx(_("Invalid set timeout value: %d"),
+				      timeout_val);
 				errflg++;
 			}
 			break;
 		case 'T':
-			++set_def_time;
-			set_def_time_val = strtou32_or_err(optarg,
-						_("Invalid default time value"));
-			if (set_def_time_val < 0 || 255 < set_def_time_val) {
+			++set_threshold_def;
+			timeout_def_val = strtou32_or_err(optarg,
+						_("Invalid default timeout value"));
+			if (timeout_def_val < 0 || 255 < timeout_def_val) {
 				warnx(_("Invalid default time value: %d"),
-				      set_def_time_val);
+				      timeout_def_val);
 				errflg++;
 			}
 			break;
 		case 'g':
-			++get;
+			++get_current;
 			break;
 		case 'G':
-			++get_def;
+			++get_defaults;
 			break;
 		case 'V':
 			printf(_("%s from %s\n"), program_invocation_short_name,
@@ -388,62 +391,62 @@ int main(int argc, char **argv)
 
 	if (errflg
 	    || (numfiles == 0)
-	    || (!query && !set && !set_def && !get && !get_def && !set_time && !set_def_time)
-	    || (set && set_def)
-	    || (set_time && set_def_time)
-	    || (get && get_def))
+	    || (!query && !set_threshold && !set_threshold_def && !get_defaults && !get_current && !set_timeout && !set_timeout_def)
+	    || (set_threshold && set_threshold_def)
+	    || (set_timeout && set_timeout_def)
+	    || (get_defaults && get_current))
 		usage(stderr);
 
 	/* For signal routine. */
 	global_optind = optind;
 
-	if (set || set_def) {
+	if (set_threshold || set_threshold_def) {
 		for (i = optind; i < argc; i++) {
 			file = open(argv[i], O_RDONLY);
 			if (file == -1)
 				err(EXIT_FAILURE, _("cannot open %s"), argv[i]);
 			if (ioctl(file,
-				  set ? CYSETTHRESH : CYSETDEFTHRESH,
-				  set ? set_val : set_def_val))
+				  set_threshold ? CYSETTHRESH : CYSETDEFTHRESH,
+				  set_threshold ? threshold_val : threshold_def_val))
 				err(EXIT_FAILURE,
 				    _("cannot set %s to threshold %d"), argv[i],
-				    set ? set_val : set_def_val);
+				    set_threshold ? threshold_val : threshold_def_val);
 			close(file);
 		}
 	}
-	if (set_time || set_def_time) {
+	if (set_timeout || set_timeout_def) {
 		for (i = optind; i < argc; i++) {
 			file = open(argv[i], O_RDONLY);
 			if (file == -1)
 				err(EXIT_FAILURE, _("cannot open %s"), argv[i]);
 			if (ioctl(file,
-				  set_time ? CYSETTIMEOUT : CYSETDEFTIMEOUT,
-				  set_time ? set_time_val : set_def_time_val))
+				  set_timeout ? CYSETTIMEOUT : CYSETDEFTIMEOUT,
+				  set_timeout ? timeout_val : timeout_def_val))
 				err(EXIT_FAILURE,
 				    _("cannot set %s to time threshold %d"),
 				    argv[i],
-				    set_time ? set_time_val : set_def_time_val);
+				    set_timeout ? timeout_val : timeout_def_val);
 			close(file);
 		}
 	}
 
-	if (get || get_def) {
+	if (get_defaults || get_current) {
 		for (i = optind; i < argc; i++) {
 			file = open(argv[i], O_RDONLY);
 			if (file == -1)
 				err(EXIT_FAILURE, _("cannot open %s"), argv[i]);
 			if (ioctl
-			    (file, get ? CYGETTHRESH : CYGETDEFTHRESH,
+			    (file, get_defaults ? CYGETTHRESH : CYGETDEFTHRESH,
 			     &threshold_value))
 				err(EXIT_FAILURE,
 				    _("cannot get threshold for %s"), argv[i]);
 			if (ioctl
-			    (file, get ? CYGETTIMEOUT : CYGETDEFTIMEOUT,
+			    (file, get_current ? CYGETTIMEOUT : CYGETDEFTIMEOUT,
 			     &timeout_value))
 				err(EXIT_FAILURE,
 				    _("cannot get timeout for %s"), argv[i]);
 			close(file);
-			if (get)
+			if (get_defaults)
 				printf(_("%s: %ld current threshold and %ld current timeout\n"),
 					argv[i], threshold_value, timeout_value);
 			else
-- 
1.9.2

