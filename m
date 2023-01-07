Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CD0C54EBC
	for <util-linux@archiver.kernel.org>; Sat,  7 Jan 2023 19:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjAGT4a (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 7 Jan 2023 14:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjAGT41 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 7 Jan 2023 14:56:27 -0500
Received: from aurora.tech (unknown [64.124.54.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7F0D2BCD
        for <util-linux@vger.kernel.org>; Sat,  7 Jan 2023 11:56:24 -0800 (PST)
Received: by aurora.tech (Postfix, from userid 1001)
        id AB104164017A; Sat,  7 Jan 2023 11:47:20 -0800 (PST)
From:   alison@she-devel.com
To:     util-linux@vger.kernel.org
Cc:     kzak@redhat.com, achaiken@aurora.tech, alison@she-devel.com
Subject: [PATCH 2/3] schedutils: clarify meaning of taskset return code
Date:   Sat,  7 Jan 2023 11:47:07 -0800
Message-Id: <20230107194708.6878-3-alison@she-devel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230107194708.6878-1-alison@she-devel.com>
References: <20230107194708.6878-1-alison@she-devel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Alison Chaiken <alison@she-devel.com>

Make clear that an EXIT_SUCCESS value returned by taskset does not mean that a
thread has actually migrated to a core matching the affinity request.
---
 schedutils/taskset.1.adoc | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/schedutils/taskset.1.adoc b/schedutils/taskset.1.adoc
index efbab08dc..9609e0c9c 100644
--- a/schedutils/taskset.1.adoc
+++ b/schedutils/taskset.1.adoc
@@ -42,7 +42,7 @@ taskset - set or retrieve a process's CPU affinity
 
 == DESCRIPTION
 
-The *taskset* command is used to set or retrieve the CPU affinity of a running process given its _pid_, or to launch a new _command_ with a given CPU affinity. CPU affinity is a scheduler property that "bonds" a process to a given set of CPUs on the system. The Linux scheduler will honor the given CPU affinity and the process will not run on any other CPUs. Note that the Linux scheduler also supports natural CPU affinity: the scheduler attempts to keep processes on the same CPU as long as practical for performance reasons. Therefore, forcing a specific CPU affinity is useful only in certain applications.
+The *taskset* command is used to set or retrieve the CPU affinity of a running process given its _pid_, or to launch a new _command_ with a given CPU affinity. CPU affinity is a scheduler property that "bonds" a process to a given set of CPUs on the system. The Linux scheduler will honor the given CPU affinity and the process will not run on any other CPUs. Note that the Linux scheduler also supports natural CPU affinity: the scheduler attempts to keep processes on the same CPU as long as practical for performance reasons. Therefore, forcing a specific CPU affinity is useful only in certain applications.   The affinity of some processes like kernel per-CPU threads cannot be set.
 
 The CPU affinity is represented as a bitmask, with the lowest order bit corresponding to the first logical CPU and the highest order bit corresponding to the last logical CPU. Not all CPUs may exist on a given system but a mask may specify more CPUs than are present. A retrieved mask will reflect only the bits that correspond to CPUs physically on the system. If an invalid mask is given (i.e., one that corresponds to no valid CPUs on the current system) an error is returned. The masks may be specified in hexadecimal (with or without a leading "0x"), or as a CPU list with the *--cpu-list* option. For example,
 
@@ -97,6 +97,34 @@ Or set it{colon}::
 
 A user can change the CPU affinity of a process belonging to the same user. A user must possess *CAP_SYS_NICE* to change the CPU affinity of a process belonging to another user. A user can retrieve the affinity mask of any process.
 
+== RETURN VALUE
+
+*Taskset* returns 0 in its affinity-getting mode as long as the provided PID exists.
+
+*Taskset* returns 0 in its affinity-setting mode as long as the underlying *sched_setaffinity()* system call does.     The success of the command does not guarantee that the specified thread has actually migrated to the indicated CPU(s), but only that the thread will not migrate to a CPU outside the new affinity mask.   For example, the affinity of the kernel thread kswapd can be set, but the thread may not immediately migrate and is not guaranteed to ever do so:
+
+$ ps ax -o comm,psr,pid | grep kswapd +
+kswapd0           4      82 +
+$ sudo taskset -p 1 82 +
+pid 82's current affinity mask: 1 +
+pid 82's new affinity mask: 1 +
+$ echo $? +
+0 +
+$ ps ax -o comm,psr,pid | grep kswapd +
+kswapd0           4      82 +
+$ taskset -p 82 +
+pid 82's current affinity mask: 1 +
+
+In contrast, when the user specifies an illegal affinity, taskset will print an error and return 1:
+
+$ ps ax -o comm,psr,pid | grep ksoftirqd/0 +
+ksoftirqd/0       0      14 +
+$ sudo taskset -p 1 14 +
+pid 14's current affinity mask: 1 +
+taskset: failed to set pid 14's affinity: Invalid argument +
+$ echo $? +
+1 +
+
 == AUTHORS
 
 Written by Robert M. Love.
-- 
2.32.0

