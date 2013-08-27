Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f51.google.com ([74.125.83.51]:64545 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab3H0SHS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Aug 2013 14:07:18 -0400
Received: by mail-ee0-f51.google.com with SMTP id c1so2415595eek.38
        for <util-linux@vger.kernel.org>; Tue, 27 Aug 2013 11:07:17 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/17] docs: add --since and time option formats to last(1) manual
Date: Tue, 27 Aug 2013 19:06:15 +0100
Message-Id: <1377626779-26030-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.1 | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/login-utils/last.1 b/login-utils/last.1
index d348645..4c4dc02 100644
--- a/login-utils/last.1
+++ b/login-utils/last.1
@@ -88,17 +88,21 @@ This is a count telling
 .B last
 how many lines to show.
 .TP
-\fB\-t\fR, \fB\-\-until\fR \fIYYYYMMDDHHMMSS\fR
-Display the state of logins as of the specified time.  This is useful,
-e.g., to determine easily who was logged in at a particular time --
-specify that time with
-.B \-\-until
-and look for "still logged in".
+\fB\-s\fR, \fB\-\-since\fR \fItime\fR
+Display the state of logins since specified
+.IR time .
+This is useful, e.g., to determine easily who was logged in at a
+particular time.  The option is often combined with
+.BR \-\-until .
 .TP
-\fB\-p\fR, \fB\-\-present\fR \fIYYYYMMDDHHMMSS\fR
+\fB\-t\fR, \fB\-\-until\fR \fItime\fR
+Display the state of logins until the specified
+.IR time .
+.TP
+\fB\-p\fR, \fB\-\-present\fR \fItime\fR
 Display users who were present at the specified time.  This option is
 similar with
-.BR \-\-until ,
+.BR \-\-since " and " \-\-until ,
 without printing any other lines than the matching sessions.
 .TP
 \fB\-F\fR, \fB\-\-fulltimes\fR
@@ -131,6 +135,25 @@ Display full user and domain names in the output.
 .TP
 \fB\-x\fR, \fB\-\-system\fR
 Display the system shutdown entries and run level changes.
+.SH TIME FORMATS
+The options that take
+.I time
+argument will understand the following formats:
+.TS
+left l2 l2.
+YYYYMMDDhhmmss
+YYYY-MM-DD hh:mm:ss
+YYYY-MM-DD hh:mm	(seconds will be set to 00)
+YYYY-MM-DD	(time will be set to 00:00:00)
+hh:mm:ss	(date will be set to today)
+hh:mm	(date will be set to today, seconds to 00)
+now
+yesterday	(time is set to 00:00:00)
+today	(time is set to 00:00:00)
+tomorrow	(time is set to 00:00:00)
++5min
+-5days
+.TE
 .SH NOTES
 The files
 .I wtmp
-- 
1.8.4

