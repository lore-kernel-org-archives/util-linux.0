Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35445 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754782AbcKJLAL (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 10 Nov 2016 06:00:11 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so2344789wme.2
        for <util-linux@vger.kernel.org>; Thu, 10 Nov 2016 03:00:11 -0800 (PST)
Subject: [PATCH 12/12] IPC namespaces also isolate POSIX message queues
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <59c54c87-4f64-2b12-fc64-051ac03eca6f@gmail.com>
Cc: mtk.manpages@gmail.com
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <937654e8-cfbf-da6a-2642-e10bb1490045@gmail.com>
Date: Thu, 10 Nov 2016 12:00:09 +0100
MIME-Version: 1.0
In-Reply-To: <59c54c87-4f64-2b12-fc64-051ac03eca6f@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

As described in pid_namespaces(7), IPC namespaces also
isolate POSIX message queues. Update the unshare(1)
and nsenter(1) pages to clarify that.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 sys-utils/nsenter.1 | 3 ++-
 sys-utils/unshare.1 | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index b67ed0f..5f85e28 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -32,7 +32,8 @@ flag in
 .BR clone (2).
 .TP
 .B IPC namespace
-The process will have an independent namespace for System V message queues,
+The process will have an independent namespace for POSIX message queues
+as well as System V message queues,
 semaphore sets and shared memory segments.
 For further details, see
 .BR namespaces (7)
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 56435c0..dc99944 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -49,7 +49,8 @@ flag in
 .BR clone (2).
 .TP
 .BR "IPC namespace"
-The process will have an independent namespace for System V \%message queues,
+The process will have an independent namespace for POSIX message queues
+as well as System V \%message queues,
 semaphore sets and shared memory segments.
 For further details, see
 .BR namespaces (7)
-- 
2.5.5

