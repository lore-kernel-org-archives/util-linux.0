Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f47.google.com ([74.125.83.47]:52341 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab3H0SHc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Aug 2013 14:07:32 -0400
Received: by mail-ee0-f47.google.com with SMTP id d49so2416751eek.6
        for <util-linux@vger.kernel.org>; Tue, 27 Aug 2013 11:07:31 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 17/17] docs: add --time-format to last(1) manual page
Date: Tue, 27 Aug 2013 19:06:19 +0100
Message-Id: <1377626779-26030-17-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.1 | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/login-utils/last.1 b/login-utils/last.1
index 4c4dc02..13b4693 100644
--- a/login-utils/last.1
+++ b/login-utils/last.1
@@ -105,6 +105,28 @@ similar with
 .BR \-\-since " and " \-\-until ,
 without printing any other lines than the matching sessions.
 .TP
+\fB\-\-time\-format\fR \fIformat\fR
+Define output timestamp
+.I format
+to be one of the
+.IR notime ,
+.IR short ,
+.IR full ,
+or
+.IR iso .
+.I notime
+will not print timestamp at all.
+.I short
+is default, and
+.I full
+is same as
+.B \-\-fulltimes
+option.  The
+.I iso
+will display time stamp in ISO-8601 format.  The iso format contains
+timezone information making it to be preferrable when print outs are
+investigated outside of the system.
+.TP
 \fB\-F\fR, \fB\-\-fulltimes\fR
 Print full login and logout times and dates.
 .TP
-- 
1.8.4

