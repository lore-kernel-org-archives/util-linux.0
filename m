Return-Path: util-linux-owner@vger.kernel.org
Received: from rrcs-67-78-168-186.se.biz.rr.com ([67.78.168.186]:60066 "EHLO
	iriserv.iradimed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862AbaFCOCO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 3 Jun 2014 10:02:14 -0400
From: Phillip Susi <psusi@ubuntu.com>
To: util-linux@vger.kernel.org
Cc: Phillip Susi <psusi@ubuntu.com>
Subject: [PATCH] flock: document exit status of flock in man page
Date: Tue,  3 Jun 2014 09:55:52 -0400
Message-Id: <1401803752-17401-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The man page did not indicate that the exit status of flock
is actually that of the child command, when one is run.
---
 sys-utils/flock.1 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index 99ae682..c245eda 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -159,6 +159,9 @@ or
 which report a failure to acquire the lock with a return value given by the
 .I \-E
 option, or 1 by default.
+.PP
+When using the <command> variant, and executing the child worked, then
+the exit status is that of the child command.
 .SH AUTHOR
 .UR hpa@zytor.com
 H. Peter Anvin
-- 
1.9.1

