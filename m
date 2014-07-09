Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:53966 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751300AbaGIN30 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Jul 2014 09:29:26 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] docs: fix many wording and some formatting issues in the man page of kill
Date: Wed,  9 Jul 2014 15:29:10 +0200
Message-Id: <1404912550-2573-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1404912550-2573-1-git-send-email-bensberg@justemail.net>
References: <1404912550-2573-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also, add the most-used form of '-signal' to the synopsis.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/kill.1 |  100 +++++++++++++++++++++++++++-------------------------
 1 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
index dd1b1ee..0d430ef 100644
--- a/misc-utils/kill.1
+++ b/misc-utils/kill.1
@@ -1,40 +1,44 @@
 .\" Copyright 1994 Salvatore Valente (svalente@mit.edu)
 .\" Copyright 1992 Rickard E. Faith (faith@cs.unc.edu)
 .\" May be distributed under the GNU General Public License
-.TH KILL 1 "March 2013" "util-linux" "User Commands"
+.TH KILL 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 kill \- terminate a process
 .SH SYNOPSIS
 .B kill
-.RB [ \-s
-.IR signal  | \fB\-p\fP ]
+.RB [ \- \fIsignal\fR| \-s
+.IR signal | \fB-p\fP ]
 .RB [ \-q
-.IR sigval ]
+.IR value ]
 .RB [ \-a ]
 .RB [ \-\- ]
-.IR pid|name ...
+.IR pid | name ...
 .br
-.B kill -l
-.RI [ signal ]
+.B kill \-l
+.RI [ number ]
+.RB "| " \-L
 .SH DESCRIPTION
 The command
 .B kill
-sends the specified signal to the specified process or process group.  If no
-signal is specified, the TERM signal is sent.  The TERM signal will kill
-processes which do not catch this signal.  For other processes, it may be
-necessary to use the KILL (9) signal, since this signal cannot be caught.
+sends the specified \fIsignal\fR to the specified processes or process groups.
+If no signal is specified, the TERM signal is sent.  This TERM signal will kill
+processes that do not catch it; for other processes it may be necessary to use
+the KILL signal (number 9), since this signal cannot be caught.
 .PP
 Most modern shells have a builtin kill function, with a usage rather similar to
-that of the command described here.  The \-\-all, \-\-pid, and \-\-queue options,
-and the possibility to specify processes by command name are a local extension.
+that of the command described here.  The
+.BR \-\-all ,
+.BR \-\-pid ", and"
+.BR \-\-queue
+options, and the possibility to specify processes by command name, are local extensions.
 .PP
-If sig is 0, then no signal is sent, but error checking is still performed.
-.SH OPTIONS
+If \fIsignal\fR is 0, then no actual signal is sent, but error checking is still performed.
+
+.SH ARGUMENTS
+The list of processes to be signaled can be a mixture of names and pids.
 .TP
-.IR pid ...
-Specify the list of processes that
-.B kill
-should signal.  Each
+.I pid
+Each
 .I pid
 can be one of four things:
 .RS
@@ -44,13 +48,13 @@ where
 .I n
 is larger than 0.  The process with pid
 .I n
-will be signaled.
+is signaled.
 .TP
 .B 0
 All processes in the current process group are signaled.
 .TP
 .B -1
-All processes with pid larger than 1 will be signaled.
+All processes with a pid larger than 1 are signaled.
 .TP
 .BI - n
 where
@@ -58,25 +62,26 @@ where
 is larger than 1.  All processes in process group
 .I n
 are signaled.  When an argument of the form '-n' is given, and it is meant to
-denote a process group, either the signal must be specified first, or the
+denote a process group, either a signal must be specified first, or the
 argument must be preceded by a '--' option, otherwise it will be taken as the
 signal to send.
 .RE
 .TP
 .I name
-All processes invoked using that name will be signaled.
+All processes invoked using this \fIname\fR will be signaled.
+
+.SH OPTIONS
 .TP
 \fB\-s\fR, \fB\-\-signal\fR \fIsignal\fR
-Specify the signal to send.  The signal may be given as a signal name or
-number.
+The signal to send.  It may be given as a name or a number.
 .TP
-\fB\-l\fR, \fB\-\-list\fR [\fIsignal\fR]
-Print a list of signal names, or convert signal given as argument to a name.
-The signals are found in
+\fB\-l\fR, \fB\-\-list\fR [\fInumber\fR]
+Print a list of signal names, or convert the given signal number to a name.
+The signals can be found in
 .I /usr/\:include/\:linux/\:signal.h
 .TP
 \fB\-L\fR, \fB\-\-table\fR
-Similar to \-l, but will print signal names and their corresponding
+Similar to \fB\-l\fR, but it will print signal names and their corresponding
 numbers.
 .TP
 \fB\-a\fR, \fB\-\-all\fR
@@ -84,47 +89,46 @@ Do not restrict the commandname-to-pid conversion to processes with the same
 uid as the present process.
 .TP
 \fB\-p\fR, \fB\-\-pid\fR
-Specify that
-.B kill
-should only print the process id (pid) of the named processes, and not send any
+Only print the process id (pid) of the named processes, do not send any
 signals.
 .IP
-The \-\-pid option functionality is also enabled when the command
-copied or linked to name
+The \fB\-\-pid\fR option is automatically enabled when the \fBkill\fR command
+is invoked with the name of
 .BR pid .
-This functionality is deprecated, and will not be removed in March 2016.
+This functionality is deprecated, and will be removed in March 2016.
 .TP
-\fB\-q\fR, \fB\-\-queue\fR \fIsigval\fR
+\fB\-q\fR, \fB\-\-queue\fR \fIvalue\fR
 Use
 .BR sigqueue (2)
 rather than
-.BR kill (2)
-and the
-.I sigval
-argument is used to specify an integer to be sent with the signal.  If the
+.BR kill (2).
+The
+.I value
+argument is an integer that is sent along with the signal.  If the
 receiving process has installed a handler for this signal using the SA_SIGINFO
 flag to
 .BR sigaction (2),
-then it can obtain this data via the si_value field of the siginfo_t structure.
+then it can obtain this data via the si_sigval field of the siginfo_t structure.
+
 .SH NOTES
-It is not possible to send a signal to explicitly selected thread in a
-multithreaded process by
+It is not possible to send a signal to an explicitly selected thread in a
+multithreaded process using the
 .BR kill (2)
 syscall.  If
 .BR kill(2)
-is used to send a signal to a thread group, then kernel selects arbitrary
+is used to send a signal to a thread group, then the kernel selects an arbitrary
 member of the thread group that has not blocked the signal.  For more details
 see
-.BR clone (2)
-CLONE_THREAD description.
+.BR clone (2),
+the CLONE_THREAD description.
 .PP
 The command
 .BR kill (1)
 as well as syscall
 .BR kill (2)
-accepts TID (thread ID, see
+accept a TID (thread ID, see
 .BR gettid (2))
-as argument.  In this case the kill behavior is not changed and the signal is
+as an argument.  In this case the kill behavior is not changed and the signal is
 also delivered to the thread group rather than to the specified thread.
 
 .SH RETURN CODES
-- 
1.7.0.4

