Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:44292 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbaEDPu6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 May 2014 11:50:58 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so5481166wgh.26
        for <util-linux@vger.kernel.org>; Sun, 04 May 2014 08:50:57 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 14/15] cytune: use matching type in struct cyclades_control with kernel
Date: Sun,  4 May 2014 16:49:55 +0100
Message-Id: <1399218596-21321-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/cytune.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
index c93951d..d9bc900 100644
--- a/sys-utils/cytune.c
+++ b/sys-utils/cytune.c
@@ -62,7 +62,7 @@ struct cyclades_control {
 	struct cyclades_monitor c;
 	char *filename;
 	int cfile;
-	int maxmax;
+	unsigned long maxmax;
 	double maxtran;
 	unsigned long threshold_value;
 	unsigned long timeout_value;
@@ -132,7 +132,7 @@ signal_handler(int sig __attribute__((__unused__)))
 
 	for (i = local_optind; i < argc; i++, j++) {
 		cc = &cmon[j];
-		warnx(_("File %s, For threshold value %lu, Maximum characters in fifo were %d,\n"
+		warnx(_("File %s, For threshold value %lu, Maximum characters in fifo were %lu,\n"
 			"and the maximum transfer rate in characters/second was %f"),
 		      cc->filename, cc->threshold_value, cc->maxmax, cc->maxtran);
 	}
@@ -143,7 +143,7 @@ signal_handler(int sig __attribute__((__unused__)))
 static void print_statistics(struct cyclades_control *cc, int init)
 {
 	if (0 < cc->threshold_value && !init)
-		warnx(_("File %s, For threshold value %lu and timeout value %lu, Maximum characters in fifo were %d,\n"
+		warnx(_("File %s, For threshold value %lu and timeout value %lu, Maximum characters in fifo were %lu,\n"
 			"and the maximum transfer rate in characters/second was %f"),
 		      cc->filename, cc->threshold_value, cc->timeout_value, cc->maxmax, cc->maxtran);
 	cc->maxmax = 0;
@@ -221,8 +221,7 @@ query_tty_stats(int argc, char **argv, struct cytune_modifiers *mod)
 				/* Don't record this first cycle after change */
 				if (cc->maxtran < xfer_rate)
 					cc->maxtran = xfer_rate;
-				if (cc->maxmax < 0 ||
-				    (unsigned long)cc->maxmax < cywork.char_max)
+				if (cc->maxmax < cywork.char_max)
 					cc->maxmax = cywork.char_max;
 			}
 			printf(_("%s: %lu ints, %lu chars; fifo: %lu thresh, %lu tmout, "
-- 
1.9.2

