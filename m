Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f173.google.com ([209.85.215.173]:42474 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab3H1Szs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 28 Aug 2013 14:55:48 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so3145832eak.4
        for <util-linux@vger.kernel.org>; Wed, 28 Aug 2013 11:55:46 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 20/21] last: trim trailing white spaces
Date: Wed, 28 Aug 2013 19:55:23 +0100
Message-Id: <1377716124-12491-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377716124-12491-1-git-send-email-kerolasa@iki.fi>
References: <1377716124-12491-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c       | 18 ++++++++++++++++++
 tests/expected/last/last |  4 ++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 23cc8aa..b800cee 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -349,6 +349,23 @@ static int time_formatter(const struct last_control *ctl, char *dst,
 }
 
 /*
+ *	Remove trailing spaces from a string.
+ */
+static void trim_trailing_spaces(char *s)
+{
+	char *p;
+
+	for (p = s; *p; ++p)
+		continue;
+	while (p > s && isspace(*--p))
+		continue;
+	if (p > s)
+		++p;
+	*p++ = '\n';
+	*p = '\0';
+}
+
+/*
  *	Show one line of information on screen
  */
 static int list(const struct last_control *ctl, struct utmp *p, time_t t, int what)
@@ -490,6 +507,7 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t t, int wh
 #  endif
 #endif
 
+	trim_trailing_spaces(final);
 	/*
 	 *	Print out "final" string safely.
 	 */
diff --git a/tests/expected/last/last b/tests/expected/last/last
index 772a738..baa6ebc 100644
--- a/tests/expected/last/last
+++ b/tests/expected/last/last
@@ -56,7 +56,7 @@ torvalds linux        Mon Aug 26 00:57   still logged in
 wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ full times ~~~
 rick     long         never-gonna-logo Thu Jan  1 00:00:00 1970 - Tue Jan 19 03:14:07 2038 (24855+03:14)
-torvalds linux        hobby            Mon Aug 26 00:57:08 1991   still logged in          
+torvalds linux        hobby            Mon Aug 26 00:57:08 1991   still logged in
 reboot   system boot  system-name      Wed Aug 28 18:00:00 2013 - Wed Aug 28 18:50:27 2013  (00:50)
 reboot   system boot  system-name      Wed Aug 28 16:00:00 2013 - Wed Aug 28 17:00:00 2013  (01:00)
 IPv4     root         dns-server       Wed Aug 28 13:00:00 2013 - Wed Aug 28 14:00:00 2013  (01:00)
@@ -90,7 +90,7 @@ accounti foo          nine                (01:00)
 wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ iso-8601 time ~~~
 rick     long         never-gonna-logout 1970-01-01T00:00:00+0000 - 2038-01-19T03:14:07+0000 (24855+03:14)
-torvalds linux        hobby            1991-08-26T00:57:08+0000   still logged in          
+torvalds linux        hobby            1991-08-26T00:57:08+0000   still logged in
 reboot   system boot  system-name      2013-08-28T18:00:00+0000 - 2013-08-28T18:50:27+0000  (00:50)
 reboot   system boot  system-name      2013-08-28T16:00:00+0000 - 2013-08-28T17:00:00+0000  (01:00)
 IPv4     root         dns-server       2013-08-28T13:00:00+0000 - 2013-08-28T14:00:00+0000  (01:00)
-- 
1.8.4

