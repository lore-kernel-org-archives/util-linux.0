Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33094 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754782AbcKJLAH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 10 Nov 2016 06:00:07 -0500
Received: by mail-wm0-f66.google.com with SMTP id u144so2348901wmu.0
        for <util-linux@vger.kernel.org>; Thu, 10 Nov 2016 03:00:07 -0800 (PST)
Subject: [PATCH 11/12] Provide better cross references for namespace concepts
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <59c54c87-4f64-2b12-fc64-051ac03eca6f@gmail.com>
Cc: mtk.manpages@gmail.com
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <678c0681-c4e6-8294-f194-1cfda699af20@gmail.com>
Date: Thu, 10 Nov 2016 12:00:05 +0100
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
 sys-utils/nsenter.1 | 59 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index 5f850c1..b67ed0f 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -11,22 +11,35 @@ Enters the namespaces of one or more other processes and then executes the speci
 program.  Enterable namespaces are:
 .TP
 .B mount namespace
-Mounting and unmounting filesystems will not affect the rest of the system
-.RB ( CLONE_\:NEWNS
-flag), except for filesystems which are explicitly marked as shared (with
+Mounting and unmounting filesystems will not affect the rest of the system,
+except for filesystems which are explicitly marked as shared (with
 \fBmount --make-\:shared\fP; see \fI/proc\:/self\:/mountinfo\fP for the
 \fBshared\fP flag).
+For further details, see
+.BR mount_namespaces (7)
+and the discussion of the
+.BR CLONE_NEWNS
+flag in
+.BR clone (2).
 .TP
 .B UTS namespace
 Setting hostname or domainname will not affect the rest of the system.
-.RB ( CLONE_\:NEWUTS
-flag)
+For further details, see
+.BR namespaces (7)
+and the discussion of the
+.BR CLONE_NEWUTS
+flag in
+.BR clone (2).
 .TP
 .B IPC namespace
 The process will have an independent namespace for System V message queues,
 semaphore sets and shared memory segments.
-.RB ( CLONE_\:NEWIPC
-flag)
+For further details, see
+.BR namespaces (7)
+and the discussion of the
+.BR CLONE_NEWIPC
+flag in
+.BR clone (2).
 .TP
 .B network namespace
 The process will have independent IPv4 and IPv6 stacks, IP routing tables,
@@ -35,15 +48,23 @@ firewall rules, the
 and
 .I /sys\:/class\:/net
 directory trees, sockets, etc.
-.RB ( CLONE_\:NEWNET
-flag)
+For further details, see
+.BR namespaces (7)
+and the discussion of the
+.BR CLONE_NEWNET
+flag in
+.BR clone (2).
 .TP
 .B PID namespace
 Children will have a set of PID to process mappings separate from the
 .B nsenter
 process
-.RB ( CLONE_\:NEWPID
-flag).
+For further details, see
+.BR pid_namespaces (7)
+and
+the discussion of the
+.BR CLONE_NEWPID
+flag in
 .B nsenter
 will fork by default if changing the PID namespace, so that the new program
 and its children share the same PID namespace and are visible to each other.
@@ -51,14 +72,22 @@ If \fB\-\-no\-fork\fP is used, the new program will be exec'ed without forking.
 .TP
 .B user namespace
 The process will have a distinct set of UIDs, GIDs and capabilities.
-.RB ( CLONE_\:NEWUSER
-flag)
+For further details, see
+.BR user_namespaces (7)
+and the discussion of the
+.BR CLONE_NEWUSER
+flag in
+.BR clone (2).
 .TP
 .B cgroup namespace
 The process will have a virtualized view of \fI/proc\:/self\:/cgroup\fP, and new
 cgroup mounts will be rooted at the namespace cgroup root.
-.RB ( CLONE_\:NEWCGROUP
-flag)
+For further details, see
+.BR cgroup_namespaces (7)
+and the discussion of the
+.BR CLONE_NEWCGROUP
+flag in
+.BR clone (2).
 .TP
 See \fBclone\fP(2) for the exact semantics of the flags.
 .TP
-- 
2.5.5

