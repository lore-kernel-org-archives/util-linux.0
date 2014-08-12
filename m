Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:53087 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754235AbaHLUPh (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Aug 2014 16:15:37 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/3] docs: bring the chrt and taskset man pages closer to standard formatting
Date: Tue, 12 Aug 2014 22:15:18 +0200
Message-Id: <1407874518-12776-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1407874518-12776-1-git-send-email-bensberg@justemail.net>
References: <1407874518-12776-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 schedutils/chrt.1    |   83 ++++++++++++++++++++++++-------------------------
 schedutils/taskset.1 |   52 ++++++++++++++++---------------
 2 files changed, 68 insertions(+), 67 deletions(-)

diff --git a/schedutils/chrt.1 b/schedutils/chrt.1
index 6711fc6..e385c9f 100644
--- a/schedutils/chrt.1
+++ b/schedutils/chrt.1
@@ -23,30 +23,30 @@
 .\" 2002-05-11 Robert Love <rml@tech9.net>
 .\" 	Initial version
 .\"
-.TH CHRT 1 "June 2010" "util-linux" "User Commands"
+.TH CHRT 1 "August 2014" "util-linux" "User Commands"
 .SH NAME
 chrt \- manipulate the real-time attributes of a process
 .SH SYNOPSIS
 .B chrt
-.RI [ options ]\  prio
-.IR command\  [ arg ]...
+[options]
+.IR priority\ command\  [ argument ...]
 .br
 .B chrt
-.RI [ options ]
+[options]
 .B \-p
-.RI [ prio ]\  pid
+.RI [ priority ]\  pid
 .SH DESCRIPTION
 .PP
 .B chrt
 sets or retrieves the real-time scheduling attributes of an existing \fIpid\fR,
