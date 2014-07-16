Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:59729 "EHLO
	cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751016AbaGPLKH (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Jul 2014 07:10:07 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/3] docs: improve the wording and conventions in the man-page howto
Date: Wed, 16 Jul 2014 13:09:52 +0200
Message-Id: <1405508993-8097-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1405508993-8097-1-git-send-email-bensberg@justemail.net>
References: <1405508993-8097-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 Documentation/howto-man-page.txt |   97 +++++++++++++++++++++-----------------
 1 files changed, 53 insertions(+), 44 deletions(-)

diff --git a/Documentation/howto-man-page.txt b/Documentation/howto-man-page.txt
index 01b458f..ee3cb4e 100644
--- a/Documentation/howto-man-page.txt
+++ b/Documentation/howto-man-page.txt
@@ -1,12 +1,12 @@
-.\" This is an util-linux manual page example in troff format.
+.\" This is a util-linux manual page example in troff format.
 .\"
-.\" .TH macro is expecting following arguments:
+.\" The .TH macro expects the following arguments:
 .\"	title section date footer header
-.\" The title is usually command name.
-.\" The section must match with file name extension.
-.\" The date tells month and year when last update happen.
+.\" The title is usually the command name.
+.\" The section must match the filename extension.
+.\" The date is the month and year when the last update happened.
 .\" The footer is fixed to "util-linux".
-.\" The header is textual string of section
+.\" The header is a textual description of the section:
 .\"	1 "User Commands"
 .\"	2 "System calls"
 .\"	3 "Programmer's Manual"
@@ -16,35 +16,36 @@
 .\"	7 "Miscellanea"
 .\"	8 "System Administration"
 .\"
-.\" Please read `man 7 groff_man' howto use various macros.
+.\" Please read `man 7 groff_man' to see how to use the various macros.
 .\"
-.TH EXAMPLE "1" "August 2011" "util-linux" "User Commands"
+.TH EXAMPLE "1" "July 2014" "util-linux" "User Commands"
 .SH NAME
-example \- an util-linux man page howto
+example \- a util-linux man-page howto
 .SH SYNOPSIS
 .B example
 [options]
 .I argument
 .SH DESCRIPTION
-All manual pages need some sort of description.  Write such here.
+Each manual page needs some sort of description of the command.
+Write such here.
 .SH OPTIONS
 .TP
 \fB\-n\fR, \fB\-\-no\-argument\fR
-This option does not use argument.
+This option does not use an argument.
 .TP
 \fB\-o\fR, \fB\-\-optional\fR[\fI=argument\fR]
-Tell in description an
+Tell in this description that the
 .I argument
-is optional, and what happens when is or is not given.  Notice that
+is optional, and what happens when it is or is not given.  Notice that the word
 .I argument
-is not abbreviated, like in usage function.  Assuming usage function would
-define argument to be
+is not abbreviated as is customary in the usage text.  For example, when the
+usage text uses the argument
 .IR num ,
 the manual page should say
 .IR number .
 .TP
 \fB\-r\fR, \fB\-\-required\fR \fIargument\fR
-Tell in description option
+Tell in this description that the
 .I argument
 is required.
 .TP
@@ -52,27 +53,33 @@ is required.
 Display version information and exit.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
-Display help and exit.
+Display help text and exit.
 .SH NOTES
-Tell details what users might need to know.  For example kernel feature or
+Tell details that users might need to know.  For example, kernel feature or
 version requirements.
 .PP
-The man page groff input lines should not exceed 80 characters length.
+The man-page source lines should not exceed 80 characters in length.
 .PP
-Do not leave empty lines to groff input.  If you need break or paragraph use
-appropriate groff macros.  See
+Do not leave empty lines in the groff input.  If you need a break or a new
+paragraph, use the appropriate groff macros.  See
 .BR groff_man (7)
 how to use man page macros.
 .PP
-Use of
+The use cases of
 .I italic
-which is underlined in terminal, and
+(which is underlined on a terminal) and
 .B bold
-are not strictly defined.  As some sort of convention
-.I arguments
-use italic, and the
-.B other highlights
-are bold.
+are not strictly defined.  The main convention is that
+.I symbolic arguments
+use italic, and
+.B commands
+and
+.B literal arguments
+use bold, and
+.I other highlights
+use
+.B either
+one.
 .\"
 .\" The manual page comments are undervalued way of adding clarifications
 .\" quite not belong to the manual, questions, TODO items etc.  Feel free
@@ -80,37 +87,39 @@ are bold.
 .\"
 .PP
 When in the source a new sentence begins somewhere midline, it should use a
-double space before its initial letter.  This is done because groff uses double
-spaces last sentence ends to end of line, and next begins from new line.
-Unless double spaces are used in middle of of line the spacing style is
-inconsistent.
+double space before its initial letter.  This is done because \fBgroff\fR
+uses a double space after a sentence when this sentence ends at the end of
+an input line and the next sentence begins on the next line.
+Unless a double space is used before other sentence starts as well, the
+spacing style will be inconsistent.
 .SH ENVIRONMENT
-Tell which environment variables affect, and how, to execution of the command.
+Tell which environment variables affect, and how, the execution of the command.
 .TP
 .B EXAMPLE_PATH
-Configuration file path.  Notice that a well-known environment variables such as
-.B HOME
-does not need explanation.
+Configuration file path.  Notice that well-known environment variables, such as
+.BR HOME ,
+do not need explanation.
 .SH FILES
-Tell which file(s) command uses.
+Tell which file(s) the command uses.
 .TP
 .B $EXAMPLE_PATH
 .TQ
 .B $HOME/.example.conf
 .TQ
 .B /etc/example.conf
-What are these files, which order and will the evaluation end or continue if a
-file is found.  In case the explanation is not simple write separated Special
-Files manual page that tells about syntax, meaning of key-value settings etc.
-The file manual page needs to be referred in
+What are these files, in which order are they read, and will the evaluation
+end or continue if one of them is found.
+In case the explanation is not simple, write a separate "Special Files"
+manual page that tells about syntax, meaning of key-value settings, etc.
+This "Special Files" manual page then needs to be referred in the
 .B SEE ALSO
 section.
 .TP
 .B /var/log/example.log
 Another file.
 .SH EXAMPLES
-Write typical and/or clever use examples here.  The bellow examples are stupid,
-and you should never write them to real man page.
+Write typical and/or clever use examples here.  The below examples are stupid,
+and you should never write them in a real man page.
 .TP
 .B example -h
 Output help screen.
@@ -118,7 +127,7 @@ Output help screen.
 .B example -V
 Output version information.
 .SH "EXIT STATUS"
-This section can be removed if command has only two return values,
+This section can be left out if the command has only two return values,
 .B 0
 for success and
 .B 1
-- 
1.7.0.4

