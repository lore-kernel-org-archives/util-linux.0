Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:38629 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337AbaEDPu1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 May 2014 11:50:27 -0400
Received: by mail-wg0-f52.google.com with SMTP id l18so5500899wgh.11
        for <util-linux@vger.kernel.org>; Sun, 04 May 2014 08:50:26 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/15] cytune: use single loop for setting and getting ioctl() calls
Date: Sun,  4 May 2014 16:49:45 +0100
Message-Id: <1399218596-21321-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This commit also fixes functional bug.  Documentation gives an idea one
might set current, and default values in one go but as a matter of fact
that did not work earlier.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/cytune.c | 93 +++++++++++++++++++++++-------------------------------
 1 file changed, 39 insertions(+), 54 deletions(-)

diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
index 63f6980..995a75f 100644
--- a/sys-utils/cytune.c
+++ b/sys-utils/cytune.c
@@ -386,65 +386,50 @@ int main(int argc, char **argv)
 	/* For signal routine. */
 	global_optind = optind;
 
-	if (set_threshold || set_threshold_def) {
-		for (i = optind; i < argc; i++) {
-			file = open(argv[i], O_RDONLY);
-			if (file == -1)
-				err(EXIT_FAILURE, _("cannot open %s"), argv[i]);
-			if (ioctl(file,
-				  set_threshold ? CYSETTHRESH : CYSETDEFTHRESH,
-				  set_threshold ? threshold_val : threshold_def_val))
-				err(EXIT_FAILURE,
-				    _("cannot set %s to threshold %d"), argv[i],
-				    set_threshold ? threshold_val : threshold_def_val);
-			close(file);
-		}
-	}
-	if (set_timeout || set_timeout_def) {
-		for (i = optind; i < argc; i++) {
-			file = open(argv[i], O_RDONLY);
-			if (file == -1)
-				err(EXIT_FAILURE, _("cannot open %s"), argv[i]);
-			if (ioctl(file,
-				  set_timeout ? CYSETTIMEOUT : CYSETDEFTIMEOUT,
-				  set_timeout ? timeout_val : timeout_def_val))
-				err(EXIT_FAILURE,
-				    _("cannot set %s to time threshold %d"),
-				    argv[i],
-				    set_timeout ? timeout_val : timeout_def_val);
-			close(file);
+	for (i = optind; i < argc; i++) {
+		file = open(argv[i], O_RDONLY);
+		if (file == -1)
+			err(EXIT_FAILURE, _("cannot open %s"), argv[i]);
+
+		if (set_threshold)
+			if (ioctl(file, CYSETTHRESH, threshold_val))
+				err(EXIT_FAILURE, _("cannot set %s to threshold %d"), argv[i], threshold_val);
+
+		if (set_threshold_def)
+			if (ioctl(file, CYSETDEFTHRESH, threshold_def_val))
+				err(EXIT_FAILURE, _("cannot set %s to threshold %d"), argv[i], threshold_def_val);
+
+		if (set_timeout)
+			if (ioctl(file, CYSETTIMEOUT, timeout_val))
+				err(EXIT_FAILURE, _("cannot set %s to time threshold %d"), argv[i], timeout_val);
+
+		if (set_timeout_def)
+			if (ioctl(file, CYSETDEFTIMEOUT, timeout_def_val))
+				err(EXIT_FAILURE, _("cannot set %s to time threshold %d"), argv[i], timeout_def_val);
+
+		if (get_defaults) {
+			if (ioctl(file, CYGETDEFTHRESH, &threshold_value))
+				err(EXIT_FAILURE, _("cannot get threshold for %s"), argv[i]);
+			if (ioctl(file, CYGETDEFTIMEOUT, &timeout_value))
+				err(EXIT_FAILURE, _("cannot get timeout for %s"), argv[i]);
+			printf(_("%s: %ld default threshold and %ld default timeout\n"),
+			       argv[i], threshold_value, timeout_value);
 		}
-	}
 
-	if (get_defaults || get_current) {
-		for (i = optind; i < argc; i++) {
-			file = open(argv[i], O_RDONLY);
-			if (file == -1)
-				err(EXIT_FAILURE, _("cannot open %s"), argv[i]);
-			if (ioctl
-			    (file, get_defaults ? CYGETTHRESH : CYGETDEFTHRESH,
-			     &threshold_value))
-				err(EXIT_FAILURE,
-				    _("cannot get threshold for %s"), argv[i]);
-			if (ioctl
-			    (file, get_current ? CYGETTIMEOUT : CYGETDEFTIMEOUT,
-			     &timeout_value))
-				err(EXIT_FAILURE,
-				    _("cannot get timeout for %s"), argv[i]);
-			close(file);
-			if (get_defaults)
-				printf(_("%s: %ld current threshold and %ld current timeout\n"),
-					argv[i], threshold_value, timeout_value);
-			else
-				printf(_("%s: %ld default threshold and %ld default timeout\n"),
-					argv[i], threshold_value, timeout_value);
+		if (get_current) {
+			if (ioctl(file, CYGETTHRESH, &threshold_value))
+				err(EXIT_FAILURE, _("cannot get threshold for %s"), argv[i]);
+			if (ioctl(file, CYGETTIMEOUT, &timeout_value))
+				err(EXIT_FAILURE, _("cannot get timeout for %s"), argv[i]);
+			printf(_("%s: %ld current threshold and %ld current timeout\n"),
+			       argv[i], threshold_value, timeout_value);
 		}
-	}
 
-	if (!query)
-		return EXIT_SUCCESS;
+		close(file);
+	}
 
-	query_tty_stats(argc, argv, interval, argc - optind, &threshold_value, &timeout_value);
+	if (query)
+		query_tty_stats(argc, argv, interval, argc - optind, &threshold_value, &timeout_value);
 
 	return EXIT_SUCCESS;
 }
-- 
1.9.2

