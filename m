Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wj0-f194.google.com ([209.85.210.194]:35631 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752625AbcLGNzr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 7 Dec 2016 08:55:47 -0500
Received: by mail-wj0-f194.google.com with SMTP id he10so35804230wjc.2
        for <util-linux@vger.kernel.org>; Wed, 07 Dec 2016 05:55:10 -0800 (PST)
To: Karel Zak <kzak@redhat.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [PATCH 1/2] docs: renice(1): Rework discussion of unprivileged users,
Cc: mtk.manpages@gmail.com, util-linux@vger.kernel.org
Message-ID: <37402fb7-ae51-4125-7d30-8bf9a5594daa@gmail.com>
Date: Wed, 7 Dec 2016 14:55:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The BUGS section describing the limitations on what an unprivileged
user may do to the nice value is outdated, given the kernel changes
that added RLIMIT_NICE in Linux 2.6.12. So, remove that text.

The revised details for modern Linux were partially covered in NOTES,
but there were also inaccuracies there (and the use of the word
"monotonically" was unneeded). In particular, the point is that
unprivileged users can only increase the nice value. There is no
restriction particular to the range 0..+19. So, for example, the
following scenario is possible:

1. Superuser sets the nice value of an unprivileged user's
   process to -20.
2. The unprivileged user can now renice that process to (say) -10.

Signed-off-by: Michael Kerrisk <mtk.man-pages@gmail.com>
---
 sys-utils/renice.1 | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/sys-utils/renice.1 b/sys-utils/renice.1
index 3b27a6c..d37fcf1 100644
--- a/sys-utils/renice.1
+++ b/sys-utils/renice.1
@@ -84,10 +84,16 @@ PIDs 987 and 32, plus all processes owned by the users daemon and root:
 .B "       renice" +1 987 -u daemon root -p 32
 .SH NOTES
 Users other than the superuser may only alter the priority of processes they
-own, and can only monotonically increase their ``nice value'' (for security
-reasons) within the range 0 to 19,
-unless a nice resource limit is set (Linux 2.6.12 and higher).  The
-superuser may alter the priority of any process and set the priority to any
+own.  Furthermore, an unprivileged user can only
+.I increase
+the ``nice value'' (i.e., choose a lower priority)
+and such changes are irreversible unless (since Linux 2.6.12)
+the user has a suitable ``nice'' resource limit (see
+.BR ulimit (1)
+and
+.BR getrlimit (2)).
+
+The superuser may alter the priority of any process and set the priority to any
 value in the range \-20 to 19.
 Useful priorities are: 19 (the affected processes will run only when nothing
 else in the system wants to), 0 (the ``base'' scheduling priority), anything
@@ -103,9 +109,6 @@ to map user names to user IDs
 .BR credentials (7),
 .BR sched (7)
 .SH BUGS
-Non-superusers cannot increase scheduling priorities of their own processes,
-even if they were the ones that decreased the priorities in the first place.
-.PP
 The Linux kernel (at least version 2.0.0) and linux libc (at least version
 5.2.18) does not agree entirely on what the specifics of the system call
 interface to set nice values is.  Thus causes renice to report bogus previous
-- 
2.5.5

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
