Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:64800 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751576AbaGOVHq (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Jul 2014 17:07:46 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/3] docs: bring a few more man pages closer to standard formatting
Date: Tue, 15 Jul 2014 23:07:37 +0200
Message-Id: <1405458458-13966-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1405458458-13966-1-git-send-email-bensberg@justemail.net>
References: <1405458458-13966-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 term-utils/mesg.1         |   43 ++++++++++++++++++++-----------------------
 term-utils/reset.1        |    4 ++--
 term-utils/script.1       |   32 ++++++++++++++++----------------
 term-utils/scriptreplay.1 |   12 ++++++------
 term-utils/setterm.1      |    2 +-
 term-utils/wall.1         |    8 ++++----
 term-utils/write.1        |    7 ++++---
 7 files changed, 53 insertions(+), 55 deletions(-)

diff --git a/term-utils/mesg.1 b/term-utils/mesg.1
index f7ebf41..9bdc6d5 100644
--- a/term-utils/mesg.1
+++ b/term-utils/mesg.1
@@ -31,23 +31,18 @@
 .\"
 .\"	@(#)mesg.1	8.1 (Berkeley) 6/6/93
 .\"
-.\" Fri Mar 10 20:31:02 1995, modified for standard man macros,
-.\" faith@cs.unc.edu
-.\"
-.\"
-.\" "
-.TH MESG 1 "April 2011" "util-linux" "User Commands"
+.TH MESG 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
-mesg \- display (do not display) messages from other users
+mesg \- display (or do not display) messages from other users
 .SH SYNOPSIS
 .B mesg
-.RB [options]
+[option]
 .RB [ n | y ]
 .SH DESCRIPTION
 The
 .B mesg
-utility is invoked by a users to control write access others have to the
-terminal device associated with the standard error output.  If write access
+utility is invoked by a user to control write access others have to the
+terminal device associated with standard error output.  If write access
 is allowed, then programs such as
 .BR talk (1)
 and
@@ -63,37 +58,39 @@ should be executed in your login scripts.
 .SH ARGUMENTS
 .TP
 .B n
-Disallows messages.
+Disallow messages.
 .TP
 .B y
-Permits messages to be displayed.
+Allow messages to be displayed.
+.PP
+If no arguments are given,
+.B mesg
+shows the current message status on standard error output.
 .SH OPTIONS
 .TP
-.B \-v, \-\-verbose
+.BR \-v , " \-\-verbose"
 Explain what is being done.
 .TP
-.B \-V, \-\-verbose
+.BR \-V , " \-\-version"
 Display version information and exit.
 .TP
-.B \-h, \-\-help
+.BR \-h , " \-\-help"
 Display help text and exit.
-.PP
-If no arguments are given,
-.B mesg
-displays the present message status to the standard error output.
-.PP
+.SH EXIT STATUS
 The
 .B mesg
 utility exits with one of the following values:
+.RS 4
 .TP
-.I "\ 0"
+.B "\ 0"
 Messages are allowed.
 .TP
-.I "\ 1"
+.B "\ 1"
 Messages are not allowed.
 .TP
-.I ">1"
+.B ">1"
 An error has occurred.
+.RE
 .SH FILES
 .I /dev/[pt]ty[pq]?
 .SH "SEE ALSO"
diff --git a/term-utils/reset.1 b/term-utils/reset.1
index fdf67e2..f8c3df7 100644
--- a/term-utils/reset.1
+++ b/term-utils/reset.1
@@ -28,8 +28,8 @@ or in the terminfo database
 (for the
 .B ncurses
 .BR tput ).
-This sequence seems to be sufficient to reset the Linux VC's when they
-start printing "funny-looking" characters.  For good measure,
+This sequence seems to be sufficient to reset a Linux VC when it
+starts printing "funny-looking" characters.  For good measure,
 .BR stty (1)
 is called with the
 .I sane
diff --git a/term-utils/script.1 b/term-utils/script.1
index 67e1066..4573f07 100644
--- a/term-utils/script.1
+++ b/term-utils/script.1
@@ -31,15 +31,16 @@
 .\"
 .\"	@(#)script.1	6.5 (Berkeley) 7/27/91
 .\"
-.TH SCRIPT "1" "September 2011" "util-linux" "User Commands"
+.TH SCRIPT "1" "June 2014" "util-linux" "User Commands"
 .SH NAME
 script \- make typescript of terminal session
 .SH SYNOPSIS
 .B script
-[options] [file]
+[options]
+.RI [ file ]
 .SH DESCRIPTION
 .B script
-makes a typescript of everything printed on your terminal.  It is useful for
+makes a typescript of everything displayed on your terminal.  It is useful for
 students who need a hardcopy record of an interactive session as proof of an
 assignment, as the typescript file can be printed out later with
 .BR lpr (1).
@@ -48,17 +49,17 @@ If the argument
 .I file
 is given,
 .B script
-saves all dialogue in
+saves the dialogue in this
 .IR file .
-If no file name is given, the typescript is saved in the file
-.IR typescript .
+If no filename is given, the dialogue is saved in the file
+.BR typescript .
 .SH OPTIONS
 .TP
 \fB\-a\fR, \fB\-\-append\fR
 Append the output to
 .I file
-or
-.IR typescript ,
+or to
+.BR typescript ,
 retaining the prior contents.
 .TP
 \fB\-c\fR, \fB\-\-command\fR \fIcommand\fR
