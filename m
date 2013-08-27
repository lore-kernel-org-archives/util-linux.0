Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f42.google.com ([74.125.83.42]:63927 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308Ab3H0SHA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Aug 2013 14:07:00 -0400
Received: by mail-ee0-f42.google.com with SMTP id b45so2489703eek.1
        for <util-linux@vger.kernel.org>; Tue, 27 Aug 2013 11:06:59 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/17] docs: add note to wall(1) about sessions which will not get message
Date: Tue, 27 Aug 2013 19:06:10 +0100
Message-Id: <1377626779-26030-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Sessions that has in utmp data ut_line begining with ':' are skipped.
This is done to avoid write errors to devices such as '/dev/:0'.  For
example wdm is reported to to generate such utmp line.

Perhaps in future this code should be revalidated.  If an utmp data
contains broken device lines it might be best inform user with a error
message, rather than skipping silently suspicious device entries.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/wall.1 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/term-utils/wall.1 b/term-utils/wall.1
index 9bf3b26..bb56625 100644
--- a/term-utils/wall.1
+++ b/term-utils/wall.1
@@ -73,6 +73,12 @@ Output version and exit.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Output help and exit.
+.SH NOTES
+Some sessions, such as wdm, that has in beginning of
+.BR utmp (5)
+ut_type data ':' character will not get message from
+.BR wall .
+This is done to avoid write errors.
 .SH SEE ALSO
 .BR mesg (1),
 .BR talk (1),
-- 
1.8.4

