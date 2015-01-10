Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:64030 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753393AbbAJNls (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 10 Jan 2015 08:41:48 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/4] docs: mention that setarch may not be able to set all listed architectures
Date: Sat, 10 Jan 2015 14:41:33 +0100
Message-Id: <1420897295-17573-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1420897295-17573-1-git-send-email-bensberg@justemail.net>
References: <1420897295-17573-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/setarch.8 |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sys-utils/setarch.8 b/sys-utils/setarch.8
index a9a126a..d0f1cba 100644
--- a/sys-utils/setarch.8
+++ b/sys-utils/setarch.8
@@ -24,11 +24,12 @@ It also allows to set various personality options.
 The default \fIprogram\fR is \fB/bin/sh\fR.
 .SH OPTIONS
 .TP
-\fB\-\-list\fR
-List the architectures that can be set.
+.B \-\-list
+List the architectures that \fBsetarch\fR knows about.  Whether \fBsetarch\fR
+can actually set each of these architectures depends on the running kernel.
 .TP
-\fB\-\-uname\-2.6\fR
-Causes the program to see a kernel version number beginning with 2.6.
+.B \-\-uname-2.6
+Causes the \fIprogram\fR to see a kernel version number beginning with 2.6.
 .TP
 .BR \-v , " \-\-verbose"
 Be verbose.
-- 
1.7.0.4

