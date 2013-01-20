Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f172.google.com ([74.125.82.172]:40937 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab3ATSFF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 20 Jan 2013 13:05:05 -0500
Received: by mail-we0-f172.google.com with SMTP id r3so1442973wey.3
        for <util-linux@vger.kernel.org>; Sun, 20 Jan 2013 10:05:03 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/6] docs: align nsenter.1 man page with howto-man-page.txt
Date: Sun, 20 Jan 2013 18:04:51 +0000
Message-Id: <1358705096-21092-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358705096-21092-1-git-send-email-kerolasa@iki.fi>
References: <1358705096-21092-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Most visible change; the --target option has a path - explanation table
instead a long paragraph.  This makes pairing of the information easier
for an average user such as me.

The rest of the changes are about aligning with howto, i.e., fix spaces
after dots, URL & mail address macros, remove inline emphasis where
possible, mark directory paths and words with underscore to be line
breakable, use optional option syntax from howto, cut line lenght to 80
chars.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/nsenter.1 | 201 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 126 insertions(+), 75 deletions(-)

diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index 0fbb645..d133e1f 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -8,96 +8,147 @@ program
 .RI [ arguments ]
 .SH DESCRIPTION
 Enters the contexts of one or more other processes and then executes specified
-program. Enterable namespaces are:
+program.  Enterable namespaces are:
 .TP
-.BR "mount namespace"
+.B mount namespace
 mounting and unmounting filesystems will not affect rest of the system
-(\fBCLONE_NEWNS\fP flag), except for filesystems which are explicitly marked as
-shared (by mount --make-shared). See /proc/self/mountinfo for the shared flags.
+.RB ( CLONE_\:NEWNS
+flag), except for filesystems which are explicitly marked as shared (by mount
+--make-\:shared).  See /proc\:/self\:/mountinfo for the shared flags.
 .TP
-.BR "UTS namespace"
+.B UTS namespace
 setting hostname, domainname will not affect rest of the system
-(\fBCLONE_NEWUTS\fP flag).
+.RB ( CLONE_\:NEWUTS
+flag).
 .TP
-.BR "IPC namespace"
+.B IPC namespace
 process will have independent namespace for System V message queues, semaphore
-sets and shared memory segments (\fBCLONE_NEWIPC\fP flag).
+sets and shared memory segments
+.RB ( CLONE_\:NEWIPC
+flag).
 .TP
-.BR "network namespace"
+.B network namespace
 process will have independent IPv4 and IPv6 stacks, IP routing tables, firewall
-rules, the \fI/proc/net\fP and \fI/sys/class/net\fP directory trees, sockets
-etc. (\fBCLONE_NEWNET\fP flag).
-.TP
-.BR "pid namespace"
+rules, the
+.I /proc\:/net
+and
+.I /sys\:/class\:/net
+directory trees, sockets etc.
+.RB ( CLONE_\:NEWNET
+flag).
+.TP
+.B pid namespace
 children will have a distinct set of pid to process mappings thantheir parent.
-(\fBCLONE_NEWPID\fP flag).
+.RB ( CLONE_\:NEWPID
+flag).
 .TP
-.BR "user namespace"
-process will have distinct set of uids, gids and capabilities. (\fBCLONE_NEWUSER\fP flag).
+.B user namespace
+process will have distinct set of uids, gids and capabilities.
+.RB ( CLONE_\:NEWUSER
+flag).
 .TP
-See the \fBclone\fR(2) for exact semantics of the flags.
+See the
+.BR clone (2)
+for exact semantics of the flags.
 .SH OPTIONS
