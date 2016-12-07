Return-Path: mtk@man7.org
To: Karel Zak <kzak@redhat.com>
Subject: [PATCH 2/2] docs: renice(1): Remove obsolete BUGS text
Cc: util-linux@vger.kernel.org
From: Michael Kerrisk <mtk@man7.org>
Message-ID: <d26d39be-da47-c52e-2d32-6bb3c0935ed2@man7.org>
Date: Wed, 7 Dec 2016 14:55:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
just kill this text in the man page.

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
Michael Kerrisk, man7.org Training and Consulting
mtk@man7.org, http://man7.org/training/
"The Linux Programming Interface" -- http://man7.org/tlpi/
