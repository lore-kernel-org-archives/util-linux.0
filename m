Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f182.google.com ([209.85.212.182]:64340 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761948Ab3EBSwX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 2 May 2013 14:52:23 -0400
Received: by mail-wi0-f182.google.com with SMTP id m6so932209wiv.15
        for <util-linux@vger.kernel.org>; Thu, 02 May 2013 11:52:21 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/16] docs: cal: add --highlight option description
Date: Thu,  2 May 2013 19:51:36 +0100
Message-Id: <1367520701-14962-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
References: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.1 | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index 4d9b3d1..decdcf5 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -65,6 +65,19 @@ Display Julian dates (days one-based, numbered from January 1).
 \fB\-y\fR, \fB\-\-year\fR
 Display a calendar for the current year.
 .TP
+\fB\-\-highlight\fR \fIwhen\fR
+Highlight output.  The
+.I when
+can be one
+.IR never ,
+.IR auto ,
+or
+.IR always .
+Never will turn off highlighting in all situations.  Auto is default, and
+it will make highlight to be in use if output is done to termina.  Always
+will allow highlight to be outputed when cal outputs to pipe, or is
+called from a script.
+.TP
 \fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
 .TP
-- 
1.8.2.2

