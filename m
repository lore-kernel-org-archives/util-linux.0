Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f171.google.com ([209.85.215.171]:49823 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263Ab3H0SG5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Aug 2013 14:06:57 -0400
Received: by mail-ea0-f171.google.com with SMTP id n15so2413854ead.2
        for <util-linux@vger.kernel.org>; Tue, 27 Aug 2013 11:06:56 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/17] docs: add --present to last(1) manual page
Date: Tue, 27 Aug 2013 19:06:09 +0100
Message-Id: <1377626779-26030-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I forgot to update manual after writing this functionality.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.1 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/login-utils/last.1 b/login-utils/last.1
index b33af5c..d348645 100644
--- a/login-utils/last.1
+++ b/login-utils/last.1
@@ -95,6 +95,12 @@ specify that time with
 .B \-\-until
 and look for "still logged in".
 .TP
+\fB\-p\fR, \fB\-\-present\fR \fIYYYYMMDDHHMMSS\fR
+Display users who were present at the specified time.  This option is
+similar with
+.BR \-\-until ,
+without printing any other lines than the matching sessions.
+.TP
 \fB\-F\fR, \fB\-\-fulltimes\fR
 Print full login and logout times and dates.
 .TP
-- 
1.8.4

