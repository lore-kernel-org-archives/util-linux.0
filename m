Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38699 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852Ab2JBUP1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Oct 2012 16:15:27 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so1465483wib.1
        for <util-linux@vger.kernel.org>; Tue, 02 Oct 2012 13:15:26 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/3] docs: clarify swapon.8 priority option
Date: Tue,  2 Oct 2012 21:15:17 +0100
Message-Id: <1349208918-11946-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1349208918-11946-1-git-send-email-kerolasa@iki.fi>
References: <1349208918-11946-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Value -1 is valid argument for -p, even though it might not make much
sense as the -1 is in use when priority is not specified at all.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/swapon.8 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index e471d07..69682b4 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -150,8 +150,8 @@ is needed.)
 .B "\-p, \-\-priority \fIpriority\fP"
 Specify the priority of the swap device.
 .I priority
-is a value between 0 and 32767. Higher numbers indicate higher
-priority. See
+is a value between \-1 and 32767.  Higher numbers indicate
+higher priority.  See
 .BR swapon (2)
 for a full description of swap priorities. Add
 .BI pri= value
@@ -159,6 +159,7 @@ to the option field of
 .I /etc/fstab
 for use with
 .BR "swapon -a" .
+When priority is not defined it defaults to \-1.
 .TP
 .B "\-s, \-\-summary"
 Display swap usage summary by device. Equivalent to "cat /proc/swaps".
-- 
1.7.12.2

