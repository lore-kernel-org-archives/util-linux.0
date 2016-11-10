Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35350 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755262AbcKJLAE (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 10 Nov 2016 06:00:04 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so2343973wme.2
        for <util-linux@vger.kernel.org>; Thu, 10 Nov 2016 03:00:03 -0800 (PST)
Subject: [PATCH 10/12] Provide better cross references for namespace concepts
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <59c54c87-4f64-2b12-fc64-051ac03eca6f@gmail.com>
Cc: mtk.manpages@gmail.com
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <b27c2458-19dc-7c98-00bb-d8966f258b6a@gmail.com>
Date: Thu, 10 Nov 2016 12:00:00 +0100
MIME-Version: 1.0
In-Reply-To: <59c54c87-4f64-2b12-fc64-051ac03eca6f@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

For each namespace that is discussed, add more explicit
references to the corresponding clone(2) flags and
add references to relevant section 7 namespace pages.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 sys-utils/unshare.1 | 57 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 98a4863..56435c0 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -21,10 +21,16 @@ See the \fBEXAMPLES\fR section for more details.
 The namespaces to be unshared are indicated via options.  Unshareable namespaces are:
 .TP
 .BR "mount namespace"
-Mounting and unmounting filesystems will not affect the rest of the system
-(\fBCLONE_NEWNS\fP flag), except for filesystems which are explicitly marked as
+Mounting and unmounting filesystems will not affect the rest of the system,
+except for filesystems which are explicitly marked as
 shared (with \fBmount --make-shared\fP; see \fI/proc/self/mountinfo\fP or
 \fBfindmnt -o+PROPAGATION\fP for the \fBshared\fP flags).
+For further details, see
+.BR mount_namespaces (7)
+and the discussion of the
+.BR CLONE_NEWNS
+flag in
+.BR clone (2).
 .sp
 .B unshare
 since util-linux version 2.27 automatically sets propagation to \fBprivate\fP
@@ -35,31 +41,62 @@ Note that \fBprivate\fP is the kernel default.
 .TP
 .BR "UTS namespace"
 Setting hostname or domainname will not affect the rest of the system.
-(\fBCLONE_NEWUTS\fP flag)
+For further details, see
+.BR namespaces (7)
+and the discussion of the
+.BR CLONE_NEWUTS
+flag in
+.BR clone (2).
 .TP
 .BR "IPC namespace"
 The process will have an independent namespace for System V \%message queues,
-semaphore sets and shared memory segments.  (\fBCLONE_NEWIPC\fP flag)
+semaphore sets and shared memory segments.
+For further details, see
+.BR namespaces (7)
+and the discussion of the
+.BR CLONE_NEWIPC
+flag in
+.BR clone (2).
 .TP
 .BR "network namespace"
 The process will have independent IPv4 and IPv6 stacks, IP routing tables,
 firewall rules, the \fI/proc/net\fP and \fI/sys/class/net\fP directory trees,
-sockets, etc.  (\fBCLONE_NEWNET\fP flag)
+sockets, etc.
+For further details, see
+.BR namespaces (7)
+and the discussion of the
+.BR CLONE_NEWNET
+flag in
+.BR clone (2).
 .TP
 .BR "pid namespace"
 Children will have a distinct set of PID-to-process mappings from their parent.
-(\fBCLONE_NEWPID\fP flag)
+For further details, see
+.BR pid_namespaces (7)
+and
+the discussion of the
+.BR CLONE_NEWPID
+flag in
+.BR clone (2).
 .TP
 .BR "cgroup namespace"
 The process will have a virtualized view of \fI/proc\:/self\:/cgroup\fP, and new
 cgroup mounts will be rooted at the namespace cgroup root.
-(\fBCLONE_NEWCGROUP\fP flag)
+For further details, see
+.BR cgroup_namespaces (7)
+and the discussion of the
+.BR CLONE_NEWCGROUP
+flag in
+.BR clone (2).
 .TP
 .BR "user namespace"
 The process will have a distinct set of UIDs, GIDs and capabilities.
-(\fBCLONE_NEWUSER\fP flag)
-.PP
-See \fBclone\fR(2) for the exact semantics of the flags.
+For further details, see
+.BR user_namespaces (7)
+and the discussion of the
+.BR CLONE_NEWUSER
+flag in
+.BR clone (2).
 .SH OPTIONS
 .TP
 .BR \-i , " \-\-ipc" [ =\fIfile ]
-- 
2.5.5

