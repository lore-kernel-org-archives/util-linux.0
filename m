Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:54436 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932357AbcCHJWK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Mar 2016 04:22:10 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 7/9] ctrlaltdel: tweak the wording in the man page
Date: Tue,  8 Mar 2016 10:07:50 +0100
Message-Id: <1457428072-2619-7-git-send-email-bensberg@justemail.net>
In-Reply-To: <1457428072-2619-1-git-send-email-bensberg@justemail.net>
References: <1457428072-2619-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/ctrlaltdel.8 |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sys-utils/ctrlaltdel.8 b/sys-utils/ctrlaltdel.8
index 170597f..337ec35 100644
--- a/sys-utils/ctrlaltdel.8
+++ b/sys-utils/ctrlaltdel.8
@@ -17,7 +17,7 @@ Immediately reboot the computer without calling
 and without any other preparation.  This is the default.
 .TP
 .B soft
-Will make kernel to send the SIGINT (interrupt) signal to the
+Make the kernel send the SIGINT (interrupt) signal to the
 .B init
 process (this is always the process with PID 1).  If this option is used,
 the
@@ -27,11 +27,12 @@ program must support this feature.  Since there are now several
 programs in the Linux community, please consult the documentation for the
 version that you are currently using.
 .PP
-When command is ran without arguments it will display current function in
-use.
+When the command is run without any argument, it will display the current
+setting.
 .PP
+The function of
 .B ctrlaltdel
-function is usually set in the
+is usually set in the
 .I /etc/rc.local
 file.
 .SH OPTIONS
-- 
1.7.0.4

