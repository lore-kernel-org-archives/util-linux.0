Return-Path: util-linux-owner@vger.kernel.org
Received: from hermes.apache.org ([140.211.11.3]:53022 "HELO mail.apache.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752992AbcFCVep (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 3 Jun 2016 17:34:45 -0400
From: Daniel Shahaf <danielsh@apache.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] ionice.1: clarify description of --classdata
Date: Fri,  3 Jun 2016 21:27:49 +0000
Message-Id: <1464989269-6761-1-git-send-email-danielsh@apache.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Before this patch, it wasn't clear whether '0' or '7' should be used to
specify "highest priority".  (The answer could have been inferred from
the 'Examples' section of the man page.)

Signed-off-by: Daniel Shahaf <danielsh@apache.org>
---
Initially reported as https://bugs.debian.org/826208

 schedutils/ionice.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/schedutils/ionice.1 b/schedutils/ionice.1
index 3b85635..f9acbc6 100644
--- a/schedutils/ionice.1
+++ b/schedutils/ionice.1
@@ -89,7 +89,7 @@ Specify the name or number of the scheduling class to use; \fI0\fR for none,
 .BR \-n , " \-\-classdata " \fIlevel\fR
 Specify the scheduling class data.  This only has an effect if the class
 accepts an argument.  For realtime and best-effort, \fI0-7\fR are valid data
-(priority levels).
+(priority levels), and \fI0\fR represents the highest priority level.
 .TP
 .BR \-p , " \-\-pid " \fIPID\fR...
 Specify the process IDs of running processes for which to get or set the
