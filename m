Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:56254 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbaG0RwX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Jul 2014 13:52:23 -0400
Received: by mail-wg0-f41.google.com with SMTP id z12so6472280wgg.24
        for <util-linux@vger.kernel.org>; Sun, 27 Jul 2014 10:52:22 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH 1/2] logger: warn when --file and command line message are combined
Date: Sun, 27 Jul 2014 18:52:14 +0100
Message-Id: <1406483535-17461-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1406483535-17461-1-git-send-email-kerolasa@iki.fi>
References: <1406483535-17461-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When --file is combined with command line arguments the later has
silently been ignored.  This commit makes user to be aware the logger
will not use command line arguments when --file is specified.

Reported-by: "Daniel 'DaB.' Baur" <debian@daniel.baur4.info>
Bug-Debian: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=467244
CC: Andreas Henriksson <andreas@fatal.se>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index afd9371..ac583fd 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -535,6 +535,7 @@ int main(int argc, char **argv)
 		.rfc5424_host = 1,
 	};
 	int ch;
+	int stdout_reopened = 0;
 #ifdef HAVE_LIBSYSTEMD
 	FILE *jfd = NULL;
 #endif
@@ -570,8 +571,8 @@ int main(int argc, char **argv)
 		switch (ch) {
 		case 'f':		/* file to log */
 			if (freopen(optarg, "r", stdin) == NULL)
-				err(EXIT_FAILURE, _("file %s"),
-				    optarg);
+				err(EXIT_FAILURE, _("file %s"), optarg);
+			stdout_reopened = 1;
 			break;
 		case 'i':		/* log process id also */
 			ctl.logflags |= LOG_PID;
@@ -642,6 +643,8 @@ int main(int argc, char **argv)
 	}
 	argc -= optind;
 	argv += optind;
+	if (stdout_reopened && argc)
+		warnx(_("--file <file> and <message> are mutually exclusive, message is ignored"));
 #ifdef HAVE_LIBSYSTEMD
 	if (jfd) {
 		int ret = journald_entry(jfd);
-- 
2.0.3

