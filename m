Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:64290 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750990AbaGOVHn (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Jul 2014 17:07:43 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/3] docs: bring several man pages closer to standard formatting
Date: Tue, 15 Jul 2014 23:07:36 +0200
Message-Id: <1405458458-13966-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 text-utils/col.1     |   31 ++++++++++++++-----------------
 text-utils/colcrt.1  |    9 ++++++---
 text-utils/column.1  |   27 ++++++++++++++-------------
 text-utils/hexdump.1 |    8 +++++++-
 text-utils/pg.1      |   34 +++++++++++++++++-----------------
 text-utils/rev.1     |    5 +++--
 text-utils/tailf.1   |   19 +++++++++----------
 text-utils/ul.1      |   14 +++++++-------
 8 files changed, 77 insertions(+), 70 deletions(-)

diff --git a/text-utils/col.1 b/text-utils/col.1
index c6aa8c4..0a5c884 100644
--- a/text-utils/col.1
+++ b/text-utils/col.1
@@ -34,7 +34,7 @@
 .\"
 .\"     @(#)col.1	6.8 (Berkeley) 6/17/91
 .\"
-.TH COL "1" "September 2011" "util-linux" "User Commands"
+.TH COL "1" "July 2014" "util-linux" "User Commands"
 .SH NAME
 col - filter reverse line feeds from input
 .SH SYNOPSIS
@@ -43,8 +43,8 @@ col - filter reverse line feeds from input
 .SH DESCRIPTION
 .B col
 filters out reverse (and half-reverse) line feeds so the output is in the
-correct order with only forward and half-forward line feeds, and replaces
-white-space characters with tabs where possible.  This can be useful in
+correct order, with only forward and half-forward line feeds.  It also replaces
+any whitespace characters with tabs where possible.  This can be useful in
 processing the output of
 .BR nroff (1)
 and
@@ -59,29 +59,26 @@ Do not output any backspaces, printing only the last character written to
 each column position.
 .TP
 \fB\-f\fR, \fB\-\-fine\fR
-Forward half line feeds are permitted
-.I fine
-mode.  Normally characters printed on a half-line boundary are printed on the
+Permit half-forward line feeds.
+Normally characters destined for a half-line boundary are printed on the
 following line.
 .TP
-\fB\-p\fR, \fB\-\-pass\fR
-Force unknown control sequences to be passed through unchanged.  Normally,
-.B col
-will filter out any control sequences from the input other than those
-recognized and interpreted by itself, which are listed below.
-.TP
 \fB\-h\fR, \fB\-\-tabs\fR
 Output tabs instead of multiple spaces.
 .TP
-\fB\-x\fR, \fB\-\-spaces\fR
-Output multiple spaces instead of tabs.
-.It Fl l, Fl Fl lines Ar num
-.TP
 \fB\-l\fR, \fB\-\-lines\fR \fInumber\fR
 Buffer at least
 .I number
 lines in memory.  By default, 128 lines are buffered.
-.It Fl V, Fl Fl version
+.TP
+\fB\-p\fR, \fB\-\-pass\fR
+Force unknown control sequences to be passed through unchanged.  Normally
+.B col
+will filter out any control sequences other than those
+recognized and interpreted by itself, which are listed below.
+.TP
+\fB\-x\fR, \fB\-\-spaces\fR
+Output multiple spaces instead of tabs.
 .TP
 \fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
diff --git a/text-utils/colcrt.1 b/text-utils/colcrt.1
index cf9f239..3b8cd09 100644
--- a/text-utils/colcrt.1
+++ b/text-utils/colcrt.1
@@ -36,7 +36,8 @@
 colcrt \- filter nroff output for CRT previewing
 .SH SYNOPSIS
 .B colcrt
-[options] [file ...]
+[options]
+.RI [ file ...]
 .SH DESCRIPTION
 .B colcrt
 provides virtual half-line and reverse line feed sequences for terminals
@@ -68,9 +69,11 @@ Display help text and exit.
 .SH EXAMPLES
 A typical use of
 .B colcrt
-would be
+would be:
 .PP
-tbl exum2.n \&| nroff \-ms \&| colcrt \- \&| more
+.RS
+.B tbl exum2.n \&| nroff \-ms \&| colcrt \- \&| more
+.RE
 .SH SEE ALSO
 .BR nroff (1),
 .BR troff (1),
diff --git a/text-utils/column.1 b/text-utils/column.1
index 33c09e4..305119f 100644
--- a/text-utils/column.1
+++ b/text-utils/column.1
@@ -31,12 +31,11 @@
 .\"
 .\"     @(#)column.1	8.1 (Berkeley) 6/6/93
 .\"
-.TH COLUMN 1 "October 2010" "util-linux" "User Commands"
+.TH COLUMN 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 column - columnate lists
 .SH SYNOPSIS
-.B column
-.RB [ options ]
+.BR column " [options]"
 .RI [ file ...]
 .SH DESCRIPTION
 The
