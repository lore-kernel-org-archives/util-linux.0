Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.hi.is ([130.208.165.104]:56510 "EHLO mx2.hi.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbeC2V2O (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 29 Mar 2018 17:28:14 -0400
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Subject: [PATCH] misc-utils/getopt.1: minor corrections to the manual
Date: Thu, 29 Mar 2018 21:15:06 +0000
Message-Id: <1522358106-21037-1-git-send-email-bjarniig@rhi.hi.is>
In-Reply-To: <n>
References: <n>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Input file is getopt.1

Test nr. 2:

Enable and fix warnings from 'test-groff'.

Input file is /tmp/getopt.1

<getopt.1>:5 (macro BI): only 1 argument, but more are expected
<getopt.1>:419 (macro IR): only 1 argument, but more are expected
<getopt.1>:421 (macro IR): only 1 argument, but more are expected

chk_manuals: Output is from: test-groff -b -e -mandoc -T utf8 -rF0 -t -w w -z

  and

Test nr. 15:

Change the name of a macro for two fonts (e.g., BR and IR) to one letter,
if there is only one argument.
Add the second argument if needed.  It is sometimes part of the first one.

5:.BI getopt
419:.IR /usr/share/getopt/
421:.IR /usr/share/doc/

#####

Test nr. 8:

Protect a full stop (.) with "\&", if it has a blank (white-space) in front
of or (ignoring transparent characters to the full stop) after it, and it does
not mean an end of a sentence.

204:the next parameter (i.e. separated by whitespace on the command
219:or as the next argument (i.e. separated by whitespace on the command
352:(i.e. a parameter that does not start with a
379:will be parsed.  It will still do parameter shuffling (i.e. all

#####

Test nr. 20:

Use a macro to change to the italic font, instead of \fI [1], if
possible.
The macros have the italic corrections, but "\c" removes them.
[1] man-pages(7)

57:is set, or if the first \fIparameter\fR is not an option (does not start
144:Set quoting conventions to those of \fIshell\fR.

#####

Test nr. 21:

Use the word (in)valid instead of (il)legal if not related to legal matters.
See "www.gnu.org/prep/standards".

25:check for legal options.  It uses the

#####

Test nr. 28:

Wrong distance between sentences or protect the indicator.

1) Separate the sentences and subordinate clauses; each begins on a new
line.  See man-pages(7) and "info groff".

Or

2) Adjust space between sentences (two spaces),

3) or protect the indicator by adding "\&" after it.

The "indicator" is an "end-of-sentence character" (.!?).

204:the next parameter (i.e. separated by whitespace on the command
219:or as the next argument (i.e. separated by whitespace on the command
352:(i.e. a parameter that does not start with a
379:will be parsed.  It will still do parameter shuffling (i.e. all
Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>

#####
---
 misc-utils/getopt.1 | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/misc-utils/getopt.1 b/misc-utils/getopt.1
index fbdcf735b..47e032b7a 100644
--- a/misc-utils/getopt.1
+++ b/misc-utils/getopt.1
@@ -2,7 +2,7 @@
 .SH NAME
 getopt \- parse command options (enhanced)
 .SH SYNOPSIS
-.BI getopt
+.B getopt
 .I optstring parameters
 .br
 .B getopt
@@ -22,7 +22,7 @@ getopt \- parse command options (enhanced)
 is used to break up
 .RI ( parse )
 options in command lines for easy parsing by shell procedures, and to
-check for legal options.  It uses the
+check for valid options.  It uses the
 .SM GNU
 .BR getopt (3)
 routines to do this.
@@ -54,8 +54,9 @@ part is used as the short options string.
 .PP
 If the environment variable
 .B GETOPT_COMPATIBLE
-is set, or if the first \fIparameter\fR is not an option (does not start
-with a
+is set, or if the first
+.I parameter
+is not an option (does not start with a
 .RB ' \- ',
 the first format in the
 .BR SYNOPSIS ),
@@ -141,7 +142,8 @@ unless you also use
 .BR \-q .
 .TP
 .BR \-s , " \-\-shell \fIshell\fP"
-Set quoting conventions to those of \fIshell\fR.
+Set quoting conventions to those of
+.IR shell .
 If the \fB\-s\fR option is not given, the
 .SM BASH
 conventions are used.  Valid arguments are currently
@@ -201,7 +203,7 @@ A simple short option is a
 .RB ' \- '
 followed by a short option character.  If the option has a required
 argument, it may be written directly after the option character or as
-the next parameter (i.e. separated by whitespace on the command
+the next parameter (i.e., separated by whitespace on the command
 line).  If the option has an optional argument, it must be written
 directly after the option character if present.
 .PP
@@ -216,7 +218,7 @@ followed by the long option name.  If the option has a required
 argument, it may be written directly after the long option name,
 separated by
 .RB ' = ',
-or as the next argument (i.e. separated by whitespace on the command
+or as the next argument (i.e., separated by whitespace on the command
 line).  If the option has an optional argument, it must be written
 directly after the long option name, separated by
 .RB ' = ',
@@ -349,7 +351,7 @@ If the first character is
 or if the environment variable
 .B POSIXLY_CORRECT
 is set, parsing stops as soon as the first non\-option parameter
-(i.e. a parameter that does not start with a
+(i.e., a parameter that does not start with a
 .RB ' \- ')
 is found that is not an option argument.  The remaining parameters
 are all interpreted as non\-option parameters.
@@ -376,7 +378,7 @@ If the first character of the first parameter of getopt is not a
 .B getopt
 goes into compatibility mode.  It will interpret its first
 parameter as the string of short options, and all other arguments
-will be parsed.  It will still do parameter shuffling (i.e. all
+will be parsed.  It will still do parameter shuffling (i.e., all
 non\-option parameters are output at the end), unless the
 environment variable
 .B POSIXLY_CORRECT
@@ -416,9 +418,9 @@ if it is called with
 Example scripts for (ba)sh and (t)csh are provided with the
 .BR getopt (1)
 distribution, and are optionally installed in
-.IR /usr/share/getopt/
+.I /usr/share/getopt/
 or
-.IR /usr/share/doc/
+.I /usr/share/doc/
 in the util-linux subdirectory.
 .SH ENVIRONMENT
 .IP POSIXLY_CORRECT
-- 
2.16.2

