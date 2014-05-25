Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:65261 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbaEYK7x (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 May 2014 06:59:53 -0400
Received: by mail-wi0-f171.google.com with SMTP id cc10so2859873wib.4
        for <util-linux@vger.kernel.org>; Sun, 25 May 2014 03:59:51 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/4] uuidd: set options to be mutually exclusive
Date: Sun, 25 May 2014 11:59:38 +0100
Message-Id: <1401015580-27951-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1401015580-27951-1-git-send-email-kerolasa@iki.fi>
References: <1401015580-27951-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--pid     || --no-pid
--debug   || --quiet
--timeout || --socket-activation
--random  || --time

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/uuidd.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 5730919..1f4a38b 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -37,6 +37,7 @@ extern int optind;
 #include "c.h"
 #include "closestream.h"
 #include "strutils.h"
+#include "optutils.h"
 
 #ifdef HAVE_LIBSYSTEMD
 # include <systemd/sd-daemon.h>
@@ -510,6 +511,14 @@ int main(int argc, char **argv)
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
 	};
+	static const ul_excl_t excl[] = {
+		{ 'P', 'p' },
+		{ 'S', 'T' },
+		{ 'd', 'q' },
+		{ 'r', 't' },
+		{ 0 }
+	};
+	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -519,6 +528,7 @@ int main(int argc, char **argv)
 	while ((c =
 		getopt_long(argc, argv, "p:s:T:krtn:PFSdqVh", longopts,
 			    NULL)) != -1) {
+		err_exclusive_options(c, longopts, excl, excl_st);
 		switch (c) {
 		case 'd':
 			uuidd_cxt.debug = 1;
@@ -576,9 +586,6 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (no_pid && pidfile_path_param && !uuidd_cxt.quiet)
-		warnx(_("Both --pid and --no-pid specified. Ignoring --no-pid."));
-
 	if (!no_pid && !pidfile_path_param)
 		pidfile_path = UUIDD_PIDFILE_PATH;
 	else if (pidfile_path_param)
-- 
1.9.3

