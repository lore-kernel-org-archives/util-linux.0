Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:56135 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932120AbcCNKGX (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 06:06:23 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/5] unshare: improve wording and formatting in the man page
Date: Mon, 14 Mar 2016 11:05:59 +0100
Message-Id: <1457949959-2866-1-git-send-email-bensberg@justemail.net>
In-Reply-To: <1457946613-2435-1-git-send-email-bensberg@justemail.net>
References: <1457946613-2435-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/unshare.1 |  117 ++++++++++++++++++++++++++-------------------------
 1 files changed, 59 insertions(+), 58 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 9507c4e..84a5d5e 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -1,4 +1,4 @@
-.TH UNSHARE 1 "July 2014" "util-linux" "User Commands"
+.TH UNSHARE 1 "February 2016" "util-linux" "User Commands"
 .SH NAME
 unshare \- run program with some namespaces unshared from parent
 .SH SYNOPSIS
@@ -10,13 +10,13 @@ unshare \- run program with some namespaces unshared from parent
 Unshares the indicated namespaces from the parent process and then executes
 the specified \fIprogram\fR.
 .PP
-The namespaces can optionally be persisted by bind mounting /proc/[pid]/ns/[type] files
-to a filesystem path and entered with
-.BR nsenter (1)
-even after \fIprogram\fR terminates.
-Once a persistent namespace is no longer needed it can be unpersisted with
+The namespaces can optionally be made persistent by bind mounting
+/proc/\fIpid\fR/ns/\fItype\fR files to a filesystem path and entered with
+.BR \%nsenter (1)
+even after the \fIprogram\fR terminates.
+Once a persistent \%namespace is no longer needed, it can be unpersisted with
 .BR umount (8).
-See EXAMPLES section for more details.
+See the \fBEXAMPLES\fR section for more details.
 .PP
 The namespaces to be unshared are indicated via options.  Unshareable namespaces are:
 .TP
