Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:44195 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbaBHSWN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Feb 2014 13:22:13 -0500
From: Phillip Susi <psusi@ubuntu.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] Correct max priority in renice man page
Date: Sat,  8 Feb 2014 13:22:10 -0500
Message-Id: <1391883730-11767-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The man page stated that the PRIO_MAX is 20.  While this
is correct, the header definition is wrong and the max
value is actually 19.

Signed-off-by: Phillip Susi <psusi@ubuntu.com>
---
 sys-utils/renice.1 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/renice.1 b/sys-utils/renice.1
index 538687e..9cb50b8 100644
--- a/sys-utils/renice.1
+++ b/sys-utils/renice.1
@@ -86,14 +86,14 @@ PIDs 987 and 32, plus all processes owned by the users daemon and root:
 Users other than the superuser may only alter the priority of processes they
 own, and can only monotonically increase their ``nice value'' (for security
 reasons) within the range 0 to
-.BR PRIO_MAX \ (20),
+.BR PRIO_MAX \ (19),
 unless a nice resource limit is set (Linux 2.6.12 and higher).  The
 superuser may alter the priority of any process and set the priority to any
 value in the range
 .BR PRIO_MIN \ (\-20)
 to
 .BR PRIO_MAX .
-Useful priorities are: 20 (the affected processes will run only when nothing
+Useful priorities are: 19 (the affected processes will run only when nothing
 else in the system wants to), 0 (the ``base'' scheduling priority), anything
 negative (to make things go very fast).
 .SH FILES
-- 
1.8.3.2

