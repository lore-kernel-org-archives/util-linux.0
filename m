Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:33780 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756866AbcB1A5N (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 27 Feb 2016 19:57:13 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1aZpfb-000704-M9
	for util-linux@vger.kernel.org; Sun, 28 Feb 2016 01:57:11 +0100
Received: from ppp37-190-56-21.pppoe.spdop.ru ([37.190.56.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sun, 28 Feb 2016 01:57:11 +0100
Received: from yumkam by ppp37-190-56-21.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sun, 28 Feb 2016 01:57:11 +0100
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: [PATCH] taskset.1: fix description of `-c` option
Date: Sun, 28 Feb 2016 03:57:03 +0300
Message-ID: <m360x9mz34.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/x-diff
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From 7b9a194fd6d2d2d7d1bc39f28064dd2cb9340aad Mon Sep 17 00:00:00 2001
From: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Date: Sun, 28 Feb 2016 03:34:13 +0300
Subject: [PATCH] taskset.1: fix description of `-c` option

Commit 42f15e9848dc07e86a2b80c742a0179aaced6c71 introduced a certain
inaccuracy in -c option description; it is not _the option with an argument_,
but it is the flag that changes interpretation of `mask` parameter.
The difference is almost not noticeable, but there are one corner case where it is:
   taskset -c 1 -p $$
fails (but it would work if 42f15e was correct). Instead,
   taskset -c -p 1 $$
works (but it should not have if 42f15e was correct).
---
P.S. argument parsing in taskset (and chrt) is rather unusual and confusing, and I'd voted to change it instead... unfortunately, people/scripts/... already depend on current behavior (and it is not outright broken, just unusual), so it is impossible.

 schedutils/taskset.1 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/schedutils/taskset.1 b/schedutils/taskset.1
index 50cbe6b..901f9fa 100644
--- a/schedutils/taskset.1
+++ b/schedutils/taskset.1
@@ -73,9 +73,9 @@ CPU.
 .BR \-a ,\  \-\-all\-tasks
 Set or retrieve the CPU affinity of all the tasks (threads) for a given PID.
 .TP
-.BR \-c ,\  \-\-cpu\-list \ \fInumbers
-Specify a numerical list of processors instead of a bitmask.  The \fInumbers\fR
-are separated by commas and may include ranges.  For example:
+.BR \-c ,\  \-\-cpu\-list
+Interpret \fImask\fR as numerical list of processors instead of a bitmask.
+Numbers are separated by commas and may include ranges.  For example:
 .BR 0,5,8-11 .
 .TP
 .BR \-p ,\  \-\-pid
-- 
2.1.4


