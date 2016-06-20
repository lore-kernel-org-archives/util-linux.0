Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f195.google.com ([209.85.217.195]:36120 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbcFTUlH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 20 Jun 2016 16:41:07 -0400
Received: by mail-lb0-f195.google.com with SMTP id z2so160640lbu.3
        for <util-linux@vger.kernel.org>; Mon, 20 Jun 2016 13:40:46 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/6] utmpdump: use iso-8601 timestamp format with subsecond accuracy
Date: Mon, 20 Jun 2016 21:40:34 +0100
Message-Id: <20160620204037.3292-4-kerolasa@iki.fi>
In-Reply-To: <20160620204037.3292-1-kerolasa@iki.fi>
References: <20160620204037.3292-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Newer 'struct utmp' is using 'struct timeval' to represent login and logout
times, so include the maximum accuracy to textual utmp format.  Notice that
this change does not remove support of converting earlier textual formats
back to binary.  But conversions from binary to former format will no longer
be available.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/Makemodule.am |  1 +
 login-utils/utmpdump.c    | 63 ++++++++++++++++++++++++++++-------------------
 2 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index 502ecd5..be07ace 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -67,6 +67,7 @@ if BUILD_UTMPDUMP
 usrbin_exec_PROGRAMS += utmpdump
 dist_man_MANS += login-utils/utmpdump.1
 utmpdump_SOURCES = login-utils/utmpdump.c
+utmpdump_LDADD = $(LDADD) libcommon.la
 endif
 
 
diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index 6eaf202..1849a4e 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -42,22 +42,10 @@
 
 #include "c.h"
 #include "nls.h"
+#include "timeutils.h"
 #include "xalloc.h"
 #include "closestream.h"
 
-static char *timetostr(const time_t time)
-{
-	static char s[29];	/* [Tue Sep 01 00:00:00 1998 GMT] */
-	struct tm *tmp;
-
-	if (time != 0 && (tmp = gmtime(&time)))
-		strftime(s, 29, "%a %b %d %T %Y %Z", tmp);
-	else
-		s[0] = '\0';
-
-	return s;
-}
-
 static time_t strtotime(const char *s_time)
 {
 	struct tm tm;
@@ -67,15 +55,32 @@ static time_t strtotime(const char *s_time)
 	if (s_time[0] == ' ' || s_time[0] == '\0')
 		return (time_t)0;
 
-	strptime(s_time, "%a %b %d %T %Y", &tm);
-
-	/* Cheesy way of checking for DST */
-	if (s_time[26] == 'D')
-		tm.tm_isdst = 1;
-
+	if (isdigit(s_time[0])) {
+		/* [1998-09-01T01:00:00,000000+00:00]
+		 * Subseconds are parsed with strtousec().  Timezone is
+		 * always UTC-0 */
+		strptime(s_time, "%Y-%m-%dT%H:%M:%S", &tm);
+	} else {
+		/* [Tue Sep 01 00:00:00 1998 GMT] */
+		strptime(s_time, "%a %b %d %T %Y", &tm);
+		/* Cheesy way of checking for DST.  This could be needed
+		 * with legacy dumps that used localtime(3).  */
+		if (s_time[26] == 'D')
+			tm.tm_isdst = 1;
+	}
 	return timegm(&tm);
 }
 
+#if defined(_HAVE_UT_TV)
+static suseconds_t strtousec(const char *s_time)
+{
+	const char *s = strchr(s_time, ',');
+	if (s)
+		return (suseconds_t) atoi(s + 1);
+	return 0;
+}
+#endif
+
 #define cleanse(x) xcleanse(x, sizeof(x))
 static void xcleanse(char *s, int len)
 {
@@ -86,26 +91,31 @@ static void xcleanse(char *s, int len)
 
 static void print_utline(struct utmp *ut, FILE *out)
 {
-	const char *addr_string, *time_string;
+	const char *addr_string;
 	char buffer[INET6_ADDRSTRLEN];
+	char time_string[40];
+	struct timeval tv;
 
 	if (ut->ut_addr_v6[1] || ut->ut_addr_v6[2] || ut->ut_addr_v6[3])
 		addr_string = inet_ntop(AF_INET6, &(ut->ut_addr_v6), buffer, sizeof(buffer));
 	else
 		addr_string = inet_ntop(AF_INET, &(ut->ut_addr_v6), buffer, sizeof(buffer));
 
-#if defined(_HAVE_UT_TV)
-	time_string = timetostr(ut->ut_tv.tv_sec);
-#else
-	time_string = timetostr((time_t)ut->ut_time);	/* ut_time is not always a time_t */
-#endif
+	tv.tv_sec = ut->ut_tv.tv_sec;
+	tv.tv_usec = ut->ut_tv.tv_usec;
+
+	if (strtimeval_iso(&tv,
+			   ISO_8601_DATE | ISO_8601_TIME | ISO_8601_COMMAUSEC |
+			   ISO_8601_TIMEZONE | ISO_8601_GMTIME, time_string,
+			   sizeof(time_string)) != 0)
+		return;
 	cleanse(ut->ut_id);
 	cleanse(ut->ut_user);
 	cleanse(ut->ut_line);
 	cleanse(ut->ut_host);
 
 	/*            pid    id       user     line     host     addr       time */
-	fprintf(out, "[%d] [%05d] [%-4.4s] [%-*.*s] [%-*.*s] [%-*.*s] [%-15s] [%-28.28s]\n",
+	fprintf(out, "[%d] [%05d] [%-4.4s] [%-*.*s] [%-*.*s] [%-*.*s] [%-15s] [%s]\n",
 	       ut->ut_type, ut->ut_pid, ut->ut_id, 8, UT_NAMESIZE, ut->ut_user,
 	       12, UT_LINESIZE, ut->ut_line, 20, UT_HOSTSIZE, ut->ut_host,
 	       addr_string, time_string);
@@ -279,6 +289,7 @@ static void undump(FILE *in, FILE *out)
 			inet_pton(AF_INET6, s_addr, &(ut.ut_addr_v6));
 #if defined(_HAVE_UT_TV)
 		ut.ut_tv.tv_sec = strtotime(s_time);
+		ut.ut_tv.tv_usec = strtousec(s_time);
 #else
 		ut.ut_time = strtotime(s_time);
 #endif
-- 
2.9.0

