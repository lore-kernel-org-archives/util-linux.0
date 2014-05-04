Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:52312 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337AbaEDPuV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 May 2014 11:50:21 -0400
Received: by mail-wg0-f47.google.com with SMTP id x12so4657010wgg.6
        for <util-linux@vger.kernel.org>; Sun, 04 May 2014 08:50:20 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/15] cytune: remove unnecessary variables
Date: Sun,  4 May 2014 16:49:43 +0100
Message-Id: <1399218596-21321-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Exit immediately at error.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/cytune.c | 46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
index 544865f..64e15cc 100644
--- a/sys-utils/cytune.c
+++ b/sys-utils/cytune.c
@@ -274,9 +274,7 @@ int main(int argc, char **argv)
 {
 	int query = 0;
 	int interval = 1;
-	int errflg = 0;
 	int file;
-	int numfiles;
 	int i;
 
 	int get_current = 0;
@@ -327,49 +325,39 @@ int main(int argc, char **argv)
 		case 'i':
 			interval = strtou32_or_err(optarg,
 						_("Invalid interval value"));
-			if (interval < 1) {
-				warnx(_("Invalid interval value: %d"),
-				      interval);
-				errflg++;
-			}
+			if (interval < 1)
+				errx(EXIT_FAILURE, _("Invalid interval value: %d"),
+						     interval);
 			break;
 		case 's':
 			++set_threshold;
 			threshold_val = strtou32_or_err(optarg, _("Invalid threshold value"));
-			if (threshold_val < 1 || 12 < threshold_val) {
-				warnx(_("Invalid threshold value: %d"), threshold_val);
-				errflg++;
-			}
+			if (threshold_val < 1 || 12 < threshold_val)
+				errx(EXIT_FAILURE, _("Invalid threshold value: %d"), threshold_val);
 			break;
 		case 'S':
 			++set_threshold_def;
 			threshold_def_val = strtou32_or_err(optarg,
 						_("Invalid threshold default value"));
-			if (threshold_def_val < 0 || 12 < threshold_def_val) {
-				warnx(_("Invalid threshold default value: %d"),
-				      threshold_def_val);
-				errflg++;
-			}
+			if (threshold_def_val < 0 || 12 < threshold_def_val)
+				errx(EXIT_FAILURE, ("Invalid threshold default value: %d"),
+						    threshold_def_val);
 			break;
 		case 't':
 			++set_timeout;
 			timeout_val = strtou32_or_err(optarg,
 						_("Invalid set timeout value"));
-			if (timeout_val < 1 || 255 < timeout_val) {
-				warnx(_("Invalid set timeout value: %d"),
-				      timeout_val);
-				errflg++;
-			}
+			if (timeout_val < 1 || 255 < timeout_val)
+				errx(EXIT_FAILURE, _("Invalid set timeout value: %d"),
+						     timeout_val);
 			break;
 		case 'T':
 			++set_threshold_def;
 			timeout_def_val = strtou32_or_err(optarg,
 						_("Invalid default timeout value"));
-			if (timeout_def_val < 0 || 255 < timeout_def_val) {
-				warnx(_("Invalid default time value: %d"),
-				      timeout_def_val);
-				errflg++;
-			}
+			if (timeout_def_val < 0 || 255 < timeout_def_val)
+				errx(EXIT_FAILURE, _("Invalid default time value: %d"),
+						     timeout_def_val);
 			break;
 		case 'g':
 			++get_current;
@@ -387,10 +375,8 @@ int main(int argc, char **argv)
 			usage(stderr);
 		}
 	}
-	numfiles = argc - optind;
 
-	if (errflg
-	    || (numfiles == 0)
+	if (argc - optind == 0
 	    || (!query && !set_threshold && !set_threshold_def && !get_defaults && !get_current && !set_timeout && !set_timeout_def)
 	    || (set_threshold && set_threshold_def)
 	    || (set_timeout && set_timeout_def)
@@ -458,7 +444,7 @@ int main(int argc, char **argv)
 	if (!query)
 		return EXIT_SUCCESS;
 
-	query_tty_stats(argc, argv, interval, numfiles, &threshold_value, &timeout_value);
+	query_tty_stats(argc, argv, interval, argc - optind, &threshold_value, &timeout_value);
 
 	return EXIT_SUCCESS;
 }
-- 
1.9.2

