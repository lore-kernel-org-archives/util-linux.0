Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:58349 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbaEDPus (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 May 2014 11:50:48 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi2so292813wib.1
        for <util-linux@vger.kernel.org>; Sun, 04 May 2014 08:50:47 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/15] cytune: deprecate undescriptive options
Date: Sun,  4 May 2014 16:49:52 +0100
Message-Id: <1399218596-21321-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The options with 'flush' in the name are not very good.  Use of 'timeout'
instead is much more appropriate.

Reviewed-by: Benno Schulenberg <bensberg@justemail.net>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/cytune.8 | 10 +++++-----
 sys-utils/cytune.c | 39 ++++++++++++++++++++++++++++-----------
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/sys-utils/cytune.8 b/sys-utils/cytune.8
index 940fa28..4f4daa9 100644
--- a/sys-utils/cytune.8
+++ b/sys-utils/cytune.8
@@ -24,7 +24,7 @@
 .\" Formatted or processed versions of this manual, if unaccompanied by
 .\" the source, must acknowledge the copyright and authors of this work.
 .\" "
-.TH CYTUNE 8 "September 2011" "util-linux" "System Administration"
+.TH CYTUNE 8 "May 2014" "util-linux" "System Administration"
 .SH NAME
 cytune \- tune driver parameters for Cyclades-Z multiport serial card
 .SH SYNOPSIS
@@ -125,7 +125,7 @@ characters.  Note that if the
 is not being held open by another process, the threshold will be reset on the
 next open.  Only values between 1 and 12, inclusive, are permitted.
 .TP
-\fB\-t\fR, \fB\-\-set\-flush\fR \fIvalue\fR
+\fB\-t\fR, \fB\-\-set\-timeout\fR \fIvalue\fR
 Set the current flush timeout to
 .I value
 units.  Note that if the
@@ -136,7 +136,7 @@ next open.  Only values between 0 and 255, inclusive, are permitted.  Setting
 to zero forces the default, currently 0x20 (160ms), but soon to be 0x02
 (10ms).  Units are 5 ms.
 .TP
-\fB\-g\fR, \fB\-\-get\-threshold\fR
+\fB\-g\fR, \fB\-\-get\-current\fR
 Get the current threshold and timeout.
 .TP
 \fB\-S\fR, \fB\-\-set\-default\-threshold\fR \fIvalue\fR
@@ -147,7 +147,7 @@ characters.  When the
 is next opened, this value will be used instead of the default.  Only values
 between 1 and 12, inclusive, are permitted.
 .TP
-\fB\-T\fR, \fB\-\-set\-default\-flush\fR \fIvalue\fR
+\fB\-T\fR, \fB\-\-set\-default\-timeout\fR \fIvalue\fR
 Set the default flush timeout to
 .I value
 units.  When the
@@ -157,7 +157,7 @@ is next opened, this value will be used instead of the default.  If
 is zero, then the value will default to 0x20 (160ms), soon to be 0x02
 (10ms).
 .TP
-\fB\-G\fR, \fB\-\-get\-glush\fR
+\fB\-G\fR, \fB\-\-get\-defaults\fR
 Get the default threshold and flush timeout values.
 .TP
 \fB\-q\fR, \fB\-\-stats\fR
diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
index 5bb1328..0f97e28 100644
--- a/sys-utils/cytune.c
+++ b/sys-utils/cytune.c
@@ -96,12 +96,12 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fprintf(out, USAGE_HEADER);
 	fprintf(out, _(" %s [options] <tty> [...]\n"), program_invocation_short_name);
 	fprintf(out, USAGE_OPTIONS);
+	fprintf(out, _(" -g, --get-current                  display current values\n"));
+	fprintf(out, _(" -G, --get-defaults                 display default values\n"));
 	fprintf(out, _(" -s, --set-threshold <num>          set interruption threshold value\n"));
-	fprintf(out, _(" -g, --get-threshold                display current threshold value\n"));
 	fprintf(out, _(" -S, --set-default-threshold <num>  set default threshold value\n"));
