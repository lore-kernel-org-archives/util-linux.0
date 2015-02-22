Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:40656 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbbBVOmm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:42 -0500
Received: by wesx3 with SMTP id x3so13586111wes.7
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:41 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 12/13] rtcwake: make some command line options mutually exclusive
Date: Sun, 22 Feb 2015 14:42:18 +0000
Message-Id: <1424616139-638-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/rtcwake.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index e6f2170..32a0ba0 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -36,6 +36,7 @@
 #include "c.h"
 #include "closestream.h"
 #include "nls.h"
+#include "optutils.h"
 #include "pathnames.h"
 #include "strutils.h"
 #include "timeutils.h"
@@ -411,6 +412,11 @@ int main(int argc, char **argv)
 		{"date",	required_argument,	0, OPT_DATE},
 		{0,		0,			0, 0  }
 	};
+	static const ul_excl_t excl[] = {
+		{ 'a', 'l', 'u' },
+		{ 's', 't', OPT_DATE },
+	};
+	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -418,6 +424,7 @@ int main(int argc, char **argv)
 	atexit(close_stdout);
 	while ((t = getopt_long(argc, argv, "A:ahd:lm:ns:t:uVv",
 					long_options, NULL)) != EOF) {
+		err_exclusive_options(t, long_options, excl, excl_st);
 		switch (t) {
 		case 'A':
 			/* for better compatibility with hwclock */
-- 
2.3.0

