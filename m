Return-Path: util-linux-owner@vger.kernel.org
Received: from kawka.in.waw.pl ([178.63.212.103]:44423 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554Ab3BHAKB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 7 Feb 2013 19:10:01 -0500
From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 2/2] nsenter: fix errors in manpage
Date: Thu,  7 Feb 2013 19:09:02 -0500
Message-Id: <1360282142-1943-2-git-send-email-zbyszek@in.waw.pl>
In-Reply-To: <1360282142-1943-1-git-send-email-zbyszek@in.waw.pl>
References: <1360282142-1943-1-git-send-email-zbyszek@in.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

- spell abbreviations with capital letters
- fix the names of a few options and files

Signed-off-by: Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl>
---
 sys-utils/nsenter.1 | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index 4a6a34d..37c46d7 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -7,14 +7,14 @@ nsenter \- run program with namespaces of other processes
 .RI [ program ]
 .RI [ arguments ]
 .SH DESCRIPTION
-Enters the contexts of one or more other processes and then executes specified
+Enters the namespaces of one or more other processes and then executes the specified
 program.  Enterable namespaces are:
 .TP
 .B mount namespace
 mounting and unmounting filesystems will not affect rest of the system
 .RB ( CLONE_\:NEWNS
 flag), except for filesystems which are explicitly marked as shared (by mount
---make-\:shared).  See /proc\:/self\:/mountinfo for the shared flags.
+--make-\:shared).  See /proc\:/self\:/mountinfo for the shared flag.
 .TP
 .B UTS namespace
 setting hostname, domainname will not affect rest of the system
@@ -37,13 +37,19 @@ directory trees, sockets etc.
 .RB ( CLONE_\:NEWNET
 flag).
 .TP
-.B pid namespace
-children will have a distinct set of pid to process mappings thantheir parent.
+.B PID namespace
+children will have a set of PID to process mappings separate from the
+.B nsenter
+process
 .RB ( CLONE_\:NEWPID
 flag).
+.B nsenter
+will fork by default if changing the PID namespace, so that the new program
+and its children share the same PID namespace and are visible to each other.
+If \-\-no\-fork is used, the new program will be exec'ed without forking.
 .TP
 .B user namespace
-process will have distinct set of uids, gids and capabilities.
+process will have distinct set of UIDs, GIDs and capabilities
 .RB ( CLONE_\:NEWUSER
 flag).
 .TP
@@ -71,16 +77,16 @@ are:
 the mount namespace
 .TP
 /proc/\fIpid\fR/ns/uts
-the uts namespace
+the UTS namespace
 .TP
 /proc/\fIpid\fR/ns/ipc
-the ipc namespace
+the IPC namespace
 .TP
 /proc/\fIpid\fR/ns/net
-the ipc namespace
+the network namespace
 .TP
 /proc/\fIpid\fR/ns/pid
-the pid namespace
+the PID namespace
 .TP
 /proc/\fIpid\fR/ns/user
 the user namespace
@@ -88,7 +94,7 @@ the user namespace
 /proc/\fIpid\fR/root
 the root directory
 .TP
-/proc/\fIpid\fR/cw
+/proc/\fIpid\fR/cwd
 the working directory respectively
 .PD
 .RE
@@ -99,13 +105,13 @@ of the target process.  If file is specified enter the mount namespace
 specified by file.
 .TP
 \fB\-u\fR, \fB\-\-uts\fR [\fIfile\fR]
-Enter the uts namespace.  If no file is specified enter the uts namespace of
-the target process.  If file is specified enter the uts namespace specified by
+Enter the UTS namespace.  If no file is specified enter the UTS namespace of
+the target process.  If file is specified enter the UTS namespace specified by
 file.
 .TP
 \fB\-i\fR, \fB\-\-ipc\fR [\fIfile\fR]
 Enter the IPC namespace.  If no file is specified enter the IPC namespace of
-the target process.  If file is specified enter the uts namespace specified by
+the target process.  If file is specified enter the IPC namespace specified by
 file.
 .TP
 \fB\-n\fR, \fB\-\-net\fR [\fIfile\fR]
@@ -114,8 +120,8 @@ namespace of the target process.  If file is specified enter the network
 namespace specified by file.
 .TP
 \fB\-p\fR, \fB\-\-pid\fR [\fIfile\fR]
-Enter the pid namespace.  If no file is specified enter the pid namespace of
-the target process.  If file is specified enter the pid namespace specified by
+Enter the PID namespace.  If no file is specified enter the PID namespace of
+the target process.  If file is specified enter the PID namespace specified by
 file.
 .TP
 \fB\-U\fR, \fB\-\-user\fR [\fIfile\fR]
-- 
1.8.1

