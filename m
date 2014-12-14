Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:50223 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751104AbaLNTp4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Dec 2014 14:45:56 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/8] docs: improve the sorting of the options in the man page of getopt
Date: Sun, 14 Dec 2014 20:45:28 +0100
Message-Id: <1418586333-5342-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1418586333-5342-1-git-send-email-bensberg@justemail.net>
References: <1418586333-5342-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/getopt.1 |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/misc-utils/getopt.1 b/misc-utils/getopt.1
index 7fd8720..6758d27 100644
--- a/misc-utils/getopt.1
+++ b/misc-utils/getopt.1
@@ -1,4 +1,4 @@
-.TH GETOPT "1" "June 2012" "util-linux" "User Commands"
+.TH GETOPT "1" "December 2014" "util-linux" "User Commands"
 .SH NAME
 getopt \- parse command options (enhanced)
 .SH SYNOPSIS
@@ -69,7 +69,7 @@ for more information).
 .PP
 Traditional implementations of
 .BR getopt (1)
-are unable to cope with whitespace and other (shell\-specific)
+are unable to cope with whitespace and other (shell-specific)
 special characters in arguments and non\-option parameters.  To solve
 this problem, this implementation can generate quoted output which
 must once again be interpreted by the shell (usually by using the
@@ -151,13 +151,6 @@ conventions are used.  Valid arguments are currently
 and
 .RB ' tcsh '.
 .TP
-.BR \-u , " \-\-unquoted"
-Do not quote the output.  Note that whitespace and special
-(shell\-dependent) characters can cause havoc in this mode (like they
-do with other
-.BR getopt (1)
-implementations).
-.TP
 .BR \-T , " \-\-test"
 Test if your
 .BR getopt (1)
@@ -170,6 +163,13 @@ is set, will return
 .RB ' \-\- '
 and error status 0.
 .TP
+.BR \-u , " \-\-unquoted"
+Do not quote the output.  Note that whitespace and special
+(shell-dependent) characters can cause havoc in this mode (like they
+do with other
+.BR getopt (1)
+implementations).
+.TP
 .BR \-V , " \-\-version"
 Display version information and exit.  No other output is generated.
 .SH PARSING
-- 
1.7.0.4

