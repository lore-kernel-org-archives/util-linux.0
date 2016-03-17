Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:63598 "EHLO
	cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933165AbcCQJkF (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 05:40:05 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/5] unshare: describe the setgroups restriction more explicitly
Date: Thu, 17 Mar 2016 10:39:13 +0100
Message-Id: <1458207554-2405-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1458207554-2405-1-git-send-email-bensberg@justemail.net>
References: <1458207554-2405-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/unshare.1 |   25 +++++++++++++++----------
 1 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index ba47c67..1df6d59 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -114,16 +114,21 @@ namespace (\fB\-\-mount\fP) is not requested.
 .BR "\-\-setgroups allow" | deny
 Allow or deny the
 .BR setgroups (2)
-syscall in user namespaces.
-
-.BR setgroups (2)
-is only callable with CAP_SETGID and CAP_SETGID in a user
-namespace.  Linux kernel (since 3.19) does not give you permission to call setgroups(2)
-until after GID map has been set.  The GID map is writable by root when
-.BR setgroups (2)
-is enabled and the GID map becomes writable by unprivileged processes when
-.BR setgroups (2)
-is permanently disabled.
+syscall in a user namespace.
+.sp
+To be able to call
+.BR setgroups (2),
+the calling process must at least have CAP_SETGID.
+But since Linux 3.19 a further restriction applies:
+the kernel gives permission to call
+.BR \%setgroups (2)
+only after the GID map (\fB/proc/\fIpid\fB/gid_map\fR) has been set.
+The GID map is writable by root when
+.BR \%setgroups (2)
+is enabled (i.e. \fBallow\fR, the default), and
+the GID map becomes writable by unprivileged processes when
+.BR \%setgroups (2)
+is permanently disabled (with \fBdeny\fR).
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
-- 
1.7.0.4

