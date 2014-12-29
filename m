Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:51167 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751665AbaL2KRj (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 29 Dec 2014 05:17:39 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 05/11] docs: restore the alternative form of setarch in its man page
Date: Mon, 29 Dec 2014 11:17:00 +0100
Message-Id: <1419848226-2533-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1419848226-2533-1-git-send-email-bensberg@justemail.net>
References: <1419848226-2533-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Commit c372860ddb4a768f7f6c50cd26d60119370d5cd accidentally removed
the alternative form of setarch in which the command name specifies
the architecture to be set.  Also improve some formatting.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/setarch.8 |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/sys-utils/setarch.8 b/sys-utils/setarch.8
index ad9d4c2..a9a126a 100644
--- a/sys-utils/setarch.8
+++ b/sys-utils/setarch.8
@@ -1,4 +1,4 @@
-.TH SETARCH 8 "July 2014" "util-linux" "System Administration"
+.TH SETARCH 8 "December 2014" "util-linux" "System Administration"
 .SH NAME
 setarch \- change reported architecture in new program environment and set personality flags
 .SH SYNOPSIS
@@ -6,21 +6,22 @@ setarch \- change reported architecture in new program environment and set perso
 .I arch
 [options]
 .RI [ program
-.RI [ arguments ]]
+.RI [ argument ...]]
+.sp
+.B arch
+[options]
+.RI [ program
+.RI [ argument ...]]
 .sp
 .B setarch
 .BR \-\-list | \-h | \-V
 .SH DESCRIPTION
 .B setarch
 currently only affects the output of \fBuname -m\fR.
-For example, on an AMD64 system, running 'setarch i386 program' will cause 'program' to see
-.IR i686
-instead of
-.IR x86_64
-as the machine type.  It also allows to set various personality options.
-The default
-.B program
-is /bin/sh.
+For example, on an AMD64 system, running \fBsetarch i386 \fIprogram\fR
+will cause \fIprogram\fR to see i686 instead of x86_64 as the machine type.
+It also allows to set various personality options.
+The default \fIprogram\fR is \fB/bin/sh\fR.
 .SH OPTIONS
 .TP
 \fB\-\-list\fR
-- 
1.7.0.4