@@ -28,8 +28,9 @@ shared (with \fBmount --make-shared\fP; see \fI/proc/self/mountinfo\fP or
 .sp
 .B unshare
 since util-linux version 2.27 automatically sets propagation to \fBprivate\fP
-in the new mount namespace to make sure that the new namespace is really
-unshared. This feature is possible to disable by option \fB\-\-propagation unchanged\fP.
+in a new mount namespace to make sure that the new namespace is really
+unshared.  It's possible to disable this feature with option
+\fB\-\-propagation unchanged\fP.
 Note that \fBprivate\fP is the kernel default.
 .TP
 .BR "UTS namespace"
@@ -37,7 +38,7 @@ Setting hostname or domainname will not affect the rest of the system.
 (\fBCLONE_NEWUTS\fP flag)
 .TP
 .BR "IPC namespace"
-The process will have an independent namespace for System V message queues,
+The process will have an independent namespace for System V \%message queues,
 semaphore sets and shared memory segments.  (\fBCLONE_NEWIPC\fP flag)
 .TP
 .BR "network namespace"
@@ -46,7 +47,7 @@ firewall rules, the \fI/proc/net\fP and \fI/sys/class/net\fP directory trees,
 sockets, etc.  (\fBCLONE_NEWNET\fP flag)
 .TP
 .BR "pid namespace"
-Children will have a distinct set of PID to process mappings from their parent.
+Children will have a distinct set of PID-to-process mappings from their parent.
 (\fBCLONE_NEWPID\fP flag)
 .TP
 .BR "user namespace"
@@ -56,42 +57,44 @@ The process will have a distinct set of UIDs, GIDs and capabilities.
 See \fBclone\fR(2) for the exact semantics of the flags.
 .SH OPTIONS
 .TP
-.BR \-i , " \-\-ipc"[=\fIfile\fP]
-Unshare the IPC namespace. If \fIfile\fP is specified then persistent namespace is created
-by bind mount.
+.BR \-i , " \-\-ipc" [ =\fIfile ]
+Unshare the IPC namespace.  If \fIfile\fP is specified, then a persistent
+namespace is created by a bind mount.
 .TP
-.BR \-m , " \-\-mount"[=\fIfile\fP]
-Unshare the mount namespace. If \fIfile\fP is specified then persistent namespace is created
-by bind mount. Note that \fIfile\fP has to be located on filesystem with
-propagation flag set to \fBprivate\fP. Use command \fBfindmnt -o+PROPAGATION\fP
-if not sure about the current setting. See also examples below.
+.BR \-m , " \-\-mount" [ =\fIfile ]
+Unshare the mount namespace.  If \fIfile\fP is specified, then a persistent
+namespace is created by a bind mount.
+Note that \fIfile\fP has to be located on a filesystem with the propagation
+flag set to \fBprivate\fP.  Use the command \fBfindmnt -o+PROPAGATION\fP
+when not sure about the current setting.  See also the examples below.
 .TP
-.BR \-n , " \-\-net"[=\fIfile\fP]
-Unshare the network namespace. If \fIfile\fP is specified then persistent namespace is created
-by bind mount.
+.BR \-n , " \-\-net" [ =\fIfile ]
+Unshare the network namespace.  If \fIfile\fP is specified, then a persistent
+namespace is created by a bind mount.
 .TP
-.BR \-p , " \-\-pid"[=\fIfile\fP]
-Unshare the pid namespace. If \fIfile\fP is specified then persistent namespace is created
-by bind mount. See also the \fB--fork\fP and \fB--mount-proc\fP options.
+.BR \-p , " \-\-pid" [ =\fIfile ]
+Unshare the PID namespace.  If \fIfile\fP is specified then persistent
+namespace is created by a bind mount.  See also the \fB--fork\fP and
+\fB--mount-proc\fP options.
 .TP
-.BR \-u , " \-\-uts"[=\fIfile\fP]
-Unshare the UTS namespace. If \fIfile\fP is specified then persistent namespace is created
-by bind mount.
+.BR \-u , " \-\-uts" [ =\fIfile ]
+Unshare the UTS namespace.  If \fIfile\fP is specified, then a persistent
+namespace is created by a bind mount.
 .TP
-.BR \-U , " \-\-user"[=\fIfile\fP]
-Unshare the user namespace. If \fIfile\fP is specified then persistent namespace is created
-by bind mount.
+.BR \-U , " \-\-user" [ =\fIfile ]
+Unshare the user namespace.  If \fIfile\fP is specified, then a persistent
+namespace is created by a bind mount.
 .TP
 .BR \-f , " \-\-fork"
 Fork the specified \fIprogram\fR as a child process of \fBunshare\fR rather than
-running it directly.  This is useful when creating a new pid namespace.
+running it directly.  This is useful when creating a new PID namespace.
 .TP
-.BR \-\-mount\-proc "[=\fImountpoint\fP]"
+.BR \-\-mount\-proc [ =\fImountpoint ]
 Just before running the program, mount the proc filesystem at \fImountpoint\fP
-(default is /proc).  This is useful when creating a new pid namespace.  It also
+(default is /proc).  This is useful when creating a new PID namespace.  It also
 implies creating a new mount namespace since the /proc mount would otherwise
 mess up existing programs on the system.  The new proc filesystem is explicitly
-mounted as private (by MS_PRIVATE|MS_REC).
+mounted as private (with MS_PRIVATE|MS_REC).
 .TP
 .BR \-r , " \-\-map\-root\-user"
 Run the program only after the current effective user and group IDs have been mapped to
@@ -100,26 +103,26 @@ conveniently gain capabilities needed to manage various aspects of the newly cre
 namespaces (such as configuring interfaces in the network namespace or mounting filesystems in
 the mount namespace) even when run unprivileged.  As a mere convenience feature, it does not support
 more sophisticated use cases, such as mapping multiple ranges of UIDs and GIDs.
-This option implies --setgroups=deny.
+This option implies \fB--setgroups=deny\fR.
 .TP
-.BR "\-\-propagation \fIprivate|shared|slave|unchanged\fP"
-Recursively sets mount propagation flag in the new mount namespace. The default
-is to set the propagation to \fIprivate\fP, this feature is possible to disable
-by \fIunchanged\fP argument. The options is silently ignored when mount namespace (\fB\-\-mount\fP)
-is not requested.
+.BR "\-\-propagation private" | shared | slave | unchanged
+Recursively set the mount propagation flag in the new mount namespace.  The default
+is to set the propagation to \fIprivate\fP.  It is possible to disable this feature
+with the argument \fBunchanged\fR.  The option is silently ignored when the mount
+namespace (\fB\-\-mount\fP) is not requested.
 .TP
-.BR "\-\-setgroups \fIallow|deny\fP"
-Allow or deny
+.BR "\-\-setgroups allow" | deny
+Allow or deny the
 .BR setgroups (2)
 syscall in user namespaces.
 
-.BR setgroups(2)
+.BR setgroups (2)
 is only callable with CAP_SETGID and CAP_SETGID in a user
 namespace (since Linux 3.19) does not give you permission to call setgroups(2)
-until after GID map has been set. The GID map is writable by root when
-.BR setgroups(2)
-is enabled and GID map becomes writable by unprivileged processes when
-.BR setgroups(2)
+until after GID map has been set.  The GID map is writable by root when
+.BR setgroups (2)
+is enabled and the GID map becomes writable by unprivileged processes when
+.BR setgroups (2)
 is permanently disabled.
 .TP
 .BR \-V , " \-\-version"
@@ -133,7 +136,7 @@ Display help text and exit.
 .TQ
 1
 .br
-Establish a PID namespace, ensure we're PID 1 in it against newly mounted
+Establish a PID namespace, ensure we're PID 1 in it against a newly mounted
 procfs instance.
 .TP
 .B $ unshare --map-root-user --user sh -c whoami
@@ -142,7 +145,6 @@ root
 .br
 Establish a user namespace as an unprivileged user with a root user within it.
 .TP
-.TQ
 .B # touch /root/uts-ns
 .TQ
 .B # unshare --uts=/root/uts-ns hostname FOO
@@ -153,22 +155,21 @@ FOO
 .TQ
 .B # umount /root/uts-ns
 .br
-Establish a persistent UTS namespace, modify hostname. The namespace maybe later entered
-by nsenter. The namespace is destroyed by umount the bind reference.
-
+Establish a persistent UTS namespace, and modify the hostname.  The namespace
+is then entered with \fBnsenter\fR.  The namespace is destroyed by unmounting
+the bind reference.
 .TP
-.TQ
 .B # mount --bind /root/namespaces /root/namespaces
 .TQ
-.B # mount --make-private /root/namespaces
+.B # mount --make-private /root/namespaces
 .TQ
-.B # touch /root/namespaces/mnt
+.B # touch /root/namespaces/mnt
 .TQ
 .B # unshare --mount=/root/namespaces/mnt
 .br
 Establish a persistent mount namespace referenced by the bind mount
-/root/namespaces/mnt. This example provides portable solution, because it makes
-sure that the bind mount is created on shared filesystem.
+/root/namespaces/mnt.  This example shows a portable solution, because it
+makes sure that the bind mount is created on a shared filesystem.
 
 .SH SEE ALSO
 .BR unshare (2),
-- 
1.7.0.4

