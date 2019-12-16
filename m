Return-Path: <SRS0=+e2a=2G=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B4AC43603
	for <util-linux@archiver.kernel.org>; Mon, 16 Dec 2019 22:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081672176D
	for <util-linux@archiver.kernel.org>; Mon, 16 Dec 2019 22:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfLPWUg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:20:36 -0500
Received: from inpost.hi.is ([130.208.165.62]:60474 "EHLO inpost.hi.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfLPWUg (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 16 Dec 2019 17:20:36 -0500
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id xBGMKWrq012004
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Mon, 16 Dec 2019 22:20:32 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is xBGMKWrq012004
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id xBGMKWPT025468
        for <util-linux@vger.kernel.org>; Mon, 16 Dec 2019 22:20:32 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id xBGMKWhV025467
        for util-linux@vger.kernel.org; Mon, 16 Dec 2019 22:20:32 GMT
Date:   Mon, 16 Dec 2019 22:20:32 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] doc: howto-man-page.txt: Use font macros instead of font
 escapes
Message-ID: <20191216222032.GA25430@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

  Use font macros instead of font escapes (\f[BIPR]).

  The escape '\c' ("connect to next input text")
is used to join the output of two macros without a space character.
This is similar to the '\' escape at the end of a line.

  Font escapes make the text more difficult to read.

###
  Changes based on:

  Use a macro to change to the italic font,
instead of \fI [1], if possible.
  The macros have the italic corrections,
but "\c" removes the "\/" part.

  Or

add the italic corrections.
[1] man-pages(7) [Debian package "manpages"]

###

Change a HYPHEN-MINUS (code 0x55, 2D) to a minus (\-), if in front of a

1) name for an option

2) negative number to be printed.

###

Wrong distance between sentences or protect the indicator.

a) Separate the sentences and subordinate clauses;
each begins on a new line.
See man-pages(7) [package "manpages"] and "info groff".

Or

b) Adjust space between sentences (two spaces),

c) or protect the indicator by adding "\&" after it.

The "indicator" is an "end-of-sentence character" (.!?).

  The amount of space between sentences in the output can then be
controlled with the ".ss" request.

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 Documentation/howto-man-page.txt | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/Documentation/howto-man-page.txt b/Documentation/howto-man-page.txt
index 55734af91..f2b352dac 100644
--- a/Documentation/howto-man-page.txt
+++ b/Documentation/howto-man-page.txt
@@ -30,10 +30,13 @@ Each manual page needs some sort of description of the command.
 Write such here.
 .SH OPTIONS
 .TP
-\fB\-n\fR, \fB\-\-no\-argument\fR
+.BR \-n ,\  \-\-no\-argument
+.\" \fB\-n\fR, \fB\-\-no\-argument\fR
 This option does not use an argument.
 .TP
-\fB\-\-optional\fR[\fI=argument\fR]
+.BR \-\-optional [ =\c
+.IR argument ]
+.\" \fB\-\-optional\fR[\fI=argument\fR]
 Tell in this description that the
 .I argument
 is optional, and what happens when it is or is not given.  Notice that the word
@@ -59,18 +62,22 @@ to be the same, but in fact the former is two separate options while the
 later will use
 .B n
 as option argument of
-.BR -o .
+.BR \-o .
 So it is best to avoid short forms of optional options altogether.
 .TP
-\fB\-r\fR, \fB\-\-required\fR \fIargument\fR
+.BR \-r ,\  \-\-required\ \c
+.I argument
+.\"\fB\-r\fR, \fB\-\-required\fR \fIargument\fR
 Tell in this description that the
 .I argument
 is required.
 .TP
-\fB\-V\fR, \fB\-\-version\fR
+.BR \-V ", " \-\-version
+.\"\fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
 .TP
-\fB\-h\fR, \fB\-\-help\fR
+.BR \-h ,\  \-\-help
+.\"\fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
 .SH NOTES
 Tell details that users might need to know.  For example, kernel feature or
@@ -105,7 +112,8 @@ one.
 .\"
 .PP
 When in the source a new sentence begins somewhere midline, it should use a
-double space before its initial letter.  This is done because \fBgroff\fR
+double space before its initial letter.  This is done because
+.B groff
 uses a double space after a sentence when this sentence ends at the end of
 an input line and the next sentence begins on the next line.
 Unless a double space is used before other sentence starts as well, the
@@ -139,10 +147,10 @@ Another file.
 Write typical and/or clever use examples here.  The below examples are stupid,
 and you should never write them in a real man page.
 .TP
-.B example -h
+.B example \-h
 Output help screen.
 .TP
-.B example -V
+.B example \-V
 Output version information.
 .SH "EXIT STATUS"
 This section can be left out if the command has only two return values,
@@ -171,7 +179,7 @@ etc
 .RE
 .SH AUTHORS
 .MT rjh@\:example.org
-Random J. Hacker
+Random J.\& Hacker
 .ME
 .br
 .MT fred@\:example.com
-- 
2.24.0
