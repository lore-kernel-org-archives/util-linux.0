Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:63886 "EHLO
	cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750823AbbKHLIY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Nov 2015 06:08:24 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/6] hexdump: fix a typo and tweak some wordings in the manpage
Date: Sun,  8 Nov 2015 11:54:13 +0100
Message-Id: <1446980055-2749-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1446980055-2749-1-git-send-email-bensberg@justemail.net>
References: <1446980055-2749-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 text-utils/hexdump.1 |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
index c7d7599..af8433d 100644
--- a/text-utils/hexdump.1
+++ b/text-utils/hexdump.1
@@ -84,8 +84,9 @@ are ignored.
 \fB\-L\fR, \fB\-\-color\fR[=\fIwhen\fR]
 Accept color units for the output.  The optional argument \fIwhen\fP
 can be \fBauto\fR, \fBnever\fR or \fBalways\fR.  If the \fIwhen\fR argument is omitted,
-it defaults to \fBauto\fR.  The colors can be disabled, for the current built-in default 
-see \fB\-\-help\fR output. See also the COLORS section.
+it defaults to \fBauto\fR.  The colors can be disabled; for the current built-in default
+see the \fB\-\-help\fR output.  See also the \fBColors\fR subsection and
+the \fBCOLORS\fR section below.
 .TP
 \fB\-n\fR, \fB\-\-length\fR \fIlength\fR
 Interpret only
@@ -335,9 +336,9 @@ conversion character or conversion string but with any
 .RB ' \&# '
 conversion flag characters removed, and referencing a NULL string.
 .PP
-If no format strings are specified, the default display is very simular to the
-\fB\-x\fR
-output format (the \fB\-x\fR uses more space between format units than the default output).
+If no format strings are specified, the default display is very similar to
+the \fB\-x\fR output format (the \fB\-x\fR option causes more space to be
+used between format units than in the default output).
 .SH "EXIT STATUS"
 .B hexdump
 exits 0 on success and >0 if an error occurred.
-- 
1.7.0.4

