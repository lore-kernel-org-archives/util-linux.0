Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f171.google.com ([209.85.215.171]:38428 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab3H1Szv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 28 Aug 2013 14:55:51 -0400
Received: by mail-ea0-f171.google.com with SMTP id n15so3150591ead.16
        for <util-linux@vger.kernel.org>; Wed, 28 Aug 2013 11:55:49 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 21/21] last: tell verbally system is still running
Date: Wed, 28 Aug 2013 19:55:24 +0100
Message-Id: <1377716124-12491-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377716124-12491-1-git-send-email-kerolasa@iki.fi>
References: <1377716124-12491-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use of uptime time stamp as previous boot login time makes the output not
constant, which is rather difficult to test.  Verbal message 'system is
still running' makes testing easy, and noticing which boot is still
running clear to a person.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c       | 13 +++++++++++--
 tests/expected/last/last | 10 +++++-----
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index b800cee..21adf2a 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -370,7 +370,7 @@ static void trim_trailing_spaces(char *s)
  */
 static int list(const struct last_control *ctl, struct utmp *p, time_t t, int what)
 {
-	time_t		secs, tmp;
+	time_t		secs, tmp, epoch;
 	char		logintime[LAST_TIMESTAMP_LEN];
 	char		logouttime[LAST_TIMESTAMP_LEN];
 	char		length[LAST_TIMESTAMP_LEN];
@@ -421,7 +421,16 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t t, int wh
 	mins  = (secs / 60) % 60;
 	hours = (secs / 3600) % 24;
 	days  = secs / 86400;
-	if (days)
+
+	epoch = time(NULL);
+	if (t == epoch) {
+		if (ctl->fulltime)
+			sprintf(logouttime, "  still running");
+		else {
+			sprintf(logouttime, "  still");
+			sprintf(length, "running");
+		}
+	} else if (days)
 		sprintf(length, "(%d+%02d:%02d)", days, hours, mins);
 	else
 		sprintf(length, " (%02d:%02d)", hours, mins);
diff --git a/tests/expected/last/last b/tests/expected/last/last
index baa6ebc..2ff5cc1 100644
--- a/tests/expected/last/last
+++ b/tests/expected/last/last
@@ -1,7 +1,7 @@
 ~~~ basic output ~~~
 rick     long         never-gonna-logo Thu Jan  1 00:00 - 03:14 (24855+03:14)
 torvalds linux        hobby            Mon Aug 26 00:57   still logged in
-reboot   system boot  system-name      Wed Aug 28 18:00 - 18:50  (00:50)
+reboot   system boot  system-name      Wed Aug 28 18:00   still running
 reboot   system boot  system-name      Wed Aug 28 16:00 - 17:00  (01:00)
 IPv4     root         dns-server       Wed Aug 28 13:00 - 14:00  (01:00)
 nonvalid foo          zero             Wed Aug 28 12:00 - down   (03:00)
@@ -18,7 +18,7 @@ wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ include system ~~~
 rick     long         never-gonna-logo Thu Jan  1 00:00 - 03:14 (24855+03:14)
 torvalds linux        hobby            Mon Aug 26 00:57   still logged in
-reboot   system boot  system-name      Wed Aug 28 18:00 - 18:50  (00:50)
+reboot   system boot  system-name      Wed Aug 28 18:00   still running
 shutdown system down  system-name      Wed Aug 28 17:00 - 18:00  (01:00)
 reboot   system boot  system-name      Wed Aug 28 16:00 - 17:00  (01:00)
 shutdown system down  system-name      Wed Aug 28 15:00 - 16:00  (01:00)
@@ -57,7 +57,7 @@ wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ full times ~~~
 rick     long         never-gonna-logo Thu Jan  1 00:00:00 1970 - Tue Jan 19 03:14:07 2038 (24855+03:14)
 torvalds linux        hobby            Mon Aug 26 00:57:08 1991   still logged in
-reboot   system boot  system-name      Wed Aug 28 18:00:00 2013 - Wed Aug 28 18:50:27 2013  (00:50)
+reboot   system boot  system-name      Wed Aug 28 18:00:00 2013   still running
 reboot   system boot  system-name      Wed Aug 28 16:00:00 2013 - Wed Aug 28 17:00:00 2013  (01:00)
 IPv4     root         dns-server       Wed Aug 28 13:00:00 2013 - Wed Aug 28 14:00:00 2013  (01:00)
 nonvalid foo          zero             Wed Aug 28 12:00:00 2013 - down                      (03:00)
@@ -74,7 +74,7 @@ wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ no time ~~~
 rick     long         never-gonna-logo   (24855+03:14)
 torvalds linux        hobby              logged in
-reboot   system boot  system-name         (00:50)
+reboot   system boot  system-name        running
 reboot   system boot  system-name         (01:00)
 IPv4     root         dns-server          (01:00)
 nonvalid foo          zero                (03:00)
@@ -91,7 +91,7 @@ wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ iso-8601 time ~~~
 rick     long         never-gonna-logout 1970-01-01T00:00:00+0000 - 2038-01-19T03:14:07+0000 (24855+03:14)
 torvalds linux        hobby            1991-08-26T00:57:08+0000   still logged in
-reboot   system boot  system-name      2013-08-28T18:00:00+0000 - 2013-08-28T18:50:27+0000  (00:50)
+reboot   system boot  system-name      2013-08-28T18:00:00+0000   still running
 reboot   system boot  system-name      2013-08-28T16:00:00+0000 - 2013-08-28T17:00:00+0000  (01:00)
 IPv4     root         dns-server       2013-08-28T13:00:00+0000 - 2013-08-28T14:00:00+0000  (01:00)
 nonvalid foo          zero             2013-08-28T12:00:00+0000 - down                      (03:00)
-- 
1.8.4