-	fprintf(out, _(" -t, --set-flush <num>              set flush timeout to value\n"));
-	fprintf(out, _(" -G, --get-flush                    display default flush timeout value\n"));
-	fprintf(out, _(" -T, --set-default-flush <num>      set the default flush timeout to value\n"));
+	fprintf(out, _(" -t, --set-timeout <num>            set flush timeout to value\n"));
+	fprintf(out, _(" -T, --set-default-timeout <num>    set the default flush timeout to value\n"));
 	fprintf(out, _(" -q, --stats                        display statistics about the tty\n"));
 	fprintf(out, _(" -i, --interval <seconds>           gather statistics every <seconds> interval\n"));
 	fprintf(out, USAGE_SEPARATOR);
@@ -251,13 +251,23 @@ int main(int argc, char **argv)
 	int intention_expressed = 0;
 	struct cytune_modifiers mod;
 
+	enum {	/* FIXME: remove after May 2016. */
+		OPT_GET_TRESHHOLD = CHAR_MAX + 1,
+		OPT_GET_FLUSH,
+		OPT_SET_FLUSH,
+		OPT_SET_FLUSH_DEFAULT
+	};
 	static const struct option longopts[] = {
+		{"get-threshold", no_argument, NULL, OPT_GET_TRESHHOLD},
+		{"get-flush", no_argument, NULL, OPT_GET_FLUSH},
+		{"set-flush", required_argument, NULL, OPT_SET_FLUSH},
+		{"set-default-flush", required_argument, NULL, OPT_SET_FLUSH_DEFAULT},
+		{"get-current", no_argument, NULL, 'g'},
+		{"get-defaults", no_argument, NULL, 'G'},
 		{"set-threshold", required_argument, NULL, 's'},
-		{"get-threshold", no_argument, NULL, 'g'},
 		{"set-default-threshold", required_argument, NULL, 'S'},
-		{"set-flush", required_argument, NULL, 't'},
-		{"get-flush", no_argument, NULL, 'G'},
-		{"set-default-flush", required_argument, NULL, 'T'},
+		{"set-timeout", required_argument, NULL, 't'},
+		{"set-default-timeout", required_argument, NULL, 'T'},
 		{"stats", no_argument, NULL, 'q'},
 		{"interval", required_argument, NULL, 'i'},
 		{"version", no_argument, NULL, 'V'},
@@ -276,7 +286,7 @@ int main(int argc, char **argv)
 	mod.interval = 1;
 
 	while ((i =
-		getopt_long(argc, argv, "qs:S:t:T:gGi:Vh", longopts,
+		getopt_long(argc, argv, "gGs:S:t:T:qi:Vh", longopts,
 			    NULL)) != -1) {
 		switch (i) {
 		case 'q':
@@ -306,6 +316,8 @@ int main(int argc, char **argv)
 				errx(EXIT_FAILURE, ("Invalid threshold default value: %d"),
 						    mod.threshold_def_val);
 			break;
+		case OPT_SET_FLUSH:
+			warnx(_("%s is deprecated, and will be removed in future, please use %s instead"), "--set-flush", "--set-timeout");
 		case 't':
 			mod.set_timeout = 1;
 			intention_expressed = 1;
@@ -315,6 +327,8 @@ int main(int argc, char **argv)
 				errx(EXIT_FAILURE, _("Invalid set timeout value: %d"),
 						     mod.timeout_val);
 			break;
+		case OPT_SET_FLUSH_DEFAULT:
+			warnx(_("%s is deprecated, and will be removed in future, please use %s instead"), "--set-default-flush", "--set-default-timeout");
 		case 'T':
 			mod.set_threshold_def = 1;
 			intention_expressed = 1;
@@ -324,17 +338,20 @@ int main(int argc, char **argv)
 				errx(EXIT_FAILURE, _("Invalid default time value: %d"),
 						     mod.timeout_def_val);
 			break;
+		case OPT_GET_TRESHHOLD:
+			warnx(_("%s is deprecated, and will be removed in future, please use %s instead"), "--get-threshold", "--get-current");
 		case 'g':
 			mod.get_current = 1;
 			intention_expressed = 1;
 			break;
+		case OPT_GET_FLUSH:
+			warnx(_("%s is deprecated, and will be removed in future, please use %s instead"), "--get-flush", "--get-defaults");
 		case 'G':
 			mod.get_defaults = 1;
 			intention_expressed = 1;
 			break;
 		case 'V':
-			printf(_("%s from %s\n"), program_invocation_short_name,
-			       PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
 		case 'h':
 			usage(stdout);
-- 
1.9.2

