Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:45727 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3HQSQx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Aug 2013 14:16:53 -0400
Received: by mail-wg0-f51.google.com with SMTP id a12so2340729wgh.6
        for <util-linux@vger.kernel.org>; Sat, 17 Aug 2013 11:16:51 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/16] last: use ISO 8601 time format for --fulltimes
Date: Sat, 17 Aug 2013 19:15:18 +0100
Message-Id: <1376763321-22782-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
References: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The ISO 8601 format allows easy time stamp parsing, it tells which
timezone the clock is represented, and this format makes sorting and
searching very easy.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.1 |  2 +-
 login-utils/last.c | 23 +++++++++++++++++------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/login-utils/last.1 b/login-utils/last.1
index eff6fe4..c7d2aa6 100644
--- a/login-utils/last.1
+++ b/login-utils/last.1
@@ -92,7 +92,7 @@ specify that time with
 and look for "still logged in".
 .TP
 \fB\-F\fR, \fB\-\-fulltimes\fR
-Print full login and logout times and dates.
+Print full login and logout times and dates in ISO 8601 format.
 .TP
 \fB\-R\fR, \fB\-\-nohostname\fR
 Suppresses the display of the hostname field.
diff --git a/login-utils/last.c b/login-utils/last.c
index e94f1f0..24a752c 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -253,6 +253,7 @@ static int dns_lookup(char *result, int size, int useip, int32_t *a)
 static int list(struct utmp *p, time_t t, int what)
 {
 	time_t		secs, tmp;
+	struct tm	*tm;
 	char		logintime[32];
 	char		logouttime[32];
 	char		length[32];
@@ -291,10 +292,13 @@ static int list(struct utmp *p, time_t t, int what)
 	 *	Calculate times
 	 */
 	tmp = (time_t)p->ut_time;
-	strcpy(logintime, ctime(&tmp));
-	if (fulltime)
-		sprintf(logouttime, "- %s", ctime(&t));
-	else {
+	if (fulltime) {
+		tm = localtime(&tmp);
+		strftime(logintime, sizeof(logintime), "%Y-%m-%dT%H:%M:%S%z", tm);
+		tm = localtime(&t);
+		strftime(logouttime, sizeof(logouttime), "- %Y-%m-%dT%H:%M:%S%z", tm);
+	} else {
+		strcpy(logintime, ctime(&tmp));
 		logintime[16] = 0;
 		sprintf(logouttime, "- %s", ctime(&t) + 11);
 		logouttime[7] = 0;
@@ -804,8 +808,15 @@ int main(int argc, char **argv)
 		}
 	}
 
-	printf(_("\n%s begins %s"), basename(ufile), ctime(&begintime));
-
+	printf(_("\n%s begins "), basename(ufile));
+	if (fulltime) {
+		char t[32];
+		struct tm *tm;
+		tm = localtime(&begintime);
+		strftime(t, sizeof(t), "%Y-%m-%dT%H:%M:%S%z", tm);
+		puts(t);
+	} else
+		fputs(ctime(&begintime), stdout);
 	fclose(fp);
 	return EXIT_SUCCESS;
 }
-- 
1.8.3.4

