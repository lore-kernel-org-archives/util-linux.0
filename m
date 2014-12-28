Return-Path: util-linux-owner@vger.kernel.org
Received: from shell.v3.sk ([195.168.3.45]:52606 "EHLO shell.v3.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767AbaL1UaA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 28 Dec 2014 15:30:00 -0500
From: Lubomir Rintel <lkundrak@v3.sk>
To: util-linux@vger.kernel.org
Cc: Mikhail Gusarov <dottedmag@dottedmag.net>, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/2] unshare: add some examples
Date: Sun, 28 Dec 2014 21:23:37 +0100
Message-Id: <1419798218-3174-1-git-send-email-lkundrak@v3.sk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

...and fix one typo.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 sys-utils/unshare.1 | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 1aa9bcb..3f9eccd 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -1,5 +1,5 @@
 .\" Process this file with
-.\" groff -man -Tascii lscpu.1
+.\" groff -man -Tascii unshare.1
 .\"
 .TH UNSHARE 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
@@ -91,6 +91,20 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
+.SH EXAMPLES
+.TP
+.B # unshare --fork --pid --mount-proc readlink /proc/self
+.TQ
+1
+.br
+Establish a PID namespace, ensure we're PID 1 in it against newly mounted 
+procfs instance.
+.TP
+.B $ unshare --map-root-user --user sh -c whoami
+.TQ
+root
+.br
+Establish a user namespace as an unprivileged user with a root user within it.
 .SH SEE ALSO
 .BR unshare (2),
 .BR clone (2),
-- 
2.1.0

