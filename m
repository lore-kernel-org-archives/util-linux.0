Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f48.google.com ([74.125.83.48]:42203 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab3H2SLE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 29 Aug 2013 14:11:04 -0400
Received: by mail-ee0-f48.google.com with SMTP id l10so420885eei.35
        for <util-linux@vger.kernel.org>; Thu, 29 Aug 2013 11:11:03 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 25/26] utmpdump: make IPv6 addresses work
Date: Thu, 29 Aug 2013 19:10:51 +0100
Message-Id: <1377799852-28461-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377799852-28461-1-git-send-email-kerolasa@iki.fi>
References: <1377799852-28461-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

(unless bug[s]) This change is backwards compatibile.  Earlier binary to
text dumps can be converted back to binary, or otherway around.

The only thing that will not work are IPv6 addresses that possible
earlier conversion had broke.  Such conversions resulted with random IPv4
in place of IPv6 address in text format, and original information is gone
forever.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/utmpdump.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index acc10db..4451363 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -85,11 +85,14 @@ static void xcleanse(char *s, int len)
 
 static void print_utline(struct utmp ut, FILE *out)
 {
-	char *addr_string, *time_string;
-	struct in_addr in;
+	const char *addr_string, *time_string;
+	char buffer[INET6_ADDRSTRLEN];
+
+	if (ut.ut_addr_v6[1] || ut.ut_addr_v6[2] || ut.ut_addr_v6[3])
+		addr_string = inet_ntop(AF_INET6, &(ut.ut_addr_v6), buffer, sizeof(buffer));
+	else
+		addr_string = inet_ntop(AF_INET, &(ut.ut_addr_v6), buffer, sizeof(buffer));
 
-	in.s_addr = ut.ut_addr;
-	addr_string = inet_ntoa(in);
 #if defined(_HAVE_UT_TV)
 	time_string = timetostr(ut.ut_tv.tv_sec);
 #else
@@ -101,7 +104,7 @@ static void print_utline(struct utmp ut, FILE *out)
 	cleanse(ut.ut_host);
 
 	/*            pid    id       user     line     host     addr       time */
-	fprintf(out, "[%d] [%05d] [%-4.4s] [%-*.*s] [%-*.*s] [%-*.*s] [%-15.15s] [%-28.28s]\n",
+	fprintf(out, "[%d] [%05d] [%-4.4s] [%-*.*s] [%-*.*s] [%-*.*s] [%-15s] [%-28.28s]\n",
 	       ut.ut_type, ut.ut_pid, ut.ut_id, 8, UT_NAMESIZE, ut.ut_user,
 	       12, UT_LINESIZE, ut.ut_line, 20, UT_HOSTSIZE, ut.ut_host,
 	       addr_string, time_string);
@@ -252,11 +255,10 @@ static int gettok(char *line, char *dest, int size, int eatspace)
 static void undump(FILE *in, FILE *out)
 {
 	struct utmp ut;
-	char s_addr[16], s_time[29], *linestart, *line;
+	char s_addr[INET6_ADDRSTRLEN + 1], s_time[29], *linestart, *line;
 	int count = 0;
 
 	linestart = xmalloc(1024 * sizeof(*linestart));
-	s_addr[15] = 0;
 	s_time[28] = 0;
 
 	while (fgets(linestart, 1023, in)) {
@@ -270,8 +272,10 @@ static void undump(FILE *in, FILE *out)
 		line += gettok(line, ut.ut_host, sizeof(ut.ut_host), 1);
 		line += gettok(line, s_addr, sizeof(s_addr) - 1, 1);
 		gettok(line, s_time, sizeof(s_time) - 1, 0);
-
-		ut.ut_addr = inet_addr(s_addr);
+		if (strchr(s_addr, '.'))
+			inet_pton(AF_INET, s_addr, &(ut.ut_addr_v6));
+		else
+			inet_pton(AF_INET6, s_addr, &(ut.ut_addr_v6));
 #if defined(_HAVE_UT_TV)
 		ut.ut_tv.tv_sec = strtotime(s_time);
 #else
-- 
1.8.4

