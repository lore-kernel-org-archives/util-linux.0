Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53814 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab3EZJO2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 26 May 2013 05:14:28 -0400
Received: by mail-wi0-f172.google.com with SMTP id m6so770308wiv.17
        for <util-linux@vger.kernel.org>; Sun, 26 May 2013 02:14:27 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/4] docs: cal: stop telling year 9999 is upper limit
Date: Sun, 26 May 2013 10:14:10 +0100
Message-Id: <1369559650-12341-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1369559650-12341-1-git-send-email-kerolasa@iki.fi>
References: <1369559650-12341-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index ec99d60..4e7570d 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -85,7 +85,7 @@ Display version information and exit.
 \fB\-h\fR, \fB\-\-help\fR
 Display help screen and exit.
 .SH PARAMETERS
-A single parameter specifies the year (1 - 9999) to be displayed; note the
+A single parameter specifies the year to be displayed; note the
 year must be fully specified:
 .B "cal 89"
 will not display a calendar for 1989.
-- 
1.8.2.3

