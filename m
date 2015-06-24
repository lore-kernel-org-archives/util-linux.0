Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:51759 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752620AbbFXS6T (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 24 Jun 2015 14:58:19 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Cc: Felix Neumann <felix.neumann@inka.de>
Subject: [PATCH] cal: correct the man page: the reformation eliminated eleven days, not ten
Date: Wed, 24 Jun 2015 20:58:06 +0200
Message-Id: <1435172286-2962-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also tweak some other wordings and formatting.

Reported-by: Felix Neumann <felix.neumann@inka.de>
Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/cal.1 |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index 50b0859..e032b97 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -34,7 +34,7 @@
 .\"
 .\"     @(#)cal.1	8.1 (Berkeley) 6/6/93
 .\"
-.TH CAL 1 "June 2011" "util-linux" "User Commands"
+.TH CAL 1 "June 2015" "util-linux" "User Commands"
 .SH NAME
 cal \- display a calendar
 .SH SYNOPSIS
@@ -55,7 +55,7 @@ Display single month output.
 Display three months spanning the date.
 .TP
 \fB\-n , \-\-months\fR \fInumber\fR
-Display number months starting from month containing the date.
+Display \fInumber\fR of months, starting from the month containing the date.
 .TP
 \fB\-s\fR, \fB\-\-sunday\fR
 Display Sunday as the first day of the week.
@@ -78,8 +78,8 @@ Display week numbers in the calendar (US or ISO-8601).
 \fB\-\-color\fR[\fI=when\fR]
 Colorize the output.  The optional argument \fIwhen\fP
 can be \fBauto\fR, \fBnever\fR or \fBalways\fR.  If the \fIwhen\fR argument is omitted,
-it defaults to \fBauto\fR.  The colors can be disabled, for the current built-in default 
-see \fB\-\-help\fR output. See also the COLORS section.
+it defaults to \fBauto\fR.  The colors can be disabled; for the current built-in default
+see the \fB\-\-help\fR output.  See also the \fBCOLORS\fR section.
 .TP
 \fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
@@ -95,10 +95,10 @@ will not display a calendar for 1989.
 Two parameters denote the month (1 - 12) and year.
 .PP
 Three parameters denote the day (1-31), month and year, and the day will be
-highlighted if the calendar is displayed on a terminal. If no parameters are
+highlighted if the calendar is displayed on a terminal.  If no parameters are
 specified, the current month's calendar is displayed.
 .PP
-A year starts on Jan 1. The first day of the week is determined by the
+A year starts on January 1.  The first day of the week is determined by the
 locale.
 .PP
 The week numbering depends on the choice of the first day of the week.  If Sunday
@@ -124,7 +124,7 @@ The
 .B cal
 program uses the 3rd of September 1752 as the date of the Gregorian calendar
 reformation -- that is when it happened in Great Britain and its colonies
-(including what is now the USA).  Ten days following that date were eliminated
+(including what is now the USA).  Starting at that date, eleven days were eliminated
 by this reformation, so the calendar for that month is rather unusual.
 The actual historical dates at which the calendar reform happened in all the
 different countries (locales) are ignored.
-- 
1.7.0.4

