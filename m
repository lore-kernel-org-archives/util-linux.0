Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33000 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752963AbcLGN6j (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 7 Dec 2016 08:58:39 -0500
Received: by mail-wm0-f68.google.com with SMTP id u144so27959782wmu.0
        for <util-linux@vger.kernel.org>; Wed, 07 Dec 2016 05:58:38 -0800 (PST)
To: Karel Zak <kzak@redhat.com>
Subject: [PATCH 2/2 resent from right address] docs: renice(1): Remove
 obsolete BUGS text
Cc: mtk.manpages@gmail.com, util-linux@vger.kernel.org
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <120aed27-9596-0b4e-abc2-dba330d8da91@gmail.com>
Date: Wed, 7 Dec 2016 14:58:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Already at least as far back as util-linux 2.2, renice uses
getpriority(2) to fetch the process's old nice value. Thus,
the "problem" discussed in this BUGS note disappeared long ago.
This is trivially demonstrable:

    $ sleep 100 &
    [1] 24322
    $ renice -n 5 24322
    24322 (process ID) old priority 0, new priority 5
    $ renice -n 10 24322
    24322 (process ID) old priority 5, new priority 10

Rather than trying to explain the ancient problem (20 years old?),
just kill this text.

Signed-off-by: Michael Kerrisk <mtk.man-pages@gmail.com>
---
 sys-utils/renice.1 | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sys-utils/renice.1 b/sys-utils/renice.1
index d37fcf1..5ac8e4b 100644
--- a/sys-utils/renice.1
+++ b/sys-utils/renice.1
@@ -108,11 +108,6 @@ to map user names to user IDs
 .BR setpriority (2),
 .BR credentials (7),
 .BR sched (7)
-.SH BUGS
-The Linux kernel (at least version 2.0.0) and linux libc (at least version
-5.2.18) does not agree entirely on what the specifics of the system call
-interface to set nice values is.  Thus causes renice to report bogus previous
-nice values.
 .SH HISTORY
 The
 .B renice
-- 
2.5.5

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
