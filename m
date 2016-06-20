Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34195 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876AbcFTUlH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 20 Jun 2016 16:41:07 -0400
Received: by mail-lf0-f67.google.com with SMTP id l184so6665952lfl.1
        for <util-linux@vger.kernel.org>; Mon, 20 Jun 2016 13:40:43 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/6] utmpdump: use always UTC-0 timezone in textual output
Date: Mon, 20 Jun 2016 21:40:32 +0100
Message-Id: <20160620204037.3292-2-kerolasa@iki.fi>
In-Reply-To: <20160620204037.3292-1-kerolasa@iki.fi>
References: <20160620204037.3292-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Converting a time structure from text format that has timezone markup is
practically impossible.  See reference links for more information.  This
leads to situation where multiple utmpdump(1) conversions from binary to
text and back make timestamps to shift amount of timezone offset to UTC-0.

The easiest way to make multiple conversions to work without timeshifts is
to always use UTC-0 timezone.  Downside of this approach is that the textual
format is less human readable than local timestamps would be.

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
2.9.0