@@ -48,42 +47,44 @@ otherwise from standard input.  Empty lines are ignored.
 .SH OPTIONS
 .IP "\fB\-c, \-\-columns\fP \fIwidth\fP"
 Output is formatted to a width specified as number of characters.
+.IP "\fB\-o, \-\-output-separator\fP \fIstring\fP"
+Specify the columns delimiter for table output (default is two spaces).
+.IP "\fB\-s, \-\-separator\fP \fIseparators\fP"
+Specify the possible input item delimiters (default is whitespace).
 .IP "\fB\-t, \-\-table\fP"
 Determine the number of columns the input contains and create a table.
 Columns are delimited with whitespace, by default, or with the characters
 supplied using the \fB\-\-output-separator\fP option.
 Table output is useful for pretty-printing.
-.IP "\fB\-s, \-\-separator\fP \fIseparators\fP"
-Specify the possible input item delimiters (default is whitespace).
-.IP "\fB\-o, \-\-output-separator\fP \fIstring\fP"
-Specify the columns delimiter for table output (default is two spaces).
 .IP "\fB\-x, \-\-fillrows\fP"
 Fill columns before filling rows.
+.IP "\fB\-V\fR, \fB\-\-version\fR"
+Display version information and exit.
 .IP "\fB\-h, \-\-help\fP"
 Display help text and exit.
 .SH ENVIRONMENT
-The environment variable COLUMNS is used to determine the size of
+The environment variable \fBCOLUMNS\fR is used to determine the size of
 the screen if no other information is available.
 .SH EXAMPLES
 .nf
-sed 's/#.*//' /etc/fstab | column -t
+.B sed 's/#.*//' /etc/fstab | column -t
 .nf
 .SH BUGS
-The util-linux version 2.23 changed
+Version 2.23 changed the
 .B \-s
 option to be non-greedy, for example:
 .PP
 .EX
-$ printf "a:b:c\\n1::3\\n" | column  -t -s ':'
+\fBprintf "a:b:c\\n1::3\\n" | column  -t -s ':'\fR
 .EE
 .PP
-old output:
+Old output:
 .EX
 a  b  c
 1  3
 .EE
 .PP
-new output (since util-linux 2.23)
+New output (since util-linux 2.23):
 .EX
 a  b  c
 1     3
diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
index 8f11103..8237fd9 100644
--- a/text-utils/hexdump.1
+++ b/text-utils/hexdump.1
@@ -33,7 +33,7 @@
 .\"
 .TH HEXDUMP "1" "April 2013" "util-linux" "User Commands"
 .SH NAME
-hexdump \- display file contents in ascii, decimal, hexadecimal, or octal
+hexdump \- display file contents in hexadecimal, decimal, octal, or ascii
 .SH SYNOPSIS
 .B hexdump
 .RI [options] " file" ...
@@ -116,6 +116,12 @@ are replaced with a line comprised of a single asterisk.
 \fITwo-byte hexadecimal display\fR.  Display the input offset in hexadecimal,
 followed by eight space-separated, four-column, zero-filled, two-byte
 quantities of input data, in hexadecimal, per line.
+.TP
+.BR \-V , " \-\-version"
+Display version information and exit.
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
 .PP
 For each input file,
 .B hexdump
diff --git a/text-utils/pg.1 b/text-utils/pg.1
index 07105b5..7431cd1 100644
--- a/text-utils/pg.1
+++ b/text-utils/pg.1
@@ -1,12 +1,12 @@
 .\" @(#)pg.1	1.7 (gritter) 4/25/01
-.TH PG 1 "April 2001" "util-linux" "User Commands"
+.TH PG 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 pg \- browse pagewise through text files
 .SH SYNOPSIS
 .B pg
-.RB [ \-\fInumber\fP ]
+.RB [ \-\fIamount\fP ]
 .RB [ \-p
-.IR string ]
+.IR prompt ]
 .RB [ \-cefnrs ]
 .RB [ +\fIline\fP ]
 .RB [ +/\fIpattern\fP/ ]
@@ -30,14 +30,14 @@ but precedes each file with its name if there is more than one.
 .PP
 If input comes from a pipe,
 .B pg
-stores the data in a buffer file while reading
+stores the data in a buffer file while reading,
 to make navigation possible.
 .SH OPTIONS
 .B pg
 accepts the following options:
 .TP
 .BI + number
-Start at the given line.
+Start at the given line number.
 .TP
 .BI +/ pattern /
 Start at the line containing the Basic Regular Expression
@@ -45,7 +45,7 @@ Start at the line containing the Basic Regular Expression
 given.
 .TP
 .BI \- number
-The number of lines per page.  Usually, this is the number of
+The number of lines per page.  By default, this is the number of
 .SM CRT
 lines minus one.
 .TP
@@ -75,7 +75,7 @@ is displayed.
 If
 .I string
 contains
-.IR %d ,
+.BR %d ,
 its first occurrence is replaced by the number of the current page.
 .TP
 .B \-r
@@ -87,23 +87,23 @@ Print messages in
 mode,
 if the terminfo entry for the terminal provides this capability.
 .TP