@@ -101,8 +102,7 @@ Display help text and exit.
 .SH NOTES
 The script ends when the forked shell exits (a
 .I control-D
-to exit
-the Bourne shell
+for the Bourne shell
 .RB ( sh (1)),
 and
 .IR exit ,
@@ -118,7 +118,7 @@ C-shell,
 Certain interactive commands, such as
 .BR vi (1),
 create garbage in the typescript file.
-.B Script
+.B script
 works best with commands that do not manipulate the screen, the results are
 meant to emulate a hardcopy terminal.
 .SH ENVIRONMENT
@@ -127,11 +127,11 @@ The following environment variable is utilized by
 .TP
 .B SHELL
 If the variable
-.I SHELL
+.B SHELL
 exists, the shell forked by
 .B script
-will be that shell. If
-.I SHELL
+will be that shell.  If
+.B SHELL
 is not set, the Bourne shell is assumed.  (Most shells set this variable
 automatically).
 .SH SEE ALSO
@@ -145,9 +145,9 @@ The
 .B script
 command appeared in 3.0BSD.
 .SH BUGS
-.B Script
+.B script
 places
-.B everything
+.I everything
 in the log file, including linefeeds and backspaces.  This is not what the
 naive user expects.
 .SH AVAILABILITY
diff --git a/term-utils/scriptreplay.1 b/term-utils/scriptreplay.1
index 329dbc9..8c9053a 100644
--- a/term-utils/scriptreplay.1
+++ b/term-utils/scriptreplay.1
@@ -3,14 +3,14 @@
 scriptreplay \- play back typescripts, using timing information
 .SH "SYNOPSIS"
 .B scriptreplay
-.RI [ options ]
+[options]
 .RB [ \-t ]
 .I timingfile
 .RI [ typescript
 .RI [ divisor ]]
 .SH "DESCRIPTION"
 This program replays a typescript, using timing information to ensure that
-output happens at the same speed as it originally appeared when the script
+output happens in the same rhythm as it originally appeared when the script
 was recorded.
 .PP
 The replay simply displays the information again; the programs
@@ -45,10 +45,10 @@ than the original session.
 The first three options will overide old-style arguments.
 .TP
 .BR \-t , " \-\-timing " \fIfile\fR
-File containing script timing output.
+File containing \fBscript\fR's timing output.
 .TP
 .BR \-s , " \-\-typescript " \fIfile\fR
-File containing the script terminal output.
+File containing \fBscript\fR's terminal output.
 .TP
 .BR \-d , " \-\-divisor " \fInumber\fR
 Speed up the replay displaying this
@@ -57,9 +57,9 @@ of times.  The argument is a floating point number.  It's called divisor
 because it divides the timings by this factor.
 .TP
 .BR \-m , " \-\-maxdelay " \fInumber\fR
-Set the maximal delay between transcript updates to
+Set the maximum delay between transcript updates to
 .I number
-seconds.  The argument is a floating point number.  This can be used to
+of seconds.  The argument is a floating point number.  This can be used to
 avoid long pauses in the transcript replay.
 .TP
 .BR \-V , " \-\-version"
diff --git a/term-utils/setterm.1 b/term-utils/setterm.1
index bc11fdb..a901e24 100644
--- a/term-utils/setterm.1
+++ b/term-utils/setterm.1
@@ -13,7 +13,7 @@
 setterm \- set terminal attributes
 .SH SYNOPSIS
 .B setterm
-.RI [ options ]
+[options]
 .SH DESCRIPTION
 .B setterm
 writes to standard output a character string that will invoke the specified
diff --git a/term-utils/wall.1 b/term-utils/wall.1
index 65f0ee8..fd6c029 100644
--- a/term-utils/wall.1
+++ b/term-utils/wall.1
@@ -35,7 +35,7 @@
 .\"
 .TH WALL "1" "August 2013" "util-linux" "User Commands"
 .SH NAME
-wall \- write a message to users
+wall \- write a message to all users
 .SH SYNOPSIS
 .B wall
 .RB [ \-n ]
@@ -45,10 +45,10 @@ wall \- write a message to users
 .SH DESCRIPTION
 .B wall
 displays a
-.I message
+.IR message ,
 or the contents of a
-.I file
-or, by default, its standard input, on the terminals of all currently logged
+.IR file ,
+or otherwise its standard input, on the terminals of all currently logged
 in users.  The command will wrap lines that are longer than 79 characters.
 Short lines are whitespace padded to have 79 characters.  The command will
 always put a carriage return and new line at the end of each line.
diff --git a/term-utils/write.1 b/term-utils/write.1
index 33eb914..ad321f4 100644
--- a/term-utils/write.1
+++ b/term-utils/write.1
@@ -44,7 +44,7 @@ write \- send a message to another user
 .I user
 .RI [ ttyname ]
 .SH DESCRIPTION
-.B Write
+.B write
 allows you to communicate with other users, by copying lines from
 your terminal to theirs.
 .PP
@@ -73,10 +73,11 @@ command.  Some commands, for example
 .BR nroff (1)
 and
 .BR pr (1),
-may disallow writing automatically, so that your output isn't overwritten.
+may automatically disallow writing, so that the output they produce
+isn't overwritten.
 .PP
 If the user you want to write to is logged in on more than one terminal,
-you can specify which terminal to write to by specifying the terminal
+you can specify which terminal to write to by giving the terminal
 name as the second operand to the
 .B write
 command.  Alternatively, you can let
-- 
1.7.0.4

