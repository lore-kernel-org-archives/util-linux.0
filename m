Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:60307 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759634Ab2FAMv2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jun 2012 08:51:28 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E1BAF9625F
	for <util-linux@vger.kernel.org>; Fri,  1 Jun 2012 14:51:26 +0200 (CEST)
From: Ludwig Nussel <ludwig.nussel@suse.de>
To: util-linux@vger.kernel.org
Cc: Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH 6/7] remove unused code
Date: Fri,  1 Jun 2012 14:51:20 +0200
Message-Id: <1338555081-2061-6-git-send-email-ludwig.nussel@suse.de>
In-Reply-To: <1338555081-2061-1-git-send-email-ludwig.nussel@suse.de>
References: <1338555081-2061-1-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Ludwig Nussel <ludwig.nussel@suse.de>
---
 login-utils/su.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/login-utils/su.c b/login-utils/su.c
index cabf116..9585d07 100644
--- a/login-utils/su.c
+++ b/login-utils/su.c
@@ -324,10 +324,7 @@ authenticate (const struct passwd *pw)
       if (is_pam_failure(retval))
 	goto done;
     }
-# if 0 /* Manpage discourages use of getlogin.  */
-  cp = getlogin ();
-  if (!(cp && *cp && (lpw = getpwnam (cp)) != NULL && lpw->pw_uid == getuid ()))
-# endif
+
   lpw = getpwuid (getuid ());
   if (lpw && lpw->pw_name)
     {
-- 
1.7.7

