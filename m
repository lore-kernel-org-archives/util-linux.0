Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36392 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754745AbcKJK7j (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 10 Nov 2016 05:59:39 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so681449wma.3
        for <util-linux@vger.kernel.org>; Thu, 10 Nov 2016 02:59:39 -0800 (PST)
Subject: [PATCH 04/12] Fix page cross references
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <404e11c0-9f88-b460-7398-d00585a9bf16@gmail.com>
Cc: mtk.manpages@gmail.com
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <5bc55c91-24c3-8399-f4b2-4aa8fdc6322a@gmail.com>
Date: Thu, 10 Nov 2016 11:59:37 +0100
MIME-Version: 1.0
In-Reply-To: <404e11c0-9f88-b460-7398-d00585a9bf16@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

* Add a section number to page cross reference
* Format cross references in bold

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 sys-utils/ipcs.1   | 10 +++++-----
 sys-utils/lsipc.1  | 10 +++++-----
 sys-utils/tunelp.8 |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sys-utils/ipcs.1 b/sys-utils/ipcs.1
index db9637d..17395c2 100644
--- a/sys-utils/ipcs.1
+++ b/sys-utils/ipcs.1
@@ -55,15 +55,15 @@ Show PIDs of creator and last operator.
 \fB\-t\fR, \fB\-\-time\fR
 Write time information.  The time of the last control operation that changed
 the access permissions for all facilities, the time of the last
-.I msgsnd()
+.BR msgsnd (2)
 and
-.I msgrcv()
+.BR msgrcv (2)
 operations on message queues, the time of the last
-.I shmat()
+.BR shmat (2)
 and
-.I shmdt()
+.BR shmdt (2)
 operations on shared memory, and the time of the last
-.I semop()
+.BR semop (2)
 operation on semaphores.
 .TP
 \fB\-u\fR, \fB\-\-summary\fR
diff --git a/sys-utils/lsipc.1 b/sys-utils/lsipc.1
index 3185911..1d3f735 100644
--- a/sys-utils/lsipc.1
+++ b/sys-utils/lsipc.1
@@ -83,15 +83,15 @@ Raw output (no columnation).
 \fB\-t\fR, \fB\-\-time\fR
 Write time information.  The time of the last control operation that changed
 the access permissions for all facilities, the time of the last
-.I msgsnd()
+.BR msgsnd (2)
 and
-.I msgrcv()
+.BR msgrcv (2)
 operations on message queues, the time of the last
-.I shmat()
+.BR shmat (2)
 and
-.I shmdt()
+.BR shmdt (2)
 operations on shared memory, and the time of the last
-.I semop()
+.BR semop (2)
 operation on semaphores.
 .TP
 \fB\-\-time\-format\fR \fItype\fP
diff --git a/sys-utils/tunelp.8 b/sys-utils/tunelp.8
index a69d88a..45c1122 100644
--- a/sys-utils/tunelp.8
+++ b/sys-utils/tunelp.8
@@ -77,7 +77,7 @@ isn't ready, quit trying, and send you mail about it.  The choice is yours.
 .TP
 \fB\-o\fR, \fB\-\-check\-status\fR \fI<on|off>\fR
 This option is much like \-a.  It makes any
-.I open()
+.BR open (2)
 of this device check to see that the device is on-line and not reporting any
 out of paper or other errors.  This is the correct setting for most versions
 of lpd.
-- 
2.5.5

