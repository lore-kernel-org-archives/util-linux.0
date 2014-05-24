Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:44090 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaEXLIb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 24 May 2014 07:08:31 -0400
Received: by mail-we0-f173.google.com with SMTP id u57so5948945wes.4
        for <util-linux@vger.kernel.org>; Sat, 24 May 2014 04:08:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/4] docs: setterm.1 add options compatibility note
Date: Sat, 24 May 2014 12:08:15 +0100
Message-Id: <1400929696-12548-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Both --option and -option formats are accepted.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.1 | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/term-utils/setterm.1 b/term-utils/setterm.1
index 5b843dc..995e1c9 100644
--- a/term-utils/setterm.1
+++ b/term-utils/setterm.1
@@ -8,7 +8,7 @@
 .\" Undocumented: -snow, -softscroll, -standout; these are
 .\" commented out in the source
 .\"
-.TH SETTERM 1 "January 2000" "util-linux" "User Commands"
+.TH SETTERM 1 "May 2014" "util-linux" "User Commands"
 .SH NAME
 setterm \- set terminal attributes
 .SH SYNOPSIS
@@ -196,6 +196,16 @@ Display version information and exit.
 .TP
 .BR \-\-help
 Display help text and exit.
+.SH COMPATIBILITY
+Since version 2.25 the
+.B setterm
+has supported long options with two hyphens, for example
+.BR \-\-help ,
+aside with single hyphen options, for example
+.BR \-help .
+In scripts it is better to use backward compatibile single hyphen rather
+than two hyphens.  Currently there are no plans or good reasons to
+discontinue single hyphen compatibility.
 .SH "SEE ALSO"
 .BR tput (1),
 .BR stty (1),
-- 
1.9.3

