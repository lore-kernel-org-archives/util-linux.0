Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:64644 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751577AbbKHLIJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Nov 2015 06:08:09 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/6] dmseg: slightly improve punctuation and formatting of the manpage
Date: Sun,  8 Nov 2015 11:54:12 +0100
Message-Id: <1446980055-2749-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1446980055-2749-1-git-send-email-bensberg@justemail.net>
References: <1446980055-2749-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/dmesg.1 |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sys-utils/dmesg.1 b/sys-utils/dmesg.1
index b3eb281..199eacb 100644
--- a/sys-utils/dmesg.1
+++ b/sys-utils/dmesg.1
@@ -45,9 +45,9 @@ then only the time delta without the timestamp is printed.
 .IP "\fB\-E\fR, \fB\-\-console\-on\fR"
 Enable printing messages to the console.
 .IP "\fB\-e\fR, \fB\-\-reltime\fR"
-Display the local time and the delta in human-readable format. Be aware that
-conversion to the local time could be inaccurate (see \fB\-T\fR) for more
-details.
+Display the local time and the delta in human-readable format.  Be aware that
+conversion to the local time could be inaccurate (see \fB\-T\fR for more
+details).
 .IP "\fB\-F\fR, \fB\-\-file \fIfile\fR"
 Read the messages from the given
 .IR file .
@@ -72,8 +72,8 @@ Print kernel messages.
 .IP "\fB\-L\fR, \fB\-\-color\fR[=\fIwhen\fR]"
 Colorize the output.  The optional argument \fIwhen\fP
 can be \fBauto\fR, \fBnever\fR or \fBalways\fR.  If the \fIwhen\fR argument is omitted,
-it defaults to \fBauto\fR.  The colors can be disabled, for the current built-in default 
-see \fB\-\-help\fR output. See also the COLORS section.
+it defaults to \fBauto\fR.  The colors can be disabled; for the current built-in default
+see the \fB\-\-help\fR output.  See also the \fBCOLORS\fR section below.
 .IP  "\fB\-l\fR, \fB\-\-level \fIlist\fR"
 Restrict output to the given (comma-separated)
 .I list
-- 
1.7.0.4

