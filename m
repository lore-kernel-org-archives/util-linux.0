Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32883 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbcKJK7s (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 10 Nov 2016 05:59:48 -0500
Received: by mail-wm0-f68.google.com with SMTP id u144so2347161wmu.0
        for <util-linux@vger.kernel.org>; Thu, 10 Nov 2016 02:59:47 -0800 (PST)
Subject: [PATCH 06/12] Fix reference for scheduling discussion
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <404e11c0-9f88-b460-7398-d00585a9bf16@gmail.com>
Cc: mtk.manpages@gmail.com
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <f0bf2261-3e72-7b3e-70bd-009e360249ec@gmail.com>
Date: Thu, 10 Nov 2016 11:59:45 +0100
MIME-Version: 1.0
In-Reply-To: <404e11c0-9f88-b460-7398-d00585a9bf16@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Some time back, I moved the discussion of scheduling from
sched_setscheduler(2) to a new sched(7) page. Adjust the cross
reference in the taskset(1) page accordingly.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 schedutils/taskset.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/schedutils/taskset.1 b/schedutils/taskset.1
index 13ed583..c0c933f 100644
--- a/schedutils/taskset.1
+++ b/schedutils/taskset.1
@@ -123,7 +123,7 @@ A user can retrieve the affinity mask of any process.
 .BR sched_setaffinity (2)
 .sp
 See
-.BR sched_setscheduler (2)
+.BR sched (7)
 for a description of the Linux scheduling scheme.
 .SH AUTHOR
 Written by Robert M. Love.
-- 
2.5.5

