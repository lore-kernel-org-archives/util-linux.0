Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:62323 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbaBPXyn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Feb 2014 18:54:43 -0500
Received: by mail-wi0-f174.google.com with SMTP id f8so1878637wiw.1
        for <util-linux@vger.kernel.org>; Sun, 16 Feb 2014 15:54:42 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/9] docs: make hexdump.1 color specification easier to understand
Date: Sun, 16 Feb 2014 23:54:17 +0000
Message-Id: <1392594862-15807-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1392594862-15807-1-git-send-email-kerolasa@iki.fi>
References: <1392594862-15807-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fix also spacing, input line lenghts, and troff table for data that is a
table.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/hexdump.1 | 72 ++++++++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
index 8b4bf27..edf5d6f 100644
--- a/text-utils/hexdump.1
+++ b/text-utils/hexdump.1
@@ -226,46 +226,46 @@ displayed as a single
 Output US ASCII characters, with the exception that control characters are
 displayed using the following, lower-case, names.  Characters greater than
 0xff, hexadecimal, are displayed as hexadecimal strings.
-.PP
-.nf
-          000 nul  001 soh  002 stx  003 etx  004 eot  005 enq
-          006 ack  007 bel  008 bs   009 ht   00A lf   00B vt
-          00C ff   00D cr   00E so   00F si   010 dle  011 dc1
-          012 dc2  013 dc3  014 dc4  015 nak  016 syn  017 etb
-          018 can  019 em   01A sub  01B esc  01C fs   01D gs
-          01E rs   01F us   0FF del
-.nf
+.RS 10
+.TS
+tab(|);
+left l l l l l.
+000 nul|001 soh|002 stx|003 etx|004 eot|005 enq
+006 ack|007 bel|008 bs|009 ht|00A lf|00B vt
+00C ff|00D cr|00E so|00F si|010 dle|011 dc1
+012 dc2|013 dc3|014 dc4|015 nak|016 syn|017 etb
+018 can|019 em|01A sub|01B esc|01C fs|01D gs
+01E rs|01F us|0FF del
+.TE
 .SS Colors
-When put at the end of a format specifier, hexdump highlights the respective
-string with the color specified. Conditions, if present, are evaluated
-prior to highlighting.
-.TP
-.B \&_L[color_unit_1,color_unit_2,...,color_unit_n]
-.TP
+When put at the end of a format specifier, hexdump highlights the
+respective string with the color specified.  Conditions, if present, are
+evaluated prior to highlighting.
+.PP
+.B \&_L[color_unit_1,\:color_unit_2,\:...,\:color_unit_n]
+.PP
 The full syntax of a color unit is as follows:
-.TP
-.B [!]COLOR[:HEX_VAL|:OCT_VAL|:STRING][@DEC_OFFT|@DEC_OFFT_START-DEC_OFFT_END]
+.PP
+.B [!]COLOR\:[:VALUE]\:[@OFFSET_START[-END]]
 .TP
 .B !
-Negate the condition. Please note that it only makes sense to negate
-a unit if both a value/string and an offset are specified. In that case
-the respective output string will be highlighted if and only if the value/string
-does not match the one at the offset.
-.PP
+Negate the condition.  Please note that it only makes sense to negate a
+unit if both a value/\:string and an offset are specified.  In that case
+the respective output string will be highlighted if and only if the
+value/\:string does not match the one at the offset.
+.TP
 .BR COLOR
 One of the 8 basic shell colors.
-.PP
-.BR HEX_VAL , OCT_VAL
-A value to be matched specified in hexadecimal or octal base.
-.PP
-.BR STRING
-A string to be matched. Please note that the usual C escape sequences
-are not interpreted by hexdump inside the color_units.
-.PP
-.BR DEC_OFFT , DEC_OFFT_START , DEC_OFFT_END
-An offset or an offset range at which
-to check for a match. Please note that DEC_OFFT is equal to DEC_OFFT-DEC_OFFT.
-Also, the range may not be larger than the respective format byte count.
+.TP
+.B VALUE
+A value to be matched specified in hexadecimal, or octal base, or as a
+string.  Please note that the usual C escape sequences are not
+interpreted by hexdump inside the color_units.
+.TP
+.B OFFSET
+An offset or an offset range at which to check for a match.  Please note
+that lone OFFSET_START uses the same value as END offset.  Also, the
+range may not be larger than the respective format byte count.
 .SS Counters
 The default and supported byte counts for the conversion characters
 are as follows:
@@ -345,8 +345,8 @@ Implement the \-x option:
    "%07.7_ax  " 8/2 "%04x " "\en"
 .nf
 .PP
-MBR Boot Signature example:
-Highlight the addresses cyan and the bytes at offsets 510 and 511 green if their value is 0xAA55, red otherwise.
+MBR Boot Signature example: Highlight the addresses cyan and the bytes at
+offsets 510 and 511 green if their value is 0xAA55, red otherwise.
 .nf
    "%07.7_Ax_L[cyan]\en"
    "%07.7_ax_L[cyan]  " 8/2 "   %04x_L[green:0xAA55@510-511,!red:0xAA55@510-511] " "\en"
-- 
1.9.0

