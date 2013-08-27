Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f53.google.com ([74.125.83.53]:61557 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab3H0SHK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Aug 2013 14:07:10 -0400
Received: by mail-ee0-f53.google.com with SMTP id b15so2472399eek.12
        for <util-linux@vger.kernel.org>; Tue, 27 Aug 2013 11:07:09 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/17] last: parse easy to use time formats
Date: Tue, 27 Aug 2013 19:06:13 +0100
Message-Id: <1377626779-26030-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/Makemodule.am |  1 +
 login-utils/last.c        | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index 8d65cc5..d382ccc 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -5,6 +5,7 @@ dist_man_MANS += \
 	login-utils/last.1 \
 	login-utils/lastb.1
 last_SOURCES = login-utils/last.c lib/strutils.c
+last_LDADD = $(LDADD) libcommon.la
 
 install-exec-hook-last:
 	cd $(DESTDIR)$(usrsbin_execdir) && ln -sf last lastb
diff --git a/login-utils/last.c b/login-utils/last.c
index 3367038..df78436 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -47,6 +47,7 @@
 #include "closestream.h"
 #include "carefulputc.h"
 #include "strutils.h"
+#include "time-util.h"
 
 #ifndef SHUTDOWN_TIME
 # define SHUTDOWN_TIME 254
@@ -735,6 +736,7 @@ int main(int argc, char **argv)
 
 	time_t until = 0;	/* at what time to stop parsing the file */
 	time_t present = 0;	/* who where present at time_t */
+	usec_t p;
 
 	static const struct option long_opts[] = {
 	      { "limit",	required_argument, NULL, 'n' },
@@ -795,13 +797,19 @@ int main(int argc, char **argv)
 			break;
 		case 'p':
 			present = parsetm(optarg);
-			if (present == (time_t) -1)
+			if (present != (time_t) -1)
+				break;
+			if (parse_timestamp(optarg, &p) < 0)
 				errx(EXIT_FAILURE, _("invalid time value \"%s\""), optarg);
+			present = (time_t) (p / 1000000);
 			break;
 		case 't':
 			until = parsetm(optarg);
-			if (until == (time_t) -1)
+			if (until != (time_t) -1)
+				break;
+			if (parse_timestamp(optarg, &p) < 0)
 				errx(EXIT_FAILURE, _("invalid time value \"%s\""), optarg);
+			until = (time_t) (p / 1000000);
 			break;
 		case 'w':
 			if (UT_NAMESIZE > name_len)
-- 
1.8.4

