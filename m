Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:49332 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754142Ab3F1AFP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 27 Jun 2013 20:05:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 52AEA33E774
	for <util-linux@vger.kernel.org>; Fri, 28 Jun 2013 00:05:15 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] exec_shell: add a license and touch up func def
Date: Thu, 27 Jun 2013 20:05:18 -0400
Message-Id: <1372377918-2644-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When this file was created, the standard license header was missed.
Add it using the same one from unshare.c.

The noreturn attribute is not needed since we include the header
which has it on the prototype.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 lib/exec_shell.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/lib/exec_shell.c b/lib/exec_shell.c
index 95620cd..2b26364 100644
--- a/lib/exec_shell.c
+++ b/lib/exec_shell.c
@@ -1,3 +1,21 @@
+/*
+ * exec_shell() - launch a shell, else exit!
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
@@ -11,7 +29,8 @@
 
 #define DEFAULT_SHELL "/bin/sh"
 
-void __attribute__((__noreturn__)) exec_shell(void) {
+void exec_shell(void)
+{
 	const char *shell = getenv("SHELL"), *shell_basename;
 	char *arg0;
 	if (!shell)
-- 
1.8.2.1

