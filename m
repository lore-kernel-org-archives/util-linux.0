Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37858 "EHLO
	mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751563AbcG2QG2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 29 Jul 2016 12:06:28 -0400
From: Chris Metcalf <cmetcalf@mellanox.com>
To: util-linux@vger.kernel.org
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Subject: [PATCH] taskset: clarify that masks are always hex in man page
Date: Fri, 29 Jul 2016 12:06:20 -0400
Message-Id: <1469808380-3120-1-git-send-email-cmetcalf@mellanox.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The man page confusingly says that the mask is "typically"
hexadecimal, when in fact it is always hexadecimal.  Fix the
language, and provide an additional example with no leading "0x".

Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
---
 schedutils/taskset.1 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/schedutils/taskset.1 b/schedutils/taskset.1
index 901f9faf5f45..6b8146985355 100644
--- a/schedutils/taskset.1
+++ b/schedutils/taskset.1
@@ -51,7 +51,8 @@ to the last logical CPU.  Not all CPUs may exist on a given system but a mask
 may specify more CPUs than are present.  A retrieved mask will reflect only the
 bits that correspond to CPUs physically on the system.  If an invalid mask is
 given (i.e., one that corresponds to no valid CPUs on the current system) an
-error is returned.  The masks are typically given in hexadecimal.  For example,
+error is returned.  The masks are given in hexadecimal, with or without
+a leading "0x".  For example,
 .RS 4
 .TP 12
 .BR 0x00000001
@@ -62,6 +63,9 @@ is processors #0 and #1,
 .TP
 .BR 0xFFFFFFFF
 is all processors (#0 through #31).
+.TP
+.BR 32
+is processors #1, #4, and #5.
 .RE
 .PP
 When
-- 
2.7.2