-.B \-h, \-\-help
-display short help and exit.
-.TP
-.B \-V, \-\-version
+.BR \-V , " \-\-version"
 Disaplay version information and exit.
-.SH USAGE
+.TP
+.BR \-h , " \-\-help"
+Display help text and exit.
+.SH COMMANDS
 The following commands may be entered at the prompt.  Commands preceded by
 .I i
 in this document accept a number as argument, positive or negative.
 If this argument starts with
-.I +
+.B +
 or
-.I \-,
+.BR \- ,
 it is interpreted relative to the current position in the input file,
 otherwise relative to the beginning.
 .TP
-.IB i <newline>
+.IB i <Enter>
 Display the next or the indicated page.
 .TP
 \fIi\fR\fBd\fR or \fB^D\fR
@@ -121,8 +121,8 @@ must be a positive number and is always interpreted relative
 to the current position.
 .TP
 \fIi\fR\fBw\fR or \fIi\fR\fBz\fR
-Behave as
-.I <newline>
+As
+.B <Enter>
 except that
 .I i
 becomes the new page size.
diff --git a/text-utils/rev.1 b/text-utils/rev.1
index 4b0bd7a..a8945a9 100644
--- a/text-utils/rev.1
+++ b/text-utils/rev.1
@@ -35,10 +35,11 @@
 .\"
 .TH REV "1" "September 2011" "util-linux" "User Commands"
 .SH NAME
-rev \- reverse lines of a file or files
+rev \- reverse lines characterwise
 .SH SYNOPSIS
 .B rev
-[options] [file ...]
+[option]
+.RI [ file ...]
 .SH DESCRIPTION
 The
 .B rev
diff --git a/text-utils/tailf.1 b/text-utils/tailf.1
index 1cdbff1..bfe97bc 100644
--- a/text-utils/tailf.1
+++ b/text-utils/tailf.1
@@ -22,16 +22,17 @@
 .\" Formatted or processed versions of this manual, if unaccompanied by
 .\" the source, must acknowledge the copyright and authors of this work.
 .\" 
-.TH TAILF 1 "February 2003" "util-linux" "User Commands"
+.TH TAILF 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 tailf \- follow the growth of a log file
 .SH SYNOPSIS
 .B tailf
-[\fIOPTION\fR] \fIfile\fR
+[option]
+.I file
 .SH DESCRIPTION
 .B tailf
-will print out the last 10 lines of a file and then wait for the file to
-grow.  It is similar to
+will print out the last 10 lines of the given \fIfile\fR and then wait
+for this \fIfile\fR to grow.  It is similar to
 .B tail -f
 but does not access the file when it is not growing.  This has the side
 effect of not updating the access time for the file, so a filesystem flush
@@ -41,12 +42,10 @@ does not occur periodically when no log activity is happening.
 is extremely useful for monitoring log files on a laptop when logging is
 infrequent and the user desires that the hard disk spin down to conserve
 battery life.
-.PP
-Mandatory arguments to long options are mandatory for short options too.
 .TP
-\fB\-n\fR, \fB\-\-lines\fR=\fIN\fR, \fB\-N\fR
-output the last
-.I N
+.BR \-n , " -\-lines=\fInumber\fR" , " \-\fInumber\fR"
+Output the last
+.I number
 lines, instead of the last 10.
 .TP
 \fB\-V\fR, \fB\-\-version
@@ -60,7 +59,7 @@ This program was originally written by Rik Faith (faith@acm.org) and may be free
 distributed under the terms of the X11/MIT License.  There is ABSOLUTELY
 NO WARRANTY for this program.
 
-The latest inotify based implementation was written by Karel Zak (kzak@redhat.com).
+The latest inotify-based implementation was written by Karel Zak (kzak@redhat.com).
 .SH "SEE ALSO"
 .BR tail (1),
 .BR less (1)
diff --git a/text-utils/ul.1 b/text-utils/ul.1
index 78fdd5f..3164bac 100644
--- a/text-utils/ul.1
+++ b/text-utils/ul.1
@@ -35,8 +35,8 @@
 .SH NAME
 ul \- do underlining
 .SH SYNOPSIS
-.B ul
-[options] [file ...]
+.BR ul " [options]"
+.RI [ file ...]
 .SH DESCRIPTION
 .B ul
 reads the named files (or standard input if none are given) and translates
@@ -63,11 +63,11 @@ present in an
 output stream on a crt-terminal.
 .TP
 \fB\-t\fR, \fB\-T\fR, \fB\-\-terminal\fR \fIterminal\fR
-.It Fl t Ar terminal
-Overrides the
+Override the environment variable
+.B TERM
+with the specified
 .I terminal
-type specified in the environment with
-.BR TERM .
+type.
 .TP
 \fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
@@ -98,7 +98,7 @@ file (see
 .BR setenv (1),
 .BR terminfo (5)
 .SH BUGS
-.B Nroff
+.B nroff
 usually outputs a series of backspaces and underlines intermixed with the
 text to indicate underlining.  No attempt is made to optimize the backward
 motion.
-- 
1.7.0.4

