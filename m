Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34734 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbcEORbM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 May 2016 13:31:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id n129so13475054wmn.1
        for <util-linux@vger.kernel.org>; Sun, 15 May 2016 10:31:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 07/11] utmpdump: use always UTC-0 timezone in textual output
Date: Sun, 15 May 2016 18:30:53 +0100
Message-Id: <1463333457-1011-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1463333457-1011-1-git-send-email-kerolasa@iki.fi>
References: <1463333457-1011-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Converting a time structure from text format that has timezone markup is
impossible.  See reference links for more information.  This leads to
situation where utmpdump(1) conversions from binary to text and back make
timestamps to shift amount of timezone offset, assuming user does not by
chance usingn UTC-0 locale at a time of conversions.

Easiest way to make multiple conversions to work is to be to ensure the
textual format is always using UTC-0 timezone, without daylight saving
shifts.  Unfortunately these timestamps are almost certainly less readable
to users altough they are more correct.

Reference: http://www.catb.org/esr/time-programming/#_strptime_3_and_getdate_3
Reference: http://man7.org/linux/man-pages/man3/strptime.3.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/utmpdump.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index 03cf4a9..6eaf202 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -47,10 +47,10 @@
 
 static char *timetostr(const time_t time)
 {
-	static char s[29];	/* [Sun Sep 01 00:00:00 1998 PST] */
+	static char s[29];	/* [Tue Sep 01 00:00:00 1998 GMT] */
 	struct tm *tmp;
 
-	if (time != 0 && (tmp = localtime(&time)))
+	if (time != 0 && (tmp = gmtime(&time)))
 		strftime(s, 29, "%a %b %d %T %Y %Z", tmp);
 	else
 		s[0] = '\0';
@@ -73,7 +73,7 @@ static time_t strtotime(const char *s_time)
 	if (s_time[26] == 'D')
 		tm.tm_isdst = 1;
 
-	return mktime(&tm);
+	return timegm(&tm);
 }
 
 #define cleanse(x) xcleanse(x, sizeof(x))
-- 
2.8.2

