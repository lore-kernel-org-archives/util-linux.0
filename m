Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:60302 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759633Ab2FAMv1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jun 2012 08:51:27 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 983FA95267
	for <util-linux@vger.kernel.org>; Fri,  1 Jun 2012 14:51:26 +0200 (CEST)
From: Ludwig Nussel <ludwig.nussel@suse.de>
To: util-linux@vger.kernel.org
Cc: Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH 1/7] don't use custom MAX macro
Date: Fri,  1 Jun 2012 14:51:15 +0200
Message-Id: <1338555081-2061-1-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Ludwig Nussel <ludwig.nussel@suse.de>
---
 login-utils/su.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/login-utils/su.c b/login-utils/su.c
index 0e89632..77722c4 100644
--- a/login-utils/su.c
+++ b/login-utils/su.c
@@ -37,10 +37,6 @@
 
    Based on an implemenation by David MacKenzie <djm@gnu.ai.mit.edu>.  */
 
-#ifndef MAX
-# define MAX(a,b) ((a) > (b) ? (a) : (b))
-#endif
-
 /* Exit statuses for programs like 'env' that exec other programs.
    EXIT_FAILURE might not be 1, so use EXIT_FAIL in such programs.  */
 enum
@@ -817,7 +813,7 @@ main (int argc, char **argv)
   if (simulate_login && chdir (pw->pw_dir) != 0)
     error (0, errno, _("warning: cannot change directory to %s"), pw->pw_dir);
 
-  run_shell (shell, command, argv + optind, MAX (0, argc - optind));
+  run_shell (shell, command, argv + optind, max (0, argc - optind));
 }
 
 // vim: sw=2 cinoptions=>4,n-2,{2,^-2,\:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
-- 
1.7.7