-or runs \fIcommand\fR with the given attributes.  Both policy (one of
+or runs \fIcommand\fR with the given attributes.  Both the policy (one of
 .BR SCHED_OTHER ,
 .BR SCHED_FIFO ,
 .BR SCHED_RR ,
 .BR SCHED_BATCH ,
 or
 .BR SCHED_IDLE )
-and priority can be set and retrieved.
+and the priority can be set and retrieved.
 .PP
 The
 .BR SCHED_BATCH
@@ -60,63 +60,63 @@ flag for policies SCHED_RR and SCHED_FIFO is supported
 since Linux 2.6.31.
 .SH OPTIONS
 .TP
-.B -a, --all-tasks
+.BR -a ,\  --all-tasks
 Set or retrieve the scheduling attributes of all the tasks (threads) for a
 given PID.
 .TP
-.B -b, --batch
+.BR -b ,\  --batch
 Set scheduling policy to
-.BR SCHED_BATCH
-(Linux specific).
+.B SCHED_BATCH
+(Linux-specific).
 .TP
-.B -f, --fifo
+.BR -f ,\  --fifo
 Set scheduling policy to
 .BR SCHED_FIFO .
 .TP
-.B -i, --idle
+.BR -i ,\  --idle
 Set scheduling policy to
-.BR SCHED_IDLE
-(Linux specific).
+.B SCHED_IDLE
+(Linux-specific).
 .TP
-.B -m, --max
+.BR -m ,\  --max
 Show minimum and maximum valid priorities, then exit.
 .TP
-.B -o, --other
+.BR -o ,\  --other
 Set policy scheduling policy to
 .BR SCHED_OTHER .
 .TP
-.B -p, --pid
+.BR -p ,\  --pid
 Operate on an existing PID and do not launch a new task.
 .TP
-.B -r, --rr
-Set scheduling policy to
-.BR SCHED_RR .
-When policy is not defined the
-.B SCHED_RR
-is used as default.
-.TP
-.B -R, --reset-on-fork
+.BR -R ,\  --reset-on-fork
 Add
 .B SCHED_RESET_ON_FORK
 flag to the
 .B SCHED_FIFO
 or
 .B SCHED_RR
-scheduling policy (Linux specific).
+scheduling policy (Linux-specific).
 .TP
-.B -v, --verbose
-Show status information.
+.BR -r ,\  --rr
+Set scheduling policy to
+.BR SCHED_RR .
+When policy is not defined the
+.B SCHED_RR
+is used as default.
 .TP
-.B -h, --help
-Display help text and exit.
+.BR -v ,\  --verbose
+Show status information.
 .TP
-.B -V, --version
+.BR -V ,\  --version
 Display version information and exit.
+.TP
+.BR -h ,\  --help
+Display help text and exit.
 .SH USAGE
 .TP
 The default behavior is to run a new command:
 .B chrt
-.I prio
+.I priority
 .IR command\  [ arguments ]
 .TP
 You can also retrieve the real-time attributes of an existing task:
@@ -125,7 +125,7 @@ You can also retrieve the real-time attributes of an existing task:
 .TP
 Or set them:
 .B chrt \-r \-p
-.I prio pid
+.I priority pid
 .SH PERMISSIONS
 A user must possess
 .BR CAP_SYS_NICE
@@ -142,14 +142,7 @@ may be ignored on some systems.
 .P
 Linux default scheduling policy is
 .BR SCHED_OTHER .
-.SH AUTHOR
-Written by Robert M. Love.
-.SH COPYRIGHT
-Copyright \(co 2004 Robert M. Love
-.br
-This is free software; see the source for copying conditions.  There is NO
-warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR taskset (1),
 .BR nice (1),
 .BR renice (1)
@@ -157,6 +150,12 @@ warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 See
 .BR sched_setscheduler (2)
 for a description of the Linux scheduling scheme.
+.SH AUTHOR
+Written by Robert M. Love.
+.SH COPYRIGHT
+Copyright \(co 2004 Robert M. Love.
+This is free software; see the source for copying conditions.  There is NO
+warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 .SH AVAILABILITY
 The chrt command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/schedutils/taskset.1 b/schedutils/taskset.1
index e6a5624..0d62e8b 100644
--- a/schedutils/taskset.1
+++ b/schedutils/taskset.1
@@ -23,23 +23,24 @@
 .\" 2002-05-11 Robert Love <rml@tech9.net>
 .\" 	Initial version
 .\"
-.TH TASKSET 1 "April 2003" "util-linux" "User Commands"
+.TH TASKSET 1 "August 2014" "util-linux" "User Commands"
 .SH NAME
-taskset \- retrieve or set a process's CPU affinity
+taskset \- set or retrieve a process's CPU affinity
 .SH SYNOPSIS
 .B taskset
-.RI [ options ]\  mask
-.IR command\  [ arg ]...
+[options]
+.IR mask\ command\  [ argument ...]
 .br
 .B taskset
-.RI [ options ]
+[options]
 .B \-p
 .RI [ mask ]\  pid
 .SH DESCRIPTION
 .PP
 .B taskset
-is used to set or retrieve the CPU affinity of a running process given its PID
-or to launch a new COMMAND with a given CPU affinity.  CPU affinity is a
+is used to set or retrieve the CPU affinity of a running process given its
+\fIpid\fR, or to launch a new \fIcommand\fR with a given CPU affinity.
+CPU affinity is a
 scheduler property that "bonds" a process to a given set of CPUs on the system.
 The Linux scheduler will honor the given CPU affinity and the process will not
 run on any other CPUs.  Note that the Linux scheduler also supports natural
@@ -54,15 +55,17 @@ may specify more CPUs than are present.  A retrieved mask will reflect only the
 bits that correspond to CPUs physically on the system.  If an invalid mask is
 given (i.e., one that corresponds to no valid CPUs on the current system) an
 error is returned.  The masks are typically given in hexadecimal.  For example,
-.TP
+.RS 4
+.TP 12
 .BR 0x00000001
-is processor #0
+is processor #0,
 .TP
 .BR 0x00000003
-is processors #0 and #1
+is processors #0 and #1,
 .TP
 .BR 0xFFFFFFFF
 is all processors (#0 through #31).
+.RE
 .PP
 When
 .BR taskset
@@ -73,19 +76,19 @@ CPU.
 .BR \-a ,\  \-\-all-tasks
 Set or retrieve the CPU affinity of all the tasks (threads) for a given PID.
 .TP
+.BR \-c ,\  \-\-cpu-list \ \fInumbers
+Specify a numerical list of processors instead of a bitmask.  The \fInumbers\fR
+are separated by commas and may include ranges.  For example:
+.BR 0,5,8-11 .
+.TP
 .BR \-p ,\  \-\-pid
 Operate on an existing PID and do not launch a new task.
 .TP
-.BR \-c ,\  \-\-cpu-list
-Specify a numerical list of processors instead of a bitmask.  The numbers
-are separated by commas and may include ranges.  For example:
-.BR 0,5,7,9-11 .
+.BR \-V ,\  \-\-version
+Display version information and exit.
 .TP
 .BR \-h ,\  \-\-help
 Display help text and exit.
-.TP
-.BR \-V ,\  \-\-version
-Display version information and exit.
 .SH USAGE
 .TP
 The default behavior is to run a new command with a given affinity mask:
@@ -106,14 +109,7 @@ A user must possess
 .B CAP_SYS_NICE
 to change the CPU affinity of a process belonging to another user.
 A user can retrieve the affinity mask of any process.
-.SH AUTHOR
-Written by Robert M. Love.
-.SH COPYRIGHT
-Copyright \(co 2004 Robert M. Love
-.br
-This is free software; see the source for copying conditions.  There is NO
-warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR chrt (1),
 .BR nice (1),
 .BR renice (1),
@@ -123,6 +119,12 @@ warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 See
 .BR sched_setscheduler (2)
 for a description of the Linux scheduling scheme.
+.SH AUTHOR
+Written by Robert M. Love.
+.SH COPYRIGHT
+Copyright \(co 2004 Robert M. Love.
+This is free software; see the source for copying conditions.  There is NO
+warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 .SH AVAILABILITY
 The taskset command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-- 
1.7.0.4

