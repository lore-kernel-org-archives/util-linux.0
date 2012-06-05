Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:33772 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934202Ab2FENbl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 5 Jun 2012 09:31:41 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 59289A2BD6
	for <util-linux@vger.kernel.org>; Tue,  5 Jun 2012 15:31:40 +0200 (CEST)
From: Ludwig Nussel <ludwig.nussel@suse.de>
To: util-linux@vger.kernel.org
Cc: Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH] su: preserve errno in cleanup_pam()
Date: Tue,  5 Jun 2012 15:31:24 +0200
Message-Id: <1338903084-19479-1-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Ludwig Nussel <ludwig.nussel@suse.de>
---
 login-utils/su.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/login-utils/su.c b/login-utils/su.c
index 944d655..0f535b9 100644
--- a/login-utils/su.c
+++ b/login-utils/su.c
@@ -153,6 +153,8 @@ static struct pam_conv conv =
 static void
 cleanup_pam (int retcode)
 {
+  int saved_errno = errno;
+
   if (_pam_session_opened)
     pam_close_session (pamh, 0);
 
@@ -160,6 +162,8 @@ cleanup_pam (int retcode)
     pam_setcred (pamh, PAM_DELETE_CRED | PAM_SILENT);
 
   pam_end(pamh, retcode);
+
+  errno = saved_errno;
 }
 
 /* Signal handler for parent process.  */
-- 
1.7.7

