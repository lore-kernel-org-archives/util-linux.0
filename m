Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f181.google.com ([74.125.82.181]:58386 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758218Ab3CGX1t (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 Mar 2013 18:27:49 -0500
Received: by mail-we0-f181.google.com with SMTP id t44so309850wey.26
        for <util-linux@vger.kernel.org>; Thu, 07 Mar 2013 15:27:46 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 7/7] docs: add long options and tidy up kill.1
Date: Thu,  7 Mar 2013 23:27:24 +0000
Message-Id: <1362698844-21292-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1362698844-21292-1-git-send-email-kerolasa@iki.fi>
References: <1362698844-21292-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.1 | 88 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 46 insertions(+), 42 deletions(-)

diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
index 404fb72..47bac5d 100644
--- a/misc-utils/kill.1
+++ b/misc-utils/kill.1
@@ -1,7 +1,7 @@
 .\" Copyright 1994 Salvatore Valente (svalente@mit.edu)
 .\" Copyright 1992 Rickard E. Faith (faith@cs.unc.edu)
 .\" May be distributed under the GNU General Public License
-.TH KILL 1 "February 2011" "util-linux" "User Commands"
+.TH KILL 1 "March 2013" "util-linux" "User Commands"
 .SH NAME
 kill \- terminate a process
 .SH SYNOPSIS
@@ -19,15 +19,14 @@ kill \- terminate a process
 .SH DESCRIPTION
 The command
 .B kill
-sends the specified signal to the specified process or process group.
-If no signal is specified, the TERM signal is sent.  The TERM signal
-will kill processes which do not catch this signal.  For other processes,
-it may be necessary to use the KILL (9) signal, since this signal cannot
-be caught.
+sends the specified signal to the specified process or process group.  If no
+signal is specified, the TERM signal is sent.  The TERM signal will kill
+processes which do not catch this signal.  For other processes, it may be
+necessary to use the KILL (9) signal, since this signal cannot be caught.
 .PP
-Most modern shells have a builtin kill function, with a usage rather similar
-to that of the command described here.  The `-a' and `-p' options,
-and the possibility to specify processes by command name are a local extension.
+Most modern shells have a builtin kill function, with a usage rather similar to
+that of the command described here.  The '-a' and '-p' options, and the
+possibility to specify processes by command name are a local extension.
 .PP
 If sig is 0, then no signal is sent, but error checking is still performed.
 .SH OPTIONS
@@ -38,7 +37,6 @@ Specify the list of processes that
 should signal.  Each
 .I pid
 can be one of five things:
-
 .RS
 .TP
 .I n
@@ -57,65 +55,66 @@ All processes with pid larger than 1 will be signaled.
 .BI - n
 where
 .I n
-is larger than 1.
-All processes in process group
+is larger than 1.  All processes in process group
 .I n
-are signaled.  When an argument of the form `-n' is given,
-and it is meant to denote a process group,
-either the signal must be specified first, or the argument must be preceded
-by a `--' option, otherwise it will be taken as the signal to send.
+are signaled.  When an argument of the form '-n' is given, and it is meant to
+denote a process group, either the signal must be specified first, or the
+argument must be preceded by a '--' option, otherwise it will be taken as the
+signal to send.
+.RE
 .TP
 .I commandname
 All processes invoked using that name will be signaled.
-.RE
 .TP
-.BI \-s " signal"
-Specify the signal to send.
-The signal may be given as a signal name or number.
+\fB\-s\fR, \fB\-\-signal\fR \fIsignal\fR
+Specify the signal to send.  The signal may be given as a signal name or
+number.
 .TP
-.B \-l
+\fB\-l\fR, \fB\-\-list\fR [\fIsignal\fR]
 Print a list of signal names.  These are found in
-.I /usr/include/linux/signal.h
+.I /usr/\:include/\:linux/\:signal.h
 .TP
-.B \-a
-Do not restrict the commandname-to-pid conversion to processes
-with the same uid as the present process.
+\fB\-a\fR, \fB\-\-all\fR
+Do not restrict the commandname-to-pid conversion to processes with the same
+uid as the present process.
 .TP
-.B \-p
+\fB\-p\fR, \fB\-\-pid\fR
 Specify that
 .B kill
-should only print the process id (pid)
-of the named processes, and not send any signals.
+should only print the process id (pid) of the named processes, and not send any
+signals.
 .TP
-.BI \-q " sigval"
+\fB\-q\fR, \fB\-\-queue\fR \fIsigval\fR
 Use
 .BR sigqueue (2)
 rather than
 .BR kill (2)
-and the sigval argument is used to specify an integer to be sent with the
-signal.  If the receiving process has installed a handler for this signal using
-the SA_SIGINFO flag to
+and the
+.I sigval
+argument is used to specify an integer to be sent with the signal.  If the
+receiving process has installed a handler for this signal using the SA_SIGINFO
+flag to
 .BR sigaction (2),
 then it can obtain this data via the si_value field of the siginfo_t structure.
 .SH NOTES
-It's not possible to send a signal to explicitly selected thread in a
+It is not possible to send a signal to explicitly selected thread in a
 multithreaded process by
 .BR kill (2)
-syscall. If
+syscall.  If
 .BR kill(2)
-is used to send a signal to a thread group,  then
-kernel selects arbitrary member of the thread group that has not blocked
-the signal. For more details see
+is used to send a signal to a thread group, then kernel selects arbitrary
+member of the thread group that has not blocked the signal.  For more details
+see
 .BR clone (2)
 CLONE_THREAD description.
-
+.PP
 The command
 .BR kill (1)
 as well as syscall
 .BR kill (2)
 accepts TID (thread ID, see
 .BR gettid (2))
-as argument. In this case the kill behavior is not changed and the signal is
+as argument.  In this case the kill behavior is not changed and the signal is
 also delivered to the thread group rather than to the specified thread.
 .SH "SEE ALSO"
 .BR bash (1),
@@ -124,8 +123,13 @@ also delivered to the thread group rather than to the specified thread.
 .BR sigvec (2),
 .BR signal (7)
 .SH AUTHOR
-Taken from BSD 4.4.  The ability to translate process names to process
-ids was added by Salvatore Valente <svalente@mit.edu>.
+Taken from BSD 4.4.  The ability to translate process names to process ids was
+added by
+.MT svalente@mit.edu
+Salvatore Valente
+.ME .
 .SH AVAILABILITY
 The kill command is part of the util-linux package and is available from
-ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
-- 
1.8.1.5

