Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:64472 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752762AbbAUSC6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 Jan 2015 13:02:58 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/5] build-sys: free() needs stdlib.h
Date: Wed, 21 Jan 2015 19:02:52 +0100
Message-Id: <1421863374-9953-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1421863374-9953-1-git-send-email-sweet_f_a@gmx.de>
References: <1421863374-9953-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

followup 4f310fae

CC: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index 3d77307..de299d3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -480,6 +480,7 @@ AX_CHECK_TLS
 
 AC_DEFUN([UL_SCANF_TYPE_MODIFIER], [dnl
 # include <stdio.h>
+# include <stdlib.h>
 int main()
 {
 	int i;
-- 
1.8.4.5

