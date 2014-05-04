Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:49250 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbaEDPug (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 May 2014 11:50:36 -0400
Received: by mail-wg0-f52.google.com with SMTP id l18so5499448wgh.23
        for <util-linux@vger.kernel.org>; Sun, 04 May 2014 08:50:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/15] cytune: add cyg_get_mon() to avoid duplicate code
Date: Sun,  4 May 2014 16:49:48 +0100
Message-Id: <1399218596-21321-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/cytune.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
index 4cc7db6..bdaad2e 100644
--- a/sys-utils/cytune.c
+++ b/sys-utils/cytune.c
@@ -135,6 +135,17 @@ static void summary(int sig)
 	cc->timeout_value = 0;
 }
 
+static void cyg_get_mon(int fd, struct cyclades_monitor *mon, char *file,
+			unsigned long *threshold_value, unsigned long *timeout_value)
+{
+	if (ioctl(fd, CYGETMON, &mon))
+		err(EXIT_FAILURE, _("cannot issue CYGETMON on %s"), file);
+	if (ioctl(fd, CYGETTHRESH, &threshold_value))
+		err(EXIT_FAILURE, _("cannot get threshold for %s"), file);
+	if (ioctl(fd, CYGETTIMEOUT, &timeout_value))
+		err(EXIT_FAILURE, _("cannot get timeout for %s"), file);
+}
+
 static void query_tty_stats(int argc, char **argv, unsigned int interval, int numfiles,
 		     unsigned long *threshold_value,
 		     unsigned long *timeout_value)
@@ -164,18 +175,8 @@ static void query_tty_stats(int argc, char **argv, unsigned int interval, int nu
 		cmon[cmon_index].cfile = open(argv[i], O_RDONLY);
 		if (cmon[cmon_index].cfile == -1)
 			err(EXIT_FAILURE, _("cannot open %s"), argv[i]);
-		if (ioctl
-		    (cmon[cmon_index].cfile, CYGETMON, &cmon[cmon_index].c))
-			err(EXIT_FAILURE, _("cannot issue CYGETMON on %s"),
-			    argv[i]);
+		cyg_get_mon(cmon[cmon_index].cfile, &cmon[cmon_index].c, argv[i], threshold_value, timeout_value);
 		summary(-1);
-		if (ioctl
-		    (cmon[cmon_index].cfile, CYGETTHRESH, &threshold_value))
-			err(EXIT_FAILURE, _("cannot get threshold for %s"),
-			    argv[i]);
-		if (ioctl(cmon[cmon_index].cfile, CYGETTIMEOUT, &timeout_value))
-			err(EXIT_FAILURE, _("cannot get timeout for %s"),
-			    argv[i]);
 	}
 	while (1) {
 		sleep(interval);
@@ -188,21 +189,9 @@ static void query_tty_stats(int argc, char **argv, unsigned int interval, int nu
 
 		for (i = optind; i < argc; i++) {
 			cmon_index = i - optind;
-			if (ioctl(cmon[cmon_index].cfile, CYGETMON, &cywork))
-				err(EXIT_FAILURE,
-				    _("cannot issue CYGETMON on %s"), argv[i]);
-			if (ioctl
-			    (cmon[cmon_index].cfile, CYGETTHRESH,
-			     &threshold_value))
-				err(EXIT_FAILURE,
-				    _("cannot get threshold for %s"), argv[i]);
-			if (ioctl
-			    (cmon[cmon_index].cfile, CYGETTIMEOUT,
-			     &timeout_value))
-				err(EXIT_FAILURE,
-				    _("cannot get timeout for %s"), argv[i]);
-
+			cyg_get_mon(cmon[cmon_index].cfile, &cywork, argv[i], threshold_value, timeout_value);
 			xfer_rate = cywork.char_count / diff;
+
 			if ((*threshold_value) !=
 			    cmon[cmon_index].threshold_value
 			    || (*timeout_value) !=
-- 
1.9.2