-Note when specifying the optional \fB<file>\fP or \fB<directory>\fP arguments, the string
-of the option, equal sign (=), and the optional argument must not contain any blanks
-or other white space.
-.TP
-.BR \-h , " \-\-help"
-Print a help message,
-.TP
-.BR \-t , " \-\-target " \fIpid\fP
-Specify a target process to get contexts from.  The paths to the contexts specified by pid are: /proc/[pid]/ns/mnt, /proc/[pid]/ns/uts, /proc/[pid]/ns/ipc, /proc/[pid]/ns/net, /proc/[pid]/ns/pid, /proc/[pid]/ns/user, /proc/[pid]/root, /proc/[pid]/cwd for the mount namespace, the uts namespace, the ipc namespace, the net namespace, the pid namespace, the user namespace, the root directory and the working directory respectively.
-.TP
-.BR \-m , " \-\-mount"[=\fIfile\fP]
-Enter the mount namespace.
-If no file is specified enter the mount namespace of the target process.
-If file is specified enter the mount namespace specified by file.
-.TP
-.BR \-u , " \-\-uts"[=\fIfile\fP]
-Enter the uts namespace.
-If no file is specified enter the uts namespace of the target process.
-If file is specified enter the uts namespace specified by file.
-.TP
-.BR \-i , " \-\-ipc"[=\fIfile\fP]
-Enter the IPC namespace.
-If no file is specified enter the IPC namespace of the target process.
-If file is specified enter the uts namespace specified by file.
-.TP
-.BR \-n , " \-\-net"[=\fIfile\fP]
-Enter the network namespace.
-If no file is specified enter the network namespace of the target process.
-If file is specified enter the network namespace specified by file.
-.TP
-.BR \-p , " \-\-pid"[=\fIfile\fP]
-Enter the pid namespace.
-If no file is specified enter the pid namespace of the target process.
-If file is specified enter the pid namespace specified by file.
-.TP
-.BR \-U , " \-\-user"[=\fIfile\fP]
-Enter the user namespace.
-If no file is specified enter the user namespace of the target process.
-If file is specified enter the user namespace specified by file.
-.TP
-.BR \-r , " \-\-root"[=\fIdirectory\fP]
-Set the root directory.
-If no directory is specified set the root directory to the root directory of the target process.
-If directory is specified set the root directory to the specified directory.
-.TP
-.BR \-w , " \-\-wd"[=\fIdirectory\fP]
-Set the working directory.
-If no directory is specified set the working directory to the working directory of the target process.
-If directory is specified set the working directory to the specified directory.
-.TP
-.BR \-e , " \-\-exec"
-Don't fork before exec'ing the specified program.  By default when entering
-a pid namespace enter calls fork before calling exec so that the children will
-be in the newly entered pid namespace.
+Argument with square brakets, such as [\fIfile\fR], means optional argument.
+Command line syntax to specify optional argument \-\-mount=/path\:/to\:/file.
+Please notice the equals sign.
+.TP
+\fB\-t\fR, \fB\-\-target\fR \fIpid\fP
+Specify a target process to get contexts from.  The paths to the contexts
+specified by
+.I pid
+are:
+.RS
+.PD 0
+.IP "" 20
+.TP
+/proc/\fIpid\fR/ns/mnt
+the mount namespace
+.TP
+/proc/\fIpid\fR/ns/uts
+the uts namespace
+.TP
+/proc/\fIpid\fR/ns/ipc
+the ipc namespace
+.TP
+/proc/\fIpid\fR/ns/net
+the ipc namespace
+.TP
+/proc/\fIpid\fR/ns/pid
+the pid namespace
+.TP
+/proc/\fIpid\fR/ns/user
+the user namespace
+.TP
+/proc/\fIpid\fR/root
+the root directory
+.TP
+/proc/\fIpid\fR/cw
+the working directory respectively
+.PD
+.RE
+.TP
+\fB\-m\fR, \fB\-\-mount\fR [\fIfile\fR]
+Enter the mount namespace.  If no file is specified enter the mount namespace
+of the target process.  If file is specified enter the mount namespace
+specified by file.
+.TP
+\fB\-u\fR, \fB\-\-uts\fR [\fIfile\fR]
+Enter the uts namespace.  If no file is specified enter the uts namespace of
+the target process.  If file is specified enter the uts namespace specified by
+file.
+.TP
+\fB\-i\fR, \fB\-\-ipc\fR [\fIfile\fR]
+Enter the IPC namespace.  If no file is specified enter the IPC namespace of
+the target process.  If file is specified enter the uts namespace specified by
+file.
+.TP
+\fB\-n\fR, \fB\-\-net\fR [\fIfile\fR]
+Enter the network namespace.  If no file is specified enter the network
+namespace of the target process.  If file is specified enter the network
+namespace specified by file.
+.TP
+\fB\-p\fR, \fB\-\-pid\fR [\fIfile\fR]
+Enter the pid namespace.  If no file is specified enter the pid namespace of
+the target process.  If file is specified enter the pid namespace specified by
+file.
+.TP
+\fB\-U\fR, \fB\-\-user\fR [\fIfile\fR]
+Enter the user namespace.  If no file is specified enter the user namespace of
+the target process.  If file is specified enter the user namespace specified by
+file.
+.TP
+\fB\-r\fR, \fB\-\-root\fR [\fIdirectory\fR]
+Set the root directory.  If no directory is specified set the root directory to
+the root directory of the target process.  If directory is specified set the
+root directory to the specified directory.
+.TP
+\fB\-w\fR, \fB\-\-wd\fR [\fIdirectory\fR]
+Set the working directory.  If no directory is specified set the working
+directory to the working directory of the target process.  If directory is
+specified set the working directory to the specified directory.
+.TP
+\fB\-e\fR, \fB\-\-exec\fR
+Do not fork before exec'ing the specified program.  By default when entering a
+pid namespace enter calls fork before calling exec so that the children will be
+in the newly entered pid namespace.
+.TP
+\fB\-V\fR, \fB\-\-version\fR
+Display version information and exit.
+.TP
+\fB\-h\fR, \fB\-\-help\fR
+Print a help message.
 .SH SEE ALSO
 .BR setns (2),
 .BR clone (2)
-.SH BUGS
-None known so far.
 .SH AUTHOR
-Eric Biederman <ebiederm@xmission.com>
+.MT ebiederm@xmission.com
+Eric Biederman
+.ME
 .SH AVAILABILITY
 The nsenter command is part of the util-linux package and is available from
-ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
-- 
1.8.1.1

